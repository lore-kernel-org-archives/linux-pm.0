From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
Date: Thu, 4 May 2017 20:44:48 +0800
Message-ID: <20170504124446.GO18578@dragon>
References: <1493141004.3557.8.camel@nxp.com>
 <f3bbd20c-2132-1121-1044-ba00dba302d6@denx.de>
 <20170503135715.GG18578@dragon>
 <76e22a7e-590f-00ee-04f8-87604303eaad@denx.de>
 <1493823533.11226.28.camel@nxp.com>
 <e46a57c2-4a28-a8b6-445e-299dd9d8659c@denx.de>
 <1493834298.11226.40.camel@nxp.com>
 <51fb1bd0-028d-c431-acc8-3c4f1d25fdba@denx.de>
 <1493890943.11226.42.camel@nxp.com>
 <6dbf67a0-42ea-ee84-d144-41422a21c1c5@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbdEDMpQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 May 2017 08:45:16 -0400
Content-Disposition: inline
In-Reply-To: <6dbf67a0-42ea-ee84-d144-41422a21c1c5@denx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Peter Chen <Peter.Chen@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, May 04, 2017 at 12:06:11PM +0200, Marek Vasut wrote:
> On 05/04/2017 11:42 AM, Leonard Crestez wrote:
> > I think there is a further misunderstanding here. I have a problem
> > where imx6sx-sdb rev C boards crash on boot with upstream (but are
> > reported to work fine with rev B). Removing the OPP overrides fixes
> > this specific issue.
> > 
> > I don't object to the second part of your patch, setting correct supply links is a good thing for various reasons. It is just not necessary for fixing the concrete crash mentioned above (and I tested this). It should probably go in a separate patch.
> 
> Mind you, my patch is not fixing any crash, it's correcting the
> regulator binding and removing the OPP override which is at that
> point useless.

Heh, that's the primary reason why I prefer Leonard's patch, as his
patch is fixing a critical crash issue, while yours is just removing
some useless stuff and correcting something that doesn't show any real
problem.

So Leonard's patch will need to be applied for v4.12-rc and copy stable
kernel, while yours will only be applied for next merge window as a
cleanup/improving thing.

Patches are similar, but they can be handled very differently, because
commit log tells completely different stories.  Do you see how commit
log matters now?

> > It might seem a pedantic difference but it's good to accurately describe the effect of patches in commit messages. For example it might help somebody looking to backport various fixes.

@Leonard, no, it's not pedantic at all.  I really appreciate your commit
message and all the comments you added in the discussion, which is
extremely helpful for us to understand the changes.

> Which part of the following commit message is unclear?
> 
> "
> The imx6sx-sdb has one power supply that drives both VDDARM_IN
> and VDDSOC_IN, which is the sw1a regulator on the PFUZE PMIC.
> Connect both inputs to the sw1a regulator on the PMIC and drop
> the OPP hackery which is no longer needed as the power framework
> will take care of the regulator configuration as needed.
> "

Something unclear in my opinion:

 - The OPP hackery was never needed, as it's only needed for LDO bypass
   mode which hasn't been supported by mainline kernel.  It's not 'no
   longer needed as the power framework ...'.

 - What are the related changes in power framework?  It will be more
   clear if we can have the particular commit mentioned here.

> btw if sending obvious bugfix upstream is met with this sort of

Leonard's patch is an obvious bugfix, but yours is not.

> resistance and pointless discussion, it is extremely demotivating.

As I said to Leonard above, the discussion is extremely helpful, IMO.

> Waiting for a maintainer reply for 2-4 weeks, only to get a kurt

This is not a paid job for maintainer.  It's expected that he doesn't
always reply in a timely manner, especially when the tree is kinda
'frozen' for merge window.

> reply like "I don't like the commit message" doesn't help either.

What really annoys me is your attitude to commit message.

Shawn
