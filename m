Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D604471257;
	Tue, 21 Jul 2026 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657645; cv=pass; b=lU0gECbP0i8wWSQskSV3JRwJW+4wUFFr8+/Xs/TXeZ7bPMbcDcsrKwfg+SYwSMpeJYzUsJxPivrdeEX+7VLAbdQE/W7Y9Sk34TWVTAw8H7GczJajFglY3Cq4MYMhi/52kAT4J+ecKczkBy09gx/6Y6iSk4X/n6CsR1eND+Px1MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657645; c=relaxed/simple;
	bh=Iq9/atbOV7VrN6MKUVNPKOmc4CLZNESEG0lUqmMP24k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cXrnqA1pPeb8+ltmNDzTo4BLI9pG/vDpG5oTdqiCVqSon6qaxYXUonaxj13ghL+fsezkNhDjNdXKhu2m19W8l7UAuB36zfYsaLcWedzS5BdW/MIsxhhwBPs71kPYtTtT1V4OXH0GqDHrV2T8B4UUWPGg2aWesVoccIJQc+/ziXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=EC8OqZD6; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="EC8OqZD6"
ARC-Seal: i=1; a=rsa-sha256; t=1784657631; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WWNREtQIARhpZdTzOlo7PMWMWQ7ThdCobIPkKDPxTNh9JFfEFWnnQuxVt4TKdHmc3j7WciR1uUD3jm/Nj7ut1BuiWnAvBW9IRdYQ9xp09QIO2fEvcBZ7i3RrbHXLAUvKVSh0AxDXFTAGLdPTWMY7UgS2up67vQ7Y/5PtF5+Y+HE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784657631; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7a5oVu7+z5umzlldF2NbQMQ8dPkrMZL/tgPhGIOB3M8=; 
	b=hyULw0rFaqlDPc5xdiY+w/lAHjFrEtIng9vYcZhqVmyt8yEQ2rSQhLsX6/VMlxOZm5WBiZKzvrAF7bvZF/hBGghflvVf3dLoqXHfGOnfV5CyJ16/ZDfxQrRaKvE5CnCjb+2QZo66MD0WSUg3KBKKIZJcJXHme/92Qv5fXE+yZQg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784657631;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=7a5oVu7+z5umzlldF2NbQMQ8dPkrMZL/tgPhGIOB3M8=;
	b=EC8OqZD6ZP7DtNf4SZO4R3UUkb3PIGBKRUv0hz3KHLg8YwKXfRFNrtYr4pS+ZhnL
	ed4NH0gLw3RepqlUq537vgWASpWk+S+m4/F0R3FKfgVKnMeIjyEqZm+5ph14jObuZOV
	SKmpAffmRJrGo4E7lDrVo833QjwFmuoeGtFCAM3gFOrLt3Tv/0x6lRCvVYJ9mIlyCfV
	okXZcu4ROHGsS8YgSRLkCruEFHzuTxn7mRNDrL9VBoXvjF7EFdWxP8F6YRXn0Pwe1uR
	hhvDE+oPrTrFmxEQFoDlRxuljbW+2EsdW6y5h20g7uVkxyNUxGS6t8IrajxTYv7RaHt
	2JKWlHDmCw==
Received: by mx.zohomail.com with SMTPS id 1784657628687548.4289091421235;
	Tue, 21 Jul 2026 11:13:48 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Wed, 22 Jul 2026 02:13:43 +0800
Subject: [PATCH v4] cpufreq/amd-pstate: Prevent the driver from loading on
 unsupported hardware
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-amd-pstate-vm-v4-1-d6607d9e9d9a@rong.moe>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13NyQ6DIBSF4VcxrEsjgyBd9T2aLhiuShOHgCVtj
 O9etBvj8iT3+++CIgQPEd2KBQVIPvpxyINfCmQ7PbSAvcsbEWspL5nEund4irOeAaceO6ENt6p
 SxjGUzRSg8Z+993j+d3ybF9h5i2wXnY/zGL77w0S2O0RLKkpJxKmdCCaYaqukY7YRIO9hHNprP
 wLa0okecX3GNGMBrmqYobZWcMLsgCk5Y5ZxbSpVSd4YSfgBr+v6A4QHilw1AQAA
X-Change-ID: 1cc24037-amd-pstate-vm-d6ab4c959bd3
To: Huang Rui <ray.huang@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, 
 Jason Andryuk <jason.andryuk@amd.com>
Cc: Michael Kelley <mhklinux@outlook.com>, 
 Michael Kelley <mhklkml@zohomail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>, Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-4217c
X-ZohoMailClient: External

X86_FEATURE_HW_PSTATE indicates if the processor supports frequency
scaling or not. Without it, the driver is unusable and thus will not
load. This check also prevents the driver from loading in guests and
thus not confuse users with misleading prints.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v4:
- Clean up the commit message (thanks Borislav Petkov)
- Drop the Fixes: tag (ditto)
- Link to v3: https://patch.msgid.link/20260721-amd-pstate-vm-v3-1-8b59574fb714@rong.moe

Changes in v3:
- Move the check into amd_cppc_supported() and add a pr_debug_once()
  message (thanks K Prateek Nayak and Mario Limonciello)
  - The check is added before the existing family 17h model 0h-2Fh one,
    as print_cpu_info() already shows family, model, and stepping, and
    will help debugging even if the new check overrides the existing
    one, but not vice versa
- Link to v2: https://patch.msgid.link/20260718-amd-pstate-vm-v2-1-6ed5f3b2c89e@rong.moe

Changes in v2:
- Check for X86_FEATURE_HW_PSTATE instead of X86_FEATURE_HYPERVISOR
  (thanks K Prateek Nayak)
- Remove the check against Xen dom0, as it doesn't need the amd-pstate
  driver (thanks Jason Andryuk)
- Reword comments and the commit message
- Remove Gautham R. Shenoy from the To list due to email bounces
- Link to v1: https://patch.msgid.link/20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a74a4cf99d22..b0b651380732 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -2167,6 +2167,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 };
 
 /*
+ * Processors without frequency scaling support can't do CPPC.
  * CPPC function is not supported for family ID 17H with model_ID ranging from 0x10 to 0x2F.
  * show the debug message that helps to check if the CPU has CPPC support for loading issue.
  */
@@ -2175,6 +2176,11 @@ static bool amd_cppc_supported(void)
 	struct cpuinfo_x86 *c = &cpu_data(0);
 	bool warn = false;
 
+	if (!cpu_feature_enabled(X86_FEATURE_HW_PSTATE)) {
+		pr_debug_once("frequency scaling is not supported by the processor\n");
+		return false;
+	}
+
 	if ((boot_cpu_data.x86 == 0x17) && (boot_cpu_data.x86_model < 0x30)) {
 		pr_debug_once("CPPC feature is not supported by the processor\n");
 		return false;

---
base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
change-id: 1cc24037-amd-pstate-vm-d6ab4c959bd3

Thanks,
Rong

