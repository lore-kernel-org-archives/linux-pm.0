From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv6 0/2] thermal: exynos: Add support for TRIMINFO feature of
 Exynos3250
Date: Wed, 03 Sep 2014 23:11:23 +0900
Message-ID: <5407218B.1020702@samsung.com>
References: <1409713743-6124-1-git-send-email-cw00.choi@samsung.com>
 <20140830023928.GC23645@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20140830023928.GC23645@developer>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: eduardo.valentin@ti.com, amit.daniel@samsung.com, rui.zhang@intel.com, kgene.kim@samsung.com, ch.naveen@samsung.com, kyungmin.park@samsung.com, b.zolnierkie@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Dear Eduardo,

On 08/30/2014 11:39 AM, Eduardo Valentin wrote:
> Hi,
> 
> On Wed, Sep 03, 2014 at 12:09:01PM +0900, Chanwoo Choi wrote:
>> This patchset add the support of TRIMINFO_RELOAD feature for Exynos3250.
>> But Exynos3250 has two TRIMINFO_CTRL register instead other Exynos has only one
>> TRIMINFO_CTRL register. So, this patchset support the some Exynos SoC which
>> has more than one TRIMINF_CTRL.
>>
>> Also, this patchset fix wrong value of TRIMINFO_RELOAD_SHIFT and remove
>> duplicate code when reading triminfo register of Exynos5440.
>>
>> Changes from v5:
>> - Rebase this patchset on next branch of linux-soc-thermal.git
>>
> 
> Pulled into my next branch. Thanks.

Thanks.

Best Regards,
Chanwoo Choi
