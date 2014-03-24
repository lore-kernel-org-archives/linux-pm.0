From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [RFC v3 0/5] cpufreq:LAB: Support for LAB governor.
Date: Mon, 24 Mar 2014 11:00:32 +0100
Message-ID: <20140324110032.7aeae15e@amdc2363>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
 <1393928852-22725-1-git-send-email-l.majewski@samsung.com>
 <CAKohpok1zBsX7n70r=geCOaP-9ONx2QdaUMK6cJeqhFrO1PkUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:20085 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaCXKAm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Mar 2014 06:00:42 -0400
In-reply-to: <CAKohpok1zBsX7n70r=geCOaP-9ONx2QdaUMK6cJeqhFrO1PkUg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Thomas Abraham <ta.omasab@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>

Hi Viresh,

> On 4 March 2014 15:57, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > Despite this patch set is working and applicable on top of 3.14-rc5,
> > please regard it solely as a pure RFC.
> 
> Okay, I am trying to do a review here and because you have mentioned
> how different it is from the earlier versions, I am trying with a
> fresh mind. i.e. with zero memories of earlier discussions :)
> 
> LAB was: Legacy Application Boost ??

Yes, correct.

> 
> Probably mention that in your new threads as well, so that new readers
> know the details. Also, like other governors, just name it "boost"
> governor.

I think, that "LAB" name is with us for some time, so it would be a
pity to discard it.

> 
> > This patch provides support for LAB governor build on top of
> > ondemand. Previous version of LAB can be found here:
> > http://thread.gmane.org/gmane.linux.kernel/1484746/match=cpufreq
> >
> > LAB short reminder:
> >
> > LAB uses information about how many cores are in "idle" state (the
> > core idleness is represented as the value between 0 and 100) and
> > the overall load of the system (from 0 to 100) to decide about
> > frequency to be set. It is extremely useful with SoCs like
> > Exynos4412, which can set only one frequency for all cores.
> 
> Probably a description of how exactly these two values come into play
> would have been more interesting here for all. Always think of new
> followers of your patchset and so add all interesting things about it
> when you resend it.
> 
> If I remember well the logic was more or less like this:
> - More idle cores means run few running cores at high frequency
> - Less idle cores means don't run them at very high frequencies
> 
> Right?

This is correct. Also, the underlying SoC - Exynos4412 has 4 cores with
option to set frequency only on all of them.

> 
> What about making it as simple as:
> - changing the ondemand governor only instead of adding a new governor

My goal is to not touch the ondemand code. It has matured, so I would
like to leave it as it is.

> - Keeping the bahavior as is for all platforms not publishing boost
> frequencies

This is also done - you get the LAB configuration specified in the DT
for the particular platform/board.

> - If more cores are idle, enable switching to boost frequencies and
> take them into consideration all the time.

I'm not sure if I have understood you, but something like that is also
performed in the code.

> - If less cores are idle, disable boost frequencies..

As written above.

> 
> Lets discuss this first and then I will get into the very details of
> your implementation.

Discussion about above functionalities requires consulting the
implementation to be sure that our opinions are the same.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
