Return-Path: <SRS0=MfD0=YJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE82ECE599
	for <linux-pm@archiver.kernel.org>; Wed, 16 Oct 2019 22:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023BC21928
	for <linux-pm@archiver.kernel.org>; Wed, 16 Oct 2019 22:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391986AbfJPWBX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:01:23 -0400
Received: from muru.com ([72.249.23.125]:37610 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391943AbfJPWBX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Oct 2019 18:01:23 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 099658107;
        Wed, 16 Oct 2019 22:01:55 +0000 (UTC)
Date:   Wed, 16 Oct 2019 15:01:18 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 1/5] power: supply: cpcap-battery: Move coulomb counter
 units per lsb to ddata
Message-ID: <20191016220118.GG5610@atomide.com>
References: <20191009210621.10522-1-tony@atomide.com>
 <20191009210621.10522-2-tony@atomide.com>
 <20191013105505.GA26237@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191013105505.GA26237@amd>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [191013 10:56]:
> On Wed 2019-10-09 14:06:17, Tony Lindgren wrote:
> > We can simplify cpcap_battery_cc_raw_div() a bit by moving the units per
> > lsb to ddata.
> > 
> > Cc: Merlijn Wajer <merlijn@wizzup.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/power/supply/cpcap-battery.c | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
> > --- a/drivers/power/supply/cpcap-battery.c
> > +++ b/drivers/power/supply/cpcap-battery.c
> > @@ -111,6 +111,7 @@ struct cpcap_battery_ddata {
> >  	struct power_supply *psy;
> >  	struct cpcap_battery_config config;
> >  	struct cpcap_battery_state_data state[CPCAP_BATTERY_STATE_NR];
> > +	u32 cc_lsb;		/* μAms per LSB */
> 
> micro-Ampere-seconds? Should be uAs?

That's micro-Ampere-milliseconds per LSB here.

Regards,

Tony
