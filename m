Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF0D3A4F23;
	Wed, 11 Mar 2026 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237729; cv=fail; b=Inyx+E5EVNbit2BQxOAY4Hohk9hDy/ntFWGSU1//0VQrCCmOV036saoY4pvhLp5pCmNVRPB9rFTZW1ObccfadXS7cYVTsjxXdG2Mtp3nhtE9P4CI6MO4ApyiM+incYmzTRPoneR4Llm6cb0N0U8+xYHI2SUzgheo+kji/AHGNmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237729; c=relaxed/simple;
	bh=lDNuAUYL83vsdV2My3Y+jWemRdOWw5ge8IGu3lAKx7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxCvFxw/LW330WCUVHJUjVvdf6i2qCVagev121BNIy5bV6GEHiJJgIwfpHnpIR0XJ3ay66C/Gkfw0T994D6OltEX6Be9xshkODChHyqTMHsNFXx9xIb84vGRvsRL74TVvJ1YmpQloXRdJa5/KABb+0EGa+3ySEg88LxKI36siHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I8fhdAki; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I8fhdAki"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6ksB31N5JTFUWcV8Tru3LldaBeEezCODFOyS6K7RQNX4X3QQjkZFWl1Ut39KPvpxlJIDt5UmQ80+DrHIZJlibBbg/cHR/iYzgw7DpKOAC11LeYYQr67tDIJuilHdR8G1FOxMfB6U67CUQPfPpXbLvjZm7RxojYkcca1sLCrCtC8PRuj3hs7Oiad4LkaaG6YDN3iM72FTbMLbSJnJaRG2nP4wD7FrCCZSAeAzwC4KZPAtS/ZpUnHb08GnE1qMunuyRK+Eb9gsPaZMq06TdMxdhNIJlAt9NOZYEVbvB0FKgbvmFDqRb0uWkyKm1KZZJ7Bq8a4emnrD7cXPdu8NJNtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ca4rhd1lnPRTFpPzaFHJgfMFIvhdJ/XPd9UWRQUGqg=;
 b=OviWVgqoWvRfDQESm3ASDjXH4vfxbdxo7aajdBRiqe11j2yZxbvq+b1IAcc+nLFQ6QJTq3PrgQ1ll7Llapxdec/8hOHkOw7642EZ1q6pbxZy7bRrXw/IyFdfBt39Pg6zn8NNXKKPHyzF0TyxggAYMtLowApckOXcWF0OO9+LmIrdy1he5yLfHPpZwAZBrDKh45QYFT/U5nKcc2ifan0u8eUU49Y1bNfQ40h90BA9GJsgNWTMJsMZ33u5sXnzF+Iind67kjlxJMVrItjtxf075fYKl03m8dck7k6IyRMA3aZ2kGisOaIqqHrUDc6eGmvsWbpteAO2cWlC7l0aCmpa1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ca4rhd1lnPRTFpPzaFHJgfMFIvhdJ/XPd9UWRQUGqg=;
 b=I8fhdAkiPILXctjjiPRcDpnV2EeqYYLH3H/SEq0SsWWzu6g6ARnf1z3xKjWpvh1LwzB4qvfuU5vCdg0WDss8H8LErSKu2RrW03hIJ9F8Ia6uhmAdY+rzq5L9RWjpb+johAVvR4ynE8TZQwQG870n4mzsHpni3PiNIO/Rdzdj/g8=
