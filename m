From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC][PATCH v5 00/14] sched: packing tasks
Date: Mon, 25 Nov 2013 19:55:59 +0100
Message-ID: <52939D3F.3050409@linaro.org>
References: <1382097147-30088-1-git-send-email-vincent.guittot@linaro.org> <CAHkRjk69GNYtLGBSWCNcsCzkBHywKrD0qQQbNkJRpMbcdsCPyw@mail.gmail.com> <20131111163630.GD26898@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:64691 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab3KYSz4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2013 13:55:56 -0500
Received: by mail-ea0-f173.google.com with SMTP id g15so2761620eak.18
        for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2013 10:55:54 -0800 (PST)
In-Reply-To: <20131111163630.GD26898@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Chris Metcalf <cmetcalf@tilera.com>, Tony Luck <tony.luck@intel.com>, "alex.shi@intel.com" <alex.shi@intel.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, "len.brown@intel.com" <len.brown@intel.com>, l.majewski@samsung.com, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm@vger.kernel.org

On 11/11/2013 05:36 PM, Peter Zijlstra wrote:
> On Mon, Nov 11, 2013 at 11:33:45AM +0000, Catalin Marinas wrote:
>
> tl;dr :-) Still trying to wrap my head around how to do that weird
> topology Vincent raised..
>
>> Question for Peter/Ingo: do you want the scheduler to decide on whic=
h
>> C-state a CPU should be in or we still leave this to a cpuidle
>> layer/driver?
>
> I think the can leave most of that in a driver; right along with how =
to
> prod the hardware to actually get into that state.
>
> I think the most important parts are what is now 'generic' code; stuf=
f
> that guestimates the idle-time and so forth.
>
> I think the scheduler simply wants to say: we expect to go idle for X
> ns, we want a guaranteed wakeup latency of Y ns -- go do your thing.

Hi Peter,

IIUC, for full integration in the scheduler, we should eradicate the=20
idle task and the related code tied with it, no ?

> I think you also raised the point in that we do want some feedback as=
 to
> the cost of waking up particular cores to better make decisions on wh=
ich
> to wake. That is indeed so.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

