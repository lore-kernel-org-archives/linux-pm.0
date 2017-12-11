From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH v4 11/12] cpufreq: Add module to register cpufreq on Krait
 CPUs
Date: Mon, 11 Dec 2017 18:52:55 +0530
Message-ID: <3c3849f2-9d8f-a3fc-701a-9b26d9ab4d0a@codeaurora.org>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
 <1512726150-7204-12-git-send-email-sricharan@codeaurora.org>
 <20171211083905.GF25177@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171211083905.GF25177@vireshk-i7>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 12/11/2017 2:09 PM, Viresh Kumar wrote:
> On 08-12-17, 15:12, Sricharan R wrote:
>> From: Stephen Boyd <sboyd@codeaurora.org>
>>
>> Register a cpufreq-generic device whenever we detect that a
>> "qcom,krait" compatible CPU is present in DT.
>>
>> Cc: <devicetree@vger.kernel.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  .../devicetree/bindings/arm/msm/qcom,pvs.txt       |  38 ++++
>>  drivers/cpufreq/Kconfig.arm                        |   9 +
>>  drivers/cpufreq/Makefile                           |   1 +
>>  drivers/cpufreq/qcom-cpufreq.c                     | 204 +++++++++++++++++++++
>>  4 files changed, 252 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,pvs.txt
>>  create mode 100644 drivers/cpufreq/qcom-cpufreq.c
> 
> This must be done differently as we have enhanced OPP core to support such
> hardware. Look at: dev_pm_opp_set_prop_name() and the binding around it
> (opp-microvolt-<name>). Talk to Stephen, he was part of all those discussions.
> 

  Thanks. Using opp-microvolt-<name> and setting the right name
  extension(dev_pm_opp_set_prop_name) after reading the version
  from efuse, makes it to work with proper opp-v2 bindings.
  Will repost with the updates. Also with opp-v2, just not having
  opp-shared property is enough to scale the cpu independently.
  As you have Nacked the other patch (correctly), will drop that
  patch to reintroduce the platform data. Testing this on ipq8064.
  Will check with Stephen once to make sure changes hold
  good for rest of the krait cores as well.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
