From: castet.matthieu@free.fr
Subject: airo suspend problem
Date: Tue, 12 Jun 2007 13:23:08 +0200
Message-ID: <1181647388.466e821cb546d@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

the airo driver (drivers/net/wireless/airo.c) does in its suspend routine [1].
But not all the pci cards support power management and cause
pci_enable_wake/pci_set_power_state to return errors.

On pci card that don't support PM, what should be done ?
Don't call pci_enable_wake/pci_set_power_state ?


Thanks

Matthieu


PS : after the failed suspend to ram due to airo driver, I tried to unload airo
driver and it hanged. After a reset, I got my ext3 root fs corrupted :(




[1]
pci_enable_wake(pdev, pci_choose_state(pdev, state), 1);
pci_save_state(pdev);
return pci_set_power_state(pdev, pci_choose_state(pdev, state));
