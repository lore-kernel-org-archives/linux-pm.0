From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v8 4/7] qcom: pm: Add cpu low power mode functions
Date: Thu, 9 Oct 2014 09:56:43 -0600
Message-ID: <20141009155643.GB1277@ilina-mac.local>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1412718106-17049-5-git-send-email-lina.iyer@linaro.org>
 <5435E245.1090507@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5435E245.1090507@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 08 2014 at 19:17 -0600, Stephen Boyd wrote:
>On 10/07/2014 02:41 PM, Lina Iyer wrote:
>
>>+
>>+static struct platform_device qcom_cpuidle_device = {
>>+	.name              = "qcom_cpuidle",
>>+	.id                = -1,
>>+	.dev.platform_data = qcom_cpu_pm_enter_sleep,
>>+};
>>+
>
>Same comment as last time, doesn't need to be static.
>
Ok, sorry I missed it.

>>+static int __init qcom_pm_device_init(void)
>>+{
>>+	platform_device_register(&qcom_cpuidle_device);
>>+
>
>This is wrong. We're going to register a platform device whenever this 
>file is included in a kernel. This is then going to try and probe the 
>qcom_cpuidle device which is going to fail and print an error message 
>if we're not running on a qcom device.
Why would this file be compiled on a non-qcom target? The file has a
dependency on ARCH_QCOM (as it should be) and would not be compiled on a
non-qcom target.

>This is one reason why I've 
>been arguing to get rid of this file and just put it inside the spm 
>driver. That way we don't ever add the cpuidle device and:
That is a poor excuse for removing this file, which has a purpose.
Putting all this SCM code inside SPM is not a good design. SPM is a
driver, doesnt know about SCM et al. Why would you want to clobber that
file with all these irrelevant code? 8660 does not have a secure mode,
but still uses an SPM. So all this code is pretty useless there, not
that we are supporting 8660 at this time, just as an example.
>
> a) We know the SPM hardware is configured and ready to be used
Its just one line check to see if the SPM hardware exists. There is no
error otherwise.
> b) We don't get this annoying warning and have some weird device in 
>sysfs on non-qcom devices
We wont compile this file on non-qcom device, so the point is moot.
Well, we may see the error, if the cpuidle framework is not compiled in.
But putthing this in SPM doesnt solve that problem either.
