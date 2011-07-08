From: Kevin Hilman <khilman@ti.com>
Subject: pm_runtime_suspended() can be false if RPM_SUSPENDED
Date: Fri, 08 Jul 2011 16:41:00 -0700
Message-ID: <871uy0733n.fsf__43567.6885107116$1310168552$gmane$org@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Just curious why pm_runtime_suspended() requires the device to be
enabled for it to return true:

static inline bool pm_runtime_suspended(struct device *dev)
{
	return dev->power.runtime_status == RPM_SUSPENDED
		&& !dev->power.disable_depth;
}

I must be misunderstanding something, but I would consider a device that
has been runtime suspended before runtime PM was disabled to still be
runtime suspended.

I just noticed this when testing with your pm-domains branch.  when I
noticed that an 'if (pm_runtime_suspended(dev))' check in my PM domain's
->suspend_noirq() was always failing since it's after the PM core calls
pm_runtime_disable().  I had to change my PM domain code to only check
dev->power.runtime_status for it to work.

Kevin
