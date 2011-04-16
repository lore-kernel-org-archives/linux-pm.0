From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/9] PM: Rework shmobile and OMAP runtime PM
	using power domains
Date: Sun, 17 Apr 2011 01:35:18 +0200
Message-ID: <201104170135.19388.rjw__40121.1624769077$1302997540$gmane$org@sisk.pl>
References: <201104130205.26988.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104130205.26988.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-pm@vger.kernel.org

Hi,

The following series of patches is my attempt to consolidate the shmobile and
OMAP runtime PM code using power domains so that it is not necessary to
replace the platform bus type's runtime PM callbacks any more.

Some of the patches have already been posted, some are new and some are
from Kevin. :-)

[1/9] - Make power domain callbacks take precedence over subsystem ones
        (this one has been discussed already).

[2/9] - Export the platform bus type's default PM callbacks so that they
        can be used in power domain objects.

[3/9] - Use a default power domain for runtime PM on shmobile (both ARM
        and SH flavors) instead of replacing the platform bus type's
        runtime PM callbacks (using __weak).

[4/9] - Use generic runtime PM callbacks directly in the platform bus type.

[5/9] - Move OMAP2 runtime PM implementation to using a power domain object
        (patch from Kevin rebased on top of [1-4/9]).

[6/9] - Add subsystem data field to struct dev_pm_info.

[7/9] - Introduce generic clock manipulation routines for runtime PM and
        convert ARM shmobile to using them.

[8/9] - Move OMAP1 runtime PM to the new core infrastructure.

[9/9] - Remove platform_bus_set_pm_ops() (patch from Kevin).

Comments welcome.

Thanks,
Rafael
