From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v3 0/7] thermal: Armada 375/380 SoC support
Date: Tue, 6 May 2014 14:31:57 -0300
Message-ID: <20140506173157.GA22929@arch.cereza>
References: <1399395591-5713-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:53680 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750892AbaEFRcb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 May 2014 13:32:31 -0400
Content-Disposition: inline
In-Reply-To: <1399395591-5713-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Just a minor clarification:

On 06 May 01:59 PM, Ezequiel Garcia wrote:
> This patchset adds the support for the thermal sensor in the recently
> introduced Armada 375 and 38x SoC. Compared to the previous patchset
> version, only the driver changes are being sent now. The rest has bee=
n
> merged by Jason Cooper through the mvebu tree.
>=20
> There are other very minor changes from v2, see below.
>=20
> The first five patches are preparation work. They add a generic
> infrastructure that allows to support similar thermal sensors in
> a non-intrusive way.
>=20
> Patches six and seven uses this infrastructure to support the=20
> Armada 375 and 380 SoC thermal sensor.
>=20

Of course, the current series end right here, in patch seven...

> Since there are some issues in the Armada 375 Z1 SoC thermal sensor,
> patch eight adds a quirk to workaround such issues. The Z1 silicon st=
epping
> is detected and the compatible string is updated, so the driver can a=
pply
> sensor initialization workarounds.
>=20

=2E. the quirk patch has been already merged through mvebu.

Thanks and sorry for the noise!

Zhang: Any comments about the driver changes?
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
