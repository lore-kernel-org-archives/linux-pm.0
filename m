From: Dave Jones <davej@redhat.com>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Fri, 18 Nov 2005 16:18:47 -0500
Message-ID: <20051118211847.GA3881@redhat.com>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115222549.GF17023@redhat.com> <1132342590.25914.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750950AbVKRVTN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1132342590.25914.86.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 18, 2005 at 07:36:29PM +0000, Alan Cox wrote:
 > On Maw, 2005-11-15 at 17:25 -0500, Dave Jones wrote:
 > > Just for info: If this goes in, Red Hat/Fedora kernels will fork
 > > swsusp development, as this method just will not work there.
 > > (We have a restricted /dev/mem that prevents writes to arbitary
 > >  memory regions, as part of a patchset to prevent rootkits)
 > 
 > Perhaps it is trying to tell you that you should be using SELinux rules
 > not kernel hacks for this purpose ?

I don't think selinux can give you the granularity to say
"process can access this bit of the file only", at least not yet.

Even if that was capable however, it still doesn't solve the problem.
Pavel's implementation wants to write to arbitary address spaces, which is
what we're trying to prevent. The two are at odds with each other.

		Dave
