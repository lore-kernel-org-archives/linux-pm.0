From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] cpufreq: st: enable selective initialization based on
 the platform
Date: Thu, 28 Apr 2016 08:19:07 +0100
Message-ID: <20160428071907.GH4892@dell>
References: <1461757227-22381-1-git-send-email-sudeep.holla@arm.com>
 <1461773939-1004-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461773939-1004-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
>=20
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
> v1->v2:
> 	- Updated compatible strings as per Lee's confirmation

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpuf=
req.c
> index a9c659f58974..04042038ec4b 100644
> --- a/drivers/cpufreq/sti-cpufreq.c
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -259,6 +259,10 @@ static int sti_cpufreq_init(void)
>  {
>  	int ret;
>=20
> +	if ((!of_machine_is_compatible("st,stih407")) &&
> +		(!of_machine_is_compatible("st,stih410")))
> +		return -ENODEV;
> +
>  	ddata.cpu =3D get_cpu_device(0);
>  	if (!ddata.cpu) {
>  		dev_err(ddata.cpu, "Failed to get device for CPU0\n");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
