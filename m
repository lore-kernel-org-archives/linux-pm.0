Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EE73EC804;
	Fri,  2 Oct 2026 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790921779; cv=none; b=MlH/yPl654cUEzzKFFQ0qDZ85oalqRF/pO1Ok5NYTNe5CCsvj9C2nn11XuxZMFH00nu72Z7Grii4GsLXxQCXU5RM8CI7wPWE56K6RPSggc2hnJ9ClIaNphMXa1R4aC5AV6qqaOJ7OrIGyFRzleni/NQNe+m4NN83qd9eAMRAg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790921779; c=relaxed/simple;
	bh=n2F3ScOdCk4J5EcEF98ICSkibYoMkmmvKMdyQDe7dVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fd7sRp5glhOjRx3rUjzO3h2zzIYbN8s6lnRpgEWS9YoDxN+1ExZiBFPWumtTfWSaL3G91S2o2XKtsMA2pZ7VZrhgUcQfKaa9ba33D3FScJP84b4qgKSuzcoJEwR9m6Dl7xcllW2YfcOpMDESKUpy+wNd6/dRwXsgaH+uExz3LKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ORIcdL5t; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ORIcdL5t"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57188169C;
	Thu,  1 Oct 2026 23:15:57 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9EF963F763;
	Thu,  1 Oct 2026 23:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790921760; bh=n2F3ScOdCk4J5EcEF98ICSkibYoMkmmvKMdyQDe7dVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORIcdL5tuE/H3yLMf1awoEeIaYAtuq3bPffTslRCyFDlHEyIyMGg8PAM/SZlTxdM6
	 UUkgNj0e8USjKNQg8GIuiZbHKsUBt63MfmtRF21gxv0wH7uT5XPbyA/Uf25rWaBJRd
	 SqwZLTtbCXIi/BvIHE9uFZFRyaiVqJ1XT+z7FS3Q=
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev
Cc: maz@kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	steven.price@arm.com,
	aneesh.kumar@kernel.org,
	oupton@kernel.org,
	gshan@redhat.com,
	joey.gouly@arm.com,
	tabba@google.com,
	yuzenghui@huawei.com,
	linux-coco@lists.linux.dev,
	gankulkarni@os.amperecomputing.com,
	sdonthineni@nvidia.com,
	alpergun@google.com,
	fj0570is@fujitsu.com,
	WeiLin.Chang@arm.com,
	lpieralisi@kernel.org,
	enju.kohei@fujitsu.com,
	sudeep.holla@arm.com,
	jonathan.cameron@oss.qualcomm.com,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>
Subject: [PATCH v22 07/10] kernel: hibernate: Add an arch hook for preventing hiberation
Date: Fri,  2 Oct 2026 07:15:03 +0100
Message-ID: <20261002061507.1600269-8-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002061507.1600269-1-suzuki.poulose@arm.com>
References: <20261002061507.1600269-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a hook to allow arch code disable hibernation. On arm64, with an RMM active,
there could be pages that are delegated to the "Realm" security state. Any
access to them are fatal (e.g., hibernate save image or restoring an image to
a delegated page). pKVM host also has its restrictions on enabling hibernation.

Add a weak arch hook to let the architectures have a say.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/suspend.h  | 1 +
 kernel/power/hibernate.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b02876f1ae38a..a3815027773c5 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -401,6 +401,7 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data);
 int hibernate_resume_nonboot_cpu_disable(void);
 int arch_hibernation_header_save(void *addr, unsigned int max_size);
 int arch_hibernation_header_restore(void *addr);
+bool arch_hibernation_available(void);
 
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index d2479c69d71a4..9d9d53828542f 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -106,11 +106,17 @@ bool hibernation_in_progress(void)
 	return !atomic_read(&hibernate_atomic);
 }
 
+__weak bool arch_hibernation_available(void)
+{
+	return true;
+}
+
 bool hibernation_available(void)
 {
 	return nohibernate == 0 &&
 		!security_locked_down(LOCKDOWN_HIBERNATION) &&
-		!secretmem_active() && !cxl_mem_active();
+		!secretmem_active() && !cxl_mem_active() &&
+		arch_hibernation_available();
 }
 
 /**
-- 
2.43.0

