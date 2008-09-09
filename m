From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 5/5] ACPI GPE based wakeup event detection
Date: Tue, 9 Sep 2008 10:08:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0809091006280.2486-100000__1982.00670206479$1220969780$gmane$org@iolanthe.rowland.org>
References: <1220922812.3989.8.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1220922812.3989.8.camel@yakui_zhao.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-pm@lists.linux-foundation.org, dbrownell@users.sourceforge.net, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 9 Sep 2008, Zhao Yakui wrote:

> > > --- linux.orig/drivers/acpi/bus.c	2008-09-08 14:28:32.000000000 +0800
> > > +++ linux/drivers/acpi/bus.c	2008-09-08 14:29:03.000000000 +0800
> > > @@ -496,6 +496,19 @@ static int acpi_bus_check_scope(struct a
> > >  	return 0;
> > >  }
> > >  
> > > +static BLOCKING_NOTIFIER_HEAD(acpi_bus_notify_list);
> > > +int register_acpi_bus_notifier(struct notifier_block *nb)
> > > +{
> > > +	return blocking_notifier_chain_register(&acpi_bus_notify_list, nb);
> > > +}
> > > +EXPORT_SYMBOL_GPL(register_acpi_bus_notifier);
> > > +
> > > +void unregister_acpi_bus_notifier(struct notifier_block *nb)
> > > +{
> > > +	blocking_notifier_chain_unregister(&acpi_bus_notify_list, nb);
> > > +}
> > > +EXPORT_SYMBOL_GPL(unregister_acpi_bus_notifier);
> > > +
> > >  /**
> > >   * acpi_bus_notify
> > >   * ---------------
> > > @@ -506,6 +519,8 @@ static void acpi_bus_notify(acpi_handle 
> > >  	int result = 0;
> > >  	struct acpi_device *device = NULL;
> > >  
> > > +	blocking_notifier_call_chain(&acpi_bus_notify_list,
> > > +			type, (void *)handle);
> > 
> > Hm, perhaps I'm too tired and I'm missing something obvious, but can you
> > tell me please why that has to be a notifier chain?  It looks like you add only
> > one notifier to it, so seemingly it could be replaced by a direct call to a
> > function like acpi_gpe_pme_handler() (with modified list of arguments).
> When the notifier chain is used, it can work regardless of whether the
> CONFIG_ACPI_GPE_WAKEUP is set.
> If the CONFIG_ACPI_GPE_WAKEUP is set, what you said is also OK. 

If CONFIG_ACPI_GPE_WAKEUP is not set then you should define 
acpi_gpe_pme_handler() as a do-nothing function.  Then you could call 
it always, regardless of the kconfig setting, with no need for a 
notifier chain.

Alan Stern
