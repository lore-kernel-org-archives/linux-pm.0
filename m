From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/5] intel_idle: Add S0ix validation
Date: Thu, 2 Jun 2016 11:25:05 +0200
Message-ID: <20160602092505.GQ3206@twins.programming.kicks-ass.net>
References: <1464842009-21789-1-git-send-email-dbasehore@chromium.org>
 <1464842009-21789-6-git-send-email-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464842009-21789-6-git-send-email-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dbasehore@chromium.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 01, 2016 at 09:33:29PM -0700, dbasehore@chromium.org wrote:
> +/*
> + * Default chosen to have <= 1% power increase while allowing fast detection of
> + * SLP S0 entry errors. Waking up 10 times a second shows ~30% increase in
> + * system power on Skylake Y. Waking up once every 10 seconds is
> + * indistinguishable from not waking up at all (as ~0.3% power increase would
> + * be). Any reasonable power increases above this will not be visible to the
> + * user.
> + */
> +#define DEFAULT_SLP_S0_SECONDS 10

So I don't think anybody waits for 10 seconds to see if suspend worked.
After 10 seconds its in the bag and I'm out the door.

Then what?


Why can't you fire a single timer after 0.5 seconds to see if you hit
C10 and leave it at that? What's the point any further wakeup, if you
know you hit C10, you're good continue on.
