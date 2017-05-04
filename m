From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
Date: Thu, 4 May 2017 15:08:41 +0200
Message-ID: <4ba6bdf2-56b2-972d-3326-0eda3985c80b@denx.de>
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
 <20170504124446.GO18578@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:52117 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdEDNIq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 May 2017 09:08:46 -0400
In-Reply-To: <20170504124446.GO18578@dragon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Peter Chen <Peter.Chen@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 05/04/2017 02:44 PM, Shawn Guo wrote:
> On Thu, May 04, 2017 at 12:06:11PM +0200, Marek Vasut wrote:
>> On 05/04/2017 11:42 AM, Leonard Crestez wrote:
>>> I think there is a further misunderstanding here. I have a problem
>>> where imx6sx-sdb rev C boards crash on boot with upstream (but are
>>> reported to work fine with rev B). Removing the OPP overrides fixes
>>> this specific issue.
>>>
>>> I don't object to the second part of your patch, setting correct supply links is a good thing for various reasons. It is just not necessary for fixing the concrete crash mentioned above (and I tested this). It should probably go in a separate patch.
>>
>> Mind you, my patch is not fixing any crash, it's correcting the
>> regulator binding and removing the OPP override which is at that
>> point useless.
> 
> Heh, that's the primary reason why I prefer Leonard's patch, as his
> patch is fixing a critical crash issue, while yours is just removing
> some useless stuff and correcting something that doesn't show any real
> problem.

Maybe you want to compare those two patches again, his patch fixing the
critical crash is removing the same "some useless stuff" as mine. Plus
mine is actually making sure the regulators are configured correctly,
not just removing "some useless stuff" and hoping for the best that
bootloader will do the right thing.

> So Leonard's patch will need to be applied for v4.12-rc and copy stable
> kernel, while yours will only be applied for next merge window as a
> cleanup/improving thing.

Well mine is bugfix, but I'm clearly unable to get that information across.

> Patches are similar, but they can be handled very differently, because
> commit log tells completely different stories.  Do you see how commit
> log matters now?

I understand how commit log matters and I still believe I described the
change there just fine.

>>> It might seem a pedantic difference but it's good to accurately describe the effect of patches in commit messages. For example it might help somebody looking to backport various fixes.
> 
> @Leonard, no, it's not pedantic at all.  I really appreciate your commit
> message and all the comments you added in the discussion, which is
> extremely helpful for us to understand the changes.
> 
>> Which part of the following commit message is unclear?
>>
>> "
>> The imx6sx-sdb has one power supply that drives both VDDARM_IN
>> and VDDSOC_IN, which is the sw1a regulator on the PFUZE PMIC.
>> Connect both inputs to the sw1a regulator on the PMIC and drop
>> the OPP hackery which is no longer needed as the power framework
>> will take care of the regulator configuration as needed.
>> "
> 
> Something unclear in my opinion:
> 
>  - The OPP hackery was never needed, as it's only needed for LDO bypass
>    mode which hasn't been supported by mainline kernel.  It's not 'no
>    longer needed as the power framework ...'.

I don't know what this is about, it's not from my patch either ...

>  - What are the related changes in power framework?  It will be more
>    clear if we can have the particular commit mentioned here.

Uh, I don't understand your question, there are no new changes in the
power framework. The DT for the SDB was always wrong, my patch fixes it.

>> btw if sending obvious bugfix upstream is met with this sort of
> 
> Leonard's patch is an obvious bugfix, but yours is not.

Please consider mine one. I marked it RFC because I don't even have the
board and I needed someone to test it.

>> resistance and pointless discussion, it is extremely demotivating.
> 
> As I said to Leonard above, the discussion is extremely helpful, IMO.
> 
>> Waiting for a maintainer reply for 2-4 weeks, only to get a kurt
> 
> This is not a paid job for maintainer.  It's expected that he doesn't
> always reply in a timely manner, especially when the tree is kinda
> 'frozen' for merge window.
> 
>> reply like "I don't like the commit message" doesn't help either.
> 
> What really annoys me is your attitude to commit message.

We had this discussion before ...

-- 
Best regards,
Marek Vasut
