From: Mason <slash.tmp@free.fr>
Subject: Re: schedule_timeout sleeps too long after dividing CPU frequency
Date: Fri, 15 May 2015 12:36:10 +0200
Message-ID: <5555CC1A.5040604@free.fr>
References: <555218C7.5050602@free.fr> <20150512155004.GP2067@n2100.arm.linux.org.uk> <555380F8.5050306@free.fr> <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com> <5554858A.9010207@free.fr> <20150514115456.GB23999@linux> <55549DEE.6010202@free.fr> <CAKohpon4AV-7nq=Qm7PpDbbW9ti98avY9zz82htzyHWi5_K7fA@mail.gmail.com> <20150514144239.GZ2067@n2100.arm.linux.org.uk> <5555BC7E.7010601@free.fr> <20150515095159.GF2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:14251 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933945AbbEOKg0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 15 May 2015 06:36:26 -0400
In-Reply-To: <20150515095159.GF2067@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mans Rullgard <mans@mansr.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>

On 15/05/2015 11:51, Russell King - ARM Linux wrote:

> As you don't say which kernel version you're using,

Sorry about that, I thought the patch-generating command
I posted conveyed the information.

$ git diff v3.14.41 HEAD >tango.patch && xz tango.patch

I'm using the 3.14.y branch from linux-stable.

> for all we know, you might be using a version which omits some fixes
> in this area, such as this one which you really must have if your
> timer is operating in period mode:
> 
> fe79a9ba1196 clockevents: Adjust timer interval when frequency changes

Hmmm, according to git log, this patch was accepted during
the 3.14-rc2 merge window. Why didn't it make it for 3.14?

I'll cherry-pick that commit, and report back along with
the other tests.

By any chance, is there a patch that would allow the platform
to get high-resolution timers when using smp_twd?

Regards.

