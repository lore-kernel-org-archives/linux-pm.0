From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH][v8] PM / hibernate: Verify the consistent of e820 memory
 map by md5 value
Date: Mon, 29 Aug 2016 15:41:23 +0200
Message-ID: <20160829134123.GA28806@nazgul.tnic>
References: <1472402140-959-1-git-send-email-yu.c.chen@intel.com>
 <20160829045942.GA6163@nazgul.tnic>
 <20160829071500.GA3859@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160829071500.GA3859@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Lee@nazgul.tnic, Chun-Yi <jlee@suse.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 29, 2016 at 09:15:00AM +0200, Pavel Machek wrote:
> Sounds about as easy as hot unplugging arbitrary memory address. IOW
> "not easy".

Regardless, forcibly panicking the system more is still the wrong
approach IMO.

Instead, I'd try to issue a big fat warning that BIOS corrupts E820 and
that the user should disable hibernation on that box and never ever
enable it again.

After that, the kernel should *disable* hibernation for the current boot
so any further hibernation runs don't even happen. Maybe even taint
itself.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
