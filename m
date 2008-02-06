From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Wed, 6 Feb 2008 02:27:13 +0100
Message-ID: <200802060227.14385.rjw@sisk.pl>
References: <20080205190600.GB11613@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761367AbYBFB3M@vger.kernel.org>
In-Reply-To: <20080205190600.GB11613@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 5 of February 2008, Pavel Machek wrote:
> 
> This rewrites wakeup code to .c, and it fixes stack (should use movl
> ,%esp, not movw). Testers wanted. Makefile infrastructure was done by
> hpa, cleanups by rjw.

I'll test it tomorrow and I still have some more cleanups (I was distracted by
a nasty scheduler issue in the current mainline).

Thanks,
Rafael
