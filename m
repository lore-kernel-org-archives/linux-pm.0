From: joeyli <jlee@suse.com>
Subject: Re: [PATCH][v8] PM / hibernate: Verify the consistent of e820 memory
 map by md5 value
Date: Tue, 30 Aug 2016 16:35:05 +0800
Message-ID: <20160830083505.GG10967@linux-rxt1.site>
References: <1472402140-959-1-git-send-email-yu.c.chen@intel.com>
 <20160829045942.GA6163@nazgul.tnic>
 <20160829071500.GA3859@amd>
 <20160829134123.GA28806@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:44886 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755587AbcH3IfU (ORCPT
        <rfc822;groupwise-linux-pm@vger.kernel.org:0:0>);
        Tue, 30 Aug 2016 04:35:20 -0400
Content-Disposition: inline
In-Reply-To: <20160829134123.GA28806@nazgul.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Lee@nazgul.tnic

On Mon, Aug 29, 2016 at 03:41:23PM +0200, Borislav Petkov wrote:
> On Mon, Aug 29, 2016 at 09:15:00AM +0200, Pavel Machek wrote:
> > Sounds about as easy as hot unplugging arbitrary memory address. IOW
> > "not easy".
> 
> Regardless, forcibly panicking the system more is still the wrong
> approach IMO.
> 
> Instead, I'd try to issue a big fat warning that BIOS corrupts E820 and
> that the user should disable hibernation on that box and never ever
> enable it again.
> 
> After that, the kernel should *disable* hibernation for the current boot
> so any further hibernation runs don't even happen. Maybe even taint
> itself.
>

I support this idea to disable hibernation when kernel detected e820 layout
was changed by BIOS. If system resume luckily then kernel should warn to user
and refuse to hibernate again. User must to know that's better to reboot
system when he saw the warning message after lucky resume.

Not just BIOS doesn't fix e820 layout. There have some machines doesn't provide
_S4_ function, so the hibernation fallbacks to "shutdown" mode because "platform"
mode unavailable. In this situation, user is just lucky to run the hibernation.
Kernel should warn to user and disable hibernation when detected e820 layout
changed.


Thanks a lot!
Joey Lee 
