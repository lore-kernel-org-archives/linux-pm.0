From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: unlock correct rwsem while updating policy->cpu
Date: Tue, 17 Sep 2013 10:16:42 +0530
Message-ID: <CAKohpo=kgYoSKJVpQRPP-QVZXWYXgD4OXukPyzdgC-6n0DhsWA@mail.gmail.com>
References: <075032be4fd288074b8f699d4f4ba0179518df6f.1379344038.git.viresh.kumar@linaro.org>
	<1379348823.3422.42.camel@linaro1.home>
	<CAKohpomEQsS-WHQpa=_07NQ1FXDB711inrmMgUguD529BA7g1A@mail.gmail.com>
	<1379356930.3422.71.camel@linaro1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:60379 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab3IQEqn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2013 00:46:43 -0400
Received: by mail-oa0-f50.google.com with SMTP id l10so828196oag.37
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 21:46:42 -0700 (PDT)
In-Reply-To: <1379356930.3422.71.camel@linaro1.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>

On 17 September 2013 00:12, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> The commit log to that patch still mentions taking both locks.

Yeah, it was sent in hurry to just give you a working solution and I forgot
to see the log if it is still valid.

> The code itself fixes the lockdep errors I had, so
>
> Tested-by: Jon Medhurst <tixy@linaro.org>

Great!!

> however, I still have concerns about the locking (below)...

:(

> But what about reads, like in cpufreq_frequency_table_update_policy_cpu
> which is called immediately after the unlocking writes? Should that not
> be covered by a reader lock?
>
> And after that call, policy is passed into blocking_notifier_call_chain,
> do those callbacks not want to look at policy fields? Or are they going
> to do there own locking?

policy->cpu is used at multiple places outside of cpufreq.c and cpufreq
core can't really put read locks for those accesses. Things will turn bad
only if cpufreq core has got these races where we are trying to access
a struct or pointer that belonged to the last policy->cpu, which is updated
now.. For example the case of lock you reported.. And so lock is required
only for those places..

> Or is update_policy_cpu itself meant to be called with a read lock held?

No.

> This is the first time I've looked at this code, so feel free just to
> say 'it's complicated, just trust me, I'm the expert, I know what I'm
> doing'...

We aren't that rude :)

Now, that you have tested this patch let me resent it...
