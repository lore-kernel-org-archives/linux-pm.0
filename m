From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH 0/6] thermal: sti: Add new Thermal driver
Date: Mon, 14 Jul 2014 14:08:24 +0100
Message-ID: <20140714130824.GA3993@lee--X1>
References: <1401980819-19962-1-git-send-email-lee.jones@linaro.org>
 <20140624092309.GD13803@lee--X1>
 <20140709120823.GA32573@lee--X1>
 <1404911964.28592.4.camel@rzhang1-toshiba>
 <20140709134646.GB479@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36892 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849AbaGNNIb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jul 2014 09:08:31 -0400
Received: by mail-ie0-f177.google.com with SMTP id at20so3215018iec.22
        for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2014 06:08:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140709134646.GB479@lee--X1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, ajitpal.singh@st.com, edubezval@gmail.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com

On Wed, 09 Jul 2014, Lee Jones wrote:
> On Wed, 09 Jul 2014, Zhang Rui wrote:
> > On Wed, 2014-07-09 at 13:08 +0100, Lee Jones wrote:
> > > On Tue, 24 Jun 2014, Lee Jones wrote:
> > >=20
> > > > > I'm re-sending this set, as one of the maintainers' email add=
resses
> > > > > is incorrect in the MAINTAINERS file.
> > > > >=20
> > > > > This patchset adds full support for 2 types of Thermal Contro=
llers
> > > > > produced by STMicroelectronics.  One is a more traditional me=
mory
> > > > > mapped variant, the other is controlled solely by system conf=
iguration
> > > > > registers.
> > > >=20
> > > > Any thing from the Thermal guys? Has this set fallen through th=
e gaps?
> > >=20
> > > Anything at all?  It's been well over a month now.
> > >=20
> > Well, for the soc thermal drivers, I'd prefer to take them via Edua=
rdo,
> > but as we didn't get any feedback from Eduardo, I will take them.
>=20
> Thanks Rui.
>=20
> So have you taken all 4 "thermal: sti: *" patches?

Have you taken these yet?  I notice that these aren't in -next yet.

> The ARM ones should go through Maxime.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
