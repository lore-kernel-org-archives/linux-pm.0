From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [GIT PULL] Immutable branch between MFD, GPIO, Thermal and X86
 due for the v4.13 merge window
Date: Wed, 31 May 2017 15:33:48 -0700
Message-ID: <cd6f226f-772b-cff6-dd80-f969021ba730@linux.intel.com>
References: <20170523072615.r4widzjc6apwxpwb@dell>
 <75e12563a835dc4f8e8dab26ecea46822262604b.1495559980.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170530085306.s4hlijutbz7gp3ay@dell>
 <20170531133826.3bee86a0@canb.auug.org.au>
 <CAENHMvOFEh_57eFcHM-58i4vPso9-dPc5Y63cQ2Rm0jX2G=yKQ@mail.gmail.com>
 <20170531065723.yhdgki6zgvbtmine@dell>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:11514 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdEaWhN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 May 2017 18:37:13 -0400
In-Reply-To: <20170531065723.yhdgki6zgvbtmine@dell>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, dvhart@infradead.org, rui.zhang@intel.com, Andy Shevchenko <andy@infradead.org>, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Platform Driver <platform-driver-x86@vger.kernel.org>

Hi Lee,


On 05/30/2017 11:57 PM, Lee Jones wrote:
> On Tue, 30 May 2017, Sathyanarayanan Kuppuswamy Natarajan wrote:
>
>> Hi All,
>>
>> On Tue, May 30, 2017 at 8:38 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>> Hi all,
>>>
>>> On Tue, 30 May 2017 09:53:06 +0100 Lee Jones <lee.jones@linaro.org> wrote:
>>>> Dear fellow Maintainers,
>>>>
>>>> Enjoy!
>>>>
>>>> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
>>>>
>>>>    Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>    git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-gpio-thermal-x86-v4.13
>>>>
>>>> for you to fetch changes up to 6aa60f67c11c10540e43bbe5a6377f7a0231501e:
>>>>
>>>>    platform: x86: intel_bxtwc_tmu: remove first level irq unmask (2017-05-30 09:34:08 +0100)
>>>>
>>>> ----------------------------------------------------------------
>>>> Immutable branch between MFD, GPIO, Thermal and X86 due for the v4.13 merge window
>>>>
>>>> ----------------------------------------------------------------
>>>> Kuppuswamy Sathyanarayanan (8):
>>>>        mfd: intel_soc_pmic_bxtwc: Use chained irqs for second level irq chips
>>> See my other bug report on this commit ...
>> Sorry, its a mistake from my end. It looks like typec wcove driver got
>> merged recently and I missed to add it to my cleanup patch set.
>>
>> Lee,
>>
>> I have created a patch to fix this issue.
>>
>> Do you want me to send the entire series again with this fix or just
>> send the fix alone.
> This highlights the fact that this patch-set is not actually
> bisectable.
Except for the last patch set ( which has fix for typec driver 
compilation issue) that I sent yesterday,
all other patch set versions are bisectable.

The problem was when I first created this patch set, typec wcove driver 
was not merged upstream.
After creating the initial set, I was just improving the patch set and 
forgot to re-check for
child devices that depend of PMIC MFD driver.  Thats why we came across 
this compilation issue.

In future, I will try to avoid these kind of issues. I think adding 
"allyesconfig" and "allmodconfig"
compilation tests to my patch submit criteria should prevent these kind 
of issues.

> To say that, when bisecting if we landed somewhere in the
> middle of this set, we would receive build errors.
>
> Ergo, this set is not actually acceptable in its current state.
> Please squash all patches where you are a) changing the API (in the
> MFD header), then b) transitioning users (child devices) over to it.
>
> Ensure that you do not make any code changes and remember to move all
> of the Acks you collected into the squashed patch.  Also, please use
> the $SUBJECT lines commonly used by particular subsystems.  For MFD
> the format is thus:
>
>    mfd: <device>: Patch description starting with an uppercase character
yes, will include it in next update.
>

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
