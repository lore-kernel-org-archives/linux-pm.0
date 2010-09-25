From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v4] power: introduce library for
	device-specific OPPs
Date: Sat, 25 Sep 2010 22:55:20 +0200
Message-ID: <201009252255.20933.rjw__3617.12249364263$1285448305$gmane$org@sisk.pl>
References: <1285332640-16736-1-git-send-email-nm@ti.com>
	<20100924193742.GJ2375@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100924193742.GJ2375@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: Nishanth Menon <nm@ti.com>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday, September 24, 2010, Paul E. McKenney wrote:
> On Fri, Sep 24, 2010 at 07:50:40AM -0500, Nishanth Menon wrote:
...
> 
> Looks like a good start!!!  Some questions and suggestions about RCU
> usage interspersed below.
...
> > + * Locking: RCU reader.
> > + */
> > +int opp_get_opp_count(struct device *dev)
> > +{
> > +	struct device_opp *dev_opp;
> > +	struct opp *temp_opp;
> > +	int count = 0;
> > +
> > +	dev_opp = find_device_opp(dev);
> > +	if (IS_ERR(dev_opp))
> > +		return PTR_ERR(dev_opp);
> > +
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(temp_opp, &dev_opp->opp_list, node) {
> > +		if (temp_opp->available)
> > +			count++;
> > +	}
> > +	rcu_read_unlock();
> 
> This one is OK as well.  You are returning a count, so if all of the
> counted structures are freed at this point, no problem.  The count was
> valid when it was accumulated, and the fact that it might now be obsolete
> is (usually) not a problem.

However, it looks like it should run rcu_read_lock() before calling
find_device_opp(dev), shouldn't it?

Rafael
