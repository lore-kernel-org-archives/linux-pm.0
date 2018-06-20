From: sricharan@codeaurora.org
Subject: Re: [PATCH v10 13/14] cpufreq: Add module to register cpufreq on
 Krait CPUs
Date: Wed, 20 Jun 2018 14:38:58 +0530
Message-ID: <4a15ab80f732ae22f12a1351550be6dc@codeaurora.org>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
 <1529415925-28915-14-git-send-email-sricharan@codeaurora.org>
 <f195e30e-bef3-9352-9584-fec35631ec5e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f195e30e-bef3-9352-9584-fec35631ec5e@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: mark.rutland@arm.com, robh@kernel.org, linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, linux-pm@vger.kernel.org, sboyd@codeaurora.org, linux@armlinux.org.uk, thierry.escande@linaro.org, linux-kernel@vger.kernel.org, david.brown@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, linux-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

>> 
>> Register a cpufreq-generic device whenever we detect that a
>> "qcom,krait" compatible CPU is present in DT.
>> 
> 
> Just curious to know how different is this from qcom kryo driver
> that was added recently. IIRC even that gets the speedbin from nvmem.
> Can they be merged ? I don't see need to have different driver for 
> Krait
> and Kryo CPUs when the code is not even remotely related to CPU type.
> 
> Sorry if I have missed anything from previous versions, I just happen
> to open and looked at this series first time today.

  Correct, having these two merged was pointed out earlier as well by 
Viresh.
  Now that kryo is merged, i will check once and see if they can be 
nicely
  merged.

Regards,
  Sricharan
