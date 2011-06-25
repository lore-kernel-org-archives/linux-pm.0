From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/10 v6] PM / Domains: Support for generic I/O PM
	domains
Date: Sat, 25 Jun 2011 23:24:13 +0200
Message-ID: <201106252324.13454.rjw__19794.7529996329$1309037556$gmane$org@sisk.pl>
References: <201106112223.04972.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106112223.04972.rjw@sisk.pl>
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
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Well, one more update. :-)

This is the 6th version of the patchset adding support for generic I/O PM
domains.  The majority of patches have had some small fixes here and there
to make things work when CONFIG_PM_RUNTIME is unset.  In addition to that,
to make the shmobile code introduced by the last patch work for
CONFIG_PM_RUNTIME unset I had to add patches [8-9/10].  Patch [7/10]
adds wakeup support that was missing from the previous version and I
decided not to push patch [1/10] for 3.0 after all.

On Saturday, June 11, 2011, Rafael J. Wysocki wrote:
> 
> The model here is that a bunch of devices share a common power resource
> that can be turned on and off by software.  In addition to that, there
> are means to start and stop the activity of each device, for example
> by manipulating their clocks.  Moreover, there may be hierarchy of
> such things, for example power resource A may be necessary for devices
> a, b, c, which don't rely on any other power resources, and for devices
> x, y, z that also rely on power resource X.  In that case there one PM
> domain object representing devices a, b, c and power resource A, and 
> another PM domain object will represent devices x, y, z with power
> resource X, plus the first object will be the second one's parent.
> 
> Overall, I think I've taken all of the important dependencies into
> consideration, but if you spot something suspicious, please let me know. :-)

[ 1/10] - Rename struct dev_power_domain to struct dev_pm_domain to reflect the
          fact that those objects need not correspond to hardware power domains
          directly.

[ 2/10] - Move subsys_data in struct dev_pm_info out of #ifdef CONFIG_PM_RUNTIME

[ 3/10] - Introduce runtime PM support for generic I/O PM domains.

[ 4/10] - Introduce generic "noirq" callbacks for system suspend/hibernation
          (that's necessary for the next patches).
 
[ 5/10] - Move some PM domains support code fro under #ifdef CONFIG_PM_RUNTIME

[ 6/10] - Add system-wide PM support for generic I/O PM domains.

[ 7/10] - Add support for wakeup from system sleep to the I/O PM domains code.

[ 8/10] - Allow PM clocks management code to be used during system suspend.

[ 9/10] - Rename PM clock management functions so that they names reflect the
          fact that they can be used during system suspend too.

[10/10] - Use the new code to represent the SH7372's A4MP power domain.

All of these patches are regarded as 3.1 material and they are available
from the git branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-domains  

The patchset has been tested on SH7372 Mackerel board for both
CONFIG_PM_RUNTIME set and unset.

Thanks,
Rafael
