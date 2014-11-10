From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/5] cpufreq, fix locking around CPUFREQ_GOV_POLICY_EXIT calls
Date: Mon, 10 Nov 2014 16:14:57 +0530
Message-ID: <CAKohpomZNwZWjmi8hkZ6QXUeDTaXTwzx_fPz1_byh3xmmkPNrQ@mail.gmail.com>
References: <1415199239-19019-1-git-send-email-prarit@redhat.com>
	<1415199239-19019-3-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:50479 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbaKJKo6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 05:44:58 -0500
Received: by mail-oi0-f44.google.com with SMTP id h136so5205607oig.31
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2014 02:44:57 -0800 (PST)
In-Reply-To: <1415199239-19019-3-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 5 November 2014 20:23, Prarit Bhargava <prarit@redhat.com> wrote:
> commit 955ef4833574636819cd269cfbae12f79cbde63a (" cpufreq: Drop rwsem
> lock around CPUFREQ_GOV_POLICY_EXIT") opens up a hole in the locking
> scheme for cpufreq.
>
> Simple tests such as rapidly switching the governor between ondemand and
> performance or attempting to read policy values while a governor switch occurs
> now fail with very NULL pointer warnings, sysfs namespace collisions, and
> system hangs.  In short, the locking that policy->rwsem is supposed to provide
> is currently broken.
>
> The identified commit attempts to resolve a lockdep warning by removing
> a lock around a section of code which does a shutdown of the
> existing policy.  The problem is that this is part of the _critical_ section of
> code that switches the governors and must be protected by the lock; without
> locking readers may access now NULL or stale data, and writes may collide with
> each other.
>
> With the previous patch, which now returns -EBUSY during times of
> contention the deadlock reported in
> 955ef4833574636819cd269cfbae12f79cbde63a (" cpufreq: Drop rwsem lock
> around CPUFREQ_GOV_POLICY_EXIT") cannot occur, so adding the locks back
> into this section of code is possible.

I still fail to understand why ? What will the _trylock() change ?
