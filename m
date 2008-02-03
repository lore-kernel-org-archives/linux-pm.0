From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: wakeup code translated to .c
Date: Mon, 4 Feb 2008 00:59:38 +0100
Message-ID: <200802040059.38963.rjw@sisk.pl>
References: <20080130120111.GB22820@elf.ucw.cz> <200802040054.43863.rjw@sisk.pl> <20080203235927.GK2799@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755083AbYBDABg@vger.kernel.org>
In-Reply-To: <20080203235927.GK2799@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Monday, 4 of February 2008, Pavel Machek wrote:
> Hi!
> 
> > BTW, I don't like the way in which the 'struct wakeup_header' fields are
> > reproduced in rm/wakeup.S very much, because it makes the code fragile.
> > It might be better to define the offsets in asm-offsets*.c and refer to them
> > relative to wakeup_header (if possible).
> 
> If you can do that.. yes, that would be nice. I triple-checked it, but
> indeed is fragile.

Do you want me to remove the unused fields from 'struct wakeup_header' too?

Rafael
