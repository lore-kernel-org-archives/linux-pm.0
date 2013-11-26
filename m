From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH V3 0/6] cpufreq: suspend early/resume late
Date: Tue, 26 Nov 2013 14:37:43 +0800
Message-ID: <529441B7.90505@intel.com>
References: <cover.1385374819.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1385374819.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nm@ti.com, swarren@wwwdotorg.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, jinchoi@broadcom.com, sebastian.capella@linaro.org, jhbird.choi@samsung.com
List-Id: linux-pm@vger.kernel.org

On 2013=E5=B9=B411=E6=9C=8825=E6=97=A5 22:11, Viresh Kumar wrote:
> This patchset adds cpufreq callbacks to dpm_{suspend|resume}() for ha=
ndling
> suspend/resume of cpufreq governors and core. This is required for ea=
rly suspend
> and late resume of governors and cpufreq core.
>=20
> There are multiple problems that are fixed by this patch:
> - Nishanth Menon (TI) found an interesting problem on his platform, O=
MAP. His board
>   wasn't working well with suspend/resume as calls for removing non-b=
oot CPUs
>   was turning out into a call to drivers ->target() which then tries =
to play
>   with regulators. But regulators and their I2C bus were already susp=
ended and
>   this resulted in a failure. Many platforms have such problems, sams=
ung, tegra,
>   etc.. They solved it with driver specific PM notifiers where they u=
sed to
>   disable their driver's ->target() routine. Most of these are update=
d in this
>   patchset to use new infrastructure.
>=20
> - Lan Tianyu (Intel) & Jinhyuk Choi (Broadcom) found another issue wh=
ere
>   tunables configuration for clusters/sockets with non-boot CPUs was =
getting
>   lost after suspend/resume, as we were notifying governors with
>   CPUFREQ_GOV_POLICY_EXIT on removal of the last cpu for that policy =
and so
>   deallocating memory for tunables. This is also fixed with this patc=
h as don't
>   allow any operation on Governors during suspend/resume now.
>=20
>=20
> So to solve these issues we introduce early suspend and late resume c=
allbacks
> which would remove need of cpufreq drivers to implement PM notifiers =
to disable
> transition after suspend and before resume.
>=20
> @Nishanth: Can you please test V2 as well and confirm that suspend_no=
irq()
> doesn't work for you. I am sure it will not, but would be better if y=
ou confirm
> that.
>=20
> Viresh Kumar (6):
>   cpufreq: suspend governors on system suspend/hibernate
>   cpufreq: call driver's suspend/resume for each policy
>   cpufreq: Implement cpufreq_generic_suspend()
>   cpufreq: exynos: Use cpufreq_generic_suspend()
>   cpufreq: s5pv210: Use cpufreq_generic_suspend()
>   cpufreq: Tegra: Use cpufreq_generic_suspend()
>=20

Patch 1-2,
Tested-by: Lan Tianyu <tianyu.lan@intel.com>

>  drivers/base/power/main.c         |   5 ++
>  drivers/cpufreq/cpufreq.c         | 133 +++++++++++++++++++++-------=
----------
>  drivers/cpufreq/exynos-cpufreq.c  |  97 ++-------------------------
>  drivers/cpufreq/s5pv210-cpufreq.c |  49 +-------------
>  drivers/cpufreq/tegra-cpufreq.c   |  54 ++--------------
>  include/linux/cpufreq.h           |   6 ++
>  6 files changed, 99 insertions(+), 245 deletions(-)
>=20


--=20
Best regards
Tianyu Lan
