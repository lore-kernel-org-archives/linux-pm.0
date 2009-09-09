From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/9] PM: Asynchronous suspend of devices
Date: Thu, 10 Sep 2009 01:27:11 +0200
Message-ID: <200909100127.11252.rjw__25431.9832813509$1252539771$gmane$org@sisk.pl>
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
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi,

The following series of patches implements asynchronous suspend and resume of
devices.

All of the patches have already been discussed, please refer to the changelogs
for details.

The patches are targeted at 2.6.33, so if there are no major objections, I'll
put them into the linux-next branch of the suspend-2.6 tree after .31-rc1 is
out.

Thanks,
Rafael
