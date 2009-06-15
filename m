From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: PCI hotplug v.s. suspend
Date: Mon, 15 Jun 2009 11:55:15 +0100
Message-ID: <4A362893.2060607__5952.91456343165$1245063273$gmane$org@tuffmail.co.uk>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-pci@vger.kernel.org, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, ath5k-devel@venema.h4ckr.net
List-Id: linux-pm@vger.kernel.org

Hi,

I triggered a WARNING while hacking on eeepc-laptop's 
rfkill-by-pci-hotplug.  I saw "Trying to free already-free IRQ" in 
ath5k_pci_remove(), because the IRQ was already freed by 
ath5k_pci_suspend().  My changes to eeepc-laptop had allowed the PCI 
device to be removed while suspended.

Are PCI drivers supposed to handle remove() while suspended?

Thanks
Alan
