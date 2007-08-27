From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 0/2 -mm] kexec based hibernation
Date: Mon, 27 Aug 2007 13:15:49 +0000
Message-ID: <20070827131549.GA4104__17023.3591729358$1188220635$gmane$org@ucw.cz>
References: <1188177245.3247.36.camel@caritas-dev.intel.com>
	<20070827050027.GB9809@in.ibm.com>
	<1188195529.3247.82.camel@caritas-dev.intel.com>
	<20070827075317.GB2060@elf.ucw.cz>
	<m1d4x95dqy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <m1d4x95dqy.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!

> >> > Does this make sense?
> >> 
> >> Yes, this is a sensible optimization. But I think it may be better to
> >> make bootloader load kernel D directly into a specified memory location.
> >> For example, we can add a option to "kernel" command of grub. 
> >> 
> >> And, I think we can do more in bootloader. Such as we can prepare
> >> two
> >
> > Yes, that would be nice.
> >
> > It will mean quite a bit of work, but I guess it should be the long
> > term goal. Loading restore kernel directly from bootloader means:
> >
> > 1) it is fast -- no need to boot another kernel
> >
> > 2) it is "classical" way of doing things
> >
> > On the other hand, we loose flexibility that way:
> >
> > 1) it locks you onto one bootloader
> >
> > 2) you no longer have userland there to do uncompression, decryption,
> > etc..
> 
> True although for the uncompression and decryption those aren't exactly foreign
> requirements for bootloaders.

Well, uncompression yes, but crypto? What is that, some kind of
trusted computing thingie?

We do RSA for uswsusp, that may be a bit of problem for a bootloader,
but I'm glad bootloaders are bloated already :-).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
