From: Todd Poynor <tpoynor@mvista.com>
Subject: Re: [RFC] Adding board access to struct pm_ops pxa_pm_ops
Date: Mon, 10 Oct 2005 10:55:16 -0700
Message-ID: <434AAB04.50806@mvista.com>
References: <1128868700.8704.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1128868700.8704.66.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Richard Purdie wrote:
> The c7x0 and cxx00 (and other Zaurus) have some board specific power
> management issues. They include software controller charging circuitry
> which needs special handling and complicates suspend/resume operations.
> 
> For example, when suspended, the charging code needs to check the
> battery status every 10 minutes. It does this by using the RTC alarm
> function to wake the device up. By checking the wakeup source, it can
> know its just a battery/charging check, do any charging operations
> necessary, then suspend again without having to bring the system back up
> completely.
> 
> The device also wakes up if AC is plugged in/removed, if a real RTC
> alarm is due and under a variety of other conditions. The code knows how
> to handle each case.
> 
> It is surprisingly simple to add this functionality to the kernel as you
> just need to intercept the pxa_pm_enter() call. Calling pxa_pm_enter can
> send the device to sleep. Upon resume, the intercept function takes
> control and can return control to the system or do things like charging
> depending on the wakeup source.
> 
> I've included the only change needed to the kernel to make this work at
> the end of this email but I realise this might not be the most
> acceptable way to do this. The core requirement is the ability to call
> pxa_pm_enter() multiple times, only returning control back to the Linux
> core when certain conditions are met.
> 
> The full drivers are available as:
> 
> http://www.rpsys.net/openzaurus/patches/sharpsl_pm-r8.patch
> http://www.rpsys.net/openzaurus/patches/corgi_pm-r3.patch
> http://www.rpsys.net/openzaurus/patches/spitz_pm-r4.patch
> 
> The first patch is the shared code, the others are machine specific
> definitions. This code is designed to run without interrupts and without
> support from the rest of the Linux system when charging whilst
> suspended.
> 
> corgi_pxa_pm_enter() replaces pxa_pm_enter(). corgi_goto_sleep() calls
> the original pxa_pm_enter() after setting up state and
> corgi_enter_suspend() decides if the device should be suspended or
> resumed after each wakeup.
> 
> I realise the first patch could still use some further cleanup but I'm
> primarily interested in agreeing a method to achieve the desired
> suspend/resume functionality. Suggestions on how best to implement this
> in a manner acceptable to mainline would be much appreciated.

cc'ing linux-pm list.  A cell phone maker has expressed interest in 
approximately the same thing, in their case to barely wake from suspend, 
update the time and other display info, check to see if they need to 
fully resume, and if not go back to suspend.

A new optional pm_ops wakeup hook, called after the enter_state callback 
returns, that can veto resume and go back to call enter_state for the 
previous state should work, yes?  This hook would be intended for 
system-specific customization (should always be NULL in generic board 
support), and would avoid global access to pm_ops and the fragile 
process of inserting new routines into the suspend/resume callback 
paths.  I can float a patch for that if that sounds suitable.  Thanks -- 
Todd

> 
> Richard
> 
> 
> Make struct pm_ops pxa_pm_ops global so board specific code call be
> added into the suspend/resume chain on the PXA.
> 
> Signed-Off-By: Richard Purdie <rpurdie@rpsys.net>
> 
> Index: linux-2.6.13/arch/arm/mach-pxa/pm.c
> ===================================================================
> --- linux-2.6.13.orig/arch/arm/mach-pxa/pm.c	2005-10-09 15:16:30.000000000 +0100
> +++ linux-2.6.13/arch/arm/mach-pxa/pm.c	2005-10-09 15:16:56.000000000 +0100
> @@ -208,8 +208,11 @@
>  
>  /*
>   * Set to PM_DISK_FIRMWARE so we can quickly veto suspend-to-disk.
> + * 
> + * Warning: Some PXA boards intercept and wrap these handlers 
> + * to add functionality.
>   */
> -static struct pm_ops pxa_pm_ops = {
> +struct pm_ops pxa_pm_ops = {
>  	.pm_disk_mode	= PM_DISK_FIRMWARE,
>  	.prepare	= pxa_pm_prepare,
>  	.enter		= pxa_pm_enter,
> 
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
