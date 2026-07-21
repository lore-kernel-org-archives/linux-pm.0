Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAA4D9909;
	Tue, 21 Jul 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646853; cv=none; b=g71SPSANAsV7ms3wVsMQPcKOERLMUp/1bt9cTFQinCKJ9mcLsZZiadKdjJC9EAbs5oiB7w6c8QQRBULKfgZfaTScMOgAa33ghdwZES0om3YZk2u6m5bCVw08zDU0n9ZFkLHYVH9u5bHAvl4jUWSye5HQ16cxDJojs9q3XRRx2oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646853; c=relaxed/simple;
	bh=MYKOoc9T6XTsGzCFlvVY6nnrWdCWV9zJIhmzPdIkqtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pt37KBRUh/aB1Q2ikyjO96TEDOXALNGWhCXBCAD8c0TnL5wNU9gcceDG6WYGg7Ua2FccrZdJzPit38LX/rhBMx7ryzYqFnsXNBJeHxfuydBeMlTEoTxJgUGnQCpGmSs1LWRoJygalsFDG0wDMneElaE0kUV9HUp6foyOxBPbqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=bVf8mKCg; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="bVf8mKCg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784646848;
	bh=AqVZhRNLNOhvukqy4uccnfnDMk+VUTfv9FzIh5myaVo=;
	h=From:To:Cc:Subject:Date:From;
	b=bVf8mKCgOdCpS0U5u6MNxrXNcb5joU93Df3XYVZ8oP89W3oWPBLmAzgJ5H934aSJd
	 zsQE/SxYK87w/92M6+swL4wq4dvLY6oFABGnh0VNejn3gxXAfC9PMuLe134Z8Euo6q
	 AB6FxO11v5ymmwGg+2SNPTAoKdvvq64hMu9di6bw=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4h4LWh4Kl4z6vMZ;
	Tue, 21 Jul 2026 15:14:08 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4h4LWg5G3Wz4vyJ;
	Tue, 21 Jul 2026 15:14:07 +0000 (UTC)
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
Subject: [PATCH v2 0/3] reboot: log the task that initiated
Date: Tue, 21 Jul 2026 16:13:55 +0100
Message-ID: <20260721151358.4185467-1-include@grrlz.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a machine reboots, powers off, kexecs or hibernates, the kernel
log records what happened but not who asked for it. This series logs
the comm and pid of the initiating task once the transition is
committed:

  reboot: initiated by systemd-shutdow[1]
  reboot: Restarting system

Patch 1 covers the restart, halt and power off commands of the
reboot syscall. Patches 2 and 3 give kexec and the hibernation power
down the same treatment at their own points of no return, as
suggested in the v1 review [1]. The kexec and PM maintainers are on
cc for their input on those two.

v1 -> v2:
- Reworded the justification in patch 1: dropped the fleet operator
  claim and spelled out the concrete gap in userspace logging
- New patch 2: log the initiator for kexec reboots
- New patch 3: log the initiator for the hibernation power down
- Added the kexec and PM maintainers and lists to cc

[1] https://lore.kernel.org/all/20260719160938.3692-1-include@grrlz.net/

Bradley Morgan (3):
  reboot: log the task that initiated the reboot
  kexec: log the task that initiated the kexec reboot
  PM: hibernate: log the task that initiated the power down

 include/linux/reboot.h   |  1 +
 kernel/kexec_core.c      |  1 +
 kernel/power/hibernate.c |  2 ++
 kernel/reboot.c          | 16 ++++++++++++++++
 4 files changed, 20 insertions(+)

-- 
2.50.1
