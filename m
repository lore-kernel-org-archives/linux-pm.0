From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] power: disable hibernation if module loading
 is disabled
Date: Tue, 8 Mar 2011 07:58:45 +0100
Message-ID: <20110308065845.GB1357__45110.4225976907$1299567612$gmane$org@ucw.cz>
References: <1299255084-4390-1-git-send-email-segoon@openwall.com>
	<201103042330.25079.rjw@sisk.pl> <20110305103444.GA26773@albatros>
	<201103051224.18621.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103051224.18621.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, security@kernel.org, linux-pm@lists.linux-foundation.org, Vasiliy Kulikov <segoon@openwall.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!


> > > modules_disabled surely is not the right interface to disable hibernation
> > > and I don't really think there's a bug because it doesn't work as you'd like
> > > it to.  In fact, there would be a bug if it did work that way.
> > 
> > What do you mean here?  Do you agree that you may read kernel image,
> > slightly change it (including e.g. possible checksums, I didn't bother
> > to check how much one should change), and write it back?
> 
> Yes, you can, but that's not the point.  The point is that calling an interface
> that disables all possible functionality modifying kernel memory
> "modules_disabled" is completely dumb.  Sorry, but that's how it goes.

Fully agreed.

If you want a subset of cap_sys_admin than can't install
rootkit... just do it like that. Create cap_small_admin with such
subset and migrate people that don't need full admin to it.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
