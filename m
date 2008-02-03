From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: wakeup code translated to .c
Date: Sun, 3 Feb 2008 19:24:44 +0100
Message-ID: <200802031924.44592.rjw@sisk.pl>
References: <20080130120111.GB22820@elf.ucw.cz> <200802031857.02422.rjw@sisk.pl> <20080203181648.GA1629@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752596AbYBCS0u@vger.kernel.org>
In-Reply-To: <20080203181648.GA1629@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Sunday, 3 of February 2008, Pavel Machek wrote:
> Hi!
> 
> > > This version works on 32-bit, and builds on 64-bit (but I'm pretty
> > > sure it does not work. 32-bit code probably needs to go into rm/....)
> > > 
> > 
> > Do you have an updated version or is this the latest one?
> 
> I'm glad you ask ;-). Here's reasonably-recent version (I have
> slightly cleaner one, but it got obscured by 2.6.24-git merge), I
> eventually got it to work on 64-bit, by reusing trampoline.S code.

Thanks, I'll have a look and test it a bit.

Rafael
