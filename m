From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] swsusp: Do not use pm_ops
Date: Thu, 3 May 2007 12:11:18 +0200
Message-ID: <20070503101118.GJ12554__45470.9646910944$1178187146$gmane$org@elf.ucw.cz>
References: <200705022213.35831.rjw@sisk.pl>
	<1178181680.13233.74.camel@johannes.berg>
	<200705031146.03358.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705031146.03358.rjw@sisk.pl>
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
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Nigel Cunningham <nigel@nigel.suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2007-05-03 11:46:02, Rafael J. Wysocki wrote:
> On Thursday, 3 May 2007 10:41, Johannes Berg wrote:
> > On Wed, 2007-05-02 at 22:13 +0200, Rafael J. Wysocki wrote:
> > 
> > > +void hibernation_set_ops(struct hibernation_ops *ops)
> > > +{
> > > +	if (ops && !(ops->prepare && ops->enter && ops->finish)) {
> > > +		printk(KERN_ERR "Wrong definition of hibernation operations! "
> > > +			"Using defaults\n");
> > > +		return;
> > > +	}
> > 
> > Why not BUG_ON here as I had before? I don't see much point in giving a
> > runtime warning, and the docs clearly state that you must assign all
> > three items. Oh, I see I had a bug before when ops was NULL, but you can
> > still do
> >   BUG_ON(ops && !(ops->prepare && ops->enter && ops->finish));
> 
> Well, BUG_ON() is extremely user-unfriendly, and it'd trigger even if the user
> actually didn't intend to suspend at all.

WARN_ON()?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
