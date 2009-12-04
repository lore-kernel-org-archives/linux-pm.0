From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] intel_txt: add s3 userspace memory integrity
 verification
Date: Fri, 4 Dec 2009 23:20:45 +0100
Message-ID: <20091204222045.GE32314__20005.6663867601$1259965352$gmane$org@elf.ucw.cz>
References: <4B18D26B.4040500@intel.com> <20091204082927.GF1540@ucw.cz>
	<4F65016F6CB04E49BFFA15D4F7B798D9AEDDD4DC@orsmsx506.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4F65016F6CB04E49BFFA15D4F7B798D9AEDDD4DC@orsmsx506.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Cihula, Joseph" <joseph.cihula@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Wang, Shane" <shane.wang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbeulich@novell.com" <jbeulich@novell.com>, "jmorris@namei.org" <jmorris@namei.org>, "chrisw@sous-sol.org" <chrisw@sous-sol.org>, "peterm@redhat.com" <peterm@redhat.com>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> > > +
> > > +   ret = tboot_pre_stack_switch();
> > > +   if (!ret) {
> > > +           tboot_switch_stack_call(tboot_do_suspend_lowlevel_call,
> > > +                                   (u64)new_stack_ptr);
> >
> > ...and here you add requirements to suspend_lowlevel that were not
> > there before. ("May not act on unchecksummed memory"), without
> > documenting them.
> 
> Really the only requirement is (as discussed in the previous thread) that it only use code and data within [_text, _end - _text]--do you think that this really needs to be called out?  do_suspend_lowlevel() is a very simple function that has just the one (resume path) call to another simple function--it doesn't seem likely that it would violate this.
> 

Resume code is already pretty tricky, and you add yet another layer of
trickery. Yes, it needs to be properly documented.

And... how does it interact with restore_processor_state? I don't
think do_suspend_lowlevel is as simple as you think...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
