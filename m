Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972143C7D9
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341905; cv=none; b=GbqJlKFIfD0AEVtX3VpskMY135a4f9t79O9EQzzhEBjPxAezMvzjd2HlToznD0KNmE56ldSB0RALFR8gtB6fw6k22NqewpHLtFEyZYtQpOvzY4hpRSC+QSRLEREhb38421+DQUEiZZVkBSlmLzIpeK/VgpiVspPbG79BoPJBX9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341905; c=relaxed/simple;
	bh=ZvC54swIjtoLdWic7mjkHUk98Z7cygXvR6WiVNV09vM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KpLQ/9W1wk1HgArcCtkH+1MXzwkA6j+qwQyBzc9mc4ZoqOg7+m/akSDd6/RA8IqJc1id/VsF7yYABIWW/3xsS+JfqRfVDy4rUhi/AdCnGgMnnHsq4MshyH73WIyfKPK/JA9KmOyfosXYxLvZO6Pu8j0RCIqbPTtxUss/1uN9aTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jHERcCvS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QkANn72X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jHERcCvS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QkANn72X"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxKxK361446
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 12:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9qaZhnJqkpFuXNUQTMvf64DqKP1Gcowxx+UUDue+d/k=; b=jHERcCvSBjEX85+G
	wv+iLnRT6hHpxDdY0dS7R0g8NO+qYXJwcgWGOEQO7ZGvZOxy0Q7dy0Hba2un1PBx
	YmlYOgwY9VTQJpR7MOI1xAGU9FfZOlA+exUr6cSSSKOpYVYiMtNM2Oi81hDyX1lf
	rKokYFp+tnknPpil7j22bPQBqfzVNGQF+MkNqwFAcSDBWFQJvlTIgsN/6YOkjNfB
	2cVS3wfKyk97kCwPoRu+KpyRomaPWnLWCcagvpdzWONQt1gYmYfru2mmiQe7+FzH
	cpGKefaudU3KsN9qiar8tJGKvN6TLHIebow4FloHMH9JoqRDGUV9WltOTCKn9V5d
	TJqHog==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h512av-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 12:44:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e7ee64b25so504363685a.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 05:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341896; x=1783946696; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9qaZhnJqkpFuXNUQTMvf64DqKP1Gcowxx+UUDue+d/k=;
        b=QkANn72XZd5vXWpV3MuOIe18UF4UqyQ5Di+9mfg34jxefoNQ8FQNORRk0+k0KJ2Wnl
         cT8J9DsrGAzuQ6dgkqc7XaSU7krd5DyayyCy0ifBgssufNK1yAW9pVjHNF/ZjFezTrNu
         WfGH6QRbzNYCaNI7zudxSGzxC/6tqAmFPvMBf3gnrhxHyCI30MKXMxaqx3HVM19BwmuP
         Jw7fkXwqLDzq9sep51rF4OE6+m1XeWMZJyNhVqJz8YIba3R1bddyUfT3plTjytYyjqIR
         e1371NE+f5FyJWbBrg4r3Y/SD2hTk0965RlTDyeOBUbCJplqcbotbAzokCQilFseY+sO
         xMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341896; x=1783946696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9qaZhnJqkpFuXNUQTMvf64DqKP1Gcowxx+UUDue+d/k=;
        b=suM1P0eEQ0u/VJcS/OQ+PBw7myDDjyym2bpXy/J++OmrwfW+ChFwJ2R0+CJ9A16zn8
         vxNQhaed22moOGcfD1ct7Dk5sqwTXcNVPwbYkuzo+ZXAMrFYxtE+ALpyH65erYm7ChDr
         JPpbTwFYwFzGn6oQwQRCywkaCT6AzVDzn/gdtycyMeZSN9GS2rklvUduqsHlJJPBT/sQ
         rBmrpGTNvVGk4/gO0fUSXefHcgBSqI2Wt159yWnLNS/ZWru/X57klAVmU1HwV8yvmhCc
         ATgvcmnGs796x7T6kfDMlApW2fLeoR2dJvVzCnTGO9zzdj+76m5a3j16H7wueSvxkmi0
         dCBA==
