From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM-Trace: add pm-trace support for suspending phase
Date: Tue, 10 Feb 2015 05:55:59 +0800
Message-ID: <20150209215559.GA12087@kroah.com>
References: <54D8318B.2060703@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55759 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796AbbBIV4D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Feb 2015 16:56:03 -0500
Content-Disposition: inline
In-Reply-To: <54D8318B.2060703@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: "rjw@rjwysocki.net >> Rafael J. Wysocki" <rjw@rjwysocki.net>, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Feb 09, 2015 at 12:03:23PM +0800, Fu, Zhonghui wrote:
> >From ec9c0f24e800461361eaf8b280abe4272b00772d Mon Sep 17 00:00:00 2001
> From: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> Date: Mon, 9 Feb 2015 11:09:22 +0800
> Subject: [PATCH] PM-Trace: add pm-trace support for suspending phase

Why is this crud here?

> 
> Occasinally, the system can't come back up after suspend/resume
> due to problems of device suspending phase. This patch make
> PM_TRACE infrastructure cover device suspending phase of
> suspend/resume process, and the information in RTC can tell
> develpers which device suspending function make system hang.
> 
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
>  arch/x86/include/asm/resume-trace.h |    2 +-
>  drivers/base/power/main.c           |   30 +++++++++++++++++++++---------
>  include/linux/resume-trace.h        |    2 +-
>  3 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resume-trace.h b/arch/x86/include/asm/resume-trace.h
> index 3ff1c2c..0ca2215 100644
> --- a/arch/x86/include/asm/resume-trace.h
> +++ b/arch/x86/include/asm/resume-trace.h
> @@ -3,7 +3,7 @@
>  
>  #include <asm/asm.h>
>  
> -#define TRACE_RESUME(user)					\
> +#define TRACE_SUSPEND_RESUME(user)				\
>  do {								\
>  	if (pm_trace_enabled) {					\
>  		const void *tracedata;				\

Why rename this?

If you want to do that, do it in 2 different functions (rename first,
with justification, add new functionality in a second patch)

> @@ -1078,7 +1082,7 @@ static int device_suspend_noirq(struct device *dev)
>  {
>  	reinit_completion(&dev->power.completion);
>  
> -	if (pm_async_enabled && dev->power.async_suspend) {
> +	if (is_async(dev)) {

Why change this logic?

greg k-h
