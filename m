From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 3/4] thermal/drivers/hisi: Prepare to add support for
 other hisi platforms
Date: Sat, 21 Oct 2017 09:42:57 -0700
Message-ID: <20171021164256.GA30342@localhost.localdomain>
References: <1508512267-18302-1-git-send-email-daniel.lezcano@linaro.org>
 <1508512267-18302-4-git-send-email-daniel.lezcano@linaro.org>
 <20171020205829.GA19087@localhost.localdomain>
 <c202f396-fdc3-70cd-d762-71c088e04ba0@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:56611 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932125AbdJUQnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Oct 2017 12:43:01 -0400
Content-Disposition: inline
In-Reply-To: <c202f396-fdc3-70cd-d762-71c088e04ba0@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Sat, Oct 21, 2017 at 10:14:33AM +0200, Daniel Lezcano wrote:
> On 20/10/2017 22:58, Eduardo Valentin wrote:
> > On Fri, Oct 20, 2017 at 05:11:06PM +0200, Daniel Lezcano wrote:
> >> From: Kevin Wangtao <kevin.wangtao@linaro.org>
> >>
> >> For platform compatibility, add the tsensor ops to a thermal data
> >> structure. Each platform has its own probe function to register proper
> >> tsensor ops function to the pointer, platform related resource request
> >> are also implemented in the platform probe function.
> >>
> >> Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
> >> Tested-by: Daniel Lezcano <daniel.lezcano@linaro.org> # hikey6220
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > 
> > This patch adds this issue to hisi driver (sparse)
> > 
> > drivers/thermal/hisi_thermal.c:398:24: warning: incorrect type in assignment (different modifiers)
> > drivers/thermal/hisi_thermal.c:398:24:    expected int ( *platform_probe )( ... )
> > drivers/thermal/hisi_thermal.c:398:24:    got void const *
> > 
> > essentially you are casting a const into a non const.
> > 
> > Please fix and resend.
> 
> I was not able to reproduce the warning. I tried the C=1, C=2 options,
> cross compiled or compiled on x86 with COMPILE_TEST, the warning does
> not appear.
> 
> Are you using make C=1 or something else to run sparse on the kernel
> sources ?


Yes, this is a make C=1.

The warning is in this code that you add in this patch:
+       platform_probe = of_device_get_match_data(dev);
+       if (!platform_probe) {
+               dev_err(dev, "failed to get probe func\n");
+               return -EINVAL;
        }

platform_probe should be const, because of_device_get_match_data() returns a const:

$ grep -A 10 of_device_get_match_data drivers/of/device.c 
const void *of_device_get_match_data(const struct device *dev)
{
	const struct of_device_id *match;

	match = of_match_device(dev->driver->of_match_table, dev);
	if (!match)
		return NULL;

	return match->data;
}
EXPORT_SYMBOL(of_device_get_match_data);


which I agree, you should use a const to receive the of_device_get_match_data().

> 
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
