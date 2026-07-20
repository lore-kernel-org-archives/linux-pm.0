Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446D3D668F
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539549; cv=none; b=GcP1jQ9pOyVYoD4hoT5V/p2ZtLrbGt+PPYGZ+6Pl5c5rV48/2IqHtu+wzIscGG75hZYupXpwyaajnQ1cMrvc3rNYxgG75n9rPSflhhL3fW1P/csrgFJAed7YpiYd09kYB38OK4BsRNN9BPkPEBR0ARHaiD0KB6CykpZNKmqM9Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539549; c=relaxed/simple;
	bh=RqOeWSIPxWyUUNyaNQX6aGDUFSUyf76Fp8vD0VV4O5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vm12+TnlxulMVAV5jfrlh7c13NCpJLxNilxMGNQzm9nLd+vZIi9tF41DGYMvMdFElmSQVD02lKB401Q2LTGuGt6tv3oJuykv74QMbW4MDv5R+A2S9IvxD++rKr/90rqvhnJ+iFzhOToVC3sk7OLyixvPtS/hB38iE8fFiJSNNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pDhTnvx2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dKU94T1Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pDhTnvx2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dKU94T1Z"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K87Ub42000778
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a7cvN8ziBliEDlKXepkct2t5ZxCcKqWtksF/xIVyVhA=; b=pDhTnvx2RVHQxDXo
	L74bzKL50Y8XvXYW/tZO/n/eD374mT352KgWjZjr6iAb6e0RHwKmI6PwYGiVL2qg
	zYQPQkOe5ejxbXNkih9928+IhyjhzSc/StiLZ9oh+V7q82QV/W3GEgIZAMek855a
	MFf3bd3xH/Jbia99eklhqrvTT2p3JlcPRWGn2i80jyScu/awSJLAMfR2xk2jdwxr
	vWI89MZ9/NSe3jmaj2AuAJ8l70gBWXPwePtNLKeQbsSvYY/3qXwQkG+UMexoXQNl
	2sxUrrvWDLThto329LYAqNROuXnYs5/Bk4kfqWH3txfDr3D1Gv331NWrdBOJiD4w
	BrBImw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfvxgcv9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:25:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bff5c7035so86659281cf.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539543; x=1785144343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a7cvN8ziBliEDlKXepkct2t5ZxCcKqWtksF/xIVyVhA=;
        b=dKU94T1Zq+yTetzImpwX9DdyvmtUKNCD+61398Sn4Nr2/q8jfHgCzHt90E5Ur8FoeX
         Xp2duDs3y7f9PgOWJ6+C0bhUeWQRwsFQ/X7bEeG7AiS6Ok/efVXh8Es4oHZGDdQH4T1d
         mjJaMiQefuwMmO8egcGfRVYD1AWYTacQyYuPPQ8yATlICeudsirtHLV7iWzaMc8jNilR
         vBsuvukaLFc8kgJkGyTG6kshrj3gePx9MokivuYPQP8jG1GtUfcDoVPEnjfxRHDhRJ9z
         YHSMW7nst9WW12cd1qahg7piRuhErSljJ0osBx6vpkbZJ1icJ9zcrhUBlBfToF5pXH77
         K+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539543; x=1785144343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a7cvN8ziBliEDlKXepkct2t5ZxCcKqWtksF/xIVyVhA=;
        b=Wwib6KXcpLhuM+c3T+3fhHkCux0MPsV+9nhirMNGQw6uFKEyRL5VRHxbyag8UeMTfR
         eYrv5hjY1R/sDrriZ8nAUHrGznzDA1X3Ro5WL4AEOyhOjSIoNLrm2gdN6916oHcMYsct
         RbXz4eXVGXg3mt25lmeGBTtHSNyJV5wRnMGEajhh7CZTJh4d/IvPMq8CDh78CWujJJtG
         F8Ge1p4X0B1tn5sQYTK7Lbrk5Gp60eo2nQ592hyWn416G8oZ2UDKuARMrslYCm3DEIjR
         IjZJ3gKHZNcSsDtbPQhyIzJ6re/iWSzYKgMo4WqUqHPv1fqrq6aWtzSKumJpF5yPL7F9
         yYyA==
X-Forwarded-Encrypted: i=1; AHgh+Rrs76hO7SUgkPPvVk96+pmTeHkvFN0z+7O6nG1028ShKEkiFp6u03R9zKvDYJwB+/Qrq4AKc6E1SA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqalF+R9RM4tajRxNlsK0XqM5XT114ixQsi6zH64EpJ2s6Nrin
	Pi22DXpOzKp4O4c7iYS+e50vuUheR9XOOKqvNBgphyZANnSnSrBqBvx/jn0n4PXPuKBhsYngVGb
	EX+sFKABsa613t0Y4rbgj/5QU72JsLxpHutjhfSLWzdcq7CnUNH46rtavE52H5A==
X-Gm-Gg: AfdE7ckaKWBWHAIf5bbDlpn8BYQ2NymqQ5SFQCBJmXckYLIzCdPL169UHFGILrR1euO
	CdWMCrLzmqkYnInI+2U1LN5WhVsD9DnwVxD7XdZdgLZ7xxjMLULFNiKDN1CZaeFMLZJ+I9FdvSD
	BB++SkWi7dq8boirB0k24WBnJ+zM3ZPwTuWmKaXiQ2ngMNHuoeVJhgAasEzMOjEEp/Lkb0Kc0Ll
	bufLNfaOwbhgg3R5g+2Y27rJef5t5U5knqWTE6iKOttgISz00YLHHYseR4zPewDHvUPCNMQdG6d
	HDbzY641ZCyNVvSnNGAi8a/szokeEj3uVwS99Bp/vzBbqFREYzuCohxvCpAka/FtfzxKalhWDS7
	bx6ACbglbFCKc8n2fp/0eSy24+rTBiw==