Received: from SJ0PR13CA0032.namprd13.prod.outlook.com (2603:10b6:a03:2c2::7)
 by CH1PR12MB9599.namprd12.prod.outlook.com (2603:10b6:610:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 14:01:52 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::2b) by SJ0PR13CA0032.outlook.office365.com
 (2603:10b6:a03:2c2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Wed,
 11 Mar 2026 14:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 14:01:51 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 09:01:47 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>
Subject: [PATCH v2 4/9] x86/cpufeatures: Add AMD CPPC Performance Priority feature
Date: Wed, 11 Mar 2026 19:31:11 +0530
Message-ID: <20260311140116.19604-5-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311140116.19604-1-gautham.shenoy@amd.com>
References: <20260311140116.19604-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CH1PR12MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fadb0c9-dff3-47a9-cec7-08de7f76bed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SoXitwqZEUGjIJ34MWVblidLYIZ73RxRHmbk7HUmI35Tp4UDeiS7PEcRvdjR+lTOiqn8uItkzKUXU26kJqWE/W0nh8SUFUfCc+41svT9rMtXjSRoYx1oaRGIpJR11qCTQkBAmZnYxu8MgcoQ7z6VPwK/vqmU/usDEsDV/eQQjsGzE3vn6b1hoje61iaKjVQRloFXonefqP/ZtFl1kGaU/N+X0JEmPT3Msiw0s/UyMHDwn2rWId2FS3xyPGY5AiYgGECn6Kmgdky4aQQ5eYlANhDAP4bMzbc4NitUaRX+EoTykKy7+i3H8MeW0D4348oVAwpMYWm6py9fyLS7GFgK63q/K7/sF67pfRrMiwSZFfWsY6rYhSCtO4CwfA0bhp3HqQAxe6yxrx9RgAEpbIrVLtkcMo6UrmyH4p7dSdz7h/vtY3Z8+bqQtuLF6xtjhXAhbNGz6zG/2VwqU0fMXuaKK5c5lqz1zyvGcg1A3aYTTyrnZiRns24jZAjOiTP0G/cuTyn4blkbeRtpvw2Qm10zDjggz2e7hmmwGkzy7jw1P1Z82Isa1j+c2fqwIKgjGTK1mEKAAzLDsU1wFXKswcNIGR2Zj3ZYPlI6Vm2u9RlcjwnPpC0/jI2WFHAThHabuIcFYAV7JzG1GoN6X0MFVbLz6QGvXoaDFToOMXFWHhneWA3bnM1ICNilgx+VG2c5GDy5bxE8Y9fu1rpr6bWJcXC7Zfl27TLNIyqSgxv0ptA1bhx187x//tNZZAiYwXVwOWTjoCgWBgdyh7JM8Hq0nHwVVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EaJ7dZ3deRSwV/ZLQLbS3VegbASljviGotfv1FjpA4COZrmauh8eo5ioJK3EQZi987ufnQeFyHMoiKgMBjzIBbsSMogKMmH8tdGOAVAJ+CNjgd81lcnjJoGf1FA88B3qde/514CYkrR5+9CBoVIV4yQ6QRdWqA7pMORocjOvX2T6RLOHe6NjsmqWRA6FBRR1vGgs88H+YUtr1UZNcMfVZGKlKNPlkwdfN9AcDuiVBULih1R3GN/KET7bMBDHdGjtC8ZFne1/t78bIfWMvxNl0QZqkvZlvTfit1yyOSkSyIpM2lUOXzm4fSi4kWZ4SqG/4zMOoWOB732mGq93+iEa75NE7f8gRj/OmlVegHWg1ADqwFuAamoS+g5cgNhxrInXL023u9ULNadGaXGAyeLiFebPXZHd+pWA1zHvJcp/HDIEtR6dZcFMVlmceC8e8NRh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 14:01:51.6702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fadb0c9-dff3-47a9-cec7-08de7f76bed6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9599

Some future AMD processors have feature named "CPPC Performance
Priority" which lets userspace specify different floor performance
levels for different CPUs. The platform firmware takes these different
floor performance levels into consideration while throttling the CPUs
under power/thermal constraints. The presence of this feature is
indicated by bit 16 of the EDX register for CPUID leaf
0x80000007. More details can be found in AMD Publication titled "AMD64
Collaborative Processor Performance Control (CPPC) Performance
Priority" Revision 1.10.

Define a new feature bit named X86_FEATURE_CPPC_PERF_PRIO to map to
CPUID 0x80000007.EDX[16].

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
Link to AMD publication describing this feature: https://docs.amd.com/v/u/en-US/69206_1.10_AMD64_CPPC_PUB

 arch/x86/include/asm/cpufeatures.h       | 2 +-
 arch/x86/kernel/cpu/scattered.c          | 1 +
 tools/arch/x86/include/asm/cpufeatures.h | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dbe104df339b8..86d17b195e794 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -415,7 +415,7 @@
  */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* "overflow_recov" MCA overflow recovery support */
 #define X86_FEATURE_SUCCOR		(17*32+ 1) /* "succor" Uncorrectable error containment and recovery */
-
+#define X86_FEATURE_CPPC_PERF_PRIO	(17*32+ 2) /* CPPC Floor Perf support */
 #define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 42c7eac0c387b..837d6a4b0c282 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -52,6 +52,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CPB,			CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,		CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_AMD_FAST_CPPC,		CPUID_EDX, 15, 0x80000007, 0 },
+	{ X86_FEATURE_CPPC_PERF_PRIO,		CPUID_EDX, 16, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,			CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_X2AVIC_EXT,		CPUID_ECX,  6, 0x8000000a, 0 },
 	{ X86_FEATURE_COHERENCY_SFW_NO,		CPUID_EBX, 31, 0x8000001f, 0 },
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index c3b53beb13007..1f1aeeb151337 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -414,7 +414,7 @@
  */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* "overflow_recov" MCA overflow recovery support */
 #define X86_FEATURE_SUCCOR		(17*32+ 1) /* "succor" Uncorrectable error containment and recovery */
-
+#define X86_FEATURE_CPPC_PERF_PRIO	(17*32+ 2) /* CPPC Floor Perf support */
 #define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
-- 
2.34.1

