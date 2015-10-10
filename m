From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] thermal: exynos: fix register read in TMU
Date: Sat, 10 Oct 2015 13:36:16 +0900
Message-ID: <561895C0.5030400@samsung.com>
References: <1443699599-9693-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAJKOXPfyC8etcPe373q6Pc1qWb2zVnHE96V+Rh5mPmpzAxFjiA@mail.gmail.com>
 <20151001141243.GA5061@sudip-pc>
 <CAJKOXPdVs9i9sVP84wa2wU0qVH1-o4unvaDC+O7c1za6bJUSLw@mail.gmail.com>
 <20151008142129.GC10587@sudip-pc>
 <CAJKOXPfbrdm75n_v+dRnq8dqAFAGvHj28QQ4ZY8WZms1D6eLZQ@mail.gmail.com>
 <20151009140716.0c6e57b7@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33830 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbbJJEgX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 10 Oct 2015 00:36:23 -0400
In-Reply-To: <20151009140716.0c6e57b7@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: k.kozlowski.k@gmail.com, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-arm-kernel@lists.infradead.org

W dniu 09.10.2015 o 21:07, Lukasz Majewski pisze:
> Hi Krzysztof,
> 
>> 2015-10-08 23:21 GMT+09:00 Sudip Mukherjee
>> <sudipm.mukherjee@gmail.com>:
>>> On Fri, Oct 02, 2015 at 08:43:52AM +0900, Krzysztof Kozlowski wrote:
>>>> 2015-10-01 23:12 GMT+09:00 Sudip Mukherjee
>>>> <sudipm.mukherjee@gmail.com>:
>>>>> On Thu, Oct 01, 2015 at 10:18:57PM +0900, Krzysztof Kozlowski
>>>>> wrote:
>>>>>> 2015-10-01 20:39 GMT+09:00 Sudip Mukherjee
>>>>>> <sudipm.mukherjee@gmail.com>:
>>>>>>> The value of emul_con was getting overwritten if the selected
>>>>>>> soc is SOC_ARCH_EXYNOS5260. And so as a result we were
>>>>>>> reading from the wrong register in the case of
>>>>>>> SOC_ARCH_EXYNOS5260.
>>>>>>
>>>>>> How the value is overwritten if the soc is Exynos5260? I can't
>>>>>> see it (although the "else if" is still more obvious than "if"
>>>>>> but how does the description match the code?).
>>>>> The code here is:
>>>>> if (data->soc == SOC_ARCH_EXYNOS5260)
>>>>>         emul_con = EXYNOS5260_EMUL_CON;
>>>>> if (data->soc == SOC_ARCH_EXYNOS5433)
>>>>>         emul_con = EXYNOS5433_TMU_EMUL_CON;
>>>>> else if (data->soc == SOC_ARCH_EXYNOS7)
>>>>>         emul_con = EXYNOS7_TMU_REG_EMUL_CON;
>>>>> else
>>>>>         emul_con = EXYNOS_EMUL_CON;
>>>>>
>>>>> So if data->soc is SOC_ARCH_EXYNOS5260 , then emul_con becomes
>>>>> EXYNOS5260_EMUL_CON. But again for the else part it will become
>>>>> EXYNOS_EMUL_CON.
>>>>
>>>> Indeed!
>>>>
>>>> Fixes: 488c7455d74c ("thermal: exynos: Add the support for
>>>> Exynos5433 TMU")
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>
>>> Hi Krzysztof,
>>> Who will pick this one up? I still do not see it in linux-next.
>>
>> Hi!
>>
>> I guess it is a patch for Lukasz.
>>
>> Lukasz,
>> Do you plan to pick it up or maybe this should go through samsung-soc
>> tree?
> 
> This is the only one patch, which is waiting in my queue. Since no more
> fixes available, please feel free to grab this patch to samsung-soc.
> 
> Acked-by: Lukasz Majewski <l.majewski@samsung.com>

Okay, thanks! Applied to fixes for current cycle. I'll it send later to
Kukjin (unless he picks it as well).

Best regards,
Krzysztof

