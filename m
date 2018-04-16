From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH v7 01/26] PM / Domains: Don't treat zero found compatible
 idle states as an error
Date: Mon, 16 Apr 2018 11:33:26 -0600
Message-ID: <20180416173326.GD1209@codeaurora.org>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
 <1523531671-27491-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523531671-27491-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 12 2018 at 05:14 -0600, Ulf Hansson wrote:
>Instead of returning -EINVAL from of_genpd_parse_idle_states() in case none
>compatible states was found, let's return 0 to indicate success. Assign
>also the out-parameter *states to NULL and *n to 0, to indicate to the
>caller that zero states have been found/allocated.
>
>This enables the caller of of_genpd_parse_idle_states() to easier act on
>the returned error code.
>
>Cc: Lina Iyer <ilina@codeaurora.org>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Lina Iyer <ilina@codeaurora.org>

>---
> drivers/base/power/domain.c | 14 ++++++++++----
> 1 file changed, 10 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>index 1ea0e25..c2ef944 100644
>--- a/drivers/base/power/domain.c
>+++ b/drivers/base/power/domain.c
>@@ -2331,8 +2331,8 @@ static int genpd_iterate_idle_states(struct device_node *dn,
>  *
>  * Returns the device states parsed from the OF node. The memory for the states
>  * is allocated by this function and is the responsibility of the caller to
>- * free the memory after use. If no domain idle states is found it returns
>- * -EINVAL and in case of errors, a negative error code.
>+ * free the memory after use. If any or zero compatible domain idle states is
>+ * found it returns 0 and in case of errors, a negative error code is returned.
>  */
> int of_genpd_parse_idle_states(struct device_node *dn,
> 			struct genpd_power_state **states, int *n)
>@@ -2341,8 +2341,14 @@ int of_genpd_parse_idle_states(struct device_node *dn,
> 	int ret;
>
> 	ret = genpd_iterate_idle_states(dn, NULL);
>-	if (ret <= 0)
>-		return ret < 0 ? ret : -EINVAL;
>+	if (ret < 0)
>+		return ret;
>+
>+	if (!ret) {
>+		*states = NULL;
>+		*n = 0;
>+		return 0;
>+	}
>
> 	st = kcalloc(ret, sizeof(*st), GFP_KERNEL);
> 	if (!st)
>--
>2.7.4
>
