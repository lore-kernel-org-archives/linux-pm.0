From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] PM / Domains / shmobile fixes
Date: Wed, 13 Jul 2011 23:52:59 +0200
Message-ID: <201107132352.59801.rjw__8496.46968204088$1310594550$gmane$org@sisk.pl>
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
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

The following three patches fix a couple of issues in the code currently
in my pm-domains branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-domains

[1/3] - Use genpd_queue_power_off_work() for queuing up the powering off
        of A4LC (this avoids attempting to queue up a work item while it is
        pending).

[2/3] - Make the generic PM domains code react to -EBUSY returned from a
        PM domain's .power_down() callback (needed for [3/3]).

[3/3] - Return -EBUSY from the A4LC's .power_down() callback to indicate that
        the domain hasn't been powered down on purpose and remove the confusing
        (and now redundant) pm_genpd_poweron(A4LC) from pd_power_down_a3rv().

Thanks,
Rafael
