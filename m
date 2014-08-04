From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq, store_scaling_governor requires policy->rwsem to
 be held for duration of changing governors
Date: Mon, 4 Aug 2014 15:24:40 +0530
Message-ID: <CAKohpoksKz5437Yds0Rk59Rgr+rdt=UcH421MjY2BhEbMjfwQw@mail.gmail.com>
References: <1406224491-3599-1-git-send-email-prarit@redhat.com>
	<CAKohpomHj17A4e6Sh8JSz1HPbq9r8gXUJeZ20PQ=Mhu59Vt7ZQ@mail.gmail.com>
	<53D24030.1010302@redhat.com>
	<53D25081.1010209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:57137 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbaHDJyk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Aug 2014 05:54:40 -0400
Received: by mail-oi0-f54.google.com with SMTP id i138so4379336oig.13
        for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2014 02:54:40 -0700 (PDT)
In-Reply-To: <53D25081.1010209@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lenny Szubowicz <lszubowi@redhat.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 25 July 2014 18:11, Prarit Bhargava <prarit@redhat.com> wrote:
> Okay -- I think I got it:  The above happens only with an *older* sysfs stack
> which acquires a &buffer->mutex.  This no longer happens with the new sysfs
> stack so the above change is still no longer necessary in mainline linux.git (at
> least AFAICT).

Hmm, that's something new for me. Would it be possible to give some commits
for reference where the behavior changed? This would be quite helpful once
we face it again and need to come back to this thread :)

> In any case, the change still appears to be incorrect in that it breaks the
> rwsem locking scheme of the cpufreq policy.  I'll do some additional testing on
> various systems and get back to you in a few days.

What about breaking rwsem locking scheme?
