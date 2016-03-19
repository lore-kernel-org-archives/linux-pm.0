From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when
 considering polling
Date: Sat, 19 Mar 2016 03:33:49 +0100
Message-ID: <CAJZ5v0hF-rdmXvZhUKmRQmnX9Ho0o3snsW__Y8Y9ohDqajfXwQ@mail.gmail.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>
	<20160316121400.680a6a46@annuminas.surriel.com>
	<10828426.sI6CaBvZhk@vostro.rjw.lan>
	<000701d180df$e8a14340$b9e3c9c0$@net>
	<CAJZ5v0gLXE=sRxv35hKuX88L4tphSBtPb9Y2oLERuEhjsbTGJQ@mail.gmail.com>
	<003301d18144$87bb8df0$9732a9d0$@net>
	<20160318173551.675ff6e5@annuminas.surriel.com>
	<CAJZ5v0hLAiVoEn0PbVo++UDrXvizYC0EeAoqj8drS3GR5mQTig@mail.gmail.com>
	<1458352411.14723.55.camel@redhat.com>
	<CAJZ5v0iQhVsyq7o8kbvppENdhvKFCZTSzWswCmELa2ithkm1iA@mail.gmail.com>
	<1458353850.14723.57.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33629 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbcCSCdv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 22:33:51 -0400
Received: by mail-lf0-f54.google.com with SMTP id h198so76902863lfh.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2016 19:33:50 -0700 (PDT)
In-Reply-To: <1458353850.14723.57.camel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Sat, Mar 19, 2016 at 3:17 AM, Rik van Riel <riel@redhat.com> wrote:
> On Sat, 2016-03-19 at 03:06 +0100, Rafael J. Wysocki wrote:
>> On Sat, Mar 19, 2016 at 2:53 AM, Rik van Riel <riel@redhat.com>
>> wrote:
>> >
>> > The kernel test robot also showed over 6% improvement in (IIRC)
>> > the wikibench test, with polling being done a little more often.
>> >
>> > Other parts of the kernel do pretty much anything for 2% extra
>> > performance, so if we can find a way to preserve that 6%, without
>> > hurting power usage significantly, I suspect it may be worthwhile.
>> Well. OK.  That is a worthy goal, but things in this thread look a
>> bit
>> too ad-hoc to me to be honest.
>>
>> I'd like to take one step at a time and in such a way that
>> improvements are actually confirmed in every step.
>>
>> Does this sound reasonable?
>>
>> If so, I first would like to restore the energy consumption in the
>> Doug's case at least to the level from before commit a9ceb78bc75c
>> (cpuidle,menu: use interactivity_req to disable polling).  That's
>> what
>> I'd like to do for 4.6 and possibly before the merge window is over.
>>
>> After 4.6-rc1, in the 4.7 cycle, we can think about improving
>> performance here and maybe sacrificing some energy for that, but in a
>> controlled way as I said above.
>>
>> What do you think?
>
> That sounds perfectly reasonable to me.
>
> Count me in for any efforts to improve performance with
> the cpuidle code, and hopefully allow more people to enable
> c-states on their servers.

OK, great!

I'm going to send a patch for Doug to test that I'd like to apply for
4.6 (on top of http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=e132b9b3bc7f19e9b158e42b323881d5dee5ecf3),
maybe not today (because I'm falling asleep now), but likely tomorrow
or on Sunday.  If that restores things for him, I'll apply it and that
will be the starting point for future changes.
