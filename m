Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809302;
	b=pn3NU3cIQBC+cGyS1nKZhRSnZZwucy4wzEyOvk3ILKWtTlgQQdBBdCjqL/KB6kr0vx7v
	 /kJaflW1+na2s1fAbpgdwqazRuWrY6XZmUPLYNJ+ayENFu2X9Qz+Cirrxsbfsug/iXtY2
	 tFBQreE9x5e9S5w7fQIcANRYxxttNoB7qB+a2rgL8ZZcRGlL8Cp/UfdDIgeDijy6uDy+8
	 yhEPK8k5TMrq6zt822nJ1Qp0oIC2XqFkY+w00qjM2+PViPSBIFxDVMWFZWZNncoY86XJB
	 66deM6AbLrKlLywj2Z+CF27rcHPcsMTp7VylixK1h1cLS7cZScnOccHPNFW0QbSbUEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809302;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hiY9I6KwNBi/iiyCvRtimmzKZzjCthBLith9u4obNsI=;
	b=y26hDDS+XWunL6odUAPnuqrLSuk1o9QN/BXumJxb6TtWqERQRMJg3ax3qfH+yRPpf7re
	 87wJ2KW/P+/PbxTzweh/k3VnDdQRP/cc+0D7k5Fh5a4Vgt+gkTcBixpY9ndv14j1v3uHz
	 yv7+2yI6aRzVrJbQJ/dKXoRrfiA0rKKJfy51VqnJzgR8M6FJYjHqQDfcyAZllvW767D40
	 fB1+Ovk6/J9tOU5Df6PyGlr+0cF+TYf1mCxyZv4T/gi/3ak/VcoY/J97uIOXx2dOcyJ3A
	 bfeklq4M1qQh7moiLewyFLRXT4+QX8vIMCYRe6vYWiQaOamD0uCa9/t1aaHalS5qwkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=khynQdHt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iLN92zQa;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3BB606AACF
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 16:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C3BB606AACF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=khynQdHt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iLN92zQa
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4FipDk3272824
	for <linux-pm@vger.kernel.org>; Wed, 4 Nov 2026 16:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hiY9I6KwNBi/iiyCvRtimm
	zKZzjCthBLith9u4obNsI=; b=khynQdHtxuXUlWFgn8YrPPweRXKoorWUjVEj9R
	g+naBxh1weCTOQl3ix2Yq8nKsy+wgbqksAcUP8/Ww5M8BBtMUyph/q+2MRqpQLPK
	ynp3STPPgZYOj9gFXPWmFxgr1Mi5mk9sqfDwHomtckz8SG3hFqM7zt1VoYQkOGas
	hz4zEm2yZU7vbHRqvEPPkdXNBq+b/OawJLTQYoPQBDbPF+cBeIhy6hQF2rJJTzoj
	f0rgRN5Gz1kVwy+Pili1w5wR3rDkzvxkGC8PEoeGmlL258P8eKlTqBxyyXCl3WBO
	BeJCZWSqF1nWCHUOlnuz6PVx/Hu+vrDXsJCj7JqcGLvsr3Ug==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bngfyw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 16:21:41 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98304865f02so766010241.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 08:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793809300; x=1794414100; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hiY9I6KwNBi/iiyCvRtimmzKZzjCthBLith9u4obNsI=;
        b=iLN92zQaYgz5ljd3Dr/894RuBgk0jDNoizjVY3JidRAuyVKXb6LlzBkKf7BMB59JO0
         pHhPhR/ShoUZHY3yVMGTOrnRE0wk+dFXSXNKszpD+vQEngzNw49ewU+QEr5IEb7CKh0o
         +2R7LAlVqVY5ciJm11u1X2jkGsaK5MonSDQS/6TJt1Lhm9ub7dbZF0bF9Kva2SVxEYfO
         pixXHzgxzIMBmL84d99j0gPzPyKjaPiocB7Dkgp/vgkD8H26zR2Jjm6+pdvEhpUIlPtg
         lxBwxYglsvbPZ8TFqq7j+EEgHZJ5C+HyvzqQtriT4rM5FUQJAewmK+BuKSgUKB+Eae7E
         JzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809300; x=1794414100;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hiY9I6KwNBi/iiyCvRtimmzKZzjCthBLith9u4obNsI=;
        b=jb8ziMN3UTAeXIxxkP6HtHJErHDe9ov8DtW1oNOGzHJ06JSnmrHgujS3Ddurs1BhQu
         4xJY1LRFlVmrxlcMc8JMer4xvOVytrTQiiHwBKej5h9p4ZYvUXJWbZYHBFNhpthoyO+F
         zqwvhSzJL2bHbQnCo3yEu8lZy75+LAxgzeVm2WF1FI5ga7DLD9NeVxKMH2/WlvHWvcjU
         ITb8Pq5hmQiTl5v+HSHd/ahZQigQaYPhKMCWS31MLHhMvZwFRxhLUDU3whOHwdnr8M0d
         RLR0LEkn0jLZEfi79ai+MRWa7+Bf6Exoiri2i5IixwynDqY9fm87q76LZtnkC+8Nlq//
         HOPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzj4r0zNfB5tXBc2PVMYJkUIboCFGjsn9jyG3Pnc9eSdpDvV9XsI9CsMG73pxf2kdAy3F3WRIsZaw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8qjifbhP46uVIFhpnbSgM/8zhasbY27U4YCHWBr9Lgex8YkF75
	OwcHNe4SMqfpiMiVNRr8yk/cRCbHcCb65XYR4B211j+Yue5b/Yxi9xZvSMhXFXn3s+/uU9JKkji
	M+cKPJIqKuzaNkW3tLaWl9zUaKXy124eOYYukFjNBVLQOwK/VnZd15GkAu/BIWg==
