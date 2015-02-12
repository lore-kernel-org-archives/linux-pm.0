From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/6] PM / sleep: Re-implement suspend-to-idle handling
Date: Thu, 12 Feb 2015 14:14:20 +0100
Message-ID: <20150212131420.GW23123@twins.programming.kicks-ass.net>
References: <8292243.ibkmfVtXac@vostro.rjw.lan>
 <5802443.EAllF0NTnO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5802443.EAllF0NTnO@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 11, 2015 at 05:01:09AM +0100, Rafael J. Wysocki wrote:
> +/* Suspend-to-idle state machnine. */
> +enum freeze_state {
> +	FREEZE_STATE_NONE,      /* Not suspended/suspending. */
> +	FREEZE_STATE_ENTER,     /* Enter suspend-to-idle. */
> +	FREEZE_STATE_WAKE,      /* Wake up from suspend-to-idle. */
> +};
> +
> +static enum freeze_state __read_mostly suspend_freeze_state;
> +static DEFINE_SPINLOCK(suspend_freeze_lock);
> +
> +bool idle_should_freeze(void)
> +{
> +	return unlikely(suspend_freeze_state == FREEZE_STATE_ENTER);
> +}

I don't see how a compiler can propagate the unlikely through an actual
function call. AFAICT that needs to be an inline function for that to
work.

It would mean exposing suspend_freeze_state and the enum; is there a
reason not to want to do that?
