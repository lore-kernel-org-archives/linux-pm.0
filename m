From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86: tsc: Rework time_cpufreq_notifier()
Date: Thu, 18 Apr 2019 20:40:40 +0200
Message-ID: <20190418184040.GM27160@zn.tnic>
References: <38900622.ao2n2t5aPS@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <38900622.ao2n2t5aPS@kreacher>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, x86 Maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 18, 2019 at 04:11:37PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are problems with running time_cpufreq_notifier() on SMP
> systems.

Just a stupid question: that must be some old rust you're fixing because
we set X86_FEATURE_CONSTANT_TSC on almost anything that is x86 nowadays
and if that is set, we don't reg that notifier call...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