X-Gm-Gg: AYBFou3ShYX8sbpUWz9Vqy96XBmHALL2wzmIXHAGDHR16In+dvKdro34lISZGu37n9A
	Ia8UJAux/JOcpuYG1x9f2uz9YitRoJIjGqHzzEkUbxlpzABfPmxPhDh2zCJ+OxcrJiKv8/+U/02
	wt/J49z/Oemfeq7I28m++VATGJkSxc2mnE/V7I0eF0HYgw3/WeLY8oh7raQKxsrvnc8HtbOP6hR
	YFAWvfA8HqZU9tG85iaLKfc93fgDbEVyOL7+iKviuWAN3dfWu8IQ2hyWg+5xXl80AKR8GWRrRf7
	FGG4vxkCDO6kE4weTkq8ZPnnVc9vU8IPCU8JVMo2j7T+LpG+5pUcGMkxlD4czuQGRSYIFVkIjHO
	cdNLDB6NHeWKIEl0lAUqyMGpfSlwyeh419imtuR9blGG+B0HyimwwZmnZm4Rs3v7jkJBy3N7m7l
	yUMQ==
X-Received: by 2002:a05:6122:1346:b0:5ea:e197:93d9 with SMTP id 71dfb90a1353d-5ec689cf04dmr7881259e0c.19.1793809300269;
        Wed, 04 Nov 2026 08:21:40 -0800 (PST)
X-Received: by 2002:a05:6122:1346:b0:5ea:e197:93d9 with SMTP id 71dfb90a1353d-5ec689cf04dmr7881216e0c.19.1793809299708;
        Wed, 04 Nov 2026 08:21:39 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aaa4b91esm138706365e9.11.2026.11.04.08.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:21:38 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 17:21:34 +0100
Subject: [PATCH] power: sequencing: pcie-m2: fix use-after-free in
 pwrseq_pcie_m2_vregs_enable()
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-pwrseq-pcie-m2-uaf-v1-1-0ae1bbea9533@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAI1b62oC/x3MTQqAIBBA4avErBtQi6KuEi3ExppFZko/IN49a
 fkt3ksQKTBFGKsEgW6OfLgCWVdgNu1WQl6KQQnVSSla9E+IdKI3TLgrvLRFLYUSg2lMu/RQQh/
 I8vtPpznnD8lY35tkAAAA
