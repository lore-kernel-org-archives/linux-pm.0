From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] opp: add dev_pm_opp_is_turbo() helper
Date: Wed, 29 Jul 2015 15:54:35 +0530
Message-ID: <20150729102435.GB9584@linux>
References: <cover.1438081962.git.viresh.kumar@linaro.org>
 <e7e8c272f85df846466e9b57d7c9eef74109c081.1438081962.git.viresh.kumar@linaro.org>
 <20150728142713.GB17745@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150728142713.GB17745@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com, nm@ti.com, sboyd@codeaurora.org, Tomasz Figa <tomasz.figa@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Javier Martinez Canillas <javier@dowhile0.org>, Thomas Abraham <thomas.ab@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 28-07-15, 16:27, Pavel Machek wrote:
> Typo.
> 
> And this is not exactly most helpful comment. opp is turbo... returns
> if opp was turbo. Explanation what "turbo" means in this context would
> be nice. I'm pretty sure it is not about air compression :-).

Does this make it any better:

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index e039cf024a6c..da8ec7f824d5 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -281,9 +281,13 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
 /**
- * dev_pm_opp_is_turbo() - Returns true if opp was trubo OPP
+ * dev_pm_opp_is_turbo() - Returns if opp is turbo OPP or not
  * @opp: opp for which turbo mode is being verified
  *
+ * Turbo OPPs are not for normal use, and can be enabled (under certain
+ * conditions) for short duration of times to finish high throughput work
+ * quickly. Running on them for longer times may overheat the chip.
+ *
  * Return: true if opp is turbo opp, else false.
  *
  * Locking: This function must be called under rcu_read_lock(). opp is a rcu


-- 
viresh
