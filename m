From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Thu, 7 Feb 2008 00:48:59 +0100
Message-ID: <200802070049.00461.rjw@sisk.pl>
References: <20080205190600.GB11613@elf.ucw.cz> <200802060227.14385.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763210AbYBFXvR@vger.kernel.org>
In-Reply-To: <200802060227.14385.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 6 of February 2008, Rafael J. Wysocki wrote:
> On Tuesday, 5 of February 2008, Pavel Machek wrote:
> > 
> > This rewrites wakeup code to .c, and it fixes stack (should use movl
> > ,%esp, not movw). Testers wanted. Makefile infrastructure was done by
> > hpa, cleanups by rjw.
> 
> I'll test it tomorrow

Works on my nx6325 (good sign, the box is easy to break ;-)).

> and I still have some more cleanups (I was distracted by a nasty scheduler
> issue in the current mainline).

The cleanups are still in the works (sorry).

Rafael
