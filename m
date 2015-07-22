From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v4 6/8] arm64: dts: add SRAM, MHU mailbox and SCPI
 support on Juno
Date: Wed, 22 Jul 2015 17:06:25 +0100
Message-ID: <20150722160625.GJ14923@e106497-lin.cambridge.arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
 <1433760002-24120-7-git-send-email-sudeep.holla@arm.com>
 <20150722132809.GG14923@e106497-lin.cambridge.arm.com>
 <55AFB96E.1050406@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AFB96E.1050406@arm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 22, 2015 at 04:40:30PM +0100, Sudeep Holla wrote:
>=20
>=20
> On 22/07/15 14:28, Liviu Dudau wrote:
> > On Mon, Jun 08, 2015 at 11:40:00AM +0100, Sudeep Holla wrote:
> >> This patch adds support for the MHU mailbox peripheral used on Jun=
o by
> >> application processors to communicate with remote SCP handling mos=
t of
> >> the CPU/system power management. It also adds the SRAM reserving t=
he
> >> shared memory and SCPI message protocol using that shared memory.
> >>
> >> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> >> Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
> >> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >> ---
> >>   arch/arm64/boot/dts/arm/juno-base.dtsi   | 31 ++++++++++++++++++=
+++++++++++++
> >>   arch/arm64/boot/dts/arm/juno-clocks.dtsi | 23 ++++++++++++++++++=
+++++
> >>   2 files changed, 54 insertions(+)
> >>
>=20
> [..]
>=20
> >> diff --git a/arch/arm64/boot/dts/arm/juno-clocks.dtsi b/arch/arm64=
/boot/dts/arm/juno-clocks.dtsi
> >> index 25352ed943e6..64af7370815a 100644
> >> --- a/arch/arm64/boot/dts/arm/juno-clocks.dtsi
> >> +++ b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
> >> @@ -42,3 +42,26 @@
> >>   		clock-frequency =3D <400000000>;
> >>   		clock-output-names =3D "faxi_clk";
> >>   	};
> >> +
> >> +	scpi {
> >> +		compatible =3D "arm,scpi";
> >> +		mboxes =3D <&mailbox 1>;
> >> +		shmem =3D <&cpu_scp_hpri>;
> >> +
> >> +		clocks {
> >> +			compatible =3D "arm,scpi-clocks";
> >> +
> >> +			scpi_dvfs: scpi_clocks@0 {
> >> +				compatible =3D "arm,scpi-dvfs-clocks";
> >> +				#clock-cells =3D <1>;
> >> +				clock-indices =3D <0>, <1>, <2>;
> >> +				clock-output-names =3D "vbig", "vlittle", "vgpu";
> >> +			};
> >> +			scpi_clk: scpi_clocks@3 {
> >> +				compatible =3D "arm,scpi-variable-clocks";
> >> +				#clock-cells =3D <1>;
> >> +				clock-indices =3D <3>, <4>;
> >
> > Subject to you addressing Mark's comments regarding the indices val=
ues (maybe choose
> > a different property to show the fact that the index is actually an=
 SCPI index
> > rather than the clock's), you can add my
> >
>=20
> I don't understand why we need to do that. I will anyway follow up on
> that thread.

Because indices are per clock node, i.e. spi_clk should have clock-indi=
ces =3D <0>, <1>.
Of course, you could have a gap in the indices, but that is both awkard=
 and not clearly
explained in this documentation.

The index that you declare here is actually what you pass to SCPI. But =
the way the device
tree is presented it declares that there are two clock blocks, one for =
DVFS and one for
PXLCLK. As far as SCPI is concerned there is only one block of clocks, =
with 3 of them
having a discrete set of values, so we are at the intersection of two c=
oncepts.

BTW, for what is worth, the PXLCLK is not really that smooth in its cov=
erage of the range.
It might have more accepted frequency values, but the way it is impleme=
nted it tends to
favour VESA clock values and falls back to a really slow algorithm to g=
enerate all other
values. Even so, it can fail to find the correct parameters for the PLL=
s so it will generate
a frequency that is different from the requested one.

Best regards,
Liviu


>=20
> > Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
>=20
> Thanks for all the ACKs.
>=20
> Regards,
> Sudeep
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
