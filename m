From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 0/5] wakeup event detect support
Date: Wed, 19 Aug 2009 15:24:08 +0800
Message-ID: <1250666648.23178.115.camel__41179.5225031257$1250666797$gmane$org@sli10-desk.sh.intel.com>
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
To: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

These are a refresh of my previous wakeup event detect support patches.
Recently Matthem is adding pci runtime power management, so making the
wakeup event detection work is essential.
The patches add support for both acpi-based and pcie native pme based
wakeup event detection. The patches are just for wakeup event detection,
so what we should do after get the event (the patch just print some
info) and how to enable wakeup event (which should be done in driver)
are not in these patches' scope. please take a look.

Thanks,
Shaohua
