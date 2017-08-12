From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 2/5] devicetree: power: Add docs for TI BQ24190
 battery charger
Date: Sat, 12 Aug 2017 12:42:33 -0400
Message-ID: <20170812164233.won7fairxmrnblps@earth>
References: <20170807195420.20767-1-liam@networkimprov.net>
 <20170807195420.20767-3-liam@networkimprov.net>
 <20170811025038.5qnhbabyybx7rgu5@rob-hp-laptop>
 <CAKvHMgSuwm5UFivbsq9dQn_wfd7kbs63UuuQSHVdGxDf_WReUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mzy63zdorlqqpm6u"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751557AbdHLQmf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 12 Aug 2017 12:42:35 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgSuwm5UFivbsq9dQn_wfd7kbs63UuuQSHVdGxDf_WReUA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>


--mzy63zdorlqqpm6u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 11, 2017 at 02:57:10PM -0700, Liam Breck wrote:
> On Thu, Aug 10, 2017 at 7:50 PM, Rob Herring <robh@kernel.org> wrote:
> > On Mon, Aug 07, 2017 at 12:54:17PM -0700, Liam Breck wrote:
> >> From: Liam Breck <kernel@networkimprov.net>
> >>
> >> Document monitored-battery and ti,system-minimum-microvolt properties.
> >>
> >> Cc: Rob Herring <robh@kernel.org>
> >> Cc: devicetree@vger.kernel.org
> >> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> >> ---
> >>  .../devicetree/bindings/power/supply/bq24190.txt   | 49 +++++++++++++=
+++++++++
> >>  1 file changed, 49 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2=
4190.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.tx=
t b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> >> new file mode 100644
> >> index 00000000..82a1c842
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> >> @@ -0,0 +1,49 @@
> >> +TI BQ24190 Li-Ion Battery Charger
> >> +
> >> +Required properties:
> >> +- compatible: contains one of the following:
> >> +    * "ti,bq24190"
> >> +    * "ti,bq24192i"
> >> +- reg: integer, I2C address of the charger.
> >> +- interrupts[-extended]: configuration for charger INT pin.
> >> +
> >> +Optional properties:
> >> +- monitored-battery: phandle of battery characteristics devicetree no=
de
> >> +    The charger uses the following battery properties:
> >> +    + precharge-current-microamp: maximum charge current during prech=
arge
> >> +      phase (typically 20% of battery capacity).
> >> +    + charge-term-current-microamp: a charge cycle terminates when the
> >> +      battery voltage is above recharge threshold, and the current is=
 below
> >> +      this setting (typically 10% of battery capacity).
> >> +    See Documentation/devicetree/bindings/power/supply/battery.txt
> >> +- ti,system-minimum-microvolt: when power is connected and the batter=
y is below
> >> +    minimum system voltage, the system will be regulated above this s=
etting.
> >> +
> >> +Other features:
> >> +- Use gpio-hog to set the OTG pin high to enable 500mA charge current=
 on USB SDP port.
> >
> > Why doesn't the charger driver control this?
>=20
> This pin/gpio has to be high when USB is plugged in to make the
> charger chip negotiate 500mA from a SDP port. It should generally be
> configured that way even if the driver is not loaded, as the chip does
> not require a driver to function. Some boards may do that with a
> pull-up. Also the user may want to change this via sysfs and not have
> the driver "fix" it.

drivers/power/supply/qcom_smbb.c exposes the otg feature as
regulator. I think in this case it could be exposed as
gpio-regulator.

-- Sebastian

--mzy63zdorlqqpm6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmPL/kACgkQ2O7X88g7
+pqlRg//asd+LipI7z9TEAL1zhk9i1kBv3UXw3hWoGyYkK8v11GAAKFaFpWQ5MxT
ke4zCBt78HA6KC4/W2+C93kzWdFIfl3y2b3BVVs4Hl23IVzF/GMBwBOwh0FeqEhp
zxmCykusR7hCKqHYHOQX5t6pz18U0RN79EF074P5yLBMwB11VHQeougTMEtoEFI7
PQOlXHgsnJau11y91ppzSbQDXtekNcdIAJ5UflNvuL5iKnDYQ63oQ3MlwrxP9DfO
SSHvVOTGw91fAMhCBYRWkuJMzDktaC0M0RPLi2aD91YZ11CLIk6woxo0JhUC22ba
RVKTgHAiM4cn8JuTlmIFYfWGBFyIiVQq3jpI01ooTNyP/lYLPpo1SynAuMrowvA3
98R7veLzXqpbPZsqnzJ0Q7158ZhHqtUsCaL43I2SG7uRq/m6HRlK6pJmhBsuvVQr
RYZoN1UJFDzTNt9YKg7OcRLtIBzh4W13xdsTp5JmLDRyqdziTvsGgHcoBNSn2oJR
ABqNBJaCNv2BdhoJDNZc0I0yPn17slbvseBBL+eG/5QDacWqvOw9/cjTETphXDTM
+vx+9TLHLE/aS8uEw/VYrcnIm1Bbx2okgcXKaIGo4padA2vqk81mV4Li4tSx15dh
uA6pmSjZRIWaNoTvBRUZMO3lgOM+Txmt+C7CdqzQRjyE4f+QsCI=
=8zgQ
-----END PGP SIGNATURE-----

--mzy63zdorlqqpm6u--
