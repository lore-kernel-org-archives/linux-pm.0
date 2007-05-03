From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: Do not use pm_ops
Date: Thu, 3 May 2007 11:46:02 +0200
Message-ID: <200705031146.03358.rjw__21457.0721182556$1178185355$gmane$org@sisk.pl>
References: <200705022213.35831.rjw@sisk.pl>
	<1178181680.13233.74.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1178181680.13233.74.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 3 May 2007 10:41, Johannes Berg wrote:
> On Wed, 2007-05-02 at 22:13 +0200, Rafael J. Wysocki wrote:
> 
> > +void hibernation_set_ops(struct hibernation_ops *ops)
> > +{
> > +	if (ops && !(ops->prepare && ops->enter && ops->finish)) {
> > +		printk(KERN_ERR "Wrong definition of hibernation operations! "
> > +			"Using defaults\n");
> > +		return;
> > +	}
> 
> Why not BUG_ON here as I had before? I don't see much point in giving a
> runtime warning, and the docs clearly state that you must assign all
> three items. Oh, I see I had a bug before when ops was NULL, but you can
> still do
>   BUG_ON(ops && !(ops->prepare && ops->enter && ops->finish));

Well, BUG_ON() is extremely user-unfriendly, and it'd trigger even if the user
actually didn't intend to suspend at all.

IMO this is not a "we can't continue if that condition is not satisfied"
situation.
 
> > -	pr_debug("PM: suspend-to-disk mode set to '%s'\n",
> > -		 pm_disk_modes[mode]);
> > +	if (!error)
> > +		pr_debug("PM: suspend-to-disk mode set to '%s'\n",
> > +			 hibernation_modes[mode]);
> 
> Isn't that an unrelated bugfix ;) just kidding

You mean the 'if (!error)'?  Well ... ;-)

> Looks good to me but I haven't checked the acpi in detail. If I
> remember, I'll try to give it all a go on my G5 later today.

OK

Greetings,
Rafael
