From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2 8/8] platform: x86: intel_bxtwc_tmu: remove first level
 irq unmask
Date: Fri, 21 Apr 2017 15:34:05 -0700
Message-ID: <d9ead97f-db7b-a0b0-4eb1-1c783ee1e841@linux.intel.com>
References: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <93377b77b9493d79de48741b030fa1b03f80094f.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170421220025.GC31650@fury>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170421220025.GC31650@fury>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Darren,

Thanks for the review.


On 04/21/2017 03:00 PM, Darren Hart wrote:
> On Fri, Apr 14, 2017 at 04:26:00PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Currently in WCOVE PMIC mfd driver, all second level irq chips
> By currently I believe you mean after the earlier patch in this series is
> applied, correct?
Yes.
> This one is dependent on the previous one?
Yes, one of my previous patch in this series fixes this problem in MFD 
driver.
>
>> are chained to the respective first level irqs. So there is no
>> need for explicitly unmasking the first level irq in this
>> driver. This patches removes this level 1 irq unmask support.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> For platform drivers x86:
>
> Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>
>
> Are you working with a specific maintainers to pull this in as a series?
Thanks for brining it up. I was planning to ask either Andy or Lee 
regarding this issue after all patches in the series are reviewed.
> With so
> many subsystems, we need to coordinate to make sure we don't make a mess for
> Linus. Given the interdependencies, I'd recommend someone pull the series in as
> a whole - maybe into MFD? Lee, do you have a preference?
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer
