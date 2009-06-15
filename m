From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PCI hotplug v.s. suspend
Date: Mon, 15 Jun 2009 09:58:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906150956360.2928-100000__39898.8408306197$1245074392$gmane$org@iolanthe.rowland.org>
References: <4A362893.2060607@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A362893.2060607@tuffmail.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, ath5k-devel@venema.h4ckr.net
List-Id: linux-pm@vger.kernel.org

On Mon, 15 Jun 2009, Alan Jenkins wrote:

> Hi,
> 
> I triggered a WARNING while hacking on eeepc-laptop's 
> rfkill-by-pci-hotplug.  I saw "Trying to free already-free IRQ" in 
> ath5k_pci_remove(), because the IRQ was already freed by 
> ath5k_pci_suspend().  My changes to eeepc-laptop had allowed the PCI 
> device to be removed while suspended.
> 
> Are PCI drivers supposed to handle remove() while suspended?

Yes.  You found a bug in the driver.  However it's not clear (to me at
least) whether the bug is that the IRQ is freed in the suspend method
or that there's no check for already-freed in the remove method.  My 
guess is the latter.

Alan Stern
