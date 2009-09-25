From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] PM / PCMCIA: Fix CardBus suspend/resume
	regression
Date: Sat, 26 Sep 2009 01:22:58 +0200
Message-ID: <200909260122.59030.rjw__38359.5453030013$1253921510$gmane$org@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, linux-pcmcia@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Florian <fs-kernelbugzilla@spline.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following two patches fix a regression causing CardBus resume to fail,
introduced during the 2.6.29 development cycle.

[1/2] Drops the second argument of pcmcia_socket_dev_suspend(), which is not
      used.

[2/2] Fixes the regression by moving the yenta suspend/resume to the late phase
      of suspend and early phase of resume, respectively.

If there are no objections, I'll push these patches through the suspend-2.6
tree early next week.

Thanks,
Rafael
