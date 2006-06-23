From: Frederik Deweerdt <deweerdt@free.fr>
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Date: Sat, 24 Jun 2006 01:53:57 +0200
Message-ID: <20060623235357.GA1181@slug>
References: <4499BE99.6010508@gmail.com> <20060621221445.GB3798@inferi.kami.home> <20060622061905.GD15834@kroah.com> <20060622004648.f1912e34.akpm@osdl.org> <20060622160403.GB2539@slug> <20060622092506.da2a8bf4.akpm@osdl.org> <20060623090206.GA2234@slug> <20060623091016.GE4940@elf.ucw.cz> <20060623194100.GA3812@flint.arm.linux.org.uk> <20060623221117.GA2497@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752176AbWFWXyE@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060623221117.GA2497@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, linux-kernel@vger.kernel.org, linux-pm@osdl.org, stern@rowland.harvard.edu
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 24, 2006 at 12:11:18AM +0200, Pavel Machek wrote:
> On Fri 2006-06-23 20:41:01, Russell King wrote:
> > On Fri, Jun 23, 2006 at 11:10:21AM +0200, Pavel Machek wrote:
> > > Serial console is currently broken by suspend, resume. _But_ I have a
> > > patch I'd like you to try.... pretty please?
> > 
> > Did you bother trying my patch, which was done the Right(tm) way?
> > There wasn't any feedback on it so I can only assume not.
> 
> (I actually forwarded him your patch in private email).
And I did try it, but it make no difference: the output would still
appear on the laptop.

Regards,
Frederik
