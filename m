From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/4] PCI PCIe portdrv: Add kerneldoc comments and
	fix suspend-resume bug
Date: Thu, 1 Jan 2009 19:47:19 +0100
Message-ID: <200901011947.19872.rjw__19938.9571942904$1230836248$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The patches in this series add kerneldoc comments to some functions in
drivers/pci/pcie/portdrv_* and fix a suspend-resume problem with port services.

Also, the code is rearranged a bit so that related functions are closer
together.

Thanks,
Rafael
