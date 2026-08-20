Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ED64854EA;
	Thu, 20 Aug 2026 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240675; cv=none; b=WzSPrRJVr6foN+D86pXGCA9eNQtDT864L/qw/FzhjJD3+bI5M/DLBH0fOMjsxuEfMgQyFQMFK5tuaWw2Vvv3NT1wakc9IBRg9w2CokS0qA0vT44JA2NQJW0giZgiq16muF3PiM56BYhTrxZ/JNesAhD8YWoVjQhlwGn+21MLPzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240675; c=relaxed/simple;
	bh=EXyFEILxEcSeIxa2eQNmClR17ObGFD2Zz+oteEo4SoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lov3IB4Nn7pwHcjvDQMoAu/AY9zwVlQ1rw/fD7zQmoiYMDUsrxIuS4k/31mHmVyk3lTKUG2pvt6xtox5ksf2bWijVfAhLYIqLHNZtQMDBi5CHeHyTMYiWOCD3U78pmCvMheZbITzI81bdL08CWYNPkA+snrpjAk4EaxEvjxMI5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpWiXCwa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpWiXCwa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943FE1F00A3E;
	Thu, 20 Aug 2026 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787240664;
	bh=LLCi+3/u1AlH14NtKta7LIro/6DlkEaRnrimWKs/lNg=;
	h=From:To:Cc:Subject:Date;
	b=FpWiXCwa5joREDMwCN6LSBrL2vIc/gNB4dC3gzGaQ+2MhaSZ9SwVK65UIdHsxCihQ
	 i8F9g4tdA4eD1uRNU0br6p5HJMgLMudCQAKLHKeMx8RChDwp43KnhU+lIUnztW7Xc6
	 2SmiIpSkR2He/EOCQqRQJ7rYDH8bG5+4kvAtU9NwOOr5PKRew4/DduXHzoRuSmbQ1G
	 MFqnhVLYmdaWcaoXVFXKUKDkwKsQKYHknsD8/zsu9TNvDrdTviSh4skG7nYkkKqHB+
	 uw/gVuWPL/8F4Z0cOH0+TQQFj5R1KWTR2minAz8FMJEsA4Vy+Bo6az9YIZxpZX6Ox2
	 huA4EEb7P7dwg==
From: Thorsten Blum <blum@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Yury Norov <ynorov@nvidia.com>
Cc: Thorsten Blum <blum@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: powerclamp: Simplify check_invalid()
Date: Thu, 20 Aug 2026 17:43:36 +0200
Message-ID: <20260820154339.47737-2-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=blum@kernel.org; h=from:subject; bh=EXyFEILxEcSeIxa2eQNmClR17ObGFD2Zz+oteEo4SoY=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFntCqv/WvP/sJpi0mj+48D9qYdjVMTzlR/OzJERXv58c obb71lbOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAic0MZ/jvXZLP8tZm+RyKf PZplsQtvSPpMfW8lG97N8Vn7p6t3v2dkWL2d7VKp4byza4qOT1nFt3ijqatueuSJbx4WM+57tFf 95wMA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Return the boolean expression directly and use const for the read-only
mask parameter.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/thermal/intel/intel_powerclamp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index bd7fd98dc310..f54cc6a29d16 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -143,12 +143,9 @@ static int allocate_copy_idle_injection_mask(const struct cpumask *copy_mask)
 }
 
 /* Return true if the cpumask and idle percent combination is invalid */
-static bool check_invalid(cpumask_var_t mask, u8 idle)
+static bool check_invalid(const struct cpumask *mask, u8 idle)
 {
-	if (cpumask_equal(cpu_present_mask, mask) && idle > MAX_ALL_CPU_IDLE)
-		return true;
-
-	return false;
+	return cpumask_equal(cpu_present_mask, mask) && idle > MAX_ALL_CPU_IDLE;
 }
 
 static int cpumask_set(const char *arg, const struct kernel_param *kp)
