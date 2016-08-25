From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] soc: ti: Add ti_sci_pm_domains driver
Date: Thu, 25 Aug 2016 09:27:39 +0200
Message-ID: <CAPDyKFooDUOPT9dP8HaW3YBO9PsX-1+96PPE7CRMyjEkra7cBQ@mail.gmail.com>
References: <20160819235653.26355-1-nm@ti.com>
 <20160819235653.26355-4-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160819235653.26355-4-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>, Russell King <rmk+kernel@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

+ Jon

[...]

> +
> +static int ti_sci_pm_domains_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct ti_sci_genpd_data *ti_sci_genpd;
> +
> +       ti_sci_genpd = devm_kzalloc(dev, sizeof(*ti_sci_genpd), GFP_KERNEL);
> +       if (!ti_sci_genpd)
> +               return -ENOMEM;
> +
> +       ti_sci_genpd->ti_sci = devm_ti_sci_get_handle(dev);
> +       if (IS_ERR(ti_sci_genpd->ti_sci))
> +               return PTR_ERR(ti_sci_genpd->ti_sci);
> +
> +       ti_sci_genpd->dev = dev;
> +
> +       INIT_LIST_HEAD(&ti_sci_genpd->pd_list);
> +       mutex_init(&ti_sci_genpd->pd_list_mutex);
> +
> +       return __of_genpd_add_provider(np, of_ti_sci_genpd_xlate_onecell,
> +                                      ti_sci_genpd);

Jon Hunter are working on adding robust method to be able to remove
initialized genpds [1].

In that series we intend to remove the __of_genpd_add_provider() API,
and instead only have of_genpd_add_provider_onecell() and
of_genpd_add_provider_simple(). Could you please convert to use any of
these APIs instead?

Kind regards
Uffe

[1]
http://www.spinics.net/lists/arm-kernel/msg524151.html
