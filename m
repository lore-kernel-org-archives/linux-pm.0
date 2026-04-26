Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0340F31354C;
	Sun, 26 Apr 2026 23:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777246030; cv=none; b=QjbTboBy0t/jh7187X1qPpr88QEfXZr/5QvX/iHpfL9lKK2mlBsnxLSch01sronHA3VvVihdYwYHrVko45FzZnt5dfA3dyMlYNqruzpYgqneR7QKeNVZqYcanB2Sh817XDH76B89p1w1L94Y644b8brVByirznDWqSDj+AvDMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777246030; c=relaxed/simple;
	bh=IeHy+q3kH3pU37JWoH0Q4L2MtC8YzKq0rQ8Fcyo+3lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQ6EVlUOlp6PS8d5wlksP6c+rTN3rsJXQhAmX2EEH2uYdr+MsAoIA2n/MD4+W5NUhQz1xl1wPxQIGQIdydyJGFYcNZ9emjt7G3bP6vZWd0yF9wr3nLQCRof1z+m5PixfpB0jYDdfXSR7pjXd0+x8lAkqSLIlCQsz+5gyPAL+ipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3aJtOLqA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3aJtOLqA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=/yRfGCz+H6Wk+KRLLP/U3Hu5ASdZ8/kg+ddKo/mVVEM=; b=3aJtOLqAH137n6GeOfouyz+dfE
	zXldllfQdyvXzBVtkpgJkkGPGgE65euZkRZ4b5bR9Bspmo4V/0og/fdcbL66lbDsyHu5YZzxutsEL
	rNuZFibjmioXTWg+X7ejehzYeIsuNhmZZlX0BWgBcEm1cfMWqPZ0S27ae9giwOa6oAPji+GzzIzNi
	Kwj8f1Ts/Mr3tTOhVNylmbfZT5iP/oWDUmKtOCwAKlZgi+OmL1GJO7AFpcmrp01vyvJPQsNYgJAkK
	+sGOhZwLpMYbgALYm8+s0k4PtHjGOqa73Akt3HpdRKYjK5AsDUwaosHfE+VKurqehioNpDGr7T05V
	2D3BJmFA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wH8sU-0000000Fw2i-15Wa;
	Sun, 26 Apr 2026 23:27:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: ABI: sysfs-class-reboot-mode-reboot_modes: fix doc warnings
Date: Sun, 26 Apr 2026 16:27:05 -0700
Message-ID: <20260426232705.422938-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repair the docs build warnings in this file by unindenting the description,
adding blank lines, and using `` to quote *arg.

WARNING: Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:36: abi_sys_class_reboot_mode_driver_reboot_modes doesn't have a description
Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: ERROR: Unexpected indentation. [docutils]
Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: ERROR: Unexpected indentation. [docutils]
Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: WARNING: Inline emphasis start-string without end-string. [docutils]
Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: ERROR: Unexpected indentation. [docutils]

Fixes: d3da03025e6d ("Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Bartosz Golaszewski <brgl@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: linux-doc@vger.kernel.org

 Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes |   13 ++++++----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- linux-next-20260424.orig/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
+++ linux-next-20260424/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
@@ -2,33 +2,36 @@ What:		/sys/class/reboot-mode/<driver>/r
 Date:		March 2026(TBD)
 KernelVersion:	TBD
 Contact:	linux-pm@vger.kernel.org
-		Description:
+Description:
 		This interface exposes the reboot-mode arguments
 		registered with the reboot-mode framework. It is
 		a read-only interface and provides a space
 		separated list of reboot-mode arguments supported
 		on the current platform.
 		Example:
+
 		 recovery fastboot bootloader
 
 		The exact sysfs path may vary depending on the
 		name of the driver that registers the arguments.
-		Example:
+		Example::
+
 		 /sys/class/reboot-mode/nvmem-reboot-mode/reboot_modes
 		 /sys/class/reboot-mode/syscon-reboot-mode/reboot_modes
 		 /sys/class/reboot-mode/qcom-pon/reboot_modes
 
 		The supported arguments can be used by userspace to
 		invoke device reset using the standard reboot() system
-		call interface, with the "argument" as string to "*arg"
-		parameter along with LINUX_REBOOT_CMD_RESTART2.
+		call interface, with the "argument" as string to ``*arg``
+		parameter along with ``LINUX_REBOOT_CMD_RESTART2``.
 
 		A driver can expose the supported arguments by
 		registering them with the reboot-mode framework
 		using the property names that follow the
 		mode-<argument> format.
 		Example:
-		 mode-bootloader, mode-recovery.
+
+		 mode-bootloader, mode-recovery
 
 		This attribute is useful for scripts or initramfs
 		logic that need to programmatically determine
