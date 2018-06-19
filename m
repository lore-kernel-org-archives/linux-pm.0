From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v10 13/14] cpufreq: Add module to register cpufreq on
 Krait CPUs
Date: Tue, 19 Jun 2018 14:56:31 +0100
Message-ID: <f195e30e-bef3-9352-9584-fec35631ec5e@arm.com>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
 <1529415925-28915-14-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529415925-28915-14-git-send-email-sricharan@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, thierry.escande@linaro.org, ctatlor97@gmail.com, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org



On 19/06/18 14:45, Sricharan R wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Register a cpufreq-generic device whenever we detect that a
> "qcom,krait" compatible CPU is present in DT.
> 

Just curious to know how different is this from qcom kryo driver
that was added recently. IIRC even that gets the speedbin from nvmem.
Can they be merged ? I don't see need to have different driver for Krait
and Kryo CPUs when the code is not even remotely related to CPU type.

Sorry if I have missed anything from previous versions, I just happen
to open and looked at this series first time today.

-- 
Regards,
Sudeep
