From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC 0/7] qcom: Add support for tsens driver
Date: Fri, 05 Jun 2015 17:25:19 -0700
Message-ID: <7hvbf1y974.fsf@deeprootsystems.com>
References: <1429796773-7151-1-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1429796773-7151-1-git-send-email-rnayak@codeaurora.org>
	(Rajendra Nayak's message of "Thu, 23 Apr 2015 19:16:06 +0530")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, javi.merino@arm.com, punit.agrawal@arm.com
List-Id: linux-pm@vger.kernel.org

[+ Javi, Punit for power_allocator questions ]

Hi Rajendra,

Rajendra Nayak <rnayak@codeaurora.org> writes:

> This is an attempt to have a single tsens driver for
> the different versions of the tsens IP that exist, on
> different qcom msm/apq SoCs.
> Support is added for msm8916, msm8960 and msm8974 families.
> Based on top of the latest eeprom framework patches [1]

Curious how are you testing this?  with which thermal governor?

I'm experimenting with the new thermal power_allocator governor
currently in linux-next, and was hoping to use this to test it, but I'm
noticing it doesn't work with the power_allocator governor.

The first thing is that the power_allator goveror expects each thermal
zone to have a sustainable-power property in the DT, which this series
doesn't provide.  Hacking some dummy values in there to see what happens
next, I then hit the "thermal zone cpu-thermal0 has wrong trip setup for
power allocator" error from the power_allocator driver.

I stopped there as that made it clear this isn't yet ready to be used
with the power_allocator governor.

Kevin
