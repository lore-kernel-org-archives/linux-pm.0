Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4F5317166
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786427426; cv=none; b=ZByoVV0VajZC2bwl3NtxI/OzEq0rcmQKGDUdH1Ys87knV19voq+RDiRwUlez0TEXJk9p2M2La/ed2upxDZKrnDqYupU7gheZX3+VJTzJ05N+TjUZl3c1/iZoIpo1nouS5teAVN+Yvxgb7+BOsZw/0P5vls4+f66aGQWyTG+POQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786427426; c=relaxed/simple;
	bh=n3vG1Ouz3Z5dfG3sO3PGglSgElYx/5po7OR/QX+HXZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oSsxdLn9b0m277LYCEM4C1q8UxyCchaCjxAChtQuhYCRRCynESLj+KWsrpHeP6cFsEsDngYkdTv3frFD3cDBS30L8DtNqjPtDwlPpAZMBagDrMtlZzAZYUmzVqjRuIsVvczXBZDTFSDF/0pZMIJ6PLSVHog0VAs9+XUXC2qC6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XtB4JrBo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NeMA9xrV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XtB4JrBo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NeMA9xrV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AMps8m3047691
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 05:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	koBYLSdR313PhDwt5MfsU4zfM6HkL0IaObNIbdT0org=; b=XtB4JrBo2XD0SHa3
	+Kk/TxytdY7ZFEVyyc4+TfwHpqpHWjnl/tvSWiybuZaDhKzXp2IT7eCcOBorrA5C
	qkSyTutzdI8U4FYZ2Iumro+mnHDktR0RqhdKM9RRfjx8PsZaSpU3ug4Fl+TAQte9
	rQWUf+k3lbIpw4a6od6NmlNphvD8U7/duu5+QyhBU38QWjqwoi2aQuENuM8LYQeA
	A0tAyUt5qDAWg0q47PqqINmc3zmsnHNieaG1LllgcApl49h3rcg0cWv4YQgn7v4x
	C6FONU8wa1+N9NXoiA4i+Goq++azwJ0QwswAbEADy4xJ2kislqNycJSPhYZa/tYc
	nxBlRQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk22kjw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 05:50:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f0fe57470so647775a91.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 22:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786427424; x=1787032224; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=koBYLSdR313PhDwt5MfsU4zfM6HkL0IaObNIbdT0org=;
        b=NeMA9xrVX53a89W2bxxfbQVi2zyiTfMPLDi7Q25ReQyJ8lwPtUaMJ8aNiD0X2hbzkR
         xPkwLTtUElEfsbXtmbYZyWh1ZbmDqhE5JKJu2aQSL7oNx2G8T+Ba6iETHWjCLVxzMAyu
         EV8uhThMM9LqqvXUEonYpKSuVweCKhRks9uHTx+uvWWeWS884RySXuc2/uiPf3z44hnM
         yT+V0I4odDzdHh/kZKFi00en4yqyB+JAMA1mfuKGIB4rQlQD5dnDWMESh/lXJTZxPGrm
         Qrsilqf/YBBHUt+v+ay0RkDkqWp0dG4NMdJgwnOkWQHFWsn5L+XNL87W2UjQsoH3B+TK
         8IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786427424; x=1787032224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=koBYLSdR313PhDwt5MfsU4zfM6HkL0IaObNIbdT0org=;
        b=hRiSzyWzPwO7fuKw++FcjgOY/Gzjjea5Ve25TZbJ/9XEmlDGnzyt1CRd6fFDrtLamn
         vbHDoymg3yVPdEPMzbZikSg7Ywh+2mWBQcVRCkSi2qXQp3x17fcgmNX7g80V2kxj5rBh
         ENjqEAk+fCAfbD1www7xGVN7DtC44p3ZnHY2Z7+HBJlDasoM5dPmjUvkuiKu8H+crMuA
         u1GSXsaKlltw8n3LbUkfGJTnkQJBnteCeyRVFqb2cdaQBdibqWoAV4jwNCnzldHAPGcF
         uoyRWEKBb6e1YQ+dufkSYgccz6UFIS578U0YKOAVyb2GHK/yUXBdPNV9V8T7Lun6D2KZ
         YrfA==
