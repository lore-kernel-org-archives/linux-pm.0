From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v8 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Fri, 24 Oct 2014 09:59:26 -0600
Message-ID: <20141024155926.GE30210@ilina-mac.qualcomm.com>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1412718106-17049-6-git-send-email-lina.iyer@linaro.org>
 <5448E103.9070505@linaro.org>
 <20141023165808.GC30210@ilina-mac.qualcomm.com>
 <544A10EF.9010505@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <544A10EF.9010505@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 24 2014 at 02:42 -0600, Daniel Lezcano wrote:
>On 10/23/2014 06:58 PM, Lina Iyer wrote:
>>On Thu, Oct 23 2014 at 05:05 -0600, Daniel Lezcano wrote:
>>>On 10/07/2014 11:41 PM, Lina Iyer wrote:

>>>+static int qcom_lpm_enter_spc(struct cpuidle_device *dev,
>>>>+                struct cpuidle_driver *drv, int index)
>>>>+{
>>>>+    cpu_pm_enter();
>>>>+    qcom_idle_enter(PM_SLEEP_MODE_SPC);
>>>
>>>Where is cpu_suspend ?
>>>
>>Inside that function qcom_idle_enter() in the SoC layer (pm.c)
>
>It would be preferable to group cpu_suspend with cpu_pm_enter/exit in 
>this function.
>
OK. Sure.


>>>+     /* Probe for other states, including standby */
>>>>+    ret = dt_init_idle_driver(drv, qcom_idle_state_match, 0);
>>>
>>>Are you sure it is not worth to add the simple WFI state ? It may have
>>>less latency than the standby mode, no ?
>>>
>>May be. But it would split the bucket between wfi and the cpu plus
>>allowing the L2 and the power hierarachy to enter their standby states.
>>This could very well be useful and possible, when there is a QoS request
>>that disallows power down and high latency states.
>
>Not necessarly a QoS, it could be a state selection from the governor 
>with very short latencies.
>
>>IMO, the benefit of the possible heirarchical standby seems to outweigh the
>>latency gain we may get by just doing a core's clock gating.
>
>It is up to the governor/scheduler to figure out this :)
>
There is a bit more problem than that, which I should have mentioned
earlier.
If we have SPM available and configured for the SoC, then unless we
explictly disable the SPM, the WFI instruction executed by the cpu core
would trigger SPM state machine and since we decided to set up the SPM
state machine to do its SPM sequence for standby only when we choose
standby in cpuidle, SPM might remain configured to do the previous idle
state and as such the WFI instruction from the core would do that
(possibly deeper), uintentionally, even when the scheduler decided only
to do cpu clock gating.

So we have to disable SPM everytime, per our pattern, if we want to do
that, that means, we still have to enter the SoC specific code, and
cannot get-by with the WFI instruction alone.


Lina
