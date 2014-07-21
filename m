From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH 0/6] thermal: sti: Add new Thermal driver
Date: Mon, 21 Jul 2014 11:13:06 +0100
Message-ID: <20140721101306.GW30888@lee--X1>
References: <1401980819-19962-1-git-send-email-lee.jones@linaro.org>
 <20140624092309.GD13803@lee--X1>
 <20140709120823.GA32573@lee--X1>
 <1404911964.28592.4.camel@rzhang1-toshiba>
 <20140709134646.GB479@lee--X1>
 <20140714130824.GA3993@lee--X1>
 <1405347277.28592.25.camel@rzhang1-toshiba>
 <20140714142703.GC3993@lee--X1>
 <20140721091753.GV30888@lee--X1>
 <1405935299.2455.3.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:53413 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbaGUKNV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 06:13:21 -0400
Received: by mail-yh0-f49.google.com with SMTP id b6so3662069yha.36
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2014 03:13:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405935299.2455.3.camel@rzhang1-toshiba>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, ajitpal.singh@st.com, edubezval@gmail.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com

On Mon, 21 Jul 2014, Zhang Rui wrote:

> On Mon, 2014-07-21 at 10:17 +0100, Lee Jones wrote:
> > On Mon, 14 Jul 2014, Lee Jones wrote:
> >=20
> > > On Mon, 14 Jul 2014, Zhang Rui wrote:
> > >=20
> > > > On Mon, 2014-07-14 at 14:08 +0100, Lee Jones wrote:
> > > > > On Wed, 09 Jul 2014, Lee Jones wrote:
> > > > > > On Wed, 09 Jul 2014, Zhang Rui wrote:
> > > > > > > On Wed, 2014-07-09 at 13:08 +0100, Lee Jones wrote:
> > > > > > > > On Tue, 24 Jun 2014, Lee Jones wrote:
> > > > > > > >=20
> > > > > > > > > > I'm re-sending this set, as one of the maintainers'=
 email addresses
> > > > > > > > > > is incorrect in the MAINTAINERS file.
> > > > > > > > > >=20
> > > > > > > > > > This patchset adds full support for 2 types of Ther=
mal Controllers
> > > > > > > > > > produced by STMicroelectronics.  One is a more trad=
itional memory
> > > > > > > > > > mapped variant, the other is controlled solely by s=
ystem configuration
> > > > > > > > > > registers.
> > > > > > > > >=20
> > > > > > > > > Any thing from the Thermal guys? Has this set fallen =
through the gaps?
> > > > > > > >=20
> > > > > > > > Anything at all?  It's been well over a month now.
> > > > > > > >=20
> > > > > > > Well, for the soc thermal drivers, I'd prefer to take the=
m via Eduardo,
> > > > > > > but as we didn't get any feedback from Eduardo, I will ta=
ke them.
> > > > > >=20
> > > > > > Thanks Rui.
> > > > > >=20
> > > > > > So have you taken all 4 "thermal: sti: *" patches?
> > > > >=20
> > > > > Have you taken these yet?
> > > >=20
> > > > Not yet. will do tomorrow.
> >=20
> > I waited 7 days and still don't see them?
> >=20
> Done, they're in my local tree and I forgot to push them.
> thanks for the reminder.

Thanks dude.

> > > Perfect, thanks for the update.
> > >=20
> > > > >   I notice that these aren't in -next yet.
> >=20
>=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
