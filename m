From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH V3 0/4] cpufreq: dt: Create platform device from generic
 code
Date: Wed, 20 Apr 2016 23:27:25 +0200
Message-ID: <5717F43D.1060504@free.fr>
References: <cover.1459325515.git.viresh.kumar@linaro.org>
 <20160420095557.GF12019@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:55565 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbcDTV23 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Apr 2016 17:28:29 -0400
In-Reply-To: <20160420095557.GF12019@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, mmcclint@codeaurora.org, Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, k.kozlowski@samsung.com

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

Present in linux-next means it will show up in 4.6-rc5?

Regards.
