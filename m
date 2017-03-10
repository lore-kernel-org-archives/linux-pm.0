From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v4 1/5] PM / Domains: Add generic data pointer to genpd
 data struct
Date: Fri, 10 Mar 2017 13:19:11 -0800
Message-ID: <m237ekg78w.fsf@baylibre.com>
References: <1488882154-21485-1-git-send-email-d-gerlach@ti.com>
 <1488882154-21485-2-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488882154-21485-2-git-send-email-d-gerlach@ti.com> (Dave
 Gerlach's message of "Tue, 7 Mar 2017 04:22:30 -0600")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Dave Gerlach <d-gerlach@ti.com> writes:

> Add a void *data pointer to struct generic_pm_domain_data. Because this
> exists for each device associated with a genpd it will allow us to
> assign per-device data if needed on a platform for control of that
> specific device.
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  include/linux/pm_domain.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 5339ed5bd6f9..b213d22daefd 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -117,6 +117,7 @@ struct generic_pm_domain_data {
>  	struct pm_domain_data base;
>  	struct gpd_timing_data td;
>  	struct notifier_block nb;
> +	void *data;
>  };
>  
>  #ifdef CONFIG_PM_GENERIC_DOMAINS
