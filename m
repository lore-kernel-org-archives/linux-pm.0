From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Rename suspend/hibernation stuff for clarity
Date: Mon, 7 Jan 2008 17:36:39 +0100
Message-ID: <200801071736.39782.rjw@sisk.pl>
References: <20080107135236.GA17140@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758099AbYAGQem@vger.kernel.org>
In-Reply-To: <20080107135236.GA17140@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Monday, 7 of January 2008, Pavel Machek wrote:
> kernel/suspend_64.c and power/cpu.c were equivalent. Move them into
> power/cpu_*.c for consistency.
> 
> power/swsusp.S and kernel/suspend_asm_64.S were both misnamed and
> equivalent. Merge then minto power/hibernation_*.S.

Well, all of that are changes in the right direction, but I'm not sure if it's
the right time to do that just now.  For example, suspend_64.c in your patch
is missing the comments on __save/restore_processor_state() already queued
up for 2.6.25 by Ingo.

Any chance to base the patch on top of the mm branch of
/pub/scm / linux/kernel/git/x86/linux-2.6-x86.git ?

Thanks,
Rafael
