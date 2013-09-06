From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v4 12/19] cpufreq: cpufreq-cpu0: remove device tree
 parsing for cpu nodes
Date: Fri, 6 Sep 2013 15:44:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1309061539310.11068@axis700.grange>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-13-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376991021-12160-13-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-pm@vger.kernel.org

Hi

On Tue, 20 Aug 2013, Sudeep KarkadaNagesha wrote:

> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Now that the cpu device registration initialises the of_node(if available)
> appropriately for all the cpus, parsing here is redundant.
> 
> This patch removes all DT parsing and uses cpu->of_node instead.
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> ---
>  drivers/cpufreq/cpufreq-cpu0.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.=
> c
> index ad1fde2..5b05c26 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -174,29 +174,17 @@ static struct cpufreq_driver cpu0_cpufreq_driver =3D =
> {
> =20
>  static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  {
> -=09struct device_node *np, *parent;
> +=09struct device_node *np;
>  =09int ret;
> =20
> -=09parent =3D of_find_node_by_path("/cpus");
> -=09if (!parent) {
> -=09=09pr_err("failed to find OF /cpus\n");
> -=09=09return -ENOENT;
> -=09}
> -
> -=09for_each_child_of_node(parent, np) {
> -=09=09if (of_get_property(np, "operating-points", NULL))
> -=09=09=09break;
> -=09}
> +=09cpu_dev =3D &pdev->dev;
> =20
> +=09np =3D of_node_get(cpu_dev->of_node);

Has this actually been tested? This seems to break cpufreq-cpu0. The 
reason is, that this probe function is called not for the DT CPU node, but 
for a special virtual cpufreq-cpu0 platform device, typically created by 
platforms, using

	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);

which then of course doesn't have on .of_node associated with it.

Thanks
Guennadi

>  =09if (!np) {
>  =09=09pr_err("failed to find cpu0 node\n");
> -=09=09ret =3D -ENOENT;
> -=09=09goto out_put_parent;
> +=09=09return -ENOENT;
>  =09}
> =20
> -=09cpu_dev =3D &pdev->dev;
> -=09cpu_dev->of_node =3D np;
> -
>  =09cpu_reg =3D devm_regulator_get(cpu_dev, "cpu0");
>  =09if (IS_ERR(cpu_reg)) {
>  =09=09/*
> @@ -269,15 +257,12 @@ static int cpu0_cpufreq_probe(struct platform_device =
> *pdev)
>  =09}
> =20
>  =09of_node_put(np);
> -=09of_node_put(parent);
>  =09return 0;
> =20
>  out_free_table:
>  =09opp_free_cpufreq_table(cpu_dev, &freq_table);
>  out_put_node:
>  =09of_node_put(np);
> -out_put_parent:
> -=09of_node_put(parent);
>  =09return ret;
>  }
> =20
> --=20
> 1.8.1.2
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
