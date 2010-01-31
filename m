From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][RFT][PATCH] ACPI: Protection from suspending
	in the middle of EC transaction
Date: Sun, 31 Jan 2010 22:09:21 +0100
Message-ID: <201001312209.21212.rjw__22774.2953728468$1264972205$gmane$org@sisk.pl>
References: <201001310029.48717.rjw@sisk.pl>
	<1264970500.5544.0.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1264970500.5544.0.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Sunday 31 January 2010, Maxim Levitsky wrote:
> On Sun, 2010-01-31 at 00:29 +0100, Rafael J. Wysocki wrote: 
...
> >  
> >  static int acpi_ec_resume(struct acpi_device *device)
> >  {
> >  	struct acpi_ec *ec = acpi_driver_data(device);
> > +
> > +	mutex_lock(&ec->lock);
> >  	/* Enable use of GPE back */
> >  	acpi_enable_gpe(NULL, ec->gpe);
> > +	/* Allow transactions to happen again */
> > +	set_bit(EC_FLAGS_SUSPENDED, &ec->flags);
>           ^^^^^^^^^^^^
> Thats why it doesn't work here....
> Will retest now.

Ouch, sorry.

Rafael
