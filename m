From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: remove sysfs files for CPU which failed to come back after resume
Date: Fri, 20 Dec 2013 16:14:57 +0100
Message-ID: <2118684.kuZSLHD0UA@vostro.rjw.lan>
References: <c6b53b186145559668722120ea1f37d28ddb3177.1387516043.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61297 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752950Ab3LTPBg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 10:01:36 -0500
In-Reply-To: <c6b53b186145559668722120ea1f37d28ddb3177.1387516043.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com

On Friday, December 20, 2013 10:38:20 AM Viresh Kumar wrote:
> There are cases where cpufreq_add_dev() may fail for some CPUs during=
 resume.
> With the current code we will still have sysfs cpufreq files for such=
 CPUs, and
> struct cpufreq_policy would be already freed for them. Hence any oper=
ation on
> those sysfs files would result in kernel warnings.
>=20
> To fix this, lets remove those sysfs files or put the associated kobj=
ect in case
> of such errors. Also, to make it simple lets remove the sysfs links f=
rom all the
> CPUs (except policy->cpu) during suspend as that operation wouldn't r=
esult with a
> loss of sysfs file permissions. And so we will create those links dur=
ing resume
> as well.
>=20
> Reported-and-tested-by: Bj=C3=B8rn Mork <bjorn@mork.no>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 61 ++++++++++++++++++++++++-------------=
----------
>  1 file changed, 31 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 02d534d..cea96c9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -845,8 +845,7 @@ static void cpufreq_init_policy(struct cpufreq_po=
licy *policy)
> =20
>  #ifdef CONFIG_HOTPLUG_CPU
>  static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
> -				  unsigned int cpu, struct device *dev,
> -				  bool frozen)
> +				  unsigned int cpu, struct device *dev)
>  {
>  	int ret =3D 0;
>  	unsigned long flags;
> @@ -877,9 +876,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq_=
policy *policy,
>  		}
>  	}
> =20
> -	/* Don't touch sysfs links during light-weight init */
> -	if (!frozen)
> -		ret =3D sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
> +	ret =3D sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
> =20
>  	return ret;
>  }

Well, this just looks odd.  Please do

	return sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");

And I'm fine with the rest of the patch.

Thanks,
Rafael

