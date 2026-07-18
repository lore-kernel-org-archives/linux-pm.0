Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D9800;
	Sat, 18 Jul 2026 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784387769; cv=pass; b=lE43eFeBuVMlQr8mx61CySZAkjhKvoGuxd/bjYs/5KL1DkKskJIkZne/VMFY76+Zle4pFgDzfxfsi0l257LFznRMTCVjaycvnjH2vFSUHS7ay2Xid+xG/Z45bOY0DAoE7ZVfte3CKHrPEZtoLqFfrKwY2McPy4EoO7+9+4/eUcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784387769; c=relaxed/simple;
	bh=HBEWICtuRtz9zqkP4FsQP/BxXLXbnNsiZWT0nD8ABhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gNM889cZLCHC9IWFoftTmL/3SsfOjYEOZzDmdSXkNe4yCWMW2iTsGY60rMmwlgWnTIIJrJg8rz5RLF02LO4pMDDJ85a8ADvo9dN0lYLXsGi4hll0O5mn4AcGmZflZhV7YGyjPbj8NoElMmOupdAllUc7J8kMiGXuKrkNgBcN+pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=KQoFZ5rF; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="KQoFZ5rF"
ARC-Seal: i=1; a=rsa-sha256; t=1784387751; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MfnFTqp5iD0ZNDecuROSkrMt0slBAZ7XIOvJyybDVcwfgUqiNk5CjQ2ZVblDIg5Hln2p5SV8/8dxa/o/G6ndofnH41bc72gxxUhL7pcf7nVxj/4jAiP/hPKWhBXBbMyDWpxqCRYFW8KQb+3i2EfTcQNSXn4lGYlUhhTyvn3Rnms=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784387751; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y/Ony+SokYZpBQcQwLEYM8VWsVMYJa/ukac3m7/HK0c=; 
	b=mIcaqGG7+P80vEy2/H1Ow7d3+4vigHH7dtVCFEpuHViW/4UnkZ5F35OVqSLLJwpEjldTtGVYFjN9SXLKbQeGUJrxNpo3/Ey1pfX/1v798HyVHIabG7JL6PhEk5tKJ/3jksHzoQa5vkwbADMif2p/SlAC7BmWuvYBE/+H/vDGCT4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784387751;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=Y/Ony+SokYZpBQcQwLEYM8VWsVMYJa/ukac3m7/HK0c=;
	b=KQoFZ5rFLT6Nc5kURV9ZiJHxyW6pxGDScBbleW9s/UIttpCEy+LovpzK4Nt3VuXF
	VrpcwPqrW1hp9Np8HQv1GsGFaZhtPMfPryLJ4Zo4KZT3QvW567z4aNPxVrlUg9RSICJ
	97Eebi7+vcJbhz3WzfOjVcWiywtv9yTIAKfI3MBObjCIL+nVMq08MIG16GOih0V1uLS
	ym9Q9QFW8Ta6XHxPMMK34tyoScxrMjPqnuoOzXSQrAWw+8mMkxQuBzrJDRIrmc1tC0x
	4GacTS9ToiE0E5/agO45hx/IuBEbfo+etG9OXpDjPoDfAFW/89HclNP0p/WSYsjXsYj
	4CCJdl7QlQ==
Received: by mx.zohomail.com with SMTPS id 1784387748536773.5587705371275;
	Sat, 18 Jul 2026 08:15:48 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Sat, 18 Jul 2026 23:15:31 +0800
Subject: [PATCH v2] cpufreq/amd-pstate: Bail out early if
 !X86_FEATURE_HW_PSTATE
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-amd-pstate-vm-v2-1-6ed5f3b2c89e@rong.moe>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NQQ6CMBBFr2Jm7RhasA2uvIdhUaYD1ARK2tpoC
 HcXcOfyJe+/v0Dk4DjC7bRA4Oyi89MG8nwCGszUMzq7MQgiWRWlRjNanGMyiTGPaJVpK6qvdWt
 L2DZz4M69j96j+XF8tU+mtEd2Y3Ax+fA5DrPYPZCFVIUW6q+dBQqUhmptS+oU63vwU38ZPUOzr
 usX7y04XLsAAAA=
X-Change-ID: 1cc24037-amd-pstate-vm-d6ab4c959bd3
To: Huang Rui <ray.huang@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, 
 Jason Andryuk <jason.andryuk@amd.com>
Cc: Michael Kelley <mhklinux@outlook.com>, linux-pm@vger.kernel.org, 
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

X86_FEATURE_HW_PSTATE indicates if the platform supports frequency
scaling or not. It is disabled on virtualized platforms (namely, KVM and
Hyper-V have been reported to do so) and is always set on physical
platforms that support frequency scaling.

Check for X86_FEATURE_HW_PSTATE as a prerequisite and bail out early if
it's unsupported.

Fixes: cb817ec6673b ("cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported")
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v2:
- Check for X86_FEATURE_HW_PSTATE instead of X86_FEATURE_HYPERVISOR
  (thanks K Prateek Nayak)
- Remove the check against Xen dom0, as it doesn't need the amd-pstate
  driver (thanks Jason Andryuk)
- Reword comments and the commit message
- Remove Gautham R. Shenoy from the To list due to email bounces
- Link to v1: https://patch.msgid.link/20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe
---
 drivers/cpufreq/amd-pstate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a74a4cf99d22..877b4b30ecd0 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -2228,6 +2228,13 @@ static int __init amd_pstate_init(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return -ENODEV;
 
+	/*
+	 * Do not continue on the following checks and emit bogus warning
+	 * messages if the platform doesn't support frequency scaling at all.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_HW_PSTATE))
+		return -ENODEV;
+
 	/* show debug message only if CPPC is not supported */
 	if (!amd_cppc_supported())
 		return -EOPNOTSUPP;

---
base-commit: 94515f3a7d4256a5062176b7d6ed0471938cd51a
change-id: 1cc24037-amd-pstate-vm-d6ab4c959bd3

Thanks,
Rong

