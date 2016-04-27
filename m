From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH V3 0/4] cpufreq: dt: Create platform device from generic
 code
Date: Wed, 27 Apr 2016 18:47:11 +0200
Message-ID: <5720ED0F.6050204@free.fr>
References: <cover.1459325515.git.viresh.kumar@linaro.org>
 <20160420095557.GF12019@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:12519 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbcD0Qrk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Apr 2016 12:47:40 -0400
In-Reply-To: <20160420095557.GF12019@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, mmcclint@codeaurora.org, Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, k.kozlowski@samsung.com, Sebastian Frias <sf84@laposte.net>

On 20/04/2016 11:55, Viresh Kumar wrote:
> On 30-03-16, 13:45, Viresh Kumar wrote:
>> Multiple platforms are using the generic cpufreq-dt driver now, and all
>> of them are required to create a platform device with name "cpufreq-dt",
>> in order to get the cpufreq-dt probed.
>>
>> Many of them do it from platform code, others have special drivers just
>> to do that.
>>
>> It would be more sensible to do this at a generic place, where all such
>> platform can mark their entries.
>>
>> The first patch fixes an issue that came up with an earlier version of
>> patch 2/4, but its still worth fixing it.  The second one creates a new
>> driver to create platform-device based on current platform and the last
>> two converts exynos platform to use this common infrastructure.
>>
>> I will migrate rest of the platforms after this is accepted as the right
>> way ahead.
> 
> @Matthew and @Mason,
> 
> Now that this is present in linux-next, you guys can send patches for
> your platforms cpufreq support.

Viresh,

IIUC, all I need to do is add my platform's string to
drivers/cpufreq/cpufreq-dt-platdev.c ?

Should I add it at the beginning or at the end?
(I suppose at the end.)

I should add "sigma,tango4", since that's what is used
in arch/arm/mach-tango/setup.c right?

Regards.
