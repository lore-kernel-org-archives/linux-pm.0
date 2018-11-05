From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Date: Mon, 5 Nov 2018 10:38:07 +0000
Message-ID: <20181105103807.GA12647@e107155-lin>
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-3-git-send-email-tdas@codeaurora.org>
 <153981915373.5275.15971019914218464179@swboyd.mtv.corp.google.com>
 <0c51a12e-38d3-2df5-4f5f-6a687727e9bf@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0c51a12e-38d3-2df5-4f5f-6a687727e9bf@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>
Cc: Stephen Boyd <swboyd@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, evgreen@google.com, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Nov 03, 2018 at 08:36:00AM +0530, Taniya Das wrote:
> Hello Stephen,
>
> On 10/18/2018 5:02 AM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-10-11 04:36:01)
> > > --- a/drivers/cpufreq/Kconfig.arm
> > > +++ b/drivers/cpufreq/Kconfig.arm

[...]

> > > +static const u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] = {
> >
> > Is this going to change in the future?
> >
>
> Yes, they could change and that was the reason to introduce the offsets.
> This was discussed earlier too with Sudeep and was to add them.

Sorry, I didn't like these registers to be coming from DT and I had the
same question: will this keep changing ? And IIRC, the answer was yes.
But I agree with Stephen, if and when we see the change, you can
introduce the array and keep it simple until then.

--
Regards,
Sudeep
