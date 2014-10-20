From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Subject: [RFC Patch 1/4] mfd: AXP20x: Add power supply bindings documentation
Date: Mon, 20 Oct 2014 22:33:14 +0200
Message-ID: <20141020223314.0484f795@neptune.home>
References: <20141020215954.7f1d5502@neptune.home>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDCZ5GUK4UNRB77DSWRAKGQED4G4IZQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20141020215954.7f1d5502-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
References: <20141020221959.2f312906-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
In-Reply-To: <20141020221959.2f312906-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


---
Note: the OCV values seem to have some defaults build into the
PMIC though may need adjustment if the used battery has a different
open circuit voltage curve.
As far as understood (these values are set in vendor driver but not
mentioned in chip documentation) they represent charge percentage
for some predefined voltages.

If prefixing these values with "x-power," is preferred the following
patch should becomes a dependency:
  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/267606.ht=
ml
and users in patch 2/4, 4/4 need adjusting.


 Documentation/devicetree/bindings/mfd/axp20x.txt |   20 +
 1 files changed, 20 insertions(+), 0 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentati=
on/devicetree/bindings/mfd/axp20x.txt
index cc9e01b..8ea681c 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -28,6 +28,20 @@ Required properties:
 		      (range: 750-1875). Default: 1.5MHz
=20
 Optional properties for DCDCs:
+- backup: Settings for backup/RTC battery charger
+	  (Voltage in =C2=B5V, current in =C2=B5A)
+	  If not present, charger will be left untouched
+- battery.ocv: OCV capacity curve points (16 data values)
+- battery.resistance: internal battery resistance in m=CE=A9
+                      (defaults to 100m=CE=A9)
+- battery.capacity: Battery capacity in mAh
+		    If this attribute is missing, charger will be disabled
+		    unless there is a battery connected.
+- battery.temp_sensor: Description of temperautre sensor, 3 values
+		       - driver current (20=C2=B5A, 40=C2=B5A, 60=C2=B5A or 80=C2=B5A)
+		       - low temperature warning level (in =C2=B5V)
+		       - high temperature warning level (in =C2=B5V)
+		       If missing, temperature sensor gets disabled
 - x-powers,dcdc-workmode: 1 for PWM mode, 0 for AUTO mode
 			  Default: AUTO mode
=20
@@ -49,6 +63,12 @@ axp209: pmic@34 {
 	ldo3in-supply =3D <&axp_ipsout_reg>;
 	ldo5in-supply =3D <&axp_ipsout_reg>;
=20
+	backup =3D <3000000 200>;
+	battery.ocv =3D <0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
+	battery.resistance =3D <0>;
+	battery.capacity =3D <2000>;
+	battery.temp_sensor =3D <20 1000000 4000000>;
+
 	regulators {
 		x-powers,dcdc-freq =3D <1500>;
=20
--=20
2.0.4

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
