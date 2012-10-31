From: Daniel Mack <zonque@gmail.com>
Subject: Re: pm: add suspend_mem and suspend_standby support
Date: Wed, 31 Oct 2012 11:27:13 +0100
Message-ID: <5090FD01.1080709@gmail.com>
References: <20121006161429.GD12462@game.jcrosoft.org> <20121009145854.GB14079@kroah.com> <20121009151704.GP12801@game.jcrosoft.org> <3430030.rKEkeKmzui@vostro.rjw.lan> <5075210B.3020309@ti.com> <50753DD9.1080105@gmail.com> <79CD15C6BA57404B839C016229A409A83EB3AF86@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33262 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932340Ab2JaK1X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 31 Oct 2012 06:27:23 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so555829bkc.19
        for <linux-pm@vger.kernel.org>; Wed, 31 Oct 2012 03:27:21 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB3AF86@DBDE01.ent.ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>

On 10.10.2012 11:29, Hiremath, Vaibhav wrote:
> On Wed, Oct 10, 2012 at 14:50:25, Daniel Mack wrote:
>> On 10.10.2012 09:17, Vaibhav Hiremath wrote:
>>> On 10/10/2012 3:42 AM, Rafael J. Wysocki wrote:
>>>> On Tuesday 09 of October 2012 17:17:04 Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>> On 07:58 Tue 09 Oct     , Greg Kroah-Hartman wrote:
>>>>>> On Tue, Oct 09, 2012 at 01:46:33PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>>>> On 22:02 Sun 07 Oct     , Rafael J. Wysocki wrote:
>>>>>>>> On Sunday 07 of October 2012 15:12:01 Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>>>>>> On 00:18 Sun 07 Oct     , Rafael J. Wysocki wrote:
>>>>>>>>>> On Saturday 06 of October 2012 18:14:29 Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> The following changes since commit 5f3d2f2e1a63679cf1c4a4210f2f1cc2f335bef6:
>>>>>>>>>>>
>>>>>>>>>>>   Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc (2012-10-06 03:16:12 +0900)
>>>>>>>>>>>
>>>>>>>>>>> are available in the git repository at:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>   git://git.jcrosoft.org/linux-2.6.git tags/pm_suspend_standby_mem
>>>>>>>>>>>
>>>>>>>>>>> for you to fetch changes up to b73c8f97aa8e720bd3b921159687d00626c99d63:
>>>>>>>>>>>
>>>>>>>>>>>   arm: at91: drop at91_suspend_entering_slow_clock (2012-10-06 18:06:25 +0800)
>>>>>>>>>>>
>>>>>>>>>>> ----------------------------------------------------------------
>>>>>>>>>>> pm: add suspend_mem and suspend_standby support
>>>>>>>>>>>
>>>>>>>>>>> Today when we go to suspend we can not knwon at drivers level if we go in
>>>>>>>>>>> STANDBY or MEM. Fix this by introducing two new callback suspend_mem and
>>>>>>>>>>> suspend_standby.
>>>>>>>>>>
>>>>>>>>>> No way. Device drivers shouldn't be concerned about that.
>>>>>>>>> I do need it on at91 as we swith to slow_clock in MEM suspend and some ip
>>>>>>>>> need special handling when switching to slow_clock
>>>>>>>>
>>>>>>>> Well, my answer to that is: please fix your platform code instead of
>>>>>>>> hacking the PM core to work around its problems.
>>>>>>> how can I fix drivers pm issue when I no way to known at driver level the
>>>>>>> real suspend, the PM core is supposed to proivde the right information to the
>>>>>>> drivers so the driver can put it's in the right pm mode. If the pm core can not
>>>>>>> provide such inforation the PM core is broken as we will have to do dirty
>>>>>>> hack.
>>>>>>
>>>>>> Why do you need to know the difference in your driver?  We used to
>>>>>> provide this information a long time ago, but it turned out to not be
>>>>>> needed at all and just caused problems.
>>>>> because on at91 I need to handle the mem standby at drviers level.
>>>>
>>>> This is not an answer.  You're basically saying "it has to be done this way,
>>>> because it has to be done this way".
>>>>
>>>>> We do it today already by a hack in different drivers at91_udc (usb device),
>>>>> atmel_serail and at91_ohci. Those 3 IP have specifci handling when switching
>>>>> to mem pm. On at91 when switch to mem we shutdown everything and run form a slow
>>>>> clock - this is done at soc level - but those IP have issue and need specific
>>>>> care before doing so. Ohterwise when the SoC will wakeup but those IP will not
>>>>>
>>>>> in this patch series I send the update of those 3 drivers too
>>>>> and kill the hack
>>>>
>>>> Well, let's start over.  What's the difference between "suspend to RAM" (mem)
>>>> and "standby" on your platform?
>>>>
>>>>>>> Any generic framework is supposed to evolve for real user need here I've one
>>>>>>> so I udpate the core to mach a need
>>>>
>>>> Yes, if there are more users needing a change.  If there's only one, I think not
>>>> really.
>>>>
>>>
>>> We came across such a need while supporting various low-power modes in
>>> AM335x SoC. I also wanted to put similar proposal, its good that Jean
>>> submitted patches and we are having this discussion early.
>>>
>>> Let me try to describe the need and issue here,
>>>
>>> In case of AM33xx device, we have different low-power modes supported
>>> by HW, for this discussion I will just talk about DeepSleep-0 and
>>> StandBy mode supported by HW (few other modes also described in spec)-
>>>
>>> Below is the Spec definition of these two low-power modes,
>>
>> Thanks for this summary, which raises a question for me that might be
>> slightly unreleated to the general discussion, but still:
>>
>> I was just looking at the code that ships with the BSP kernel, and the
>> approach there is to load a binary firmare blob to the M3 UMEM and then
>> communicates with mailbox commands in order to put the system to suspend.
>>
> 
> Ohh, Great, then you are aware of AM33xx power management support.
> As you are aware, M3 here works as a soft-PRCM block, so certain things has 
> to be done on M3 while entering into low-power state.
> 
>> Is this how it should be done in mainline as well or are there any plans
>> to implement that behaviour natively?
>>
> 
> Yes, we will follow similar approach for Mainline, its under development and 
> soon you will see patches getting submitted to the list for review. The 
> first step is to get deepsleep-0 support in Mainline and then other will 
> follow.

May I ask whether there is anything yet I can test?


Thanks,
Daniel

