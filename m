From: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Subject: Re: [PATCH 3/3] power_supply: max77693: Listen for cable events and enable charging
Date: Tue, 27 Sep 2016 15:34:48 +0200
Message-ID: <87a8etwjnr.fsf@machinist.wiedmeyer.de>
References: <20160927081344.GC4394@kozik-lap>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from wiedmeyer.de ([85.116.192.112]:52036 "EHLO wiedmeyer.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754359AbcI0NfM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Sep 2016 09:35:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by wiedmeyer.localdomain (Postfix) with ESMTP id 6FF408E919B
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2016 15:35:10 +0200 (CEST)
Received: from wiedmeyer.de ([127.0.0.1])
        by localhost (wiedmeyer.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BBEnH5BHnQdA for <linux-pm@vger.kernel.org>;
        Tue, 27 Sep 2016 15:35:07 +0200 (CEST)
In-reply-to: <20160927081344.GC4394@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cw00.choi@samsung.com, b.zolnierkie@samsung.com, broonie@kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Krzysztof Kozlowski writes:

> On Tue, Sep 27, 2016 at 01:31:10AM +0200, Wolfgang Wiedmeyer wrote:
>> This patch adds a listener for extcon cable events and enables
>> charging if an USB cable is connected. It recognizes SDP and DCP cable
>> types and treats them the same (same input current and fast charge
>> current). The maximum input current is set before the charger is
>> enabled and before the charger gets disabled, the maximum input
>> current is set to zero. The listener is inspired by the listener
>> implementation that was used for the AXP288 Charger driver.
>>=20
>> The patch also adds support for the CURRENT_NOW property. It reads the
>> fast charge current that gets set before the charger is enabled or
>> disabled.
>>=20
>> Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
>
> No. This power supply driver should not manage regulators. It is not a
> regulator consumer. For that specific need, there is a charger-manager dr=
iver.

When I was in the middle of implementing this, I noticed that the
charger manager does everything that is needed. But it took me quite
some time to configure the DTS correctly until I realized that the
charger manager used a deprecated function
(extcon_register_interest()) and thus couldn't work. And as I didn't see
the charger-manager in any other device's DTS, I thought that this might
not be right way.
But Chanwoo Choi has a fix: https://patchwork.kernel.org/patch/8898541/
So I will try to get it working with this patch.

> I agree that you might configure here the charger. You might even expose
> some writeable properties through power supply class. However the
> purpose of this driver is to expose the battery charger to user-space,
> not to replace the user-space with its work.
>
> So... NACK.

Ok, then I will try to reduce the patch to the CURRENT_NOW property
support.

> If you would like to play with charger-manager, here is my old DTS for
> Trats2 (might need updates):

Is there a reason that this patch is not in the kernel? It would have
been very helpful for me :)

Thanks,
Wolfgang

> index 595ad4ba6977..b4361b4a9de7 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -856,6 +856,44 @@
>                 };
>         };
>=20=20
> +       charger-manager@0 {
> +               compatible =3D "charger-manager";
> +               status =3D "okay";
> +               chg-reg-supply =3D <&charger_reg>;
> +
> +               cm-name =3D "battery";
> +               /* Polling only for external power source */
> +               cm-poll-mode =3D <2>;
> +               cm-poll-interval =3D <30000>;
> +
> +               cm-fullbatt-vchkdrop-ms =3D <30000>;
> +               cm-fullbatt-vchkdrop-volt =3D <150000>;
> +               cm-fullbatt-soc =3D <100>;
> +
> +               cm-battery-stat =3D <0>;
> +               cm-fuel-gauge =3D "max170xx_battery";
> +
> +               /* Allow charging for 5hr */
> +               cm-charging-max =3D <18000000>;
> +               /* Allow discharging for 2hr */
> +               cm-discharging-max =3D <7200000>;
> +
> +               cm-num-chargers =3D <1>;
> +               cm-chargers =3D "max77693-charger";
> +
> +               charger@0 {
> +                       cm-regulator-name =3D "chg-reg";
> +                       cable@0 {
> +                               cm-cable-name =3D "USB";
> +                               cm-cable-extcon =3D "max77693-muic";
> +                       };
> +                       cable@1 {
> +                               cm-cable-name =3D "TA";
> +                               cm-cable-extcon =3D "max77693-muic";
> +                       };
> +               };
> +       };
> +
>         exynos-usbphy@125B0000 {
>                 status =3D "okay";
>         };
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Best regards,
> Krzysztof


=2D-=20
Website: https://fossencdi.org
OpenPGP: 0F30 D1A0 2F73 F70A 6FEE  048E 5816 A24C 1075 7FC4
Key download: https://wiedmeyer.de/keys/ww.asc

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX6nV4AAoJEFgWokwQdX/EM3MP/3Tjam7wO96R8xTiM0jpHRf4
dAlaEixC1LcpmB7FJdelIblGKj1OsPTBO8kMS0JphBRcbLg6lo8Lxj0pla/IPP5h
73Weq4xPlIFpDPYQE+r8W75dZrUKdn5xvs01K5RAoGrZ9hMMzMpmJFg/vFbIjhxF
UE+vgzGbCArt/yQx/jZxgQM+cDxzlttA/o292TKmyok+OMIZyC/FQw8Z7t0oD/LJ
t+2uIKv0ipmuwPoN5EEqu9tnaA/bRkVVngdAVmr5Yio7bJbyxa8ReQ2XEFVMW4WZ
iHeWsXI653suPlwySLdfoLxJHnBd3L1Q6jiRbZxv1wOsBTPEiFK1jINYaQ3Q1bch
DxmmTCFgwSwxXkqF94mn3rLUr8kjsBA+Qt1Rt75shFsiw0rzCFZW2G1cUt0meEwt
kvSPnrLpR6NBSuABdU8DTFxqrw196IueVg463ibX7Pyvf0S//BoLNYjToRy3VafD
EDED2iQApBMp6K77gvLufuTRXA79cZHmuiklf2gXtSUU8LPQOVQFf2SsDf/0Bwa7
xQ0NcgucJ/TbvEEuJo31nCc4zs/LBBIhcFlZg5JekyIGiGNilNaY2VlXYWNJyd6w
VTkAbaZHfHrcoEV1q0L2bkBTzhmkwtxSAlLOZodn0/FTJ433TAvR7FMW9PEDLYrA
qc1wE7+Ctasr2cQfiVAa
=ZaLh
-----END PGP SIGNATURE-----
--=-=-=--
