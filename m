From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC v3 01/12] PM / Domains: Abstract genpd locking
Date: Fri, 4 Mar 2016 11:09:22 +0100
Message-ID: <CAPDyKFp4y_QSNPesVq6TJ_jPmmJiFJ_dqza6gzAdHypE+0j+3g@mail.gmail.com>
References: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
	<1456866931-37851-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1456866931-37851-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Axel Haslam <ahaslam@baylibre.com>, Marc Titinger <mtitinger@baylibre.com>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 1 March 2016 at 22:15, Lina Iyer <lina.iyer@linaro.org> wrote:
> Abstract genpd lock/unlock calls, in preparation for domain specific
> locks added in the following patches.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Krzysztof Koz=C5=82owski <k.kozlowski@samsung.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

[...]

> +struct genpd_lock_fns;
> +
>  struct generic_pm_domain {
>         struct dev_pm_domain domain;    /* PM domain operations */
>         struct list_head gpd_list_node; /* Node in the global PM doma=
ins list */
>         struct list_head master_links;  /* Links with PM domain as a =
master */
>         struct list_head slave_links;   /* Links with PM domain as a =
slave */
>         struct list_head dev_list;      /* List of devices */
> -       struct mutex lock;
>         struct dev_power_governor *gov;
>         struct work_struct power_off_work;
>         const char *name;
> @@ -74,6 +75,8 @@ struct generic_pm_domain {
>         struct genpd_power_state *states;
>         unsigned int state_count; /* number of states */
>         unsigned int state_idx; /* state that genpd will go to when o=
ff */
> +       const struct genpd_lock_fns *lock_fns;
> +       struct mutex mlock;

Nitpick: I wouldn't mind if you name this mtx_lock, as it would be a
bit more consistent with the corresponding helper functions.

>
>  };
>
> --
> 2.1.4
>

Otherwise this looks good to me!

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

One issue I noticed though, this patch isn't based upon Rafael's
latest tree, thus it can't be applied as is. Could you perhaps
re-base?

I suppose that's needed for some of the other patches as well. I think
we should split up the dependency a bit better so we can move forward
with standalone patches.

Kind regards
Uffe
