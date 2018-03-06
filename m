From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH v2 4/6] cpuidle: Return nohz hint from cpuidle_select()
Date: Tue, 6 Mar 2018 10:28:29 +0100
Message-ID: <CAJZ5v0g=Enc1ji-HMt9R+WSh9KPvGsB8saN34xtuVi5UOfcBMQ@mail.gmail.com>
References: <2067762.1uWBf5RSRc@aspire.rjw.lan> <1756432.KnKEJ20PhI@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1756432.KnKEJ20PhI@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Bummer. :-(

On Tue, Mar 6, 2018 at 10:05 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> +       if (drv->states[idx].flags & CPUIDLE_FLAG_POLLING) {
> +               *nohz_ret = false;
> +       } else if (drv->states[idx].target_residency < TICK_USEC) {
> +               /*
> +                * Do not stop the tick if there is at least one more state
> +                * within the tick period range that could be used if longer
> +                * idle duration was predicted.
> +                */
> +               *nohz_ret = first_idx > idx &&
> +                           drv->states[first_idx].target_residency < TICK_USEC;

This is reversed, sent a wrong version of the patch.

I'll resend with this fixed shortly.
