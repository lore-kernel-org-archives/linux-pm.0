From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: cpu_cooling: Replace kmalloc with kmalloc_array
Date: Tue, 23 May 2017 19:27:10 -0700
Message-ID: <20170524022706.GA11529@localhost.localdomain>
References: <1495521460.2303.4.camel@intel.com>
 <eff10695c92ff2d2e9733987d1b06adf559c07b0.1495522926.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34574 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758128AbdEXC1P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 22:27:15 -0400
Content-Disposition: inline
In-Reply-To: <eff10695c92ff2d2e9733987d1b06adf559c07b0.1495522926.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On Tue, May 23, 2017 at 12:33:06PM +0530, Viresh Kumar wrote:
> Checkpatch reports following:
>=20
> WARNING: Prefer kmalloc_array over kmalloc with multiply
> +	cpufreq_cdev->freq_table =3D kmalloc(sizeof(*cpufreq_cdev->freq_table) =
* i,
>=20
> Fix that.

That is how the patch would apply. Enter to continue

WARNING: line over 80 characters
#159: FILE: drivers/thermal/cpu_cooling.c:783:
+	cpufreq_cdev->freq_table =3D kmalloc(sizeof(*cpufreq_cdev->freq_table) * =
i,

WARNING: Prefer kmalloc_array over kmalloc with multiply
#159: FILE: drivers/thermal/cpu_cooling.c:783:
+	cpufreq_cdev->freq_table =3D kmalloc(sizeof(*cpufreq_cdev->freq_table) * =
i,
+					  GFP_KERNEL);

WARNING: line over 80 characters
#190: FILE: include/linux/cpufreq.h:859:
+static inline int cpufreq_table_count_valid_entries(const struct cpufreq_p=
olicy *policy)


>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 1305020790b2..908a8014cf76 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -724,8 +724,9 @@ __cpufreq_cooling_register(struct device_node *np,
>  	/* max_level is an index, not a counter */
>  	cpufreq_cdev->max_level =3D i - 1;
> =20
> -	cpufreq_cdev->freq_table =3D kmalloc(sizeof(*cpufreq_cdev->freq_table) =
* i,
> -					  GFP_KERNEL);
> +	cpufreq_cdev->freq_table =3D kmalloc_array(i,
> +					sizeof(*cpufreq_cdev->freq_table),
> +					GFP_KERNEL);
>  	if (!cpufreq_cdev->freq_table) {
>  		cdev =3D ERR_PTR(-ENOMEM);
>  		goto free_idle_time;
> --=20
> 2.13.0.70.g6367777092d9
>=20
