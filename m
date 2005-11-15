From: Dave Jones <davej@redhat.com>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Tue, 15 Nov 2005 17:25:49 -0500
Message-ID: <20051115222549.GF17023@redhat.com>
References: <20051115212942.GA9828@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965049AbVKOW0M@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051115212942.GA9828@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 15, 2005 at 10:29:42PM +0100, Pavel Machek wrote:
 > Hi!
 > 
 > This is prototype of userland swsusp. I'd like kernel parts to go in,
 > probably for 2.6.16. Now, I'm not sure about the interface, ioctls are
 > slightly ugly, OTOH it would be probably overkill to introduce
 > syscalls just for this. (I'll need to add an ioctl for freeing memory
 > in future).

Just for info: If this goes in, Red Hat/Fedora kernels will fork
swsusp development, as this method just will not work there.
(We have a restricted /dev/mem that prevents writes to arbitary
 memory regions, as part of a patchset to prevent rootkits)

Even it were not for this, the whole idea seems misconcieved to me
anyway.

		Dave
