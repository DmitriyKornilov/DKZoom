unit DK_Zoom;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ComCtrls;

type

  TZoomEvent = procedure(const AZoomPercent: Integer) of object;

  { TZoomForm }

  TZoomForm = class(TForm)
    ValueLabel: TLabel;
    TitleLabel: TLabel;
    ZoomInButton: TSpeedButton;
    ZoomTrackBar: TTrackBar;
    ZoomOutButton: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure ZoomInButtonClick(Sender: TObject);
    procedure ZoomOutButtonClick(Sender: TObject);
    procedure ZoomTrackBarChange(Sender: TObject);
  private
    OnZoomChange: TZoomEvent;
    procedure SetValueLabel;
  public

  end;

var
  ZoomForm: TZoomForm;

  function CreateZoomControls(const AMinPercent, AMaxPercent, ACurrentPercent: Integer;
                          const AParent: TWinControl;
                          const AOnZoomChange: TZoomEvent;
                          const AAlignRight: Boolean = False): TZoomForm;

implementation

function CreateZoomControls(const AMinPercent, AMaxPercent, ACurrentPercent: Integer;
                        const AParent: TWinControl;
                        const AOnZoomChange: TZoomEvent;
                        const AAlignRight: Boolean = False): TZoomForm;
begin
  Result:= TZoomForm.Create(AParent);
  Result.ZoomTrackBar.Min:= AMinPercent;
  Result.ZoomTrackBar.Max:= AMaxPercent;
  Result.ZoomTrackBar.Position:= ACurrentPercent;
  if AAlignRight then
    Result.Align:= alRight
  else
    Result.Align:= alLeft;
  Result.Color:= AParent.Color;
  Result.Parent:= AParent;
  Result.OnZoomChange:= AOnZoomChange;
  Result.Show;
end;

{$R *.lfm}

{ TZoomForm }

procedure TZoomForm.FormShow(Sender: TObject);
var
  W: Integer;
begin
  W:= ValueLabel.Width;
  ValueLabel.Constraints.MinWidth:= W;
  ValueLabel.Constraints.MaxWidth:= W;
  ValueLabel.AutoSize:= False;
  SetValueLabel;
  //ValueLabel.Caption:= '100 %';
  AutoSize:= True;
end;

procedure TZoomForm.ZoomInButtonClick(Sender: TObject);
begin
  ZoomTrackBar.Position:= ZoomTrackBar.Position + 5;
end;

procedure TZoomForm.ZoomOutButtonClick(Sender: TObject);
begin
  ZoomTrackBar.Position:= ZoomTrackBar.Position - 5;
end;

procedure TZoomForm.ZoomTrackBarChange(Sender: TObject);
begin
  SetValueLabel;
  if Assigned(OnZoomChange) then
    OnZoomChange(ZoomTrackBar.Position);
end;

procedure TZoomForm.SetValueLabel;
begin
  ValueLabel.Caption:= IntToStr(ZoomTrackBar.Position) + ' %';
end;

end.

