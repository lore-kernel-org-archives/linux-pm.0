From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] Net driver fixes related to power management
Date: Thu, 10 Feb 2011 17:51:56 +0100
Message-ID: <201102101751.56508.rjw__23046.284603379$1297357063$gmane$org@sisk.pl>
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
To: netdev@vger.kernel.org
Cc: Jay Cliburn <jcliburn@gmail.com>, Chris Snook <chris.snook@gmail.com>, Matt Carlson <mcarlson@broadcom.com>, Jie Yang <jie.yang@atheros.com>, Thomas Fjellstrom <thomas@fjellstrom.ca>, Michael Chan <mchan@broadcom.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, David Miller <davem@davemloft.net>
List-Id: linux-pm@vger.kernel.org

Hi,

The following series of patches fix minor issues related to power management
in the tg3, alt1 and atl1c drivers.

[1/3] - tg3: Don't use device_init_wakeup() (PCI does that)
[2/3] - atl1c: Don't use device_init_wakeup() (ditto)
[3/3] - atl1: Don't use legacy PCI power management.

Please consider for applying.

Thanks,
Rafael
