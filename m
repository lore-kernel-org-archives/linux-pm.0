From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: hibernation fails from kexec'ed kernel
Date: Sat, 12 Jan 2013 21:06:52 +0100
Message-ID: <4354889.LUp82ppzIy@vostro.rjw.lan>
References: <50F18577.3030506@gmail.com> <50F19CC3.9060104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:39000 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138Ab3ALUBF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 12 Jan 2013 15:01:05 -0500
In-Reply-To: <50F19CC3.9060104@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Saturday, January 12, 2013 06:26:27 PM Jiri Slaby wrote:
> On 01/12/2013 04:47 PM, Jiri Slaby wrote:
> > Hi,
> > 
> > when I try to hibernate and resume from a kexec'ed kernel, the resume
> > fails with:
> > PM: Image not found (code -22)
> > 
> > I dumped sig and orig_sig from swsusp_check and it looks like this:
> > 53 57 41 50 53 50 41 43 45 32                    SWAPSPACE2
> > 53 57 41 50 53 50 41 43 45 32                    SWAPSPACE2
> > 
> > So it looks like the image (or only the signature) did not land to the disk.
> 
> Note that I see "PM: S|" and the error returned from mark_swapfiles is 0.
> 
> > I use only the in-kernel hibernation, I do not even have the suspend
> > package installed. This is with 3.7.2 and happens this way for some time
> > already. When I boot the kernel normally, hib+resume works just fine.
> > 
> > Any ideas?

Quite frankly, I'm not really surprised, because this is the first time I know
of anybody has tested hibernate and resume from a kexec'ed kernel.

I have no idea why exactly it doesn't work, though.

Did you use s2disk or the internal hibernation?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
