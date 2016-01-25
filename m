From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Mon, 25 Jan 2016 11:11:34 -0600
Message-ID: <20160125171134.GA21713@rob-hp-laptop>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
 <1452598189-8272-1-git-send-email-andy.yan@rock-chips.com>
 <20160120182840.GA15741@rob-hp-laptop>
 <56A07A6D.3010406@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54130 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757928AbcAYRLq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Jan 2016 12:11:46 -0500
Content-Disposition: inline
In-Reply-To: <56A07A6D.3010406@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: heiko@sntech.de, arnd@arndb.de, john.stultz@linaro.org, linux@roeck-us.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, geert+renesas@glider.be, sre@kernel.org, olof@lixom.net, dbaryshkov@gmail.com, alexandre.belloni@free-electrons.com, jun.nie@linaro.org, pawel.moll@arm.com, f.fainelli@gmail.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, cernekee@gmail.com, linux-kernel@vger.kernel.org, dwmw2@infradead.org, mark.rutland@arm.com, maxime.ripard@free-electrons.com

On Thu, Jan 21, 2016 at 02:27:57PM +0800, Andy Yan wrote:
> Hi Rob:
>    thanks for your review.
> On 2016=E5=B9=B401=E6=9C=8821=E6=97=A5 02:28, Rob Herring wrote:
> >On Tue, Jan 12, 2016 at 07:29:49PM +0800, Andy Yan wrote:
> >>add device tree binding document for reboot-mode driver
> >>
> >>Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> >>
> >>---
> >>
> >>Changes in v2: None
> >>Changes in v1: None
> >>
> >>  .../bindings/power/reset/reboot-mode.txt           | 41 +++++++++=
++++++++
> >>  .../bindings/power/reset/syscon-reboot-mode.txt    | 52 +++++++++=
+++++++++++++
> >>  2 files changed, 93 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/power/reset/=
reboot-mode.txt
> >>  create mode 100644 Documentation/devicetree/bindings/power/reset/=
syscon-reboot-mode.txt
> >>
> >>diff --git a/Documentation/devicetree/bindings/power/reset/reboot-m=
ode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> >>new file mode 100644
> >>index 0000000..81d9f66
> >>--- /dev/null
> >>+++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> >>@@ -0,0 +1,41 @@
> >>+Generic reboot mode core map driver

[...]

> >>+		compatible =3D "syscon-reboot-mode";
> >>+		offset =3D <0x40>;
> >This doc by itself is a little confusing. For example, is a child of=
 the
> >syscon node? I would remove offset (and perhaps compatible) from thi=
s
> >example.
>=20
>    Yes, is a child of a syscon mapped node. For example, Rockchip pla=
tform
> use a register of PMU(rk3066/rk3288) or GRF(rk3036), PMU and GRF are =
aleady
> mapped by syscon.
>    offset and compatible are used by write interface driver like
> syscon-reboot-mode.c. If you don't like it appear in the core map doc=
, I
> will move it to the syscon-reboot-mode.txt?

Yes, try to make this doc stand on its own. It will obviously be=20
incomplete lacking information on where in the DT it goes. So perhaps a=
=20
note stating reboot-mode node location is defined in platform specific=20
binding docs.

> >>+
> >>+		loader {
> >>+			linux,mode =3D "loader";
> >>+			loader,magic =3D <BOOT_LOADER>;
> >>+		};
> >Sorry, my previous suggestion was not clear. I'm suggesting get rid =
of
> >the subnodes and just do properties like this:
> >
> >loader =3D <BOOT_LOADER>;
> >maskrom =3D <BOOT_MASKROM>;
> >
> >That's the same amount of information unless node names and linux,mo=
de
> >values are going to diverge. Do they need to? I can't see a reason.
>=20
>     Because the command"linux,mode" and value"loader,magic" is vendor
> specific. I don't know what commands and how many mode other platform=
 will
> use. So as John says in his reply, this sort of flexibility help us a=
dapt
> the driver to different hardware/system environments.

The only part of "reboot to fastboot" that is vendor specific would be=20
the magic value. While we can have custom modes, we should standardize=20
the common ones as much as possible. As I pointed out in my reply to=20
John, we can still support vendor specific modes with just a property.

> >
> >We need to be clear what loader means. More specifically, it is boot
> >into bootloader shell.
>     Actually, Rockchip platform will reboot into a bootloader downloa=
d mode
> with this command. This mode can download faster than maskrom downloa=
d mode.

My point is proven. I assumed one thing and you meant something else.=20
Doesn't matter what the mode is, just needs to be clear.

Rob