X-Forwarded-Encrypted: i=1; AHgh+RoYCukPZmGuqGgdrnk2cjEd9aR673+WM1zNB9/SU3gbBynh3dXR2ny28dF/AcWnT3eCkGd6H7iw1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0+EPfZdyhR7028cPNuYu0XUdQNtCWlJzYQpO2ErlYjGC8FVMN
	AB4Mn8injkUU7J8q2OFe5Oto7XZV8/SNloZoR/TMVcyYfZbvSgropVVt7FfobmDPofiANX9JEch
	+ST3Y4wHm/kMiFMVz0Ya7qlpMD1GdNAAJVA1hs/WZuF7g5e+quEvW0kyKdJQSpg==
X-Gm-Gg: AfdE7ck0dGTF9Sof7URoqc4KnwulUpXvVvw69G77Mydpgc+nGLdydjVKCeqMZo9v6n9
	EPkRg35zvMCQPaWgOUFhOUXhAUrdusitwg/DcmIdz6k46WxtY+6ewhL6U3WehXFv+lfeQhK5NMS
	xJ5Xvj6F1GCdNOhsxW3tw88MBrqJ8Bb1cYNBfY5h9F3uHoK9Vb0BRrh40DZa3AXmQlTNlbFJDie
	xaBfJJjqpS5AMq6Af4Ucd7Lqe83zRFkkthpU6dSynLu/KaPs7nxbS22TZtfR/gxduBmYqpHgKw3
	KYixGdVicg4P8bdx8MoY+QmoPwhSGiai3XB5b5rHgEz+YDsJpiCwV1sAE08cLFuSdYQPo5tbhGS
	4axqmYPqeTaHKt4YAZEm2D7kgWjfiZnkuuKR9/jnG
X-Received: by 2002:a05:620a:3710:b0:92e:8f7f:e51c with SMTP id af79cd13be357-92ebb60a590mr47343785a.53.1783341896240;
        Mon, 06 Jul 2026 05:44:56 -0700 (PDT)
X-Received: by 2002:a05:620a:3710:b0:92e:8f7f:e51c with SMTP id af79cd13be357-92ebb60a590mr47336285a.53.1783341895726;
        Mon, 06 Jul 2026 05:44:55 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:44:54 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:14 +0200
