From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date: Tue, 20 Nov 2018 16:59:30 -0800
Message-ID: <154276197062.88331.8324696168748324451@swboyd.mtv.corp.google.com>
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-3-git-send-email-tdas@codeaurora.org>
 <153981915373.5275.15971019914218464179@swboyd.mtv.corp.google.com>
 <0c51a12e-38d3-2df5-4f5f-6a687727e9bf@codeaurora.org>
 <154130523254.88331.12609105382114756048@swboyd.mtv.corp.google.com>
 <3aa7b871-9cf9-9626-11fe-b9aa6009b477@codeaurora.org>
 <20181116002337.GP22824@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116002337.GP22824@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

Quoting Matthias Kaehlcke (2018-11-15 16:23:37)
> On Sun, Nov 11, 2018 at 06:12:29PM +0530, Taniya Das wrote:
> > On 11/4/2018 9:50 AM, Stephen Boyd wrote:
> > > Quoting Taniya Das (2018-11-02 20:06:00)
> > > > On 10/18/2018 5:02 AM, Stephen Boyd wrote:
> > > > > Quoting Taniya Das (2018-10-11 04:36:01)
> > > > > > --- a/drivers/cpufreq/Kconfig.arm
> > > > > > +++ b/drivers/cpufreq/Kconfig.arm
> > > > > > @@ -121,6 +121,17 @@ config ARM_QCOM_CPUFREQ_KRYO
> > > > > > =

> > > > > >             If in doubt, say N.
> > > > > > =

> > > > > > +config ARM_QCOM_CPUFREQ_HW
> > > > > > +       bool "QCOM CPUFreq HW driver"
> > > > > =

> > > > > Is there any reason this can't be a module?
> > > > > =

> > > > =

> > > > We do not have any use cases where we need to support it as module.
> > > =

> > > Ok, so it could easily be tristate then? Why not allow it?
> > > =

> > =

> > I have checked other vendors CPUfreq drivers and those too support only
> > "bool".
> =

> That's not entirely correct. Most drivers in Kconfig are 'tristate'
> and about 50% of those in KConfig.arm are. I'd say make it 'tristate'
> unless there are good reasons not to do so.

Yes, please make tristate.

> =

> > > > > > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufre=
q/qcom-cpufreq-hw.c
> > > > > > new file mode 100644
> > > > > > index 0000000..fe1c264
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > > > > @@ -0,0 +1,354 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * Copyright (c) 2018, The Linux Foundation. All rights reserv=
ed.
> > > > > > + */
> > > [...]
> > > > > > +
> > > > > > +static const u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] =3D {
> > > > > =

> > > > > Is this going to change in the future?
> > > > > =

> > > > =

> > > > Yes, they could change and that was the reason to introduce the off=
sets.
> > > > This was discussed earlier too with Sudeep and was to add them.
> > > > =

> > > > > > +       [REG_ENABLE]            =3D 0x0,
> > > =

> > > This is only used once? Maybe it could be removed.
> > > =

> > > > > > +       [REG_LUT_TABLE]         =3D 0x110,
> > > =

> > > And this is only used during probe to figure out the supported
> > > frequencies. So we definitely don't need to store around the registers
> > > after probe in an array of iomem pointers. The only one that we need
> > > after probe is the one below.
> > > =

> > > > > > +       [REG_PERF_STATE]        =3D 0x920,
> > > > > > +};
> > > > > > +
> > =

> > As these address offsets could change, so I am of the opinion to leave =
them
> > as it is.
> =

> As of now there is only one set of offsets. Let's just keep the code
> simple while this is the case and address different offsets when it is
> actually needed, as suggested by Stephen and Sudeep.

Yes, please simplify by getting rid of this and not storing anything in
the struct that's only used during probe.

> =

> > > =

> > > With fast switching we can avoid incurring any extra instructions, so
> > > please make another iomem pointer in the cpufreq_qcom struct just for
> > > writing the index or if possible, just pass the iomem pointer that
> > > points to the REG_PERF_STATE as the policy->driver_data variable here.
> > > Then we have the address in hand without any extra load. If my
> > > understanding is correct, we don't need to keep around anything besid=
es
> > > this register address anyway so we should be able to just load it and
> > > write it immediately.
> > > =

> > =

> > The c->reg_bases[] is just an index to the updated bases addresses. I a=
m not
> > clear as to why it would incur an extra instruction.
> > =

> > The below code would already take care of it.
> > =

> > +     for (i =3D REG_ENABLE; i < REG_ARRAY_SIZE; i++)
> > +             c->reg_bases[i] =3D base + offsets[i];
> > +
> =

> From a performance point of view using a direct iomem pointer
> seems like a micro-optimization that probably doesn't have a
> measurable impact. However I think the code shouldn't be more complex
> than necessary, and at this point the indirection isn't needed.
> =


Yes it's a micro-optimization for sure, in the task switching path so it
may actually be useful. Either way, I think we can greatly simplify by
just having the iomem pointer be the only pointer that is stored in the
policy driver_data.
