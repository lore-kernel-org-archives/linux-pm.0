From: Andi Kleen <ak@suse.de>
Subject: Re: swsusp status report
Date: 26 Jul 2006 17:13:02 +0200
Message-ID: <p73fygo5ri9.fsf@verdi.suse.de>
References: <200607251325.14747.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750741AbWGZPNG@vger.kernel.org>
In-Reply-To: <200607251325.14747.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> The code that restores the memory state from the suspend image in step
> (11) also uses the kernel identity mapping to address memory, so it cannot
> access highmem pages on i386, but it practically has no other limitations as
> far as the image size is concerned.  In other words, it would be possible to
> restore suspend images as big as 80% or even 90% of RAM, or the normal zone
> on i386, if the 'snapshotting' code were able to create them.

Why can't you just kmap or ioremap them as needed and pass the pfns/struct
page * for IO?

> The code that performs steps (5) and (11) of the suspend-resume cycle is
> quite robust and there is only one known problem with it, which seems to
> be x86_64-specific.  Namely, on x86_64 machines with more than 2 GB of RAM
> there are memory gaps and/or reserved memory areas between the 2nd and 3rd
> Gbyte of physical memory and swsusp tries to save these areas as though
> they were RAM which leads to oopses.  This issue is now being worked on.

I guess we could just borrow a new struct page flags bit again and set it
during memory setup. That would fix your problem I guess. Should be fairly
easy to do. Let me know if you need it.

-Andi
