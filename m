Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91AC3D565D
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539548; cv=none; b=gcCFMmVx2m9RTCtpCs4QnRpFgoROb5q4q+YD9PYlbz+b8GhxE9/oBkiyKjKbunyMgsug2MHCy7q2Prwe6M5lsP0TbewLSsrZYzI+/JrxPkdvnzyoAFomKp0RuPCYlcqojLeW2j4ZuKQPwxdrnlj6ELo0MsTdlJv4mU5wH4YxLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539548; c=relaxed/simple;
	bh=e/KidaL4wAeLOYzpEup79QBE4YB3GUvthnfa0Ew8sdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hV4oP3wxX5eeVM0oMFvH1MRFpojTMmNM9JvhyRiuE4ELtMMkXpa04Rlhr1GQa0DL4ZjbjlT66F381YiNKBFz35ArI3pI7Mjez1Tx7hdb4MgjNTNNMg/p6BcCvdBsFlEl90EP8lRNMJbnHPAzK53E5aZjmwF+IcNsrZ3c7W61RUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q+znHmvo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZAvMAs1t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q+znHmvo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZAvMAs1t"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RW101420212
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7yyISHBDW6HtabJ1pV9A/MMaSyWcRa8ODURQFtJ8g18=; b=Q+znHmvoeBFyZJiz
	uYyIo/u7JSU0yCc9yH/0dG9iBQoOzXGKf66qCX2LGTIH8vdhy6poPAKixz8wCUAV
	KTDo6Z/e0bN22d29hD6Ab5TbhyJYi5NSEcD7bDAXdKeg9Xnal8iSk2Ya6g8f/epE
	jPxQkaPvzUqHBJP7vM/totBYHOKQbJVgV6CI5Oo7y35sP3etT0a3C78UR+VUw8ZP
	XkUpepdM3SVL86oMT7rcUZ9K5pBGNh2uIHqe+KjQ0UiVsZPCkcQv2OTj5kNSvgOE
	gL/r4U8CuOzJa1KacsHYz6LQoZYRoab5n1oX2yg9p7uj2/RMt9fkip3uLlLNXMdj
	9MTabg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2s7wjr2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 09:25:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1b4d961dso67198751cf.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539538; x=1785144338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7yyISHBDW6HtabJ1pV9A/MMaSyWcRa8ODURQFtJ8g18=;
        b=ZAvMAs1tgyCviG3iRpgVeEYLMWL+yMyhsEjxDiHvfUpSoL2SnEd0qGMXoRJ14PPMoe
         +jkK2AFIwQqVX25XX4Sh0+cs4w5oh2BERKg7oV8JWiruOqs0TLr5u2qxwZDcB8rMIYN7
         QGM3HsRYRJKeNl0AOg5GMs9uN4MvtLvYOIGC+FmU65hQ1or7r4XUMM21OHT1w2O8LBpY
         mGLXkc7aWt0Kcr3SwnldJ8Ifhcp4IRzq4Xu7giV8/vSwUP8jYBn+8xB489557so5fpWG
         um7ijxT4WC46R/GE97N20JL9DpyjB5nPeTvWs47F8t8tFGfw0lTVzrcq6Sbms2tG2L5p
         flZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539538; x=1785144338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7yyISHBDW6HtabJ1pV9A/MMaSyWcRa8ODURQFtJ8g18=;
        b=OujM415csS2HSvBPnvSgP/vrAoyzcQEn5Z1iiZzZvZ2bSt+t/OPQHsWlX9jfGmaNws
         sVNFEuLwOdrJWY1DwDiwYDq7st4wyG0x0Z/1HXEIUgeyKPqz7++sjh89QiIbiZNPHWfs
         E1W2fflYj8giJSFTZY57GWstTw9KVIc7P8GiIwpylu4z4V/nZqAJq3ur20frW3Iw00N0
         5+QoIyFUg5DRow5c8QWwZH5cO+BtikIR2yibrzXmskeqxm8zqZN52gVTGU5FYKRPjTpA
         j5oX+OgCUpPqAvDnc2Pnm4Qwj3FYxnxao9rm8Fyw3EiyeuUjIjVusCcxT3tQYNgvuZLX
         jAPQ==
X-Forwarded-Encrypted: i=1; AHgh+RplgqKsOR9I2xJOtU2pxSiLT9ECzTT4Q5RcKngGp/Lz73ig/DY3P2COUR+Ode7emP7SGeeKh+Dl2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2rDYz3F8acPldMWR9VtF/s2mVCjeknW4aQ9YG3BTnFJaUScN8
	BUPxFOTABPaIiJeGVAPhwBQ8z8pIn/8HeYZxV3jvEhtrDgbDuLTyxXnfkadg5UcngwkDHoNvDKg
	xEhQzl2yVZl7aqhEDzLsYwDxnZBc9izsLWvw4CqTfsGf1s161sV+O3aPaIBlKKw==
X-Gm-Gg: AfdE7cnctD562N14sG083ik/qyXomdqDEF2O4LhLOMWSSrWA3r6QrzJgdyo6u3awGnF
	6delrlr7AR9qc6SdP00YRaIUj5HH4SiKxVy5RF0Q3kGh0Jne3MuC9IvhUOSOF4voZuve7/XTPL6
	8ltY0rQtqipgMqL0RiBfMDuDXawLBJI5F3GTzSDIC5YfnMrP4oFCYbQyEB2kS93iPn6TyphPurI
	TzOlbAxKNPXwhIzP6ceWelB/zTImFpYBsMZ5y5s33goRYOXH2rOVTflPE4Jb4nYuQkWrNLxuXJ8
	9aFttvMYi4czd3b0FXO6zuK4M19uN3KFA5dj8YNd0LzLQX+32q965Ne+1yskCu2F+hA8w5AtwYn
	nuZK1RWOTV81GxQtP+C8wKbjEzHI3/w==
