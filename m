From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/2] PCI PM: Fix radeonfb vs
	pci_set_power_state() problem
Date: Wed, 25 Mar 2009 01:38:52 +0100
Message-ID: <200903250138.53234.linux-pci-owner@vger.kernel.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following two patches are intended to fix the problem that will arise
when the PM patches queued up for 2.6.30 are merged and which is that
pci_set_power_state() called by radeonfb to complete the transition into D2
will return immediately due to the device's current_state being already PCI_D2.

1/2 introduces low level PM core functions one of which may be called by the
radeonfb driver to complete the power transition.

2/2 actually makes radeonfb use the new function.

The patches (on top of the linux-next branch of suspend-2.6) have not been
tested yet, but they compile (at least on x86_64).

Comments welcome.

Thanks,
Rafael
