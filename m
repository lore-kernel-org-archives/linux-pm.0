From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-usb-devel] Re: The evilness of
	struct?usb_device->auto_pm
Date: Fri, 5 Oct 2007 09:34:57 +0200
Message-ID: <20071005073457.GA25296__45707.0972574458$1191569799$gmane$org@atrey.karlin.mff.cuni.cz>
References: <200709281712.35721.rjw@sisk.pl>
	<200710041205.38967.oliver@neukum.org>
	<20071004101643.GJ22940@elf.ucw.cz>
	<200710041227.29817.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200710041227.29817.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Hi!

> > > OK, so this is the consensus. Then the question arises, how does a
> > > driver learn that all it's children have gone into autosuspend?
> > 
> > atomic_t variable in the parent, with children updating it and calling
> > parent's callback when it goes to 1->0 and 0->1?
> 
> That's a viable proposal, but it means moving part of the autosuspend
> code into the generic model. Are you all okay with that?

Me? Yes.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
