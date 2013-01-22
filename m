From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] cpufreq: exynos: Initialise return variable
Date: Tue, 22 Jan 2013 14:59:14 +0100
Message-ID: <2641184.NcZpVXpRem@vostro.rjw.lan>
References: <1358764194-22753-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1358764194-22753-1-git-send-email-sachin.kamat@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, jhbird.choi@samsung.com, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On Monday, January 21, 2013 03:59:53 PM Sachin Kamat wrote:
> 'ret' is undefined when the function returns from the first
> error condition. Without this patch we get the following warning:
>=20
> drivers/cpufreq/exynos-cpufreq.c: In function =E2=80=98exynos_target=E2=
=80=99:
> drivers/cpufreq/exynos-cpufreq.c:182:2: warning:
> =E2=80=98ret=E2=80=99 may be used uninitialized in this function [-Wu=
ninitialized]

I'd prefer these two patches to go through the Exynos tree.

Thanks,
Rafael


> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Jonghwan Choi <jhbird.choi@samsung.com>
> ---
>  drivers/cpufreq/exynos-cpufreq.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exyno=
s-cpufreq.c
> index 218b3ce..38c6158 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -159,7 +159,7 @@ static int exynos_target(struct cpufreq_policy *p=
olicy,
>  {
>  	struct cpufreq_frequency_table *freq_table =3D exynos_info->freq_ta=
ble;
>  	unsigned int index;
> -	int ret;
> +	int ret =3D -EINVAL;
> =20
>  	mutex_lock(&cpufreq_lock);
> =20
> @@ -167,10 +167,8 @@ static int exynos_target(struct cpufreq_policy *=
policy,
>  		goto out;
> =20
>  	if (cpufreq_frequency_table_target(policy, freq_table,
> -					   target_freq, relation, &index)) {
> -		ret =3D -EINVAL;
> +					   target_freq, relation, &index))
>  		goto out;
> -	}
> =20
>  	freqs.new =3D freq_table[index].frequency;
> =20
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
