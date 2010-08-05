From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] pm: Add runtime PM statistics
Date: Fri, 6 Aug 2010 01:45:28 +0200
Message-ID: <201008060145.28969.rjw__8628.26494635574$1281052156$gmane$org@sisk.pl>
References: <20100710095254.5ab7291c@infradead.org>
	<4C3F2CEF.2090404@linux.intel.com>
	<87bp9gpryb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87bp9gpryb.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday, August 06, 2010, Kevin Hilman wrote:
> Arjan van de Ven <arjan@linux.intel.com> writes:
> 
> > +
> > +/**
> > + * update_pm_runtime_accounting - Update the time accounting of power
> > states
> > + * @dev: Device to update the accounting for
> > + *
> > + * In order to be able to have time accounting of the various power states
> > + * (as used by programs such as PowerTOP to show the effectiveness of
> > runtime
> > + * PM), we need to track the time spent in each state.
> > + * update_pm_runtime_accounting must be called each time before the
> > + * runtime_status field is updated, to account the time in the old state
> > + * correctly.
> > + */
> > +void update_pm_runtime_accounting(struct device *dev)
> > +{
> > +    unsigned long now = jiffies;
> > +    int delta;
> > +
> > +    delta = now - dev->power.accounting_timestamp;
> > +
> > +    if (delta < 0)
> > +        delta = 0;
> > +
> > +    dev->power.accounting_timestamp = now;
> > +
> > +    if (dev->power.disable_depth > 0)
> > +        return;
> > +
> > +    if (dev->power.runtime_status == RPM_SUSPENDED)
> > +        dev->power.suspended_jiffies += delta;
> > +    else
> > +        dev->power.active_jiffies += delta;
> > +}
> 
> By using jiffies, I think we might miss events in drivers that are doing
> runtime PM transitions in short bursts.  On embedded systems with slow
> HZ, there could potentially be lots of transitions between ticks.
> 
> It would be nicer to use clocksource-based time so transitions between
> jiffies could still be factored into the accounting.

Patch please?

Rafael
