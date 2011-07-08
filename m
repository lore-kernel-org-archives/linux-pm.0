From: Kevin Hilman <khilman@ti.com>
Subject: Re: [Update][PATCH 6/10] PM / Domains: System-wide
	transitions support for generic domains (v5)
Date: Thu, 07 Jul 2011 17:29:35 -0700
Message-ID: <871uy1d380.fsf__44807.0578896024$1310085044$gmane$org@ti.com>
References: <201106112223.04972.rjw@sisk.pl> <201106252324.13454.rjw@sisk.pl>
	<201106252328.31882.rjw@sisk.pl> <201106290144.01186.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106290144.01186.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Wed, 29 Jun 2011 01:44:00 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Make generic PM domains support system-wide power transitions
> (system suspend and hibernation).  Add suspend, resume, freeze, thaw,
> poweroff and restore callbacks to be associated with struct
> generic_pm_domain objects and make pm_genpd_init() use them as
> appropriate.
>
> The new callbacks do nothing for devices belonging to power domains
> that were powered down at run time (before the transition).  

Thinking about this some more, how is a driver supposed to reconfigure
wakeups during suspend if it has already been runtime suspended?

For example, assume a device where device_may_wakeup() == false.  This
means wakeups during *suspend* are disabled, but wakeups wakeups are
assumed to enabled when it is runtime suspended.

So now, assume this device is RPM_SUSPENDED, it has wakeups *enabled*,
and then system suspend comes along.  

With this current patch, the driver will never receive any callbacks, so
it can never disable its wakeups.  

Am I missing something?

Kevin
