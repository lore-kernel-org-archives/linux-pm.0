Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7483D3CE4
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539532; cv=none; b=SNDvtshHqkB9pSzYIzCsRk9r7eC04Lf0/KWznXloIe0LZxbwmX+xCskqt0rFVRvR10ZSLbnnvVPg44ZCONo38Qk617/T9wPMnVmUSVgJ9TB0Ujg3t0RGglAt1VN9hGgycIklg34IAxgiQLcP+ZEsIdiG7e40x3SwcgOJDakmXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539532; c=relaxed/simple;
	bh=sj3G1vA76GGMvTxTrnIke6x7OVx8A1wtoaHoSynVfU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gz6uOalWIZloi2DxfLDCcrN39ag/xPzcJqI/sNNIJiLmQ2kfLsZRhiyjuwIewcAv/qH69i2ocH9sVmB3wPcXVDL5AdqZUmHOrU3SSZ7Zh3dOG4B1Sj92XscMVLW6maNVTJ7lBxjbPIhNlkc5DecFa0xY77ENtWqtCk0dRinE5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fJtWX/f4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=faq4ZCQl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fJtWX/f4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="faq4ZCQl"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K87WI52000791
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AI+EfZ7yUUjRJ/yYVPoEI2N0HcqWmjq7EqyYmjIn1lw=; b=fJtWX/f4Pep3nCDv
	t0l7qxrd7PP/pB2HZ9HkVtp29x85Der5J18aJuKzkok6pooxZYFA8Lm6LDHDCGZZ
	x+giSv7G8qFthdMi5GIv+8a8nKxnwzx5PpVRYDfvJfbh/yRbqr1r+onEP6AKMmc9
	xEFPtzMvhnGbchF6++xB8cDcp0xiSvd+d9maFoHbBycn1acsNhvtZ/IBa1J7MMj8
	w0lBhF6VlFeiOho+nKC9pmVYk4vXEWJCzSyFE7xCliPCyPUksUX4eFpDWGDmsmFT
	ZD0BB3+DYaqd3N1K1UqlOQ7Ohqg505rr5uvVmvirKZ6tOoDnPlAfLYBjl4bm533x
	EFD/Ww==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfvxgctt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:25:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51a87ef9713so47534571cf.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539528; x=1785144328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AI+EfZ7yUUjRJ/yYVPoEI2N0HcqWmjq7EqyYmjIn1lw=;
        b=faq4ZCQlAOQkqFzLy7wTsWMVpT6s7PUv972GXEm9tMZ7KhbvTGt+bDkbtmdlaiIjt7
         dLjIJ69lNCatlXBOs2q+CJmCCkPeSnT94yHXqaj1qETEOY980om2fgoIHcxL97iwmO79
         gjKxUFeMtJAoYsmiOAEoARU98IUje1g0yG7CcZrz0R3HV0KI13zBfGeSpRC99bHKjY5E
         Xn4hJM7zE42ZnYw2g5c+cYWK2WX5BAravtNd+w1GrzywtWvJzo/t3U1bRugAgVQ7MGnO
         pguMUERC8zJOmRBktOpePtkswAy5gHJCeUAfAXsTy+jqhDUqXuC4MaCBzfOHvAR9731l
         m8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539528; x=1785144328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AI+EfZ7yUUjRJ/yYVPoEI2N0HcqWmjq7EqyYmjIn1lw=;
        b=rJXIFoNlbCKO88pANGJtaZn4ypB4P+sO6B4KdPcYAxdLwUkBMkiJXawxsg1VLa/wqt
         2dJEw3mrNoCHX5bWZ0mp4Kqy4DVRFBCB5c4jaDjy870OCIRkUHbt6DRziKl0xgLeqVdQ
         TE9eQMU6yEA4c8zdXgpMN04uW/Lf0tzarC0g50AUd4f/nu4z17VLxKEyqVxv7pEuh1TA
         Tub/uiW/nikBxSwDnG4x7aKHpkXpYU7LL2szyfoqPzDxI/n7WKbdhUXsM9i3TqTt+Rjo
         5ZIm6H5jUNDfuCpJ5J7AUWeh+LQgqQBu2TpcP/gvtO+v4O6rimay5Dzt27GBs/kmdUXd
         J2zA==
X-Forwarded-Encrypted: i=1; AHgh+RrcJh/PxP9Iz5y4SSwBj5qn/VJ2TWnWoyWgij5BagVkaSGkVxxc4HLqIA2WOe0XZdXRLaLNfT9QrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQSxbCORGlcuXSHT1eevJeamtgvlhZFNwXtRc3q8bx785Zibe4
	o70WIyoUc1F6hGgBCqHUBh2SU+/MNUDRsOvWNwrGArGebBokfEGWORUzQNp42nQpnODznyKkQgU
	MUyaExdL2AyeswImNZwNXjZp0SjFSf8Vl/zKQ0X3275MUjEGVpN2+igDb4NaoQg==
X-Gm-Gg: AfdE7cmUxdrWSlPPH+5a5j3Os873hV11tuFZu+u3PgRNYePu5c5cR8WLlwerLk0PoFu
	ORdb/NBG48/u0ZKbbqq6WR9LK4bi3M7Zyjadb51hrJcdz55CPwy2LRr6cCEbWGW7WzsDu9q7dqH
	6lO2F6HNZeqVo9cm1ZfqlkchieYw3LMjl/6atR02zyuw/RFEq/GB2I49VwgY3U8SyqGjH7FTgOn
	uhytvI+2aBKp2fXM0T4BJ/8V+I2oHSrlnxVdsv5x+gSxPDVi7Dy6yoYzYT0ZVaY6HPph1wGtbXj
	e5yDgDk5fw+KSUgp8a4D0jETGBWLir29ddFWmWq0dtqap254JLpbrhIv+ff2kXn9QvGiizDyC1p
	Xbmz+V1e6DQgI6y3Bg8+H3LaEOCCPTg==
