From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: Hibernation considerations
Date: Wed, 1 Aug 2007 09:22:28 +0000
Message-ID: <20070801092227.GB4808__26693.056888371$1186070652$gmane$org@ucw.cz>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<87lkd9ohtn.fsf@jbms.ath.cx>
	<E1ICJRG-0000OG-00@dorka.pomaz.szeredi.hu>
	<200707212120.04645.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707212120.04645.rjw@sisk.pl>
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
Cc: david@lang.hm, nigel@nigel.suspend2.net, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

Hi!

> > Hmm, wonder why this isn't affecting people with VPNs?  Probably
> > network mounts over VPN are rare, and ever rarer to have fs activity
> > on them during suspend.
> > 
> > Anyway, I think it's long overdue to stop thinking about how to "fix"
> > fuse, and concentrate on fixing the underlying problem instead ;)
> 
> To conclude this branch of the thread, I have a patch in the works that may
> help a bit with unfreezable FUSE filesystems and it only affects the freezer.
> I'll post it when 2.6.23-rc1 is out, because it's on top of some other patches
> that need to go first.

I'm interested... which one is that?
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