X-Gm-Message-State: AOJu0YyOsB4ZD910sm63j6TK2i3YletT0HCmRKjDvwYuTsm2GCLOhzz3
	e9TI17V6x+GdCUJDfPSVc+f6Wi03B8NyxEkYcgh4WlJzx2oU3G4CVeJLpijpSkDvi7ZeHhAq66/
	CFYBSkaK4xApWNqxRcesTByC5OR4dhxoMyL137p34AweAdkia1Z6h4WnareRjp9/TMP0cbQ==
X-Gm-Gg: AR+sD116XFR0r+d3DcOkjp+xC9vg/ipUXcjBa+frLxNEoW3ZqbdE/OQco5CfZH79f9J
	gdvak2mtQfXx3SwRpiRDgbv9bTb6zLODBbAWAp26+xRm3WXgbXGu82jJ+L/1yOF3LTNmc58fQsd
	nRVMDIrcR4abH8N69FpZbhJMdfVd25u41DTFD+Of9cwi/1DOt9CaGaGg1q6lo6YKH1r1Qix9lwC
	bp8Ydfodw8TwMz3ArDj8CzpNOcBQy9edG8tSN72yKH8ml14m8ZWvZnJwfkrlm1kPx9UicPK8nG1
	5YzgPMCz8wUGGPYhLIDWqBsrLCD2LJ7VWuLmSpLc/z5qBnHGl+ieiJBFZniVMdYuBIgO3WFNGm5
	cllPk1Fsvzt+RDfK4JPHjmIetQftf
X-Received: by 2002:a17:90b:442f:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-392ed2b2696mr174463a91.0.1786427423710;
        Mon, 10 Aug 2026 22:50:23 -0700 (PDT)
X-Received: by 2002:a17:90b:442f:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-392ed2b2696mr174449a91.0.1786427423254;
        Mon, 10 Aug 2026 22:50:23 -0700 (PDT)
Received: from hu-mkshah-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d534ab78sm2062289a91.12.2026.08.10.22.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 22:50:22 -0700 (PDT)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 11:20:01 +0530
Subject: [PATCH 1/2] cpuidle: psci: Start CPU-cluster pmdomain OFF when OSI
 is used
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-domain_off_ss3-v1-1-6a0a0fc023f5@oss.qualcomm.com>
References: <20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com>
In-Reply-To: <20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786427415; l=3853;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=n3vG1Ouz3Z5dfG3sO3PGglSgElYx/5po7OR/QX+HXZw=;
 b=hp47SzX2oSIQQDth+AiGTQrZv0cU9EsBKhRwhlX8jToxrRKHixorXMnct9hWJVur1NdokWpa4
 oPSV85nibLFCpBmWqKbcVkB8G0dsd9tujf0ueoPWX8fdo6vvEH5wG+u
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA0NiBTYWx0ZWRfX47n0eDdgl4cr
 RVSxgRCyrSa6LCOMUdmLICvO4ucKMefwXCNTb81W7YxtK6n0X2DC22UAcF/GnmNkx6zSLlfBNHo
 9h/3L/9LnT0rxGnxJx4SqjriZX69XTk=
X-Proofpoint-GUID: EAgJmj1uhsSqJijiJS8WcgEX5q-m2BKo
X-Proofpoint-ORIG-GUID: EAgJmj1uhsSqJijiJS8WcgEX5q-m2BKo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA0NiBTYWx0ZWRfX9ezx5jPcy0t4
 oDPgLsCGq3hdUN/VHqeZ35nEYhtxp/jdrALueH61rb3efpDnZIgMGCokb5QcmvGks0vGs29kvDD
 AE0g+3+QXBZ0mxoI9IbWiq7yLCW+AnMr1qBIC94+qwq4s9fED3xwIbpzXEKNApb7uqP4Sb4LIsk
 CWTtv877L+EPJw49qp7IbtsX/KpfhwKtprVe//uMj+O+tbyc41E6i4okPx1ro47azYtSxH26BJY
 0TlwcRlZIZ641f6gf6CU1zChnKhF1K0Fo0p7DxkzPB/4kTK/H720AtM/JMjGQTxn0pTmjB4yTyL
 GVmOoYf2wL0XaS8pYBqb4JTDDpFH5iXFm4881hF8G33b5sY272hzKBaQK8qGY2rplO9FGeOgQCx
 fE9i4ViYcMgBsjoWOI4rIFQ0x2m4/wsVSAhTrbVUrgjXqrMI9twjfTielZTt3nfiUq/C3Edw4Gn
 0dye31WGyqJLDkoJ7Qw==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=6a7ab820 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Ub2yIDUOchdfQrooBeMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110046