Subject: [PATCH v3 02/20] driver core: platform: provide
 platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-2-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mfd@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Manuel Ebner <manuelebner@mailbox.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZvC54swIjtoLdWic7mjkHUk98Z7cygXvR6WiVNV09vM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6MvV2oOwm8I6DyBnozXcyFSk9osOc4e2GH4g
 DJh76eJhECJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujLwAKCRAFnS7L/zaE
 w74pD/0f7wh768Ib4M3VSkBLYD7YQhvFxC2RY+MGZZP+VR1ZlemRCg9DeXdDdSnJSRDL3pft627
 DEvgLCBHwMElpwNSxsMWzEZhXl4R8IEAepNXoxVDXBTaHg3jl8EynFQEcWOeyg6HkMutGn3PMWF
 Wjlt68/Dol/bNnDNzQXKwG4dWAGXaKNln2ReAlzp6+08tymfFK0JoWQ+H+6GPkgzlbEX9CcVawD
 DKACpO8oiyAfEvlpIepcdNMc5lgfc3jv8gQ89TMoB5ERvz+ga96oVvwZQ3Q4ZPthgfz3wAkwDaB
 t8HLs9zAF3hupQ1CpfEox0RQEZDOa40SZwCBoEBN13BQBJ6AroiSGotGwZQQQ9aTWFrgZST4gJD
 SjTeZvyidzE87MxKKYkvxt8NanEKGvWihHCfVtXKt9yMdwr+hSGI96PqwLkOZqj3lOfEjy9zaLz
 Hj7GbbORQ7C6CvDBp8MHQJkkDKHKAE76uGcslbyA89nnGeDQPZQs8bXxFe5imODg7O3XpEA4Bee
 zhvO48lmfv/maHlAUdlg9HdHPPrS7lvHqXMB59rQYQQvr9aCZVoPUC/9+l0ig00xy3Q3MYp2FoT
 xOnkjupxjTDlvOP3c50tvOaWQ5NBcYARj08DrQz6gxBMoL8/9250lNxRls8cpxKP9h/3z02yi9F
 7ilBwmbOytfDmMw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: QtolGg6P_OBK7pUxdJSVK5nL1TYE5WEu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX4mCmc2KotSnD
 hz6U/qLhP3LlHjHqq3jqdD4nW9ReiL7nM+lXUx6quuDlLYSKIhr8cVAtnTvhpbLgpZFlWycXqpK
 fqaYs5yxvlIkEbXasiVCcT/kMJvShTo=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4ba348 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=b3CbU_ItAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=Q8RKEeUEMY9O-VPP2I0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX4KQG4qlZjVja
 hzz39hOEOeKpZX3Mgu6KcgOEij0aIeZ1/8FjHWDbrsReG4Ha22sGCFlmBjCr1UXvuczgCm4O1yI
 fFYxGbARI48R9HBPUEWqXEbTtMBhH0uIKweiO5WR8LK4UumDCuUoyABWwse5txFx0DHJB2ToOxc
 DND4023rWW/lCu03hGHrmkT2f7xnJn7V8L0uUdoGogX4SVwi+Ey9kXG7EMnxDVACpi6gOMuByoW
 PZ2hd+HN+q6FZxOPdcDe6YL93IlNOFCnXsxz+2Om+my0P/XeZrl48oW4ltVPwcL+8MZ4JRR6cid
 Qc/pMpjGQx1rAZUJpO6+0tnRLFaNVPSpJ3WHDYRWKohfLVkH2ShsgTBTzQS1vd6kRH8IRMmV8hr
 yMaS4MC8Tw3sGIVTtCtaLulaYRqKDeCrO9Nj1ILHkaVgezXuajXUNzYAZsUdrccPThFuqojLFFm
 RDjlnM8fiUtnyMwAvVw==
X-Proofpoint-ORIG-GUID: QtolGg6P_OBK7pUxdJSVK5nL1TYE5WEu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060129

Encapsulate the reference counting logic for OF nodes assigned to
platform devices created with platform_device_alloc() in a helper
function. Make the kerneldoc state that this is the proper interface for
assigning OF nodes to dynamically allocated platform devices. This will
allow us to switch to counting the references of the device's firmware
nodes, not only the OF nodes.

Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 18 ++++++++++++++++++
 include/linux/platform_device.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index fb9120b0bcfe0e7dd9dfc0d29b91e0ad40a01440..3188d5aba5f90622f821c695049cacda030204fb 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -693,6 +693,24 @@ int platform_device_add_data(struct platform_device *pdev, const void *data,
 }
 EXPORT_SYMBOL_GPL(platform_device_add_data);
 
+/**
+ * platform_device_set_of_node - assign an OF node to device
+ * @pdev: platform device to add the node for
+ * @np: new device node
+ *
+ * Assign an OF node to this platform device. Internally keep track of the
+ * reference count. Devices created with platform_device_alloc() must use this
+ * function instead of assigning the node manually.
+ */
+void platform_device_set_of_node(struct platform_device *pdev,
+				 struct device_node *np)
+{
+	of_node_put(pdev->dev.of_node);
+	pdev->dev.of_node = of_node_get(np);
+	pdev->dev.fwnode = of_fwnode_handle(np);
+}
+EXPORT_SYMBOL_GPL(platform_device_set_of_node);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 8c566f09d04efe420d85ffa046f92c44c6d08526..e9f7baceeb4c8269dbc0143c4d8fc9d73ba024ca 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -19,6 +19,8 @@
 struct irq_affinity;
 struct mfd_cell;
 struct property_entry;
+struct platform_device_id;
+struct device_node;
 
 struct platform_device {
 	const char	*name;
@@ -262,6 +264,8 @@ extern int platform_device_add_resources(struct platform_device *pdev,
 					 unsigned int num);
 extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
+void platform_device_set_of_node(struct platform_device *pdev,
+				 struct device_node *np);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3

