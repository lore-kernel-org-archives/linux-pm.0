From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 01/18] dt-bindings: power: battery: add
 constant-charge-current property
Date: Wed, 15 Mar 2017 23:23:51 +0100
Message-ID: <20170315222351.6huhcw25tmvbarxk@earth>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315105537.22349-2-quentin.schulz@free-electrons.com>
 <CAKvHMgSnyPPMEZ1o70Ed2oBHGcMho=-jjFhfXGn4t+2bdALEew@mail.gmail.com>
 <ce6f2ddb-f875-0370-ca45-293397d97495@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dplvyusly7ip4mmi"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ce6f2ddb-f875-0370-ca45-293397d97495-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--dplvyusly7ip4mmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 15, 2017 at 02:10:37PM +0100, Quentin Schulz wrote:
> Hi Liam,
>=20
> On 15/03/2017 13:08, Liam Breck wrote:
> > I dropped most of the CCs, pls re-add anyone essential. Use Cc lines
> > in patch description to direct a patch to interested parties and
> > relevant lists. I don't want to see all 19 patches in this series.
> >=20
> > On Wed, Mar 15, 2017 at 3:55 AM, Quentin Schulz
> > <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> >> This adds the constant-charge-current property to the list of optional
> >> properties of the battery.
> >>
> >> The constant charge current is critical for batteries as they can't
> >> handle all charge currents.
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> ---
> >>
> >> v4:
> >>  - switch from constant-charge-current-microamp to constant-charge-mic=
roamp,
> >=20
> > Must be constant-charge-current-microamp for the reasons discussed in
> > battery.txt - consistency with sysfs names.
> >=20
>=20
> Hum. Just nitpicking, but I disagree with the use of 'must'. IIRC there
> is nothing in the code that would require the property to be named after
> a property from the enum power_supply_property.
>=20
> I would say that you _want_ it to be named like that because it
> underlines the relation between the DT property and the actual impacted
> property in the power supply subsystem. I'm fine with this reason but in
> the end, the maintainer's opinion prevails (if (s)he does not want it,
> (s)he will not take it). So, basically, I actually don't mind either
> option and I see arguments on each side.
>=20
> So, just waiting for maintainer's opinion to make the final version of
> this patch.

I'm fine with either property names.

-- Sebastian

--dplvyusly7ip4mmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJvvcACgkQ2O7X88g7
+prvgRAAlZL2H6lho3IdMAzRd8qpTqiVZGN9Twb4GGJX+JAGyUQ65J0TxEOMr2T8
IsqhXtsmJeT99/vuBASNVpkH+BCyjj6hJVe3hhfLyVU44hb3oc7yHMqMOShrj2//
EGlL8SdDksdpgRgd5ObZ852n2CMehjxCynqGzbDQfC2S06Rzkra5HAeKCzGMDLs2
qtC1W2NXH98YzSrg2vZhsXWZFxo/vu8KiOKkgzwtFrm3aUUKSPLn7mCfX9W9nRrA
FK9On9gKGDg8ntsgjGk/+WAVb0aBJpAxm4aODZgQwRrt/1H5lmJlmPBurSr5LGmJ
Sr8B/Ocv7u3SV6AVPbxVppf0dHw6yDjywQIlIRdcjgix4m06v+P7ctiS4IcqWz46
VBcywnNMmbzugByjQH9tgseeSsfuDev4h43CxKUAc3TfbGF/uMFLswJc0pQ4iOF9
1QLafex5jkI3Kj2utXFYWqN/HTKt5gx445RaF0hxp1M6vgp9wRKrNVNMWYTqYN4i
PiW9AvtzSyuvImaLSUcMhiuIEEBOMtFtiQVQZEoBE+X6xIg7Ukxr28/xAS0AyXgo
SexBG+uswInbaNSNxY5D2HOd+GqLQ+P5X0Yw7ZMEznScVJ14JqZpklZQ9eqv6Ke/
sI7F62eb+Dll6bTpvRYHq93YHzBBg3BwenEt39tMezVsG6ZIg8M=
=ySiJ
-----END PGP SIGNATURE-----

--dplvyusly7ip4mmi--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
