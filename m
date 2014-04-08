From: =?utf-8?B?566h6Zuq5rab?= <gxt@pku.edu.cn>
Subject: =?utf-8?Q?=E5=9B=9E=E5=A4=8D=EF=BC=9A_[PATCH]_drivers:cpufreq:uni?=
 =?utf-8?Q?core32:_fix_typo_issue_for_'clk'?=
Date: Tue, 8 Apr 2014 11:04:28 +0800 (CST)
Message-ID: <620835913.18252.1396926268726.JavaMail.root@bj-mail03.pku.edu.cn>
References: <53429445.5000005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <53429445.5000005@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, rjw@rjwysocki.net, viresh kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Thanks,

Acked-by: Xuetao Guan <gxt@mprc.pku.edu.cn>

----- Chen Gang <gang.chen.5i5j@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
> Need use 'clk' instead of 'mclk', which is the original removed local
> variable.
>=20
> The related original commit:
>=20
>   "652ed95 cpufreq: introduce cpufreq_generic_get() routine"
>=20
> The related error with allmodconfig for unicore32:
>=20
>     CC      drivers/cpufreq/unicore2-cpufreq.o
>   drivers/cpufreq/unicore2-cpufreq.c: In function =E2=80=98ucv2_targe=
t=E2=80=99:
>   drivers/cpufreq/unicore2-cpufreq.c:48: error: =E2=80=98struct cpufr=
eq_policy=E2=80=99 has no member named =E2=80=98mclk=E2=80=99
>   make[2]: *** [drivers/cpufreq/unicore2-cpufreq.o] Error 1
>   make[1]: *** [drivers/cpufreq] Error 2
>   make: *** [drivers] Error 2
>=20
>=20
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  drivers/cpufreq/unicore2-cpufreq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpufreq/unicore2-cpufreq.c b/drivers/cpufreq/uni=
core2-cpufreq.c
> index 13be802..8d045af 100644
> --- a/drivers/cpufreq/unicore2-cpufreq.c
> +++ b/drivers/cpufreq/unicore2-cpufreq.c
> @@ -45,7 +45,7 @@ static int ucv2_target(struct cpufreq_policy *polic=
y,
>  	freqs.new =3D target_freq;
> =20
>  	cpufreq_freq_transition_begin(policy, &freqs);
> -	ret =3D clk_set_rate(policy->mclk, target_freq * 1000);
> +	ret =3D clk_set_rate(policy->clk, target_freq * 1000);
>  	cpufreq_freq_transition_end(policy, &freqs, ret);
> =20
>  	return ret;
> --=20
> 1.7.9.5

