From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 3/4] cpufreq: s5pv210: Defer probe if getting
 regulators fail
Date: Fri, 11 Jan 2019 10:46:26 +0100
Message-ID: <CAJKOXPdz-LfQ1-jPXB5Y7pVVVBDdH0Q=5xZJxvabjhZ-Ush+dg@mail.gmail.com>
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com> <20190110205215.22030-4-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110205215.22030-4-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc: kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 10 Jan 2019 at 21:53, Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
>
> There is possibility, that when probing driver, regulators are not yet
> initialized. In this case we should return EPROBE_DEFER and wait till
> they're initialized, since they're required currently for cpufreq driver
> to work. Also move regulator initialization code at beginning of probe,
> so we can defer as fast as posibble.
>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v1:
>   - Fix compilation error
>   - Reorganize code so it's smaller
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 32 ++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-=
cpufreq.c
> index f51697f1e0b3..6df95941ba96 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -594,6 +594,25 @@ static int s5pv210_cpufreq_probe(struct platform_dev=
ice *pdev)
>          * this whole driver as soon as S5PV210 gets migrated to use
>          * cpufreq-dt driver.
>          */
> +       arm_regulator =3D regulator_get(NULL, "vddarm");
> +       if (IS_ERR(arm_regulator)) {
> +               if (PTR_ERR(arm_regulator) =3D=3D -EPROBE_DEFER)
> +                       pr_debug("vddarm regulator not ready, defer\n");
> +               else
> +                       pr_err("failed to get regulator vddarm\n");
> +               return PTR_ERR(arm_regulator);
> +       }
> +
> +       int_regulator =3D regulator_get(NULL, "vddint");
> +       if (IS_ERR(int_regulator)) {
> +               if (PTR_ERR(int_regulator) =3D=3D -EPROBE_DEFER)
> +                       pr_debug("vddint regulator not ready, defer\n");
> +               else
> +                       pr_err("failed to get regulator vddint\n");
> +               regulator_put(arm_regulator);
> +               return PTR_ERR(int_regulator);
> +       }
> +

Error paths are now not correct. You should put the regulators when
returning later. The previous code had these error paths wrong as well
- not iounmapping - but if you move things around, maybe let's fix
things.

Best regards,
Krzysztof
