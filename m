From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] cpufreq: st: enable selective initialization based on
 the platform
Date: Wed, 27 Apr 2016 17:07:46 +0100
Message-ID: <20160427160746.GG4892@dell>
References: <1461757227-22381-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35919 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbcD0QHr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 12:07:47 -0400
Received: by mail-wm0-f53.google.com with SMTP id n129so34455859wmn.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2016 09:07:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461757227-22381-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Wed, 27 Apr 2016, Sudeep Holla wrote:

> The sti-cpufreq does unconditional registration of the cpufreq-dt dri=
ver
> which causes issue on an multi-platform build. For example, on Vexpre=
ss
> TC2 platform, we get the following error on boot:
>=20
> cpu cpu0: OPP-v2 not supported
> cpu cpu0: Not doing voltage scaling
> cpu: dev_pm_opp_of_cpumask_add_table: couldn't find opp table
> 	for cpu:0, -19
> cpu cpu0: dev_pm_opp_get_max_volt_latency: Invalid regulator (-6)
> ...
> arm_big_little: bL_cpufreq_register: Failed registering platform driv=
er:
> 		vexpress-spc, err: -17
>=20
> The actual driver fails to initialise as cpufreq-dt is probed
> successfully, which is incorrect. This issue can happen to any platfo=
rm
> not using cpufreq-dt in a multi-platform build.

Ah yes.  One of the pitfalls of not requiring platform registration.

> This patch adds a check to do selective initialization of the driver.
>=20
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Fixes: ab0ea257fc58 ("cpufreq: st: Provide runtime initialised driver=
 for ST's platforms")
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/sti-cpufreq.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpuf=
req.c
> index a9c659f58974..5fce58712a97 100644
> --- a/drivers/cpufreq/sti-cpufreq.c
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -259,6 +259,10 @@ static int sti_cpufreq_init(void)
>  {
>  	int ret;
> =20
> +	if ((!of_machine_is_compatible("st,stih407-b2120")) &&
> +		(!of_machine_is_compatible("st,stih407")))
> +		return -ENODEV;

You need to check for "st,stih407" and "st,stih410".

>  	ddata.cpu =3D get_cpu_device(0);
>  	if (!ddata.cpu) {
>  		dev_err(ddata.cpu, "Failed to get device for CPU0\n");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
