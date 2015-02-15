From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] PM-Trace: add pm-trace support for suspending phase
Date: Sun, 15 Feb 2015 10:29:01 +0800
Message-ID: <54E0046D.70209@linux.intel.com>
References: <54DB6A81.3040706@linux.intel.com> <20150212012339.GE28271@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21113 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754361AbbBOC3H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 14 Feb 2015 21:29:07 -0500
In-Reply-To: <20150212012339.GE28271@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


On 2015/2/12 9:23, Greg Kroah-Hartman wrote:
> On Wed, Feb 11, 2015 at 10:43:13PM +0800, Fu, Zhonghui wrote:
>> >From 2626594c03ca3b9884dd44073385c36f99a3651d Mon Sep 17 00:00:00 2001
>> From: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>> Date: Wed, 11 Feb 2015 16:20:21 +0800
>> Subject: [PATCH] PM-Trace: add pm-trace support for suspending phase
>>
>> Occasionally, the system can't come back up after suspend/resume
>> due to problems of device suspending phase. This patch make
>> PM_TRACE infrastructure cover device suspending phase of
>> suspend/resume process, and the information in RTC can tell
>> developers which device suspending function make system hang.
>>
>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>> ---
>>  arch/x86/include/asm/pm-trace.h     |   36 +++++++++++++++++++++++++++++++++++
>>  arch/x86/include/asm/resume-trace.h |   21 --------------------
>>  drivers/base/power/main.c           |   20 +++++++++++++++---
>>  drivers/base/power/trace.c          |    6 ++--
>>  include/linux/pm-trace.h            |   35 ++++++++++++++++++++++++++++++++++
>>  include/linux/resume-trace.h        |   34 ---------------------------------
>>  kernel/power/main.c                 |    2 +-
>>  7 files changed, 91 insertions(+), 63 deletions(-)
>>  create mode 100644 arch/x86/include/asm/pm-trace.h
>>  delete mode 100644 arch/x86/include/asm/resume-trace.h
>>  create mode 100644 include/linux/pm-trace.h
>>  delete mode 100644 include/linux/resume-trace.h
> Please create patches that move files around with -M so that the rename
> and changes can be reviewed much easier.  As it is, I can't see the
> changes you have made here.
I have re-sent this patch according to your comments, and the subject is "[PATCH v2] PM-Trace: add pm-trace support for suspending phase".


Thanks,
Zhonghui
>
> thanks,
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

