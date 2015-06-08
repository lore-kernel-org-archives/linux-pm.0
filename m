From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v4 6/8] arm64: dts: add SRAM, MHU mailbox and SCPI
 support on Juno
Date: Mon, 8 Jun 2015 15:35:13 +0100
Message-ID: <20150608143513.GI12807@e106497-lin.cambridge.arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
 <1433760002-24120-7-git-send-email-sudeep.holla@arm.com>
 <1433771479.2882.44.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:6683 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752372AbbFHOfR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Jun 2015 10:35:17 -0400
In-Reply-To: <1433771479.2882.44.camel@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>

On Mon, Jun 08, 2015 at 02:51:19PM +0100, Jon Medhurst (Tixy) wrote:
> On Mon, 2015-06-08 at 11:40 +0100, Sudeep Holla wrote:
> [...]
> > +
> > +	scpi {
> > +		compatible =3D "arm,scpi";
> > +		mboxes =3D <&mailbox 1>;
> > +		shmem =3D <&cpu_scp_hpri>;
> > +
> > +		clocks {
> > +			compatible =3D "arm,scpi-clocks";
> > +
> > +			scpi_dvfs: scpi_clocks@0 {
> > +				compatible =3D "arm,scpi-dvfs-clocks";
> > +				#clock-cells =3D <1>;
> > +				clock-indices =3D <0>, <1>, <2>;
> > +				clock-output-names =3D "vbig", "vlittle", "vgpu";
>=20
> From where do the clock names derive? They look more like names for
> voltage domains rather than clocks. My (admittedly very old) Juno doc=
s,
> have the clocks as ATLCLK, APLCLK and GPUCLK.
>=20
> > +			};
> > +			scpi_clk: scpi_clocks@3 {
> > +				compatible =3D "arm,scpi-variable-clocks";
> > +				#clock-cells =3D <1>;
> > +				clock-indices =3D <3>, <4>;
> > +				clock-output-names =3D "pxlclk0", "pxlclk1";
>=20
> Can we also have clock index 5, name 'i2s_clk', for used by audio?
> (I don't know what other clocks the SCP currently supports, but audio=
 is
> one being currently used by the out-of-tree code).
>=20
> Also, I believe that both display outputs share the same clock, and s=
o
> pxlclk0 and pxlclk1 can't be controlled independently. But I guess th=
ese
> device-tree entries are for the interface to the SCP firmware, not th=
e
> hardware, and if that pretends the clocks are independent...

Actually, they can be independent, but the other source for clock gener=
ation
can only be used to drive a VGA resolution.

We were just debating with Sudeep on how to expose this: at the moment =
the SCP
is configured so that the request for a clock frequency always succeeds=
 even
if the other user of the clock is active. That means that if you have 2=
 monitors
connected that have different resolutions or pixel clocks then one of t=
he
monitor will get out of sync (unless it is a VGA monitor). On the other=
 hand the
HDLCD driver (or more corectly the DRM KMS one) will default to 640x480=
 if no
monitor is connected to an HDMI output, meaning the clock could already=
 be used
but by a driver that should really be inactive. It is very hard to dete=
ct in
which situation we are, so the usual fix is "plug the monitor into the =
other
HDMI output if you have problems with single monitors".

Best regards,
Liviu

>=20
> --=20
> Tixy
>=20
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF

