Return-Path: <SRS0=AVup=YI=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071EBECE588
	for <linux-pm@archiver.kernel.org>; Tue, 15 Oct 2019 17:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB75B20650
	for <linux-pm@archiver.kernel.org>; Tue, 15 Oct 2019 17:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbfJORW2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:22:28 -0400
Received: from muru.com ([72.249.23.125]:37368 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfJORW2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Oct 2019 13:22:28 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0E9178108;
        Tue, 15 Oct 2019 17:23:00 +0000 (UTC)
Date:   Tue, 15 Oct 2019 10:22:23 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH] power: supply: cpcap-charger: Limit voltage to 4.2V for
 battery
Message-ID: <20191015172223.GZ5610@atomide.com>
References: <20191009203355.5622-1-tony@atomide.com>
 <20191013112714.GA5653@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013112714.GA5653@amd>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [191013 11:27]:
> Hi!
> 
> > There have been some cases of droid4 battery bulging that seem to be
> > related to being left connected to the charger for several weeks.
> > 
> > It is suspected that the 4.35V charge voltage configured for the battery
> > is too much in the long run, so lets limit the charge voltage to 4.2V.
> > It could also be that the batteries are just getting old.
> > 
> > We don't really want to just change the charge voltage to 4.2V as Android
> > may have charged the battery to 3.51.V as pointed out by Pavel
> > Machek.
> 
> Now I'm confused. What is 3.51V? Is it typo for 4.35V?
> 
> > +	/*
> > +	 * If battery voltage is higher than charge voltage, it may have been
> > +	 * charged to 3.51V by Android. Try again in 10 minutes.
> > +	 */
> 
> Ok, so maybe it is not a typo. I'm confused.

Hmm a long mistake.. No idea what I was thinking with 3.51..
Yeah both should be 4.35V.

> Note that I'd prefer not to see this in -stable.

OK. In that case I'll send a new version with the typos
fixed against v5.4-rc cycle instead of v5.3.

Regards,

Tony

