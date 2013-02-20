From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] vt: add init_hide parameter to suppress boot output
Date: Tue, 19 Feb 2013 20:45:06 -0800
Message-ID: <20130220044506.GA2728@kroah.com>
References: <1361289224-10678-1-git-send-email-kirill.shutemov@linux.intel.com>
 <20130220014512.GC31018@kroah.com>
 <51244B35.8090006@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:56028 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933680Ab3BTEol (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Feb 2013 23:44:41 -0500
Received: by mail-pb0-f50.google.com with SMTP id up1so2644310pbc.37
        for <linux-pm@vger.kernel.org>; Tue, 19 Feb 2013 20:44:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <51244B35.8090006@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Ross <andy.ross@windriver.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Feb 19, 2013 at 08:04:05PM -0800, Andy Ross wrote:
> On 02/19/2013 05:45 PM, Greg Kroah-Hartman wrote:
> >>When vt.init_hide is set, suppress output on newly created consoles
> >>until an affirmative switched to that console.  This prevents boot
> >>output from displaying (and clobbering splash screens, etc...)
> >>without disabling the console entirely.
> >
> >What's wrong with the 'quiet' option we have?  And you forgot to
> >document this.
> 
> You're right about docs, obviously.  I'll write something up and send
> it tomorrow morning.
> 
> But setting "quiet" controls logging.  It won't prevent the console
> from doing a buffer clear or mode switch, nor will it prevent
> userspace from writing to it, nor will the buffer rewrites due to the
> console switches that happen on suspend and resume (which I didn't
> know existed) be suppressed.
> 
> There's a (sort of) similar commonly-used option, vga=current, which
> prevents a mode switch for the special case of VGA/vesa.  But that
> doesn't work with the framebuffer console.

Why not?  Can't you fix that?

> The idea here (and I'm clearly no domain expert) was to leave the
> console enabled and active, but invisible by default.  So nothing
> displays, the splash screen stays put, and nothing fights with other
> users of the framebuffer.  And it stays that way until something
> affirmatively switches to a different VT using chvt or Alt-Fn or
> whatever.
> 
> To be fair, a lot of this could be managed in userspace with the VT_*
> ioctl interface.

Yes, that's what "normal" systems do :)

> But the specific application here (Android's surfaceflinger) isn't set
> up for that, and it's a non-trivial API (and even doing it "right"
> involves racing against other users at startup).

How could there be any other users at startup, you "own" the system
here, there should not be anyone to race with.

> This seemed like a much simpler metaphor that still meets the
> requirements.

I think you should use the ioctls, that is what they are there for, and
is what you need to implement if you want to use a console anyway,
right?

greg k-h
