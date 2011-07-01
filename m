From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/10 v6] PM / Domains: Support for generic
	I/O PM domains (v7)
Date: Fri, 1 Jul 2011 22:03:58 +0200
Message-ID: <201107012203.58283.rjw__28108.8813361295$1309550652$gmane$org@sisk.pl>
References: <201106112223.04972.rjw@sisk.pl> <201106252326.23837.rjw@sisk.pl>
	<87tyb5yipq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87tyb5yipq.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, July 01, 2011, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Introduce common headers, helper functions and callbacks allowing
> > platforms to use simple generic power domains for runtime power
> > management.
> >
> > Introduce struct generic_pm_domain to be used for representing
> > power domains that each contain a number of devices and may be
> > parent domains or subdomains with respect to other power domains.
> > Among other things, this structure includes callbacks to be
> > provided by platforms for performing specific tasks related to
> > power management (i.e. ->stop_device() may disable a device's
> > clocks, while ->start_device() may enable them, ->power_off() is
> > supposed to remove power from the entire power domain
> > and ->power_on() is supposed to restore it).
> >
> > Introduce functions that can be used as power domain runtime PM
> > callbacks, pm_genpd_runtime_suspend() and pm_genpd_runtime_resume(),
> > as well as helper functions for the initialization of a power
> > domain represented by a struct generic_power_domain object,
> > adding a device to or removing a device from it and adding or
> > removing subdomains.
> >
> > Introduce configuration option CONFIG_PM_GENERIC_DOMAINS to be
> > selected by the platforms that want to use the new code.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Reviewed-by: Kevin Hilman <khilman@ti.com>

Thanks!

> While I still don't think this is generic enough for some more
> complicated SoCs, it most certainly a huge step in the right direction,
> and I think we can address the other complexities with additional
> patches as needed.

That's my intention.

> Thanks Rafael for all your hard work on this and putting up with my
> nagging. ;)

I don't mind that at all, it kind of helps to focus on important stuff. ;-)

Rafael
