From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 01/70] cpufreq: interactive: New 'interactive' governor
Date: Mon, 2 Nov 2015 10:06:03 -0800
Message-ID: <5637A60B.7010104@linaro.org>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
 <4534884.dsz2GVUDrG@vostro.rjw.lan> <20151028030042.GD13324@ubuntu>
 <20151102140255.GS17308@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35992 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbbKBSGH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2015 13:06:07 -0500
Received: by pacfv9 with SMTP id fv9so161732869pac.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2015 10:06:06 -0800 (PST)
In-Reply-To: <20151102140255.GS17308@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?UTF-8?Q?B=c3=a1lint_Czobor?= <czoborbalint@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mike Chan <mike@android.com>, Todd Poynor <toddpoynor@google.com>, Ingo Molnar <mingo@kernel.org>

On 11/02/2015 06:02 AM, Peter Zijlstra wrote:
> On Wed, Oct 28, 2015 at 08:30:42AM +0530, Viresh Kumar wrote:
>> These are the last memories I have around upstreaming this governor:
>> http://marc.info/?l=linux-kernel&m=132867057910479&w=2
>>
>> Has anything changed after that? Or we decided to go ahead with it and
>> upstream ?
> 
> Urgh, I thought we were trying to kill all the various governors by
> integrating the lot with the scheduler !?

That's the goal but it may be a while. There are major unanswered questions IMO about the viability of replacing all the governers with a single scheduler-driven implementation. Is per-entity load tracking responsive enough to drive CPU frequency? Can we replicate the functionality available and being used today with the proposed design? These aren't necessarily showstoppers but they could require considerable extra work (and debate).

If we move forward without ensuring these concerns are addressed I believe it would make things even worse than they are now since there will be people/vendors remaining behind on cpufreq governors, forward porting them if necessary, and there will be the fundamentally different sched-driven solution to support and maintain as well.

Having the interactive governor in the tree would help in the evaluation and comparison process, and also immediately address a widely used component being out of tree.
