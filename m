From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/8] PM / Domains: Rename struct
	dev_power_domain to struct dev_pm_domain
Date: Mon, 20 Jun 2011 16:37:39 -0700
Message-ID: <87fwn45b24.fsf__18780.4864523516$1308613152$gmane$org@ti.com>
References: <201106112223.04972.rjw@sisk.pl> <201106112226.07631.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106112226.07631.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 11 Jun 2011 22:26:07 +0200")
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
> The naming convention used by commit 7538e3db6e015e890825fbd9f86599b
> (PM: Add support for device power domains), which introduced the
> struct dev_power_domain type for representing device power domains,
> evidently confuses some developers who tend to think that objects
> of this type must correspond to "power domains" as defined by
> hardware, which is not the case.  Namely, at the kernel level, a
> struct dev_power_domain object can represent arbitrary set of devices
> that are mutually dependent power management-wise and need not belong
> to one hardware power domain.  To avoid that confusion, rename struct
> dev_power_domain to struct dev_pm_domain and rename the related
> pointers in struct device and struct pm_clk_notifier_block from
> pwr_domain to pm_domain.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Kevin Hilman <khilman@ti.com>

Thanks!

Kevin
