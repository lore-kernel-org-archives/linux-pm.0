From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4] thermal: Add QPNP PMIC temperature alarm driver
Date: Tue, 3 Feb 2015 15:26:57 -0400
Message-ID: <20150203192656.GB3486@developer.amazonguestwifi.org>
References: <1422890370-6914-1-git-send-email-iivanov@mm-sol.com>
 <20150202181446.GE17425@developer.hsd1.ca.comcast.net>
 <1422955485.2177.31.camel@mm-sol.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:61180 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966015AbbBCT1E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 14:27:04 -0500
Content-Disposition: inline
In-Reply-To: <1422955485.2177.31.camel@mm-sol.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, David Collins <collinsd@codeaurora.org>


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2015 at 11:24:45AM +0200, Ivan T. Ivanov wrote:
>=20
> Hi Eduardo,
>=20
> On Mon, 2015-02-02 at 14:14 -0400, Eduardo Valentin wrote:
> > Ivan,
> >=20
> > On Mon, Feb 02, 2015 at 05:19:30PM +0200, Ivan T. Ivanov wrote:
> > > Add support for the temperature alarm peripheral found inside
> > > Qualcomm plug-and-play (QPNP) PMIC chips. The temperature alarm
> > > peripheral outputs a pulse on an interrupt line whenever the
> > > thermal over temperature stage value changes.
> > >=20
> > > Register a thermal sensor. The temperature reported by this thermal
> > > sensor device should reflect the actual PMIC die temperature if an
> > > ADC is present on the given PMIC. If no ADC is present, then the
> > > reported temperature should be estimated from the over temperature
> > > stage value.
> > >=20
> > > Cc: David Collins <collinsd@codeaurora.org>
> > > Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> > > ---
> > >=20
> > > Changes since v3:
> > >=20
> > > - Driver register thermal sensor instead thermal zone. Device thermal=
 zone
> > >   should be properly described in DT files according thermal.txt docu=
ment.
> >=20
> > Thanks a lot for keeping this up. I believe the driver looks smaller and
> > cleaner now, don't you agree?
>=20
> Yep.
>=20
> >=20
> > > - Dropped support for software override PMIC shutdown sequence and re=
lated
> > >   bit definitions. If software did not take action for clean device s=
hutdown,
> > >   until critical temperature is reached, PMIC chip will execute inter=
nal
> > >   pre-programed shutdown sequence.
> > >=20
> >=20
> > OK. Let me know if this functionality is crucial and needs further
> > discussion.
>=20
> Unless I miss something, I think that this functionality is
> used only for the purpose of debugging.

OK Great!

>=20
> >=20
> >=20
> > I have two very minor comments as follows.
> >=20
> >=20
> > > v3: http://comments.gmane.org/gmane.linux.ports.arm.msm/10071
> > >=20
> > >  .../bindings/thermal/qcom-spmi-temp-alarm.txt      |  57 ++++
> > >  drivers/thermal/Kconfig                            |  11 +
> > >  drivers/thermal/Makefile                           |   1 +
> > >  drivers/thermal/qcom-spmi-temp-alarm.c             | 311 +++++++++++=
++++++++++
> > >  4 files changed, 380 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-sp=
mi-temp-alarm.txt
> > >  create mode 100644 drivers/thermal/qcom-spmi-temp-alarm.c
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp=
-alarm.txt=20
> > > b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> > > new file mode 100644
> > > index 0000000..290ec06
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.=
txt
> > > @@ -0,0 +1,57 @@
> > > +Qualcomm QPNP PMIC Temperature Alarm
> > > +
> > > +QPNP temperature alarm peripherals are found inside of Qualcomm PMIC=
 chips
