From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] ARM: mvebu: SoC changes for v3.17 (round 3)
Date: Wed, 23 Jul 2014 16:45:15 -0700
Message-ID: <CAOesGMj1euJo-NPO-Ah18enuJc12u9ndaYo=9dM37pX_yX-wUw@mail.gmail.com>
References: <20140722205706.GA23220@titan.lakedaemon.net>
	<201407232231.41787.arnd@arndb.de>
	<20140723234130.GM23220@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:37005 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758541AbaGWXpQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 19:45:16 -0400
Received: by mail-vc0-f169.google.com with SMTP id hu12so3594489vcb.28
        for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2014 16:45:15 -0700 (PDT)
In-Reply-To: <20140723234130.GM23220@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, "arm@kernel.org" <arm@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Jul 23, 2014 at 4:41 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Wed, Jul 23, 2014 at 10:31:41PM +0200, Arnd Bergmann wrote:
>> On Tuesday 22 July 2014, Jason Cooper wrote:
>> > All,
>> >
>> > Here's the cpufreq changes I mentioned over the weekend.  It's been in
>> > -next for a while.  Once I get the new version of cpuidle from ThomasP,
>> > I'll push that as quickly as possible.
>>
>> Just for my information, is this coordinated with the cpufreq maintainers?
>> I remember being asked to ensure all cpufreq/cpuidle stuff has an Ack
>> from them, even stuff that doesn't touch drivers/cpufreq at all.
>
> Good to know.
>
>> The contents look good to me. I can merge them if there are no objections
>> from Viresh, feel free to send the next batch already without waiting
>> for me to pull.
>
> We've been coordinating with Viresh.  He has an unsettled issue on his
> side he hopes to have resolved soon.  Worst case scenario, he doesn't
> get the change in for v3.17, we'll have to do a minor DT fix on top of
> -rc1.
>
>> > As usual (do I need to type this each time any more? :) ), this is an
>> > incremental pull request from tags/mvebu-soc-3.17-2 up to
>> > tags/mvebu-soc-3.17-3 on the mvebu/soc branch.
>>
>> It certainly helps me to have this information, but you can write it
>> more briefly, e.g. "based on tags/mvebu-soc-3.17-2".
>
> Ahhhh....  Much more succinct.  Thank you.  On a side note, I wonder
> what it would take to get 'git request-pull' smart enough to add that
> information when handed a tag?
>
>> > The following changes since commit ba364fc752daeded072a5ef31e43b84cb1f9e5fd:
>> >
>> >   ARM: Kirkwood: Remove mach-kirkwood (2014-07-13 22:13:39 +0000)
>
> eg:
>
>   ARM: Kirkwood: Remove mach-kirkwood (tags/mvebu-soc-3.17-2)

That only maps to the tag in your tree, which might or might not map
directly to something that we know or care about. We do tend to keep
naming similar, but not always identical. For example, the branch for
that tag would be mvebu/soc2 in our tree.

>> >
>> > are available in the git repository at:
>> >
>> >   git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.17-3
>> >
>> > for you to fetch changes up to ba3ec5780bba27819bbc4f669e6c77418a00f14b:
>> >
>> >   Merge branch 'mvebu/soc-cpufreq' into mvebu/soc (2014-07-22 20:46:48 +0000)
>> >
>> > ----------------------------------------------------------------
>
> Is the date of the base commit useful in any way in the pull request?

I find the SHA to be useful, I will sometimes run "git branch
--contains ba3ec57<...>" to see where the base is merged already. The
date, for me, less so.


-Olof
