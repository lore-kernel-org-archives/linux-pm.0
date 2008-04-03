From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] PM: New suspend and hibernation callbacks
Date: Fri, 4 Apr 2008 01:11:13 +0200
Message-ID: <200804040111.15255.rjw__47647.8165867322$1207264784$gmane$org@sisk.pl>
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
To: Greg KH <greg@kroah.com>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi Greg,

The following patches are intended to start the redesign of the suspend and
hibernation framework for devices.

The first one introduces new callbacks for suspend and hibernation (7th revision).
It also updates the PM core to use the new callbacks at the top level, allowing
it to use the existing callbacks if the new ones are not defined.

The other two patches implement the new suspend and hibernation callbacks
for the platform and PCI bus types (3rd revision of both).

The patches allow platform and pci drivers to start using the new callbacks
immediately and similar patches for the other bus types etc. will follow.
Still, until drivers actually start to implement the new callbacks, no
functional changes are expected to appear as a result of these patches.

I think the patches have stabilized sufficiently for being pushed upstream,
so please add them to your queue.

Thanks,
Rafael
