From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] opp: no need to check return value of debugfs_create
 functions
Date: Wed, 23 Jan 2019 12:46:14 +0530
Message-ID: <20190123071614.nyzopisx4yhojgw3@vireshk-i7>
References: <20190122152151.16139-18-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190122152151.16139-18-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22-01-19, 16:21, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/opp/core.c    |  10 +---
>  drivers/opp/debugfs.c | 109 +++++++++++-------------------------------
>  drivers/opp/opp.h     |  15 +++---
>  3 files changed, 37 insertions(+), 97 deletions(-)

Applied with following changes. Thanks Greg.

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 91d15c58eae1..d455b84cce5a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -793,7 +793,6 @@ static struct opp_device *_add_opp_dev_unlocked(const struct device *dev,
                                                struct opp_table *opp_table)
 {
        struct opp_device *opp_dev;
-       int ret;
 
        opp_dev = kzalloc(sizeof(*opp_dev), GFP_KERNEL);
        if (!opp_dev)
diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index baac1ae33c55..a1c57fe14de4 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -93,7 +93,8 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
        debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend);
        debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate);
        debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate);
-       debugfs_create_ulong("clock_latency_ns", S_IRUGO, d, &opp->clock_latency_ns);
+       debugfs_create_ulong("clock_latency_ns", S_IRUGO, d,
+                            &opp->clock_latency_ns);
 
        opp_debug_create_supplies(opp, opp_table, d);

-- 
viresh