> > > +that utilize the Qualcomm SPMI implementation. These peripherals pro=
vide an
> > > +interrupt signal and status register to identify high PMIC die tempe=
rature.
> > > +
> > > +Required properties:
> > > +- compatible:      Should contain "qcom,spmi-temp-alarm".
> > > +- reg:             Specifies the SPMI address and length of the cont=
roller's
> > > +                   registers.
> > > +- interrupts:      PMIC temperature alarm interrupt.
> > > +- #thermal-sensor-cells: Should be 0. See thermal.txt for a descript=
ion.
> > > +
> > > +Optional properties:
> > > +- io-channels:     Should contain IIO channel specifier for the ADC =
channel,
> > > +                   which report chip die temperature.
> > > +- io-channel-names: Should contain "thermal".
> > > +
> > > +Example:
> > > +
> > > +       pm8941_temp: thermal-alarm@2400 {
> > > +               compatible =3D "qcom,spmi-temp-alarm";
> > > +               reg =3D <0x2400 0x100>;
> > > +               interrupts =3D <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
> > > +               #thermal-sensor-cells =3D <0>;
> > > +
> > > +               io-channels =3D <&pm8941_vadc VADC_DIE_TEMP>;
> > > +               io-channel-names =3D "thermal";
> > > +       };
> > > +
> > > +       thermal-zones {
> > > +               pm8941 {
> > > +                       polling-delay-passive =3D <250>;
> > > +                       polling-delay =3D <1000>;
> > > +
> > > +                       thermal-sensors =3D <&pm8941_temp>;
> > > +
> > > +                       trips {
> > > +                               passive {
> > > +                                       temperature =3D <1050000>;
> > > +                                       hysteresis =3D <2000>;
> > > +                                       type =3D "passive";
> > > +                               };
> > > +                               alert {
> > > +                                       temperature =3D <125000>;
> > > +                                       hysteresis =3D <2000>;
> > > +                                       type =3D "hot";
> > > +                               };
> > > +                               crit {
> > > +                                       temperature =3D <145000>;
> > > +                                       hysteresis =3D <2000>;
> > > +                                       type =3D "critical";
> > > +                               };
> > > +                       };
> > > +               };
> > > +       };
> >=20
> > Do you have the appropriate DT changes under architecture code too?
> >=20
> > I mean, I am fine picking these changes, but should this series include
> > also a minor inclusion under arch/arm/boot/dts too, given that you
> > already did the hard part?
>=20
> We don't have any DT files for these PMIC's upstream. Probably is time=20
> to start adding them. I have waiting to have some drivers accepted=20
> before pushing such changes. But not we have 2 types of ADC, RTC, GPIO's,=
=20
> MPP's and hopefully Thermal :-). I would like this to be a separate effor=
t.

I am fine if you take the approach of doing it in two steps. It is just
that your series can be better reviewed if you include the DT changes.

