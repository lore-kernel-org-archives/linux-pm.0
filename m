From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 0/5] Register an Energy Model for Arm reference
 platforms
Date: Tue, 5 Feb 2019 10:25:13 +0530
Message-ID: <20190205045513.p4ljxgsnvmk3fzgw@vireshk-i7>
References: <20190204110952.16025-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190204110952.16025-1-quentin.perret@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: nm@ti.com, linux-pm@vger.kernel.org, sboyd@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, mka@chromium.org, sudeep.holla@arm.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 04-02-19, 11:09, Quentin Perret wrote:
> The Energy Model (EM) framework feeds interested subsystems (the
> scheduler/EAS as of now) with power costs provided by drivers. Yet, no
> driver is actually doing that upstream yet. This series updates a set of
> CPUFreq drivers in order to register power costs in the EM framework for
> some of the Arm reference platforms for EAS: Hikey960, Juno and TC2.
> =

> The series is split as follows:
>  - Patch 01 introduces in PM_OPP a helper function which estimates the
>    CPU power using the P=3DCV=B2f equation also used by IPA. It should be
>    noted that this introduces duplicate code with IPA, which will
>    eventually be fixed by migrating IPA to using PM_EM. The ideal plan
>    would be to do so later, in a separate patch series. I would indeed
>    prefer to keep the thermal and CPUFreq discussion separate at this
>    stage, if deemed acceptable.
>  - Patches 02-04 make use of that PM_OPP helper function from the
>    following CPUFreq drivers: cpufreq-dt, scpi-cpufreq and
>    arm_big_little.
>  - Patch 05 modifies the SCMI cpufreq driver to pass the power costs
>    obtained from firmware to PM_EM. This patch is independent from the
>    rest of the series.
> =

> =

> Changes since v3 (20190201093101.31869-1-quentin.perret@arm.com)
>  - Moved the OPP count inside dev_pm_opp_of_register_em() (Matthias,
>    Sudeep)

Applied. Thanks.

-- =

viresh
