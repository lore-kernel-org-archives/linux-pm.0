From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 0/4] thermal/drivers/hisi: Add hi3660 thermal driver
 support
Date: Mon, 23 Oct 2017 19:07:39 +0200
Message-ID: <fae4287e-8bfd-c8cf-baec-b9b44675661d@linaro.org>
References: <1508662475-6763-1-git-send-email-daniel.lezcano@linaro.org>
 <20171023162157.GA2280@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023162157.GA2280@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23/10/2017 18:21, Eduardo Valentin wrote:
> On Sun, Oct 22, 2017 at 10:54:31AM +0200, Daniel Lezcano wrote:
>> This series adds the support for the hikey960 thermal driver. The tsensor
>> is almost the same than the hi6220 but with a memory shared updated by a
>> Cortex-M4.
>>
>> In order to handle both, the hi6220 and the hi3660, the current code should
>> be prefixed with the platform name as we will add functions with the same
>> purpose but slightly different. In addition, the core driver code is
>> maintained untouched by using a set of ops filled at boot time.
>>
>> Changelog:
>>
>>  - V3 :
>> 	- Fixed sparse warning about void const * mismatch assignment
> 
> Thanks for fixing this, the series is now applied.
> 
> Please have a look on my -linus branch and let me know if I missed any
> patches from you guys. Feel free to [RESEND] if I missed anything.


I had a look at your branch and our patches are there.

Thanks!

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
