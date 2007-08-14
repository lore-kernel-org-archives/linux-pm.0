From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [discuss] [PATCH] x86_64: Save registers in
	saved_context during suspend and hibernation
Date: Tue, 14 Aug 2007 21:06:44 +0200
Message-ID: <20070814190644.GB4182@elf.ucw.cz>
References: <200708132347.07396.rjw@sisk.pl>
	<20070813225229.GF3406@bingen.suse.de>
	<200708140026.27519.rjw@sisk.pl> <200708141927.58449.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708141927.58449.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: discuss@x86-64.org, pm list <linux-pm@lists.linux-foundation.org>, Andi Kleen <ak@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Nice. These variables always annoyed me too when looking
> > > at that code.
> > > 
> > > >  	DEFINE(pbe_next, offsetof(struct pbe, next));
> > > >  	BLANK();
> > > > +	DEFINE(saved_context_rbx, offsetof(struct saved_context, rbx));
> > > 
> > > But is there a reason you can't just use a pt_regs and then an array
> > > for the crNs ? 
> > 
> > Hm, I think I can use pt_regs.  I'll try to redo the patch to use it.
> 
> The updated patch (using pt_regs) is appended.

Looks ok to me.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
