From: Mason <slash.tmp@free.fr>
Subject: Re: schedule_timeout sleeps too long after dividing CPU frequency
Date: Fri, 15 May 2015 11:21:16 +0200
Message-ID: <5555BA8C.7090906@free.fr>
References: <CAKohpo=eMA6L9=jK=bAnbFuDxcdtpQNub0WFnSy6MOqB3jOdjA@mail.gmail.com> <555218C7.5050602@free.fr> <20150512155004.GP2067@n2100.arm.linux.org.uk> <555380F8.5050306@free.fr> <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com> <5554858A.9010207@free.fr> <20150514115456.GB23999@linux> <55549DEE.6010202@free.fr> <CAKohpon4AV-7nq=Qm7PpDbbW9ti98avY9zz82htzyHWi5_K7fA@mail.gmail.com> <5554B5C1.2070402@free.fr> <20150515041632.GG6348@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:2164 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754462AbbEOJV2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 15 May 2015 05:21:28 -0400
In-Reply-To: <20150515041632.GG6348@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mans Rullgard <mans@mansr.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>

On 15/05/2015 06:16, Viresh Kumar wrote:

> What core does your platform have? Cortex A9? Doesn't that uses this
> timer instead: drivers/clocksource/arm_arch_timer.c ?

Cortex-A9 MPCore r3p0

Generic Timer (aka Architected system timer) is not available
in Cortex-A9.

https://community.arm.com/message/8775

"Generic Timer is not an option on the Cortex-A9 (or A8 or A5)
processors. The Generic Timer is an optional part of the ARMv7
architecture, and is not implemented by those three processors."

Regards.

