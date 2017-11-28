From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 1/4] thermal: imx: Use better parameter names than "val"
Date: Tue, 28 Nov 2017 15:20:43 +0200
Message-ID: <1511875243.20123.41.camel@nxp.com>
References: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
         <20171121200225.23316-2-u.kleine-koenig@pengutronix.de>
         <1511807971.20123.29.camel@nxp.com>
         <20171127195038.k3ntwdqmdibfooi7@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-sn1nam01on0076.outbound.protection.outlook.com ([104.47.32.76]:36148
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753116AbdK1NUs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Nov 2017 08:20:48 -0500
In-Reply-To: <20171127195038.k3ntwdqmdibfooi7@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, kernel@pengutronix.de

On Mon, 2017-11-27 at 20:50 +0100, Uwe Kleine-König wrote:
> On Mon, Nov 27, 2017 at 08:39:31PM +0200, Leonard Crestez wrote:
> > On Tue, 2017-11-21 at 21:02 +0100, Uwe Kleine-König wrote:
> > > 
> > > The values passed to imx_init_calib() and imx_init_temp_grade() are
> > > read from specific OCOTP values. Use their names (in lower case) as
> > > parameter name instead of "val" to make the code easier to understand.
> > > 

> > > -static void imx_init_temp_grade(struct platform_device *pdev, u32 val)
> > > +static void imx_init_temp_grade(struct platform_device *pdev, u32 ocotp_mem0)

> > On imx7 (thermal not currently supported in upstream) the temperature
> > grade is in OCOTP_TESTER3. So using a more generic parameter name here
> > would be preferable or this would have to be changed again later.

> Then I suggest to change the semantic and make this:
> 
> 	imx_init_temp_grade(struct platform_device *pdev, u32 grade)
> 
> and let the caller do the bit shift and masking.

That would work. It just so happens that the grade is stored in the
same bits.

It might be better to deal with this when adding imx7 thermal support
instead.

> Does the same problem exist for ocotp_ana1?

No, not that I know of.
