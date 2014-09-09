From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Hibernate: Do not assume the first e820 area to be RAM
Date: Tue, 9 Sep 2014 09:18:56 +0200
Message-ID: <20140909071856.GA27512@amd>
References: <1407754252-22779-1-git-send-email-jlee@suse.com>
 <1561567.ev2pEO8C5v@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1561567.ev2pEO8C5v@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>
List-Id: linux-pm@vger.kernel.org

On Tue 2014-09-09 00:52:55, Rafael J. Wysocki wrote:
> On Monday, August 11, 2014 06:50:52 PM Lee, Chun-Yi wrote:
> > In arch/x86/kernel/setup.c::trim_bios_range(), the codes introduced
> > by 1b5576e6 (base on d8a9e6a5), it updates the first 4Kb of memory
> > to be E820_RESERVED region. That's because it's a BIOS owned area
> > but generally not listed in the E820 table:
> > 
> > [    0.000000] e820: BIOS-provided physical RAM map:
> > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000096fff] usable
> > [    0.000000] BIOS-e820: [mem 0x0000000000097000-0x0000000000097fff] reserved
> > ...
> > [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> > [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> > 
> > But the region of first 4Kb didn't register to nosave memory:
> > 
> > [    0.000000] PM: Registered nosave memory: [mem 0x00097000-0x00097fff]
> > [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> > 
> > The codes in e820_mark_nosave_regions() assumes the first e820 area to be
> > RAM, so it causes the first 4Kb E820_RESERVED region ignored when register
> > to nosave. This patch removed assumption of the first e820 area.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Signed-off-by: Lee, Chun-Yi <jlee@suse.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
