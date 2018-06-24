From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v8 03/26] PM / Domains: Add generic data pointer to
 genpd_power_state struct
Date: Sun, 24 Jun 2018 23:09:20 +0200
Message-ID: <CAJZ5v0i52JTFbvBBaDyNHCnTz3UMW00NiodFpzS5m614D++9uA@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org> <20180620172226.15012-4-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620172226.15012-4-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 20, 2018 at 7:22 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> From: Lina Iyer <lina.iyer@linaro.org>
>
> Let's add a data pointer to the genpd_power_state struct, to allow
> platforms to store per state specific data.

Can you please fold it into a patch actually using this pointer?

> Cc: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  include/linux/pm_domain.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 9206a4fef9ac..27fca748344a 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -44,6 +44,7 @@ struct genpd_power_state {
>         s64 residency_ns;
>         struct fwnode_handle *fwnode;
>         ktime_t idle_time;
> +       void *data;
>  };
>
>  struct genpd_lock_ops;
> --
> 2.17.1
>
