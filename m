From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/4] PM: Make power.subsys_data be more useful
Date: Tue, 9 Aug 2011 00:28:12 +0200
Message-ID: <201108090028.12698.rjw__17905.5098597475$1312842808$gmane$org@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

The following patchset reworks the power.subsys_data field of
struct device so that it can be used not only for clock PM
management.

[1/4] - Introduce struct pm_subsys_data to be point to by power.subsys_data.
[2/4] - Add reference counting for power.subsys_data.
[3/4] - Optimize generic PM domains code by making it use power.subsys_data.
[4/4] - Move PM clock management headers and definitions to a separate file.

The patchset is on top of the pm-domains branch of the linux-pm tree at:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-domains

It has been tested on an ARM shmobile Mackerel board.

Thanks,
Rafael
