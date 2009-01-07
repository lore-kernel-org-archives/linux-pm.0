From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/10] PCI PM: Make new suspend-resume callbacks
	carry out core operations
Date: Wed, 7 Jan 2009 13:00:59 +0100
Message-ID: <200901071301.00139.rjw__23427.2479582161$1231330616$gmane$org@sisk.pl>
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
Cc: Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, Linux PCI <linux-pci@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

The following series of patches adds the callbacks that save/restore the
standard PCI config registers, change the power state of the device etc. to
the new suspend-resume callbacks (which are not yet used by device drivers),
so that the drivers don't have to worry about these operations.

The default suspend-resume handling of PCI devices (ie. for devices without
drivers or without PM support in the drivers) is also modified so that the same
callbacks that are used for devices with PM support can be used for them too.

The patches are on top of the current Linus' tree with the linux-next branch of
your pci-2.6 tree merged.

Please apply.

Thanks,
Rafael
