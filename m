From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC PATCH v15 04/11] ARM: cpuidle: Register cpuidle_ops for
 QCOM cpus
Date: Thu, 12 Mar 2015 09:06:55 -0600
Message-ID: <20150312150655.GA497@linaro.org>
References: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org>
 <1425914206-22295-5-git-send-email-lina.iyer@linaro.org>
 <5500866F.6080704@codeaurora.org>
 <550187C0.4020006@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <550187C0.4020006@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 12 2015 at 06:34 -0600, Daniel Lezcano wrote:
>On 03/11/2015 07:16 PM, Stephen Boyd wrote:
>>On 03/09/15 08:16, Lina Iyer wrote:

[...]

>>>+#if IS_ENABLED(CONFIG_QCOM_PM)
>>
>>Why not #ifdef CONFIG_QCOM_PM? I thought IS_ENABLED was for C code where
>>you want to put it in an if () statement.
>
>This is right. But the IS_ENABLED is also valid.
>
>It seems the current trend is to replace #ifdef with #if IS_ENABLED. 
>It is supposed to prevent to create or'ed conditional with the module 
>support.
>
>eg:
>
>#if defined(CONFIG_FOO) || defined(CONFIG_FOO_MODULE)
>
>is replaced by:
>
>#if IS_ENABLED(CONFIG_FOO)
>
>Lina: By the way, it would be preferable to use the 
>CONFIG_ARM_QCOM_CPUIDLE where IS_ENABLED makes more sense even the 

Daniel: I dont have CONFIG_ARM_QCOM_CPUIDLE defined anymore. By moving
to generic ARM cpuidle, i removed all changes to drivers/cpuidle/. So I
used the config item that defineds these items.

Also, having two indpendent CONFIG_ items provides a chance that the
declaration is not matched with the definition or vice versa.

>drivers are not modules (who knows if they are converted as module 
>again hence #ifdef will be invalid).
>
>
>
>>>+CPUIDLE_OPS(qcom_kpss_v1)
>>>+CPUIDLE_OPS(qcom_kpss_v2)
>>>+#endif