X-Change-ID: 20261104-pwrseq-pcie-m2-uaf-a10209c3c4d7
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4813;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=jrKYHbzHuQtQDH1LJjU1wsAH7+nStAGDkNwI3EwYo/4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq61uRKXGWBdRrvCWYVcvySwfBACYO/OgtWSoo1
 sH3o/YY8CaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCautbkQAKCRAFnS7L/zaE
 w/93D/429Cp5VXKSuk7vHjuZgz2bxK6OBXmyg+UxhWJNt3a3nWo8uf6x/Pdky9bSXKvULi3jB+5
 o83Lo4ohWZAoEzbrYlAJgcphlNxtxzWuZMMgP6yVmfK5UDdpxZYHtvvYTmY4ykmv88r/I99dDTN
 CAqKLvRruicC1Wk6pVmdYgMQ3fnHeDGE8bcgWrwT6SROynUzMKqRhLToaq82aIj0IGXUxISBE7d
 73/iOuPMsuEUWUB0ueDIq74J4dHhedi5HLW+WKClWxJBqok9EOUhImsfTxbgNqnSYM+e+sy9A7E
 1chdLNuXKtEfz/lobUGwVlUXaE6/k5tdSfOgeptO2HxaWbktFFoN8ZTkfzJLtwihwFrR1915u+C
 0nQaRYajsErdHDAt4xZhplP6rKrGnisuM4usHmgm5WXdw3EFE0lxIg9OkDhfF2boEh4F+3c3ma1
 tTaSZ8tdvhUT8fDQIl7yJCamrScPkxjNV/vzdOGl+37wOUsLZHMkIe6+eNf/scoMJitD+DBuzcv
 bp8UODhN8pT25NIhIBhyhPl9vK+2JHwsjKJuAcdE7tEg71E5vA4zMWGammiRjVtIdRsn605AWKb
 Fe5LYBkw8SKoIkP5FSMYwinDiYjhVdbdaOhdKKtN6CDnsl13tR3xHIqIO4UwuB0NqOofDWVFy0U
 nZMv1f6vrg+A/bQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX2ZHZqE8qAvc3
 JaxzbVvzckQnm0cqKfbQahwVvJlG/UeA+LG40goFI+TuXX0WxknKQyv8SeP/hQ46hdkUt+VWUzg
 LgRIlPoKZGsOq7fF7PbmhVC26xiWVpHGe+wZDIDF+GeRCWLAxGYNSMWG+fhIC0EUzJgUvK9YLXI
 2YcGZexvUAf44nHV8mXjh/QuntYS2Q5q6vZfm7yBO7nPGB7lVEWJPTLiYdQYDT/pwD7/xIqI3+t
 NWMsT3+LuBTQlCNHhKJjag+cLvVFIAY9Vfc0oUJmnF+4TiQ3AGU/WA8x+JXHwpBN5cpuRnzeo4Y
 arRw6FszRem7Lj4DPKfIaUUubtO9OhnHmZ66rG3sjSyrBFSLljU46z5WFCmEuLIUpG/1NsVE64l
 w2hFibsbmhEMkKzKlJGoKLIqoPjb7uMiajaHiiqErrCyE5K/HUwlLN4ahr8i0UG06uVTXimjrs4
 zJDlsbQK8zPOHZaqGYQ==
X-Authority-Analysis: v=2.4 cv=KLLPn1Fo c=1 sm=1 tr=0 ts=6aeb5b95 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mM_0bNS9DA9p5V46oFgA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 1CFWJzBqCeiLZnnOW6Dc5hpcgo9Z7thI
X-Proofpoint-GUID: 1CFWJzBqCeiLZnnOW6Dc5hpcgo9Z7thI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfXzSravE72p/Ci
 ijP+k32CNH+6j7gwuHFTWNvAXd+tl7npQkAbyjcqNKe7+2E+LQYzCx96VP8w5SZNygwntDSzKe2
 4DKfWMiVfaKnLdS64bSSLHrir621mSw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040065

During device teardown or on the probe error path, a concurrent consumer
access triggers a use-after-free in pwrseq_pcie_m2_vregs_enable() or
pwrseq_pcie_m2_vregs_disable() due to a lifetime inversion between
devm-managed device registration and manual resource cleanup.

