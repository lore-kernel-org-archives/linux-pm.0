From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Resume hanging on MSI motherboard
Date: Tue, 8 Dec 2009 23:43:30 +0100
Message-ID: <200912082343.30195.rjw@sisk.pl>
References: <20091204081739.575b29d5@mjolnir.ossman.eu>
	<200912081338.56941.rjw@sisk.pl>
	<20091208233553.498e1442@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091208233553.498e1442@mjolnir.ossman.eu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <pierre-list@ossman.eu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 08 December 2009, Pierre Ossman wrote:
> On Tue, 8 Dec 2009 13:38:56 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Tuesday 08 December 2009, Pierre Ossman wrote:
> > > Anyone?
> > 
> > Sorry, it's just difficult to advise something in this case.
> > 
> > You can try to use the /sys/power/pm_test tests to see if the problem is
> > related to the drivers (it is described in
> > Documentation/power/basic-pm-debugging.txt), but I bet it's not.
> > 
> 
> Yeah, that test went through just fine.
> 
> Any ideas as to why pm_trace isn't working though?

Probably it crashes early in the wakeup code.  pm_trace only really starts to
work when you get to the drivers.

> And any common incantations that appease buggy ACPI implementations?

It may be worth trying to put your system into acpisleep_dmi_table[] in
drivers/acpi/sleep.c with init_set_sci_en_on_resume as the callback.

Also please have a look at the acpi_sleep= options in
Documentation/kernel-parameters.txt .  Especially old_ordering is worth
trying.

Thanks,
Rafael
