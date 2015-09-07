From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH 5/9] clk: qcom: gcc-msm8960: add child devices support.
Date: Mon, 07 Sep 2015 12:09:26 +0530
Message-ID: <55ED311E.1070404@codeaurora.org>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org> <1436348838-22671-6-git-send-email-rnayak@codeaurora.org> <20150811224902.GO2839@codeaurora.org> <55CB0B26.2020105@linaro.org> <55CC1CFE.7000005@codeaurora.org> <20150814004206.GU26614@codeaurora.org> <55CD5BD2.3070907@codeaurora.org> <55E660F6.3020007@codeaurora.org> <20150903172743.GE15099@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150903172743.GE15099@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, lina.iyer@linaro.org, nrajan@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

[]..

>>>> No. The driver should work just fine without having to
>>>> interrogate the device's compatible string. If we still need the
>>>> compatible check for some reason, then we can always match based
>>>> on qcom,gcc-msm8960, qcom,gcc-apq8064, etc. But I don't see why
>>>
>>> Thats not quite possible I guess. 2 drivers (gcc and tsens) matching
>>> the same compatibles? Will it not just depend on which ends up being
>>> the first match?
>>
>> Any thoughts on how to move forward with this?
>>
>> I tried what you were suggesting, and here's what I had to do to get
>> things working
>>
>> * Created a gcc node in DT with gcc and tsens compatibles, with gcc and
>> tsens properties
>
> This is not what I had in mind. This is what's should be in DT
>
>   clock-controller@f000 {
>   	compatible = "qcom,gcc-msm8916";
> 	reg = <0xf000 ...>;
> 	....
>   };
>
>> * gcc driver probes the device/node first given gcc is registered with
>> a core_initcall()
>> * creates a virtual child device attaching the same of_node (having
>> both gcc and tsens compatibles)
>> * gcc ends up probing the virtual device/node _again_ (due to the gcc
>> compatible match), fails
>> * At a later point, tsens driver gets registered (using module_initcall)
>> ends up probing the virtual child node and succeeds
>
> Yeah this might happen though because we've assigned the of_node
> pointer to the tsens device before we register it on the platform
> bus. The other way to pass that data down from gcc to tsens would
> be to not have an of_node assigned to the tsens device, and check
> for that case in the tsens driver. If there isn't an of_node,
> then we look at the parent device's of_node to figure out which
> gcc it is (if this even matters) and parse DT properties.

Parsing DT properties from parent (in the tsens driver) is fine, but
the nvmem apis still expect an of_node for the tsens device and hence
fail.

Associating the of_node of the parent to the tsens device while being
probed ends up with the same issues of gcc ending up probing the device
and failing because tsens defers probe a couple times before a
successful probe.
