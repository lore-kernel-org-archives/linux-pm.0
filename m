From: "Cihula, Joseph" <joseph.cihula@intel.com>
Subject: Re: [PATCH] intel_txt: add s3 userspace memory
	integrity	verification
Date: Fri, 4 Dec 2009 08:52:12 -0800
Message-ID: <4F65016F6CB04E49BFFA15D4F7B798D9AEDDD4DC__12656.6728031777$1259960443$gmane$org@orsmsx506.amr.corp.intel.com>
References: <4B18D26B.4040500@intel.com> <20091204082927.GF1540@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091204082927.GF1540@ucw.cz>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>, "Wang, Shane" <shane.wang@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbeulich@novell.com" <jbeulich@novell.com>, "jmorris@namei.org" <jmorris@namei.org>, "chrisw@sous-sol.org" <chrisw@sous-sol.org>, "peterm@redhat.com" <peterm@redhat.com>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: Friday, December 04, 2009 12:29 AM
>
> > This patch added verification for userspace memory integrity after
> >  S3 resume.
>
> It does not work.
>
> > Integrity verification for other memory (say kernel itself) has been done by tboot.
> >
>
> Not true. Kernel  uses memory above 4G on x86-64. Including... say
> console writing functions.

I've responded to that in your previous email thread, so let's keep the technical discussion of what is MAC'ed to just that one thread.

> You can patch holes, but without description 'what does this protect
> against' it is almost impossible to evaluate.
>
>
> > +void tboot_do_suspend_lowlevel(void)
> > +{
> > +   int ret = -1;
> > +
> > +   if (!tboot_enabled()) {
> > +           do_suspend_lowlevel();
> > +           return;
> > +   }
> > +
> > +   ret = tboot_pre_stack_switch();
> > +   if (!ret) {
> > +           tboot_switch_stack_call(tboot_do_suspend_lowlevel_call,
> > +                                   (u64)new_stack_ptr);
>
> ...and here you add requirements to suspend_lowlevel that were not
> there before. ("May not act on unchecksummed memory"), without
> documenting them.

Really the only requirement is (as discussed in the previous thread) that it only use code and data within [_text, _end - _text]--do you think that this really needs to be called out?  do_suspend_lowlevel() is a very simple function that has just the one (resume path) call to another simple function--it doesn't seem likely that it would violate this.

>
> NAK.
>                                                                       Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
