From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3 1/3] cpufreq: ondemand: Change the calculation of
 target frequency
Date: Thu, 6 Jun 2013 11:55:26 +0200
Message-ID: <20130606095526.GB21181@pd.tnic>
References: <51AF60D5.3080605@semaphore.gr>
 <20130605161703.GA29958@pd.tnic>
 <51AF6E39.2080307@verisign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51AF6E39.2080307@verisign.com>
Sender: cpufreq-owner@vger.kernel.org
To: David C Niemi <dniemi@verisign.com>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Please do not top-post.

On Wed, Jun 05, 2013 at 12:58:33PM -0400, David C Niemi wrote:
> When you are doing a locally-originated truly CPU-bound task, "race to
> idle" does make some sense. But I can think of a couple of caveats.
>
> 1) If you care about power consumption, you want to avoid
> super-power-hungry turbo states, as you get less done per watt-hour
> than in some of the middle states.
>
> 2) CPU usage that is related to I/O (network, disk, video) doesn't
> necessarily let you go to idle sooner if at all. In this case if you
> want to minimize power consumption you may want to use middle states a
> lot. But if you care more about responsiveness or latency than power
> consumption, you might want to go to a high state anyway; that is why
> we have tunables -- so we can configure based on the actual priorities
> for the machine.

No, users don't always know about tunables - this should Just Work(tm).

The correct "fix" for this whole deal is coupling cpufreq with
the scheduler, as it has been said so many times before. You need
"something" which can tell you whether raising the freq. is worth it or
not (i.e. the process is waiting on IO or is executing instructions).

Btw, recent AMD CPUs have something called frequency feedback interface
which can tell you how much performance you would get if you would raise
the frequency to the next P-state.

I don't know though how reliable this heuristic is, and, besides,
we need this addressed for all hw out there, which means, a sw-only
solution would be the way to go.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
