From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc/pm: add api to get suspend state which
 is STANDBY or MEM
Date: Tue, 29 Apr 2014 17:47:12 -0500
Message-ID: <1398811632.24575.98.camel@snotra.buserror.net>
References: <1398319908-30166-1-git-send-email-dongsheng.wang@freescale.com>
	 <1398462328.24575.20.camel@snotra.buserror.net>
	 <CADRPPNTGRyLSSjcdpdZL95NVnRepR_ZqvVk1zrMU3ZOL0_bbNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2lp0239.outbound.protection.outlook.com ([207.46.163.239]:50883
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751060AbaD2WrV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Apr 2014 18:47:21 -0400
In-Reply-To: <CADRPPNTGRyLSSjcdpdZL95NVnRepR_ZqvVk1zrMU3ZOL0_bbNQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Li <pku.leo@gmail.com>
Cc: Dongsheng Wang <dongsheng.wang@freescale.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Zhao Chenhui <chenhui.zhao@freescale.com>, =?UTF-8?Q?=E6=AD=A3=E9=9B=84_=E9=87=91?= <jason.jin@freescale.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Mon, 2014-04-28 at 13:53 +0800, Leo Li wrote:
> On Sat, Apr 26, 2014 at 5:45 AM, Scott Wood <scottwood@freescale.com> wrote:
> > On Thu, 2014-04-24 at 14:11 +0800, Dongsheng Wang wrote:
> >> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >>
> >> Add set_pm_suspend_state & pm_suspend_state functions to set/get
> >> suspend state. When system going to sleep or deep sleep, devices
> >> can get the system suspend state(STANDBY/MEM) through pm_suspend_state
> >> function and to handle different situations.
> >>
> >> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> >> ---
> >> *v2*
> >> Move pm api from fsl platform to powerpc general framework.
> >
> > What is powerpc-specific about this?
> 
> Generally I agree with you.  But I had the discussion about this topic
> a while ago with the PM maintainer.  He suggestion to go with the
> platform way.
> 
> https://lkml.org/lkml/2013/8/16/505

If what he meant was whether you could do what this patch does, then you
can answer him with, "No, because it got nacked as not being platform or
arch specific."  Oh, and you're still using .valid as the hook to set
the platform state, which is awful -- I think .begin is what you want to
use.

If we did it in powerpc code, then what would we do on ARM?  Copy the
code?  No.

Now, a more legitimate objection to putting it in generic code might be
that "standby" and "mem" are loosely defined and the knowledge of how a
driver should react to each is platform specific -- but your patch
doesn't address that.  You still have the driver itself interpret what
"standby" and "mem" mean.

As for "in analogy with ACPI suspend operations", can someone familiar
with ACPI explain what is meant?

-Scott


