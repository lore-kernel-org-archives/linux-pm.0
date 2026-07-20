Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E60A22A7F0;
	Mon, 20 Jul 2026 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784573287; cv=pass; b=MrxpberO7/F8tRK2qYTiQ8PwR6aGZJq6lPWVHOTjXCJMJVytID1biQyChDS7J+0yNzBiXzZcMYQ55OEA6Tuvze0fvXE9F6MTYn/f2NGhCCG+FF05daf0OHPZaMH4/ZKbKTin/hXnnYIpQBo/fqdaqvb5D2aXTPJG5XjZ+kTBkK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784573287; c=relaxed/simple;
	bh=OPcsPoeA/U/4i9WetJ1f5Pw9Ta7GG4Q9eChPArb6Tzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dm4AocJC+xwIEyqNY1RkCaoJnffCNqOE3Le2IblY/sMwxwhj2lgqK+0Do7qjxMpUUEZf8M4Qm/OX0olFsf5AP6q3KAiaNMOuDGu7YAc6ZJecxzLXRsLVb8g2mEi9V0ko9t2+5ehrrlBTZYjV4Oh9gMKGGfLKXTt8TR6Ohgtof2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=RgcdYV+e; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="RgcdYV+e"
ARC-Seal: i=1; a=rsa-sha256; t=1784573267; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Aj6nyxSaVBXYDbLZ14kzaMOBiH8P+eUID2qm6BlaneTIKPg+7qDLWC5VnyQ9EMJ5DXjEGd4RjCuOkmaLNBJHcTOdlV6ZXxPy6PuyWnKBtyhOgQiIVVZZpEWf5o7QHHpEJA9UHYvr9DHIm9GwQmX2UWvONJBmcDhUMpuWiElLVhk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784573267; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pnExjSSkB2UcP0HCicuBWYVaWVapSMXQD9XXVqQdPII=; 
	b=dR7i0yIvCpAxDeFNouojprdTZ+T2Iz/gFQAmHsa1jVASmCzGVKDKF2HEFfdx/8v929zJ8ZVZKXAP8Z+j58jt7Qxp0NAU2mVpYdwXZFLsj60rAUzO9N9GjRz2TtQmDC66a5vByRgWlEmnfj0b7hqscmr38P0BeQ0lh3T83bWvOOM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784573267;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=pnExjSSkB2UcP0HCicuBWYVaWVapSMXQD9XXVqQdPII=;
	b=RgcdYV+eYB18AkoYqyl7EAhkeoFtSRBRIqRqL7ZWpg3f+Zz/2H83nc+laUrQrrQh
	Hpil0mQmMaw/8rmw1SIMpk7QHJVDFDnQUIalC4ULvB8cHx+RXD7YnR4xGVe7tXzbhY4
	0iTPb8LFimCrTFQOTNSvqTnxioAfh/DDywlS84imjoVclTXqUxDrRMSQdEQnJlPtjyL
	fk4WEh0xtjIHb9WU5hZSycbj5pRbC3rQaH9XMazaoQRYqx+mlbjTR4WRONTpta15BxT
	gi1kQ4XifKUCNBm9qqaT57jS63yKjqAmqrxKdwSUWLg3fA2c0pYIJW9fA2VcfF/0Yv9
	qYrMi+7cxg==
Received: by mx.zohomail.com with SMTPS id 1784573264848433.9060323803228;
	Mon, 20 Jul 2026 11:47:44 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Tue, 21 Jul 2026 02:47:22 +0800
Subject: [PATCH v3] cpufreq/amd-pstate: Bail out early if
 !X86_FEATURE_HW_PSTATE
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-amd-pstate-vm-v3-1-8b59574fb714@rong.moe>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NQQ6DIBQFr2L+ujQCCtJV79F0gfBVmigGLGljv
 HvVbozLSd7MmyFicBjhls0QMLno/LACv2RgOj20SJxdGagxrMi5JLq3ZIyTnpCknlih68KoUtW
 Ww+qMARv32XuP55/ju36hmbbItuhcnHz47oeJbjtgORO5pOLUTpRQwrRR0nLTCJT34If22nuEL
 Z3YUa7OMltlgbZseM1MpfAgL8vyA9zz1Z34AAAA
X-Change-ID: 1cc24037-amd-pstate-vm-d6ab4c959bd3
To: Huang Rui <ray.huang@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, 
 Jason Andryuk <jason.andryuk@amd.com>
Cc: Michael Kelley <mhklinux@outlook.com>, 
 Michael Kelley <mhklkml@zohomail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-4217c
X-ZohoMailClient: External

When booting a VM that simulates or passes-through a relatively new CPU
model, these warning messages are printed to kmsg:

    amd_pstate: The CPPC feature is supported but currently disabled by the BIOS.
    Please enable it if your BIOS has the CPPC option.
    amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

Technically the check is not wrong and acts as a safetynet that prevents
the driver from being registered incorrectly, but the warning messages
are noisy and incorrect, as the CPPC feature is neither supported in a
VM nor disabled by the VM's BIOS.

The CPPC feature is disabled by the hypervisor as it makes no sense to
expose them to guests. It creates a paradox that the same kernel both
disables CPPC as a hypervisor (KVM) and warns about it being disabled
as a guest.

X86_FEATURE_HW_PSTATE indicates if the processor supports frequency
scaling or not. It is disabled on virtualized platforms (namely, KVM and
Hyper-V have been reported to do so) and is always set on physical
platforms that support frequency scaling.

Check for X86_FEATURE_HW_PSTATE as a prerequisite and bail out early if
it's unsupported. A debug message is also added to help debug driver
loading issues.

Fixes: cb817ec6673b ("cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported")
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Rong Zhang <i@rong.moe>
---
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
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 1cc24037-amd-pstate-vm-d6ab4c959bd3

Thanks,
Rong