>=20
>=20
> > > + * This function updates the internal temp value based on the
> > > + * current thermal stage and threshold as well as the previous stage
> > > + */
> > > +static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
> > > +{
> > > +       unsigned int stage;
> > > +       int ret;
> > > +       u8 reg =3D 0;
> > > +
> > > +       ret =3D qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       stage =3D reg & STATUS_STAGE_MASK;
> > > +
> > > +       if (stage > chip->stage) {
> > > +               /* increasing stage, use lower bound */
> > > +               chip->temp =3D (stage - 1) * TEMP_STAGE_STEP +
> > > +                                                               chip-=
>thresh * TEMP_THRESH_STEP=20
> > > +
> > > +                                                               TEMP_=
STAGE_HYSTERESIS +=20
> > > TEMP_THRESH_MIN;
> > > +       } else if (stage < chip->stage) {
> > > +               /* decreasing stage, use upper bound */
> > > +               chip->temp =3D stage * TEMP_STAGE_STEP +
> > > +                                                               chip-=
>thresh * TEMP_THRESH_STEP=20
> > > -
> > > +                                                               TEMP_=
STAGE_HYSTERESIS +=20
> > > TEMP_THRESH_MIN;
> > > +       }
> >=20
> > For my own edification, no change in state means no change in
> > temperature too, right?
>=20
> More or less, just no way to estimate exact temperature
> between stages.

OK.

>=20
> >=20
> > > +
> > > +       chip->stage =3D stage;
> > > +
> > > +       return 0;
> > > +}
> > > +
>=20
> <snip>
>=20
> > > +static int qpnp_tm_probe(struct platform_device *pdev)
> > > +{
> > > +       struct qpnp_tm_chip *chip;
> > > +       struct device_node *node;
> > > +       u8 type, subtype;
> > > +       u32 res[2];
> > > +       int ret, irq;
> > > +
> > > +       node =3D pdev->dev.of_node;
> > > +
> > > +       chip =3D devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> > > +       if (!chip)
> > > +               return -ENOMEM;
> > > +
> > > +       dev_set_drvdata(&pdev->dev, chip);
> > > +
> > > +       chip->map =3D dev_get_regmap(pdev->dev.parent, NULL);
> > > +       if (!chip->map)
> > > +               return -ENXIO;
> > > +
> > > +       ret =3D of_property_read_u32_array(node, "reg", res, 2);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       /* ADC based measurements are optional */
> > > +       chip->adc =3D iio_channel_get(&pdev->dev, "thermal");
> > > +       if (PTR_ERR(chip->adc) =3D=3D -EPROBE_DEFER)
> > > +               return PTR_ERR(chip->adc);
> > > +
> > > +       irq =3D platform_get_irq(pdev, 0);
> > > +       if (irq < 0)
> > > +               return irq;
> > > +
> > > +       chip->base =3D res[0];
> > > +
> > > +       ret =3D qpnp_tm_read(chip, QPNP_TM_REG_TYPE, &type);
> > > +       if (ret < 0) {
> > > +               dev_err(&pdev->dev, "could not read type\n");
> > > +               goto fail;
> > > +       }
> > > +
> > > +       ret =3D qpnp_tm_read(chip, QPNP_TM_REG_SUBTYPE, &subtype);
> > > +       if (ret < 0) {
> > > +               dev_err(&pdev->dev, "could not read subtype\n");
> > > +               goto fail;
> > > +       }
> > > +
> > > +       if (type !=3D QPNP_TM_TYPE || subtype !=3D QPNP_TM_SUBTYPE) {
> > > +               dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0=
x%02x\n",
> > > +                       type, subtype);
> > > +               ret =3D -ENODEV;
> > > +               goto fail;
> > > +       }
> > > +
> > > +       ret =3D qpnp_tm_init(chip);
> > > +       if (ret < 0) {
> > > +               dev_err(&pdev->dev, "init failed\n");
> > > +               goto fail;
> > > +       }
> > > +
> > > +       chip->tz_dev =3D thermal_zone_of_sensor_register(&pdev->dev, =
0, chip,
> > > +                                                       &qpnp_tm_sens=
or_ops);
> > > +       if (IS_ERR(chip->tz_dev)) {
> > > +               dev_err(&pdev->dev, "failed to register sensor\n");
> > > +               ret =3D PTR_ERR(chip->tz_dev);
> > > +               goto fail;
> > > +       }
> > > +
> > > +       ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL, qpnp=
_tm_isr,
> > > +                                       IRQF_ONESHOT, node->name, chi=
p);
> >=20
> > What if we request this IRQ before registering the of thermal zone
> > sensor? I believe it makes more sense conceptually, as you mean, you
> > register into upper layers once your driver is fully ready to do so.
> >=20
> > Any objections changing the order?
>=20
> Sure.


Good!

>=20
> >=20
> > > +       if (ret < 0)
> > > +               goto unreg;
> > > +
> > > +       return 0;
> > > +
> > > +unreg:
> > > +       thermal_zone_of_sensor_unregister(&pdev->dev, chip->tz_dev);
> >=20
> > As mentioned by Stanimir Varban, you may also remove the above, since
> > the irq is devm.
>=20
> Sure. s/Varban/Varbanov/ ;-)

Ohh.. my bad. Sorry Varbanov. Fixing next time! :-)

>=20
> Thank you.
> Ivan

BR,

Eduardo Valentin

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU0SD1AAoJEMLUO4d9pOJWf7wIAJq8nCoB1uTfcfG6tzUSO6ck
SHN8XFwLKUoZuNw/RRZkRaZeDuYEAEpnXVJ0p4reKVnSA/I45SlB7jYW2+u3OFZ9
tCSW9BUurvaDqM3690NQRs7JQDtx8sKxO/wEDIFOAVyd1Szr8xfJfdDkNwX81e8r
7jKyVBCBRlWi1pabWPEIFhU8pXbXiSFLMRqaSTfGNT8ea+WLmzXQrKDR2S81u/kz
HATzLkveEFN0DBT4hIasRP8QRHsaOxVnostI+oTZdPNG3WH7nuPFTUgEzBb/hWMM
59MDfbUDqgCWwjchTNIDyTYTR20Jrqgu5TvGYZLGH0OAQ+hKjx70SAlaDoWHahA=
=QxEB
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
