From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] sched: cpufreq: Adds a field cpu_power in the
 task_struct
Date: Fri, 15 May 2015 18:07:16 +0200
Message-ID: <20150515160716.GY21418@twins.programming.kicks-ass.net>
References: <1431647748-13221-1-git-send-email-kandoiruchi@google.com>
 <1431647748-13221-3-git-send-email-kandoiruchi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:59959 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934713AbbEOQHd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2015 12:07:33 -0400
Content-Disposition: inline
In-Reply-To: <1431647748-13221-3-git-send-email-kandoiruchi@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ruchi Kandoi <kandoiruchi@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vladimir Davydov <vdavydov@parallels.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Davidlohr Bueso <dave@stgolabs.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 14, 2015 at 04:55:48PM -0700, Ruchi Kandoi wrote:
> cpu_power has been added to keep track of amount of power each task is
> consuming. cpu_power is updated whenever stime and utime are updated for
> a task. power is computed by taking into account the frequency at which
> the current core was running and the current for cpu actively
> running at hat frequency.
> 

Both you patches completely lack any reason for me to even start
considering this.

_WHY_ and _what_ are you doing?
