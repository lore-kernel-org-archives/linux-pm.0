From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][v8] PM / hibernate: Verify the consistent of e820 memory
 map by md5 value
Date: Mon, 29 Aug 2016 09:15:00 +0200
Message-ID: <20160829071500.GA3859@amd>
References: <1472402140-959-1-git-send-email-yu.c.chen@intel.com>
 <20160829045942.GA6163@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53524 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbcH2HPE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Aug 2016 03:15:04 -0400
Content-Disposition: inline
In-Reply-To: <20160829045942.GA6163@nazgul.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Lee@nazgul.tnic, Chun-Yi <jlee@suse.com>

On Mon 2016-08-29 06:59:42, Borislav Petkov wrote:
> On Mon, Aug 29, 2016 at 12:35:40AM +0800, Chen Yu wrote:
> > On some platforms, there is occasional panic triggered when trying to
> > resume from hibernation, a typical panic looks like:
> > 
> > "BUG: unable to handle kernel paging request at ffff880085894000
> > IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70"
> > 
> > This is because e820 map has been changed by BIOS across
> > hibernation, and one of the page frames from first kernel
> > is right located in second kernel's unmapped region, so panic
> > comes out when accessing unmapped kernel address.
> > 
> > In order to expose this issue earlier, the md5 hash of e820 map
> > is passed from suspend kernel to resume kernel, and the system will
> > trigger panic once it finds the md5 value of previous kernel is not
> > the same as current resume kernel.
> 
> ... so basically now even the cases where it managed to resume would
> panic because the digests differ, even if the original panic condition
> doesn't trigger the bug, i.e. your Note 1 below.

Note where?

You can't guarantee that e820 mismatch results in kernel panic, it
could also be endless loop or data corruption. 

> The more important question IMHO would be, can we resume our system
> successfully *even* if BIOS fiddled with the e820 map?

Sounds about as easy as hot unplugging arbitrary memory address. IOW
"not easy".

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
