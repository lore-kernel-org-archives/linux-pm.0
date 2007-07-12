From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Thu, 12 Jul 2007 10:54:28 +0200
Message-ID: <20070712085428.GA1866__12117.0368780897$1184273384$gmane$org@elf.ucw.cz>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<20070711111350.GI7091@elf.ucw.cz>
	<1184257734.9346.76.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1184257734.9346.76.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Looks interesting... but I was feeling strange dejavu reading
> > this... and that's because you pasted the changelog twice :-).
> > 
> 
> Sorry, I should have re-checked the mail before sending out.

Were your patches enough to get hibernation working? I got kexec to
work here, so I guess I'm one step closer...

...video does not work in the kexec-ed kernel, unless I boot with
vga=1.

> > How fast can kexec boot secondary kernel?
> 
> I measure it on my IBM T42 with CONFIG_PRINTK_TIME=y. The boot-up time
> is about 4.35s from kexec is issued to root mounted in kexec kernel.

Not bad...

> > > 2. Compile the kexec-tools with kdump and kjump patches added, the
> > >    kdump patch can be found at:
> > > 
> > > http://lse.sourceforge.net/kdump/patches/kexec-tools-1.101-dkump10.patch
> > 
> > I got 404 error :-(.
> 
> Sorry, typo problem. The URL should be:
> http://lse.sourceforge.net/kdump/patches/kexec-tools-1.101-kdump10.patch

That works, thanks.

> > > 7. In the kexec booted kernel, trigger the jumping back with following
> > >    shell command.
> > > 
> > >    echo <a>:<b> > /sys/power/resume
> > > 
> > >    Where <a> and <b> is non-negative integer, at least one of them must
> > >    be non-zero.
> > 
> > What does a and b mean?

> a and b has no meaning. They are only used to trigger the resume
> process. This will be fixed in the future version.

Ok.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