The driver exposes the power sequencer using devm_pwrseq_device_register(),
meaning the device remains fully registered and accessible on the
pwrseq_bus until the driver core schedules devm_pwrseq_device_unregister()
to run after pwrseq_pcie_m2_remove() returns. However, the driver performs
manual resource teardown within pwrseq_pcie_m2_remove() and the
pwrseq_pcie_m2_probe() error path, prematurely destroying the backing
regulator array.

This creates a narrow vulnerability window where the globally visible power
sequencer is backed by freed memory. If a concurrent consumer invokes
pwrseq_enable() during this window, execution is routed to the sequencer
callback and dereferences the destroyed ctx->regs array, resulting in a
direct use-after-free and a kernel crash.

Schedule a devres action for freeing the memory used for the regulator
array to ensure it runs *after* the pwrseq provider was unregistered.

Cc: stable@vger.kernel.org
Fixes: 3f736aecbdc8 ("power: sequencing: pcie-m2: Create serdev device for WCN7850 bluetooth")
Closes: https://sashiko.dev/#/bug/linux-bd17e5b1-a000-4717-b392-0ff0c2a9c376
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 56c5d51293c10faba6c978265bcd07a6980d2a52..a794e2ad6a9c8cc71b1ca426df92abdaef8aa85b 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -533,6 +533,14 @@ static int pwrseq_pcie_m2_create_serdev(struct pwrseq_pcie_m2_ctx *ctx)
 	return ret;
 }
 
+static void pwrseq_pcie_m2_free_regulators(void *data)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = data;
+
+	regulator_bulk_free(ctx->num_vregs, ctx->regs);
+	kfree(ctx->regs);
+}
+
 static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -561,21 +569,21 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "Failed to get all regulators\n");
 
+	ret = devm_add_action_or_reset(dev, pwrseq_pcie_m2_free_regulators, ctx);
+	if (ret)
+		return ret;
+
 	ctx->num_vregs = ret;
 
 	ctx->w_disable1_gpio = devm_gpiod_get_optional(dev, "w-disable1", GPIOD_OUT_HIGH);
-	if (IS_ERR(ctx->w_disable1_gpio)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctx->w_disable1_gpio),
+	if (IS_ERR(ctx->w_disable1_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->w_disable1_gpio),
 				     "Failed to get the W_DISABLE_1# GPIO\n");
-		goto err_free_regulators;
-	}
 
 	ctx->w_disable2_gpio = devm_gpiod_get_optional(dev, "w-disable2", GPIOD_OUT_HIGH);
-	if (IS_ERR(ctx->w_disable2_gpio)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctx->w_disable2_gpio),
+	if (IS_ERR(ctx->w_disable2_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->w_disable2_gpio),
 				     "Failed to get the W_DISABLE_2# GPIO\n");
-		goto err_free_regulators;
-	}
 
 	config.parent = dev;
 	config.owner = THIS_MODULE;
@@ -584,11 +592,9 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	config.targets = ctx->pdata->targets;
 
 	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
-	if (IS_ERR(ctx->pwrseq)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
+	if (IS_ERR(ctx->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
 				     "Failed to register the power sequencer\n");
-		goto err_free_regulators;
-	}
 
 	mutex_init(&ctx->list_lock);
 	INIT_LIST_HEAD(&ctx->pci_devices);
@@ -613,9 +619,6 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
 err_destroy_mutex:
 	mutex_destroy(&ctx->list_lock);
-err_free_regulators:
-	regulator_bulk_free(ctx->num_vregs, ctx->regs);
-	kfree(ctx->regs);
 
 	return ret;
 }
@@ -627,9 +630,6 @@ static void pwrseq_pcie_m2_remove(struct platform_device *pdev)
 	bus_unregister_notifier(&pci_bus_type, &ctx->nb);
 	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
 	mutex_destroy(&ctx->list_lock);
-
-	regulator_bulk_free(ctx->num_vregs, ctx->regs);
-	kfree(ctx->regs);
 }
 
 static const struct of_device_id pwrseq_pcie_m2_of_match[] = {

---
base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
change-id: 20261104-pwrseq-pcie-m2-uaf-a10209c3c4d7

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

