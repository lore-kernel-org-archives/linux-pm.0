From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/9] PCI PM: Rework PCI device PM
Date: Fri, 20 Jun 2008 01:45:32 +0200
Message-ID: <200806200145.33053.rjw__19306.3716906638$1213920051$gmane$org@sisk.pl>
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
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following series of patches is intended to rework PCI device power
management to join it with the related ACPI bits more tightly and to clean up
disabling/enabling the system wake-up capability of PCI devices.  In
particular, after these patches the PCI devices that are capable of waking
up the system should have their /sys/devices/.../power/wakup files set up
as appropriate.

The last patch introduces two helper function intended to be used by PCI
drivers implementing the new suspend/hibernation callbacks that do not take
the second pm_message_t argument.

Comments welcome.

Thanks,
Rafael
