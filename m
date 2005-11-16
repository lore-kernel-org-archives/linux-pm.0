From: Greg KH <greg@kroah.com>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Tue, 15 Nov 2005 22:14:59 -0800
Message-ID: <20051116061459.GA31181@kroah.com>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115222549.GF17023@redhat.com> <20051115233201.GA10143@elf.ucw.cz> <1132115730.2499.37.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030192AbVKPGab@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1132115730.2499.37.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
Cc: Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 16, 2005 at 06:35:30AM +0200, Dumitru Ciobarcianu wrote:
> ??n data de Mi, 16-11-2005 la 00:32 +0100, Pavel Machek a scris:
> > ...but how do you provide nice, graphical progress bar for swsusp
> > without this? People want that, and "esc to abort", compression,
> > encryption. Too much to be done in kernel space, IMNSHO.
> 
> Pavel, you really should _listen_ when someone else is talking about the
> same things in different implementations. suspend2 has this feature
> (nice graphical progress bars in userspace) for a long time now and it's
> compatible with the fedora kernels.

It's also implemented in the kernel, which is exactly the wrong place
for this.  Pavel is doing this properly, why do you doubt him?

> Why don't you and Nigel (of suspend2) can just work together on this ?
> It's a shame that much work is wasted in duplicated effort.

It's not duplicated, Nigel knows what need to be done to work together,
if he so desires.

thanks,

greg k-h
