From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] PM / Hibernate: Fixes related to user space
	interface
Date: Sat, 7 May 2011 00:29:44 +0200
Message-ID: <201105070029.44623.rjw__19648.847441613$1304721249$gmane$org@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Alexandre Felipe Muller de Souza <alexandrefm@mandriva.com.br>
List-Id: linux-pm@vger.kernel.org

Hi,

The following three patches fix bugs related to the hibernate user space
interface:

[1/3] - Fix warning from pm_restrict_gfp_mask() in the SNAPSHOT_S2RAM ioctl
        code path.

[2/3] - Make snapshot_release() call pm_restore_gfp_mask() if tasks weren't
        thawed before.

[3/3] - Make the SNAPSHOT_S2RAM clear data->ready.

With all of these patches applied, s2both actually works on my Toshiba test
machine, which is nice. :-)

Many thanks to Alexandre for turning my attention to these problems.

Thanks,
Rafael
