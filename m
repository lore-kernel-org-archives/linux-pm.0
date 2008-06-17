From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] PCI PM: Rework pci_set_power_state
Date: Tue, 17 Jun 2008 02:06:26 +0200
Message-ID: <200806170206.26616.rjw__19506.0736536563$1213662047$gmane$org@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

Hi,

I've recently discovered that pci_set_power_state() calls the platform
callback intended for changing the state of the device after it has done
that using the native PCI mechanism.  In my opinion this is not correct,
because, for example, if the device is being put into D0 from a low power
state, it may require some platform-controlled power resources to be turned
on before that (in theory).

The following series of patches changes this function so that the platform
callback is performed first and then the native mechanism is used.
Additionally, however, it checks if the devices is power manageable by the
platform and only in that case the platform callback is invoked.  For this
purpose, I needed to add an ACPI function allowing PCI to check the power
manageability of given device.

Comments welcome.

Thanks,
Rafael
