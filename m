From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 0/7] thermal: Armada 375/380 SoC support
Date: Thu, 15 May 2014 17:14:04 +0800
Message-ID: <1400145244.2273.36.camel@rzhang1-toshiba>
References: <1399395591-5713-1-git-send-email-ezequiel.garcia@free-electrons.com>
	 <20140506173157.GA22929@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32330 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbaEOJOI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 May 2014 05:14:08 -0400
In-Reply-To: <20140506173157.GA22929@arch.cereza>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On =E4=BA=8C, 2014-05-06 at 14:31 -0300, Ezequiel Garcia wrote:
> Just a minor clarification:
>=20
> On 06 May 01:59 PM, Ezequiel Garcia wrote:
> > This patchset adds the support for the thermal sensor in the recent=
ly
> > introduced Armada 375 and 38x SoC. Compared to the previous patchse=
t
> > version, only the driver changes are being sent now. The rest has b=
een
> > merged by Jason Cooper through the mvebu tree.
> >=20
> > There are other very minor changes from v2, see below.
> >=20
> > The first five patches are preparation work. They add a generic
> > infrastructure that allows to support similar thermal sensors in
> > a non-intrusive way.
> >=20
> > Patches six and seven uses this infrastructure to support the=20
> > Armada 375 and 380 SoC thermal sensor.
> >=20
>=20
> Of course, the current series end right here, in patch seven...
>=20
> > Since there are some issues in the Armada 375 Z1 SoC thermal sensor=
,
> > patch eight adds a quirk to workaround such issues. The Z1 silicon =
stepping
> > is detected and the compatible string is updated, so the driver can=
 apply
> > sensor initialization workarounds.
> >=20
>=20
> .. the quirk patch has been already merged through mvebu.
>=20
> Thanks and sorry for the noise!
>=20
> Zhang: Any comments about the driver changes?

The whole series has been applied, with minor typo fix of patch 2/7,
according to Eduardo' comments.

thanks,
rui


