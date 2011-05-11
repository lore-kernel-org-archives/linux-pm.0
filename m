From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/5] PM: Support for system-wide power
	transitions in generic power domains
Date: Wed, 11 May 2011 21:11:50 +0200
Message-ID: <201105112111.50740.rjw__24241.0718150952$1305141177$gmane$org@sisk.pl>
References: <201104290154.12966.rjw@sisk.pl> <201105082324.19674.rjw@sisk.pl>
	<20110511111732.2f75713a@bike.lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110511111732.2f75713a@bike.lwn.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org

On Wednesday, May 11, 2011, Jonathan Corbet wrote:
> Hi, Rafael,
> 
> One small question that came to mind as I was looking at this patch:
> 
> > +/**
> > + * pm_genpd_powered_down - Check if power has been removed from a power domain.
> > + * @genpd: Power domain to check.
> > + */
> > +static bool pm_genpd_powered_down(struct generic_power_domain *genpd)
> > +{
> > +	bool ret;
> > +
> > +	mutex_lock(&genpd->lock);
> > +	ret = genpd->power_is_off;
> > +	mutex_unlock(&genpd->lock);
> > +
> > +	return ret;
> 
> I'm not quite sure why this function exists?  The lock doesn't really
> change anything, since the power state can change before or after this
> check regardless.  If you need the power state to be stable, it seems like
> the lock needs to be taken further up the stack; otherwise simply checking
> genpd->power_is_off directly would seem to be sufficient. Am I missing
> something?

No, you aren't. :-)

In fact, the function doesn't exist any more in the most recent version
of the patch: https://patchwork.kernel.org/patch/775412/

Thanks,
Rafael
