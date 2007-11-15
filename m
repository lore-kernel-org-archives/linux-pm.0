From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: make freezer optional for suspend
Date: Thu, 15 Nov 2007 21:24:24 +0100
Message-ID: <200711152124.25136.rjw@sisk.pl>
References: <1194980670.6695.1.camel@johannes.berg>
	<200711142230.14662.rjw@sisk.pl>
	<1195145246.13846.68.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1195145246.13846.68.camel@johannes.berg>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 15 of November 2007, Johannes Berg wrote:
> 
> > > > > +config SUSPEND_FREEZER
> > > > > +	bool "Enable freezer for suspend to RAM/standby" if ADB_PMU || BROKEN
> > > > 
> > > > Hm, is ADB_PMU specific to powerpc?
> > > 
> > > Yes, and it's the only code that allows you to suspend w/o the freezer
> > > right now (via PMU specific ioctls)
> > 
> > It's a bit confusing for someone who doesn't know what ADB_PMU is.
> > 
> > Perhaps it might depend on something like ARCH_CAN_DO_WITHOUT_FREEZER instead?
> 
> It can't really. Things break. Ben and Paul just don't want to hear
> about it. I made it depend on BROKEN so people can take it out and see
> what breaks (to possibly fix it), and depend on ADB_PMU so they can have
> their favourite setting without enabling BROKEN.

I understand that, but it's a bit confusing to put ADB_PMU, which is specific
to powerpc, into the generic configuration file.

Greetings,
Rafael
