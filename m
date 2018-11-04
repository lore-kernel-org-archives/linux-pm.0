From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date: Sat, 03 Nov 2018 21:20:32 -0700
Message-ID: <154130523254.88331.12609105382114756048@swboyd.mtv.corp.google.com>
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-3-git-send-email-tdas@codeaurora.org>
 <153981915373.5275.15971019914218464179@swboyd.mtv.corp.google.com>
 <0c51a12e-38d3-2df5-4f5f-6a687727e9bf@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c51a12e-38d3-2df5-4f5f-6a687727e9bf@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Taniya Das <tdas@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

Quoting Taniya Das (2018-11-02 20:06:00)
> Hello Stephen,
> =

> On 10/18/2018 5:02 AM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-10-11 04:36:01)
> >> --- a/drivers/cpufreq/Kconfig.arm
> >> +++ b/drivers/cpufreq/Kconfig.arm
> >> @@ -121,6 +121,17 @@ config ARM_QCOM_CPUFREQ_KRYO
> >>
> >>            If in doubt, say N.
> >>
> >> +config ARM_QCOM_CPUFREQ_HW
> >> +       bool "QCOM CPUFreq HW driver"
> > =

> > Is there any reason this can't be a module?
> > =

> =

> We do not have any use cases where we need to support it as module.

Ok, so it could easily be tristate then? Why not allow it?

> =

> >> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-=
cpufreq-hw.c
> >> new file mode 100644
> >> index 0000000..fe1c264
> >> --- /dev/null
> >> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> >> @@ -0,0 +1,354 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> >> + */
[...]
> >> +
> >> +static const u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] =3D {
> > =

> > Is this going to change in the future?
> > =

> =

> Yes, they could change and that was the reason to introduce the offsets. =

> This was discussed earlier too with Sudeep and was to add them.
> =

> >> +       [REG_ENABLE]            =3D 0x0,

This is only used once? Maybe it could be removed.

> >> +       [REG_LUT_TABLE]         =3D 0x110,

And this is only used during probe to figure out the supported
frequencies. So we definitely don't need to store around the registers
after probe in an array of iomem pointers. The only one that we need
after probe is the one below.

> >> +       [REG_PERF_STATE]        =3D 0x920,
> >> +};
> >> +
> >> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> >> +
> >> +static int
> >> +qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> >> +                            unsigned int index)
> >> +{
> >> +       struct cpufreq_qcom *c =3D policy->driver_data;
> >> +
> >> +       writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
> > =

> > Why can't we avoid the indirection here and store the perf_state pointer
> > in probe? Then we don't have to indirect through a table to perform the
> > register write.
> > =

> =

> As the offsets could change and that was the reason to add this.

With fast switching we can avoid incurring any extra instructions, so
please make another iomem pointer in the cpufreq_qcom struct just for
writing the index or if possible, just pass the iomem pointer that
points to the REG_PERF_STATE as the policy->driver_data variable here.
Then we have the address in hand without any extra load. If my
understanding is correct, we don't need to keep around anything besides
this register address anyway so we should be able to just load it and
write it immediately.
