From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][v8] PM / hibernate: Verify the consistent of e820 memory map by md5 value
Date: Tue, 30 Aug 2016 13:51:19 +0200
Message-ID: <4046257.PxhXCrvGHl@vostro.rjw.lan>
References: <1472402140-959-1-git-send-email-yu.c.chen@intel.com> <20160829071500.GA3859@amd> <20160829134123.GA28806@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160829134123.GA28806@nazgul.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Lee@nazgul.tnic, Chun-Yi <jlee@suse.com>
List-Id: linux-pm@vger.kernel.org

On Monday, August 29, 2016 03:41:23 PM Borislav Petkov wrote:
> On Mon, Aug 29, 2016 at 09:15:00AM +0200, Pavel Machek wrote:
> > Sounds about as easy as hot unplugging arbitrary memory address. IOW
> > "not easy".
> 
> Regardless, forcibly panicking the system more is still the wrong
> approach IMO.

Agreed.

> Instead, I'd try to issue a big fat warning that BIOS corrupts E820 and
> that the user should disable hibernation on that box and never ever
> enable it again.
> 
> After that, the kernel should *disable* hibernation for the current boot
> so any further hibernation runs don't even happen. Maybe even taint
> itself.

Yes, taint the kernel when e820 mismatch is detected.

It may be a good idea to start an emergency shutdown in that case too, but
after getting to a point when it actually has a chance to work.

Thanks,
Rafael