X-Received: by 2002:a05:622a:1cc4:b0:51a:8c86:bd3e with SMTP id d75a77b69052e-5213cdcae0cmr123373031cf.59.1784539543104;
        Mon, 20 Jul 2026 02:25:43 -0700 (PDT)
X-Received: by 2002:a05:622a:1cc4:b0:51a:8c86:bd3e with SMTP id d75a77b69052e-5213cdcae0cmr123372451cf.59.1784539542656;
        Mon, 20 Jul 2026 02:25:42 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:39 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:52 +0200
Subject: [PATCH 5/8] pmdomain: imx: use platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-5-2dee93f42c54@oss.qualcomm.com>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>
Cc: brgl@kernel.org, driver-core@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, iommu@lists.linux.dev,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=900;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=RqOeWSIPxWyUUNyaNQX6aGDUFSUyf76Fp8vD0VV4O5I=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXel98Yq2nzHQpr7zc+lfp9wUTQhIqA4ulbVtz
 ++G9Q0pmKyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3pfQAKCRAFnS7L/zaE
 w817EACiOlcLCBRprjyobSbum4i2BmSVzsdPwYul9dr0OU82QH1C5u8pWbLrvuPsQB634ec3Jfd
 GZqYJlngzIE//uUIpnHd/fmBmZGgAwz/qNkfpmEITHgTZg6wNLiAjJxEkreHpzFaTo1ET2Bvw8i
 5XM5cJ97A/3jhhSnDO32PRFQ7w5NAk+ClsamFytOSAr77WKUfC6ocdJVann+NfsPdU3XTBjQTri
 AXcNA7CIj+llJo1OwaMVdlBTJ76MGAhAYC45kEQGz0qpg4eECtUyY6rc2LS+2cToVao7+l47Q/N
 k1pQ/JjAsRPk5Es4S5jXikd3H9ID0hgAXYV+Ywk0zn3tksl1M3CbG27TGBvRp4yq7xrajuympd1
 XksOBEoVT+Z1ANm0e1sLuXLoFLDMf8miLPLRPXspYL74Ca7tzcEqUuKL4K8pU0LYFGvzufuKltc
 wuWk+hdBIobiw0ZC3/h9X7INj2GAVFOzp9dTL46iWF9O1U0RrZ9NlJnZozrfwixI+GElJFwnuap
 35WtJezSneQjrDCDpBRH/k3iKwb0+6Tw673pzmCpt22LACgFd9gRTdtNMlDYSncH8+e/amevHaV
 CFGCZKeDDNgpp8ixAPR3srPMEHWwcv7Pdr8GwiPFBXrUIkI34fsT1tLgmQ8XDa/MDRM6ztgc1eX
 QaDnELK4pLqXNjA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=HKLz0Itv c=1 sm=1 tr=0 ts=6a5de998 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=RoXXKHpjzh-0z6vojJcA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX1QYZTLrm2Hdv
 nWXcAxRyh+AWdBtGBuQ1G8kry9yY4t+BwpFNTBzEJK2tErFqBdOLGlKdmK84E2Tj6QlPRibaVA0
 y70NJBoZdQLILH9xc8O515Vci5fXrhU=
X-Proofpoint-GUID: PrdNMLYnnNp791b4MfRPM5qt1VLF31yR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX4GWVoJxaGXgm
 xmdeAOc2fVmM3IBAKPLr220j7AH+fjTHIly8VfcBqcdCq0ol9RJpanCy2Q7Hi6CFSoDXnJErkrD
 qHen97oGJ4SgbYynVb4ruoWeG3tjKWn3ePD34U99Q7C2HSkQ872YfL0Xatva9MiTf4uWIJrIEjU
 OfJR4n4XilAbcUviBeTosTzASz6uyL6u0PjlUXRpGvdXRkrHt1t6QCo/Sde4/cwi6Uo5rnknUVs
 haOyhz72pGT9Ac4MxsYFiTuQvai0x4/O8QqMwxpn2bSpcDR8eiL30zw1M06JjRLIxgOA3rg6zcH
 0wo7x5rTanCheuh5lq0qrdHBjgsTUT1OuG0OtyUWxiapkWUYSI1lsY64kV3a6m8F2QjC1XvjaNO
 cl6C30AtkBeUbecQ6WR7Kl0DCgAVV5lTBeu8q7bOqHs9onJLM7xQTIDBa4WPN2J1tIUakNtRxQb
 pQNQtEd1zdGabaQWNMw==
X-Proofpoint-ORIG-GUID: PrdNMLYnnNp791b4MfRPM5qt1VLF31yR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200104

Prefer the higher-level platform_device_set_fwnode() over the
OF-specific platform_device_set_of_node() for dynamically allocated
platform devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pmdomain/imx/gpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index abca5f449a226fbae4213926e1395c413160c950..c147eaf048ba2b79a744ec87029420981581e48e 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -487,7 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 			domain->ipg_rate_mhz = ipg_rate_mhz;
 
 			pd_pdev->dev.parent = &pdev->dev;
-			platform_device_set_of_node(pd_pdev, np);
+			platform_device_set_fwnode(pd_pdev, of_fwnode_handle(np));
 
 			ret = platform_device_add(pd_pdev);
 			if (ret) {

-- 
2.47.3

