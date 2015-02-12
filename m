From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM-Trace: add pm-trace support for suspending phase
Date: Thu, 12 Feb 2015 09:23:39 +0800
Message-ID: <20150212012339.GE28271@kroah.com>
References: <54DB6A81.3040706@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45641 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbbBLBXu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 20:23:50 -0500
Content-Disposition: inline
In-Reply-To: <54DB6A81.3040706@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Feb 11, 2015 at 10:43:13PM +0800, Fu, Zhonghui wrote:
> >From 2626594c03ca3b9884dd44073385c36f99a3651d Mon Sep 17 00:00:00 2001
> From: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> Date: Wed, 11 Feb 2015 16:20:21 +0800
> Subject: [PATCH] PM-Trace: add pm-trace support for suspending phase
> 
> Occasionally, the system can't come back up after suspend/resume
> due to problems of device suspending phase. This patch make
> PM_TRACE infrastructure cover device suspending phase of
> suspend/resume process, and the information in RTC can tell
> developers which device suspending function make system hang.
> 
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
>  arch/x86/include/asm/pm-trace.h     |   36 +++++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/resume-trace.h |   21 --------------------
>  drivers/base/power/main.c           |   20 +++++++++++++++---
>  drivers/base/power/trace.c          |    6 ++--
>  include/linux/pm-trace.h            |   35 ++++++++++++++++++++++++++++++++++
>  include/linux/resume-trace.h        |   34 ---------------------------------
>  kernel/power/main.c                 |    2 +-
>  7 files changed, 91 insertions(+), 63 deletions(-)
>  create mode 100644 arch/x86/include/asm/pm-trace.h
>  delete mode 100644 arch/x86/include/asm/resume-trace.h
>  create mode 100644 include/linux/pm-trace.h
>  delete mode 100644 include/linux/resume-trace.h

Please create patches that move files around with -M so that the rename
and changes can be reviewed much easier.  As it is, I can't see the
changes you have made here.

thanks,

greg k-h