psci_pd_init() always calls pm_genpd_init() with is_off=false, so a
CPU-cluster pmdomain is marked ON at creation regardless of whether any
CPU has actually powered it on yet. The pmdomain's own status tracking
(and the power-on notifier chain fired from _genpd_power_on()) is
therefore wrong from the outset for OSI mode.

A concrete example: hamoa has 3 CPU clusters, each with 4 CPUs, under a
single parent system-level pmdomain. Passing "maxcpus=4" on the kernel
command line limits boot to the first 4 CPUs, so only cluster0 is ever
actually powered on. Without this fix, cluster1 and cluster2 are still
marked ON at creation regardless, since is_off is always false. Because
none of their CPUs ever come online, neither dt_idle_attach_cpu() nor
psci_idle_cpuhp_up() ever fires for them, so nothing subsequently
drives those two domains to OFF - they stay marked ON for as long as
the system runs. When cluster0's CPUs go idle and its pmdomain is
powered off, the parent system-level pmdomain still sees cluster1 and
cluster2 as ON and therefore never selects a system-level idle state,
even though no CPU in those two clusters ever executed.

Starting the domain OFF is safe under OSI:

 - For CPUs already online by the time this driver probes,
   dt_idle_attach_cpu() explicitly checks cpu_online() and calls
   pm_runtime_get_sync() on the CPU's attach device, which resolves to
   this same pmdomain and drives a real power-on immediately. This runs
   from psci_cpuidle_probe(), a device_initcall, strictly after
   psci_idle_init_domains()'s core_initcall has already created and
   marked off every pmdomain, so there is no window where an online
   CPU's domain is left off with nothing left to turn it on.

 - For CPUs that come online later, psci_idle_cpuhp_up() (registered
   via cpuhp_setup_state_nocalls(), which never invokes the callback
   for already-online CPUs at registration time) powers the domain on
   through the normal cpuhp AP_ONLINE path.

Gate this on use_osi rather than applying it unconditionally: in
non-OSI mode psci_pd_init() sets GENPD_FLAG_ALWAYS_ON, which
independently blocks genpd_power_off() regardless of is_off, so the
domain can never really be off there and marking it is_off=true would
be misleading noise with no effect.

Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index b9e4ad7d43a3..fab9de648b17 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -78,7 +78,19 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	/* Use governor for CPU PM domains if it has some states to manage. */
 	pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
 
-	ret = pm_genpd_init(pd, pd_gov, false);
+	/*
+	 * Start the domain in the OFF state when OSI is in use, so that
+	 * genpd's own status tracking (and its power-on notifier chain)
+	 * reflects reality from the outset instead of reporting ON before
+	 * any CPU in the domain has actually requested it. This is safe:
+	 * dt_idle_attach_cpu() runtime-resumes the domain for every CPU
+	 * that is already online by the time this driver probes, and the
+	 * PSCI cpuidle cpuhp callbacks power it on/off for CPUs that come
+	 * online/offline afterwards. When OSI isn't in use, GENPD_FLAG_ALWAYS_ON
+	 * above keeps the domain powered regardless of is_off, so this has
+	 * no effect there.
+	 */
+	ret = pm_genpd_init(pd, pd_gov, use_osi);
 	if (ret)
 		goto free_pd_prov;
 

-- 
2.43.0

