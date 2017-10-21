From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 3/4] thermal/drivers/hisi: Prepare to add support for
 other hisi platforms
Date: Sat, 21 Oct 2017 10:14:33 +0200
Message-ID: <c202f396-fdc3-70cd-d762-71c088e04ba0@linaro.org>
References: <1508512267-18302-1-git-send-email-daniel.lezcano@linaro.org>
 <1508512267-18302-4-git-send-email-daniel.lezcano@linaro.org>
 <20171020205829.GA19087@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171020205829.GA19087@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 20/10/2017 22:58, Eduardo Valentin wrote:
> On Fri, Oct 20, 2017 at 05:11:06PM +0200, Daniel Lezcano wrote:
>> From: Kevin Wangtao <kevin.wangtao@linaro.org>
>>
>> For platform compatibility, add the tsensor ops to a thermal data
>> structure. Each platform has its own probe function to register proper
>> tsensor ops function to the pointer, platform related resource request
>> are also implemented in the platform probe function.
>>
>> Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
>> Tested-by: Daniel Lezcano <daniel.lezcano@linaro.org> # hikey6220
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> This patch adds this issue to hisi driver (sparse)
> 
> drivers/thermal/hisi_thermal.c:398:24: warning: incorrect type in assignment (different modifiers)
> drivers/thermal/hisi_thermal.c:398:24:    expected int ( *platform_probe )( ... )
> drivers/thermal/hisi_thermal.c:398:24:    got void const *
> 
> essentially you are casting a const into a non const.
> 
> Please fix and resend.

I was not able to reproduce the warning. I tried the C=1, C=2 options,
cross compiled or compiled on x86 with COMPILE_TEST, the warning does
not appear.

Are you using make C=1 or something else to run sparse on the kernel
sources ?



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
