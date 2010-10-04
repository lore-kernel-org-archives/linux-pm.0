From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v5] power: introduce library for
	device-specific OPPs
Date: Tue, 5 Oct 2010 00:45:27 +0200
Message-ID: <201010050045.27969.rjw__7641.73941356621$1286232417$gmane$org@sisk.pl>
References: <1285933174-24053-1-git-send-email-nm@ti.com>
	<201010050036.23179.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010050036.23179.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Paul <paulmck@linux.vnet.ibm.com>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 05, 2010, Rafael J. Wysocki wrote:
> On Friday, October 01, 2010, Nishanth Menon wrote:
...
> > +int opp_init_cpufreq_table(struct device *dev,
> > +			    struct cpufreq_frequency_table **table)
> > +{
> > +	struct device_opp *dev_opp;
> > +	struct opp *opp;
> > +	struct cpufreq_frequency_table *freq_table;
> > +	int i = 0;
> > +
> > +	rcu_read_lock();
> 
> I would pretend I'm an updater here and acquire dev_opp_list_lock instead.
> 
> > +	dev_opp = find_device_opp(dev);
> > +	if (IS_ERR(dev_opp)) {
> > +		rcu_read_unlock();
> 
> So that won't be necessary.

Or rather the lock will have to be dropped here instead.

> > +		pr_warning("Unable to find device\n");
> > +		return PTR_ERR(dev_opp);
> > +	}
> > +

Thanks,
Rafael
