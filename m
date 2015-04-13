From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86/power/hibernate: Use local labels in asm
Date: Mon, 13 Apr 2015 14:51:22 +0200
Message-ID: <20150413125122.GA21051@amd>
References: <1428867906-12016-1-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428867906-12016-1-git-send-email-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun 2015-04-12 21:45:06, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> ... so that they don't appear in the object file and thus in objdump
> output. They're local anyway and have a meaning only within that file.
> 
> No functionality change.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
