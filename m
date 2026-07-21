Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB74D9914;
	Tue, 21 Jul 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646854; cv=none; b=VWFdANZv8YAmT4GL9FPsxFRnJRehbymkLI4v6cRuaI6OmzYOh6+XHj0Ck3j2oBwy6xzR5RsN5mPUZ3So06ntP258tSZ314Pt6QKXFcYISjBiFxbR2qiziayF+/zl0oW/ysgYHVihApR9YpdaWQtyfWqy7ACtt1nDABpDTeVRe4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646854; c=relaxed/simple;
	bh=StdNA1WERZBz3R832dxnd3DmnecPu8RaIVeJcTN9nJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4uYCFbxKSHl7romuzDbngUt4LRf3v6oX1Mk4bhhl9EQnMbTfLWMxdDee52YGiXFE1U8R82pn+Kw76JP8CAYrJf3RA0ho4dxt5nfTcpEBevS+Qvn3XL0BtFIN3OGVLXyIQg0KJlZQpLXF1AHoXO55qz6O8EQlvAeqmVjnejFieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=UFNLM+vu; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="UFNLM+vu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784646849;
	bh=pbKDGyNNyhDV1H5PR4A8c50OlkFbCH78KDfnPB0VA6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFNLM+vumosCC9EyEK+PQKYA3EUr1upq2TWPePwN5KH/nfU+TDJjZKakbxvqim6Tr
	 ogeSAoqUrtIBnKZCBVDsjE6iOIopbbttQjh89NqivAhDIAMBTS6UAuTYgvL6+vOncf
	 TQZ7MZ6puX+XljlXxojFfCmlbxHpsua38BRpNvwY=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4h4LWj3LXyz6vNZ;
	Tue, 21 Jul 2026 15:14:09 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4h4LWh4sK6z4vyJ;
	Tue, 21 Jul 2026 15:14:08 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Cc: baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	kees@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v2 1/3] reboot: log the task that initiated the reboot
Date: Tue, 21 Jul 2026 16:13:56 +0100
Message-ID: <20260721151358.4185467-2-include@grrlz.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260721151358.4185467-1-include@grrlz.net>
References: <20260721151358.4185467-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a machine reboots or powers off, the kernel log records what
happened but not who asked for it. The reboot syscall throws the
caller identity away, and userspace does not reliably record it
either: systemd only journals shutdowns that go through logind,
anything calling reboot(2) directly (watchdog daemons, container
agents, orchestration tooling) leaves no record at all, and the
journal is being torn down while the machine goes away, so even the
lines that should be written can be lost. The kernel is the only
place that always sees the caller, and a kernel log line survives
via pstore or a serial console when userspace logs do not.

Log the comm and pid of the calling task in the reboot syscall, once
the requested command is committed and can no longer fail, e.g:

  reboot: initiated by systemd-shutdow[1]
  reboot: Restarting system

The existing "Restarting system", "System halted" and "Power down"
lines are left untouched, so anything parsing dmesg today keeps
working. The two ctrl alt del toggle commands are excluded so init
setting the mode does not add a line to dmesg on every boot.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 include/linux/reboot.h |  1 +
 kernel/reboot.c        | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index aa08c3bbbf59..3fb8d8533563 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -172,6 +172,7 @@ extern void kernel_restart(char *cmd);
 extern void kernel_halt(void);
 extern void kernel_power_off(void);
 extern bool kernel_can_power_off(void);
+void reboot_log_initiator(void);
 
 void ctrl_alt_del(void);
 
diff --git a/kernel/reboot.c b/kernel/reboot.c
index bed6967bfa96..3f4534cd5b9c 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -717,6 +717,18 @@ EXPORT_SYMBOL_GPL(kernel_power_off);
 
 DEFINE_MUTEX(system_transition_mutex);
 
+/*
+ * Log the task that asked for the transition once the requested
+ * command is committed and can no longer fail, e.g:
+ *
+ *   reboot: initiated by systemd-shutdow[1]
+ *   reboot: Restarting system
+ */
+void reboot_log_initiator(void)
+{
+	pr_info("initiated by %s[%d]\n", current->comm, task_pid_nr(current));
+}
+
 /*
  * Reboot system call: for obvious reasons only root may call it,
  * and even root needs to set up some magic numbers in the registers
@@ -764,6 +776,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	mutex_lock(&system_transition_mutex);
 	switch (cmd) {
 	case LINUX_REBOOT_CMD_RESTART:
+		reboot_log_initiator();
 		kernel_restart(NULL);
 		break;
 
@@ -776,10 +789,12 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		break;
 
 	case LINUX_REBOOT_CMD_HALT:
+		reboot_log_initiator();
 		kernel_halt();
 		do_exit(0);
 
 	case LINUX_REBOOT_CMD_POWER_OFF:
+		reboot_log_initiator();
 		kernel_power_off();
 		do_exit(0);
 		break;
@@ -792,6 +807,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		}
 		buffer[sizeof(buffer) - 1] = '\0';
 
+		reboot_log_initiator();
 		kernel_restart(buffer);
 		break;
 
-- 
2.50.1

