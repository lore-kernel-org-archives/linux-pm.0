From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: wakeup code translated to .c
Date: Mon, 4 Feb 2008 00:57:23 +0100
Message-ID: <200802040057.24429.rjw@sisk.pl>
References: <20080130120111.GB22820@elf.ucw.cz> <200802032333.02821.rjw@sisk.pl> <20080203235722.GI2799@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755479AbYBCX7i@vger.kernel.org>
In-Reply-To: <20080203235722.GI2799@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Monday, 4 of February 2008, Pavel Machek wrote:
> Hi!
> 
> > - Could the real mode directory be called just "real-mode" or something like
> >   this ("rm" is not very meaningful :-))?
> > 
> > Apart from the above and the _WAKEUP hacks mentioned elsewhere, it looks okay
> > (from a very high orbit).
> 
> Wakeup hacks? You mean those #ifdef WAKEUP in video code?

Yes.

[I'm not sure if that could be done differently, though.  Surely hpa knows ;-)]

Rafael