X-Received: by 2002:ac8:5850:0:b0:51c:753:4679 with SMTP id d75a77b69052e-51fc129313amr171953521cf.28.1784539528189;
        Mon, 20 Jul 2026 02:25:28 -0700 (PDT)
X-Received: by 2002:ac8:5850:0:b0:51c:753:4679 with SMTP id d75a77b69052e-51fc129313amr171953301cf.28.1784539527779;
        Mon, 20 Jul 2026 02:25:27 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:26 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:48 +0200
Subject: [PATCH 1/8] powerpc/powermac: use platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-1-2dee93f42c54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1029;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=sj3G1vA76GGMvTxTrnIke6x7OVx8A1wtoaHoSynVfU0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXel4ao2b6PC8YcfYlmQvKjVNTYAN1ewTrHVv4
 VS/GA/4xYaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3peAAKCRAFnS7L/zaE
 w3NgD/9l2EbcigcAHxvPVoK36otzZzzZAcLLE1rOxvRGlo6hSfTfqwyjacSMxamoCAzMy7RJjY4
 O1Q9Ez1UjISjLIv7zC2yWIvgwDNXQoqYzZNNPk0nE+DkNW5mh9IYSXJXoSWusyc33i9/0/0RHEG
 dHMiRRQ1Mrwm399I4y0GsSUsuCaB4vaNtyu724qEMD82zpNS2bhn37rTUp0ySxFBdnrFYjbHDh2
 ihyPtPJ2bV48l6uhV1ZWpQbnsiWKLrv3jq2ZvSLH2nwSMYEeor9SRF8DE9Ox/CMBlHs+x4BHcAO
 FOc9zwL/KMXVNgGr/v/x5tfU2uoYCOhSv0VbVg5tztPlS0Nytl8m7TbbYS338vEYXe9DeA+gXoV
 OlfG8Gh+v0cTkDkG7mjFAJ3cBxadQxInBHxvd2/ehlw/G7xlFJcxGEK9YPdqcV0X27XKvZdWAhC
 rLW9Hgvx2nHvvrwx5BwFbRBMyOGBIfmoyzp3OT8dkY9Af0TC2TTM7jQLdBo5pLVwhkEdvVdoR5G
 iizZ+VtdCoawhMt4eV6NqRz8JGdSfq5WVQiiPbPD4zkDOC+zTiE4k8YwxWGVkBs0DwhL61wlCWg
 3x6Oek9Hdyi64mhLonLyra44rbLzUixYPetQ31t2fI8SGC4jqzgPC2nEKFZ9JEaogvOH+qz+7l5
 cGgc2lbHIuybUhA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=HKLz0Itv c=1 sm=1 tr=0 ts=6a5de989 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=xOXlHDOaurapFSMEQ2YA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX5tp7nG37rDSs
 HEL5f6+reFniD+1tT0tjq/oxx18bEKfGhDvty/BGDub/kL/E/SRbxqhMMJqONztLTd/3+Y/PX+1
 PpsOFGo5ZqGN+gcpSJ3nMFRAosnk6u4=
X-Proofpoint-GUID: 0ipOFTG2jKN9xnE06XKpy1e8U2Dbdi8X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX0Nd+uag+ZhZu
 7wKGWaGUgL0rj5pWSedB4bsenZs6lx0k2IPb0iFUoflx2+q4qYQV0r4x2/TYC78VlWVVNuUco/l
 v9dLtyunBwI2w65Ud9CESpY7/VQGk9ShABqnkou92kOcJrGuFZV9xRuvxI63++QgAe7YQCfon5e
 LvC3/4tCxZiafMmoCRsP2oBxh9JOJUQqn3EFdpIpMHJ9Zi+9xANKE+bNCuaaNP7ruD7YTB3AEBk
 UTlBrbVtbNqVbquHs8T+1n0y0mzQhHwnNSF1XB/PQ6NTP8Cy2PR5RlOHhtJl0W0qqsKwqwKxok7
 ZY8ZGi1+4GpupVTzCuxbOjLPQ/GsLk38oM7AOXaUS/niUlUTBEe1Nmcz+7/4gMTL+XAf3fuUj/M
 0elog5dOzl3yaQ8TDK7OUKmNeDyaUUtHGOuUT7oNfCNOTfL6lHos7y+X6aFXQJUlJpWzdFkKVF4
 jRob1XfsPfPCXiZnw3g==
X-Proofpoint-ORIG-GUID: 0ipOFTG2jKN9xnE06XKpy1e8U2Dbdi8X
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
 arch/powerpc/platforms/powermac/low_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index a175a32a222bab4cc7400f6ab6071f5630db2cb8..eda35534cfd72e828616f27b5f8319189d68285e 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1471,7 +1471,7 @@ static int __init pmac_i2c_create_platform_devices(void)
 		if (bus->platform_dev == NULL)
 			return -ENOMEM;
 		bus->platform_dev->dev.platform_data = bus;
-		platform_device_set_of_node(bus->platform_dev, bus->busnode);
+		platform_device_set_fwnode(bus->platform_dev, of_fwnode_handle(bus->busnode));
 		platform_device_add(bus->platform_dev);
 	}
 

-- 
2.47.3

