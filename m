From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] vt: add init_hide parameter to suppress boot output
Date: Wed, 20 Feb 2013 17:12:42 -0800
Message-ID: <20130221011242.GB4961@kroah.com>
References: <1361289224-10678-1-git-send-email-kirill.shutemov@linux.intel.com>
 <20130220014512.GC31018@kroah.com>
 <51244B35.8090006@windriver.com>
 <20130220044506.GA2728@kroah.com>
 <5124FFD7.8070708@windriver.com>
 <20130220205737.GB6597@xo-6d-61-c0.localdomain>
 <51254959.1020309@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:52173 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab3BUBOZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Feb 2013 20:14:25 -0500
Received: by mail-pa0-f51.google.com with SMTP id hz1so4377311pad.10
        for <linux-pm@vger.kernel.org>; Wed, 20 Feb 2013 17:14:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <51254959.1020309@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Ross <andy.ross@windriver.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, Feb 20, 2013 at 02:08:25PM -0800, Andy Ross wrote:
> On 02/20/2013 12:57 PM, Pavel Machek wrote:
> >I'm sure something creative can be done with fake init that shuts
> >the console up then execs previous init. No need to add more kernel
> >knobs, I'd say.
> 
> Fair enough, but some last words:
> 
> That's argument is the "it's about logging" hypothesis again.  Even if
> it were possible to completely shut up console output (something
> that's awfully hard in the general case when running on PC hardware,
> and IMHO from a developer's perspective not even a good thing), that's
> not the whole problem.  The framebuffer console initialization does a
> buffer clear and mode set, and that clobbers anything the bootloader
> might have left on the screen prematurely, before userspace is ready
> to throw up its own splash.  Splash screens may be a silly
> requirement, but they're still a requirement.

Yes, they are a requirement in some situations, and if you look most
distros have already solved this issue for you, by not using a
framebuffer at all.  Why not just do the same thing in your Android
system as you do have full control over the hardware and the boot
process.

> And the suspend console problem is likewise at work: ideally you'd
> like to know, for example, that the panel backlight is off before
> suspending.  But what happens in practice is that the kernel does a VT
> switch to/from console 63 and the backlight wakes up (I'm not going to
> pretend I have this bit completely figured out, but the problem is/was
> real and this patch fixed it by suppressing the console visibility).

My systems don't drop down to the framebuffer when suspending, I think
you need to look at using a better distro :)

> Now, the point that an in-kernel console is "going away" and thus not
> worth augmenting with new APIs is valid.  And this is a small patch
> that's unlikely to be difficult to maintain in a custom tree.  And as
> we all agree there are other mechanisms that can be used here (even if
> AFAICT they don't completely solve the problem), and indeed I'd love
> to get surfaceflinger working with VT_ACTIVATE et. al. if I get a
> chance.  So I'm not going to cry if this isn't worth mainline.

I don't see why this is even needed for surfaceflinger systems, as
again, you have full control over the hardware and system so you don't
even need a framebuffer console at all.

thanks,

greg k-h
