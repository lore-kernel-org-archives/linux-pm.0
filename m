From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RESEND] smp: make wake up idle cpus more generic
Date: Fri, 1 Apr 2016 09:07:58 +0200
Message-ID: <20160401070758.GA28352@gmail.com>
References: <1459489819-20435-1-git-send-email-lianwei.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33915 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758211AbcDAHIE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 03:08:04 -0400
Content-Disposition: inline
In-Reply-To: <1459489819-20435-1-git-send-email-lianwei.wang@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lianwei Wang <lianwei.wang@gmail.com>
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kbuild-all@01.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>


* Lianwei Wang <lianwei.wang@gmail.com> wrote:

> The wake_up_all_idle_cpus API always wake up all the online
> cpus, but sometimes we only want to wake up a set of cpus.
> 
> Use a generic function to wake up a group of cpus that is
> specified by the cpumask parameter. This generic API can
> benefit to the cases that only need to wake up a set of
> cpus.

What is the new user of this new argument to the wake-up call?

Thanks,

	Ingo
