From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [RFC][PATCH 0/1] ARM: Add initial hibernation support
Date: Wed, 30 Jun 2010 17:28:00 +0300
Message-ID: <1277908081-17195-1-git-send-email-Hiroshi.DOYU__35684.5301379964$1278005751$gmane$org@nokia.com>
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
To: linux-arm-kernel@lists.infradead.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Yoshiya.Hirase@nokia.com, teerth@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is the experimental patch to add hibernation (a.k.a:
Suspend-To-Disk) support for ARM architecutre.

Presently it seems to work with OMAP3, and apparently it still needs
more efforts to make it enough stable and to support other ARM
platforms cleanly but I am sending this patch to get some feedbacks at
its early phase to find out the further direction. It would be really
appreciated if you give some comment on this.

This patch is based on the one sent to loml(*1) by Teerth Reddy, which
was originally from Romit and Raghu at TI.

    *1: https://patchwork.kernel.org/patch/96442/

Hiroshi DOYU (1):
  ARM: Add initial hibernation support

 arch/arm/Kconfig                |    4 +
 arch/arm/include/asm/memory.h   |    1 +
 arch/arm/include/asm/suspend.h  |    6 +
 arch/arm/kernel/Makefile        |    1 +
 arch/arm/kernel/hibernate.c     |  234 +++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/hibernate_asm.S |  135 ++++++++++++++++++++++
 arch/arm/kernel/vmlinux.lds.S   |    3 +-
 7 files changed, 383 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/include/asm/suspend.h
 create mode 100644 arch/arm/kernel/hibernate.c
 create mode 100644 arch/arm/kernel/hibernate_asm.S
