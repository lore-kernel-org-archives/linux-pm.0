From: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc/pm: add api to get suspend state which is
 STANDBY or MEM
Date: Fri, 9 May 2014 17:33:20 +0800
Message-ID: <CADRPPNRukfr92m4hSTar_N4iNYJ8fRPMnyOokzc9tCEDLg_BVw@mail.gmail.com>
References: <1398319908-30166-1-git-send-email-dongsheng.wang@freescale.com>
	<1398462328.24575.20.camel@snotra.buserror.net>
	<CADRPPNTGRyLSSjcdpdZL95NVnRepR_ZqvVk1zrMU3ZOL0_bbNQ@mail.gmail.com>
	<1398811632.24575.98.camel@snotra.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:57650 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756273AbaEIJdW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 05:33:22 -0400
Received: by mail-la0-f51.google.com with SMTP id gf5so242878lab.24
        for <linux-pm@vger.kernel.org>; Fri, 09 May 2014 02:33:20 -0700 (PDT)
In-Reply-To: <1398811632.24575.98.camel@snotra.buserror.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Dongsheng Wang <dongsheng.wang@freescale.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Zhao Chenhui <chenhui.zhao@freescale.com>, =?UTF-8?B?5q2j6ZuEIOmHkQ==?= <jason.jin@freescale.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Apr 30, 2014 at 6:47 AM, Scott Wood <scottwood@freescale.com> wrote:
> On Mon, 2014-04-28 at 13:53 +0800, Leo Li wrote:
>> On Sat, Apr 26, 2014 at 5:45 AM, Scott Wood <scottwood@freescale.com> wrote:
>> > On Thu, 2014-04-24 at 14:11 +0800, Dongsheng Wang wrote:
>> >> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>> >>
>> >> Add set_pm_suspend_state & pm_suspend_state functions to set/get
>> >> suspend state. When system going to sleep or deep sleep, devices
>> >> can get the system suspend state(STANDBY/MEM) through pm_suspend_state
>> >> function and to handle different situations.
>> >>
>> >> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>> >> ---
>> >> *v2*
>> >> Move pm api from fsl platform to powerpc general framework.
>> >
>> > What is powerpc-specific about this?
>>
>> Generally I agree with you.  But I had the discussion about this topic
>> a while ago with the PM maintainer.  He suggestion to go with the
>> platform way.
>>
>> https://lkml.org/lkml/2013/8/16/505
>
> If what he meant was whether you could do what this patch does, then you
> can answer him with, "No, because it got nacked as not being platform or
> arch specific."  Oh, and you're still using .valid as the hook to set
> the platform state, which is awful -- I think .begin is what you want to
> use.

I'm not saying the current patch is good for upstream.  Actually I did
say that the patch need to be updated for upstream purpose.  I only
meant that we discussed about having the mem/standby passed by generic
kernel/power interface as you suggested internally and got an negative
feedback.

>
> If we did it in powerpc code, then what would we do on ARM?  Copy the
> code?  No.

If you are saying that this shouldn't be done in arch/powerpc  Yes.
We have determined to use drivers/platform folder for the re-used code
with ARM.  Platform power management code will be moved there.

>
> Now, a more legitimate objection to putting it in generic code might be
> that "standby" and "mem" are loosely defined and the knowledge of how a
> driver should react to each is platform specific -- but your patch
> doesn't address that.  You still have the driver itself interpret what
> "standby" and "mem" mean.
>

Yup, we will address it in next batch.

- Leo
