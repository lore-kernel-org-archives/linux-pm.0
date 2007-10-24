From: Shaohua Li <shaohua.li@intel.com>
Subject: [discuss]disable PCI resource decode in D3?
Date: Wed, 24 Oct 2007 10:58:40 +0800
Message-ID: <1193194720.27150.27.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
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
List-Id: linux-pm@vger.kernel.org

PCIPM spec requires OS to disable IO/Memory decode and bus master if a
device is put into D3 (spec 8.2.2). pci_set_power_state doesn't do this
for D3. Could this cause mysterious hang of S3 in some BIOS?

Thanks,
Shaohua
