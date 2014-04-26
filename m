From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 00/10] thermal: Armada 375/380 SoC support
Date: Fri, 25 Apr 2014 22:45:09 -0300
Message-ID: <20140426014509.GA1043@arch.cereza>
References: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140426005516.GR28159@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51060 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750756AbaDZBpu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Apr 2014 21:45:50 -0400
Content-Disposition: inline
In-Reply-To: <20140426005516.GR28159@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Tawfik Bayouk <tawfik@marvell.com>, devicetree@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hello Zhang,

On Apr 25, Jason Cooper wrote:
> On Thu, Apr 24, 2014 at 05:23:14PM -0300, Ezequiel Garcia wrote:
> > This patchset adds the support for the thermal sensor in the recent=
ly
> > introduced Armada 375 and 38x SoC. Compared to the previous patchse=
t
> > version, this v2 introduces the A380 SoC support.
> >=20
> > The first five patches are preparation work. They add a generic
> > infrastructure that allows to support similar thermal sensors in
> > a non-intrusive way.
> >=20
> > Patches six and seven uses this infrastructure to support the=20
> > Armada 375 and 380 SoC thermal sensor.
> >=20
> > Since there are some issues in the Armada 375 Z1 SoC thermal sensor=
,
> > patch eight adds a quirk to workaround such issues. The Z1 silicon =
stepping
> > is detected and the compatible string is updated, so the driver can=
 apply
> > sensor initialization workarounds.
> >=20
> > In addition, the quirk moves the offset of the thermal control regi=
ster,
> > and allows to specifiy the correct (A0 stepping) offset in the devi=
cetree.
> > This quirk is applied only for the A375-DB board, being the only bo=
ard known
> > to have the problematic Z1 SoC.
> >=20
> > Finally, the last two patches enables the thermal sensor in the dev=
icetree.
> > for the Armada 375 A0 stepping SoC, and the Armada 380/385 SoCs.
> >=20
> > The series applies on v3.15-rc1, and has been tested on A375-DB boa=
rd
> > and A385-DB board.
> >=20
> > Feedback and comments are welcome!
> >=20
> > Changes from v1:
> >=20
> >   * Introduced the Armada 380 support. In order to support this in =
a clean
> >     way, the 'inverted' field was added.
> >=20
> >   * Cleaned the A375 workaround in the thermal driver, by detecting=
 the
> >     device compatible string, as suggested by Jason Cooper.
> >=20
> >   * Added details about the register offset in the Z1 stepping to t=
he
> >     binding documentation as requested by Jason Cooper.
> >=20
> > Ezequiel Garcia (10):
> >   thermal: armada: Rename armada_thermal_ops struct
> >   thermal: armada: Add infrastructure to support generic formulas
> >   thermal: armada: Add generic infrastructure to handle the sensor
> >   thermal: armada: Pass the platform_device to init_sensor()
> >   thermal: armada: Allow to specify an 'inverted readout' sensor
> >   thermal: armada: Support Armada 375 SoC
> >   thermal: armada: Support Armada 380 SoC
>=20
> Thermal series:
>=20
> Acked-by: Jason Cooper <jason@lakedaemon.net>
>=20

Do you have any comments about this?

Thanks!
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
