From: Kukjin Kim <kgene@kernel.org>
Subject: Re: [PATCH 1/3] exynos: config: Remove CONFIG_EXYNOS_THERMAL_CORE
 define (exynos_defconfig)
Date: Wed, 04 Feb 2015 23:33:50 +0900
Message-ID: <54D22DCE.5070806@kernel.org>
References: <1422458920-14555-1-git-send-email-l.majewski@samsung.com> <20150129225908.GH29837@developer.amazonguestwifi.org> <20150204144943.58003ac6@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150204144943.58003ac6@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 02/04/15 22:49, Lukasz Majewski wrote:
> Hi Kukjin,
> 
Hi,

>> On Wed, Jan 28, 2015 at 04:28:38PM +0100, Lukasz Majewski wrote:
>>> After Exynos TMU rework to use device tree for configuration this
>>> flag can be removed. It is not used anymore.
>>>
>>> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>>
>> I dont see problems with this patch:
>>
>> Acked-by: Eduardo Valentin <edubezval@gmail.com>
>>
>> This should go, obviously, via the correct platform tree.
> 
> Could you apply this patch to -samsung tree?
> 
Sure, I'll queue this series into samsung tree.

Thanks,
Kukjin