X-Received: by 2002:a05:622a:190c:b0:516:5019:d27f with SMTP id d75a77b69052e-51fbf8bb3b7mr165219821cf.18.1784539537870;
        Mon, 20 Jul 2026 02:25:37 -0700 (PDT)
X-Received: by 2002:a05:622a:190c:b0:516:5019:d27f with SMTP id d75a77b69052e-51fbf8bb3b7mr165219341cf.18.1784539537361;
        Mon, 20 Jul 2026 02:25:37 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:36 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:51 +0200
Subject: [PATCH 4/8] net: bcmgenet: use platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-4-2dee93f42c54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=999;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=e/KidaL4wAeLOYzpEup79QBE4YB3GUvthnfa0Ew8sdk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXel7DPUjBAYpcf7niyv0je5wGjcw6b2KYr8sT
 XuTSwpcWaWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3pewAKCRAFnS7L/zaE
 w0tjD/43qo3abkR30JWubh7GVIOZEwMy6gwIxxGEFh+64tlAWfcLqoTyNpfDWe9lZeBbZ1iltc4
 zfcV7M5oRVFE0KyZ1Yiwjib/cZWQi7vhxVQ0bePCjlyvllspMWyUfr2/SK5xFC+j0/xnhBPSZlR
 9+viBjtr7I4qZYIhZm0nDKPPboq2KqPcCQVdb2n0a1lqMrj56FTzTZy8qRlBH6opmKTsBPUpdah
 YLEWRScnyMfdm23dhcA1j3g0+OXu36onH8sy1uxZ8HS56kcQKURCK6m18b9e2VwiDIk5akIlAKH
 V/USnZ6vRpNl9XMir6bi1QFnNSAVYa3aSWMKPaJxEBtdaRbfDNNHlw5qYfeLonJF9XAEw0JQC/b
 iMMQCIj4eH4u1UrMdLCmzYF72Xw2Scjcnet4fqyBDvs2XgopXv3XXF9gVioCPtg47IwWemXcXjE
 23HIm9UdkNPKhC0YIr+CQwopylJDyKj9XiX62XW3GlesyySsJMBx9wxHwjPr0TesTOZp9LJGAMX
 kWuqevBo1tEoLu92X/0LJpXlKqOFqSsW/M3tCXsvF0fRgu8DvU2Kyyl8AoD1vJsyeN8EGBj3uiN
 KP5T0cPG/maBIKrbh5yP8+K9raSK9x3Zyxd32E+i9tJZK1Bm3Dj8ahaq+83dmJNnSW5e/7yRqQs
 rTNxmSOpcUPV51Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX4OY9IH/MGtjh
 S6vk1Oxz+Hqqi6Ub45BJw0i+1vYNhuJFS11sIOodCrq4qV9o37YC/5Gs1ndy739YYyjouQHt1og
 bn3ZHNhBff8XrT3djw6AcyZiLkMe797+zDGBUJ+hnIS+JvCVfzkg71pk1VJuUGalDbYS7jueD3F
 KVI/7WpANjOccMgaAsdPB+oAq7Zb1/uH5g3y1lrPKSXiHWlanGNy2XeKS4xbDeblmnSBcbfNoTv
 SPzNKS9BANbP4Kb+EaPu9i8FspCizkShJcf0w0VWC8WAxPh5uHI4lFEE2bDXvkKP+gXVDwkxit7
 gdn1hBymqck09LlNWYsav15zLo4OrRWKwgHiGtzxLh+1qX4jEmuPOFOs1szMskhuNcJmX+gFt7S
 XLgDLk1RIM+LWoFicCKWm5aW+X/GfiRYUC4HivCtDurqBMdZDGDl3Zr5UYmhTdMQmOqeBC9TnR1
 cFhmJkiK6AfkOiDszVw==
X-Authority-Analysis: v=2.4 cv=eKsjSnp1 c=1 sm=1 tr=0 ts=6a5de993 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=cykPYtnZiOmdoJCT1yAA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: SjtNte7TcWePBA8OwFvf1AdZgbmltxRX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX/bBbWfgjCOx7
 2Dd3Y2ug9xbuPsVw7RKp5rLCznJqphtFsKSZXv4p9AsgByCakTYkGbwheDM3VhYREYMju6j5VnV
 ie8/6ovVfKEfNfKvSRI03Lz32AKv9Q8=
X-Proofpoint-GUID: SjtNte7TcWePBA8OwFvf1AdZgbmltxRX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200104

Prefer the higher-level platform_device_set_fwnode() over the
OF-specific platform_device_set_of_node() for dynamically allocated
platform devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 0f0dbabfaabbce3469de79af91d7731b8476709f..6f471723bd53f454e4b0de1716977b4382013429 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -492,7 +492,8 @@ static int bcmgenet_mii_register(struct bcmgenet_priv *priv)
 	ppdev->dev.parent = &pdev->dev;
 
 	if (dn)
-		platform_device_set_of_node(ppdev, bcmgenet_mii_of_find_mdio(priv));
+		platform_device_set_fwnode(ppdev,
+					   of_fwnode_handle(bcmgenet_mii_of_find_mdio(priv)));
 	else
 		ppd.phy_mask = ~0;
 

-- 
2.47.3

