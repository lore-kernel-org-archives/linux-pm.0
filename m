Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AAE39FCC1
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692632; cv=none; b=Vou0kg57T8GggbW9kRqgfp7mihuenJxGkIGaN4O/Mz03BjapEae7rb5b0NxKLKexQ4bey5j64mjhdTfxPkasZwz6O3+DfPo64R+dbZuvNS5h5PKSZPNNNjk3XdHeA9gN84uvHPzvAXoNY1d/37pyzv67n2JfzG3+kKKmTJDETJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692632; c=relaxed/simple;
	bh=IWeomyOh1Ae5xTrTn3KT0pUIoKGaJ6fwTgGzVci0FIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bb2nEhTHsvkYRDIQdWTC6g4u5bi0D/OXN2BGo92j/axKLwcSA64O2ZJ0yCCCorp6b3ojeTGEvmv27/Wm8g2VAqZITEIYofOOAEHU4JaoNMT7h3VD2yzneQmuVZsRxxDgk1O9Rs67HyCSmiHeJw97NhhxAk9o1RyXv15cIECBduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQxQq+og; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CxSTIzqY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQxQq+og";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CxSTIzqY"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGAs5B2524326
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 17:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZhqeTaO2TDEjcP66wfCrkDg+Koq/B3QkWrfrf2cS9lQ=; b=fQxQq+ogkG0kthGh
	83i0eWPeE8JdizI4q8NsjOSv25cMCXMfjG9C8NIJem68Z34SEDrIgMZ+AGG6OSjl
	DgFFyOYmxWP1JJDx/TXLFlXQDc58BkOsHdeIMoNnhWGkrkNz/IAS8RzCsELMMq0J
	jGoKWs6nCVaamf6Aj4YKX0puFEnbGpLmeI8cbdg9meGFixdKckeOnBm4/YRpNGjW
	3XSyf98t4OIxbgi3D1B0/8psNXix6XDNN7w7Eo3nYiKwGu1ZM0GtNB00r/KYGYOg
	NW903jrcHRD95MEMQCcBK2GoA1BKk/xtzxDFVYp4GQFp7pxOgL0xZpHlkblMopRi
	jlIS1A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjg942-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 17:17:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so1240589eec.1
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778692622; x=1779297422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhqeTaO2TDEjcP66wfCrkDg+Koq/B3QkWrfrf2cS9lQ=;
        b=CxSTIzqYAker85rLxqf/ZJJtEBkCrNVKcu1A/mojRmrK5mGJ9wcW2DW1avTQzgni+t
         J7GOX/DNsPbO+i7Vggj9Z1BShTQqNLN/UQZXq+Tr5S4MSY1XtkieDOEj5qm0BUE5+jI1
         b7mqW9lcOWk9n8N4W+o7TUxvR/Y9vyswnxREYdc+UY2wsfALW55V3tYk4ADGeZWf2STY
         +3224PI+f7+viekHt8v2xJh8xbBPa+eYA0qk/CtGm4ANCu/0r2GY9jnf22gR/Bjd4D3g
         BDWlcYrsRl8mH8kG8bmCV80wLAr5wqUda0X2KwdcIkb7kdiaK2lPFDcQUEY2o2k3PMhx
         bH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778692622; x=1779297422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZhqeTaO2TDEjcP66wfCrkDg+Koq/B3QkWrfrf2cS9lQ=;
        b=DLbUHgN7XP8cXeVNQ+UVVK4KIHJAq3NLhTz0ETz26SiylVA8zCS7CikpbkWIQAhuKb
         a58J0o4QrCFg/ngecEUvTkrb3+m+UcrwW8ZVVWmYu49tLap/wBjc0WdcYLeHnlqoFwS7
         r774GuRw3tuWU3lp6yowxtsjqXT3teg8FwFAOBdiF5mknBErHAJnAl7L9VnVOd8OxaLH
         ffZadeqZaOPzyf8sBpxHgc8CQ/6FdVDTC7yYcV6scID8zSx/L2NSIXf8g7cvAZvL6e06
         3noEeDbA7gSVSWQayI9UUCHTrNYMUI47dJytSKe1gub0j1+naVjuA5Ums2dsQdYUGLGc
         a0Ww==
X-Forwarded-Encrypted: i=1; AFNElJ9TQdSlLs3yn6yZolSqkOv45YUAVWAeUNbPSA7JJ5CccbNM9EUDJRqDOOl+UaIi3mSwj9A9u2Nwyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy0tbuFXvWOkmNxRQdli3fhlr/iEiZT3bBlgxoeZi1Wa1any6x
	+GGi/3wion21omhUU49buBP84UURuKEGAR9iYVT9XxgCnT/UkINgqtx98mK71wOaLvnaAhFEi1O
	BGOWGDW/PGXREvhElkojsKRfQuaS6Ryn2izJUQ0FGndLgwF6rmYhW9wNpvSV3GA==
X-Gm-Gg: Acq92OEanh3c886iO+MMiehY/dk5SPfsDIJpfowwGehD6aaIIcajZizZUYpW+miWmCZ
	vlDxmncc/eI3yK5YUzwR85k/vQ3p1UlXmuufYKx2Uuo3b0eZ/YnZmjs5y9ieZRagSN8XuzG0UJB
	6KQdHrmtDCBVOwJTXUE+6pZTsoevsd3Hr0TDMJgjZ8AdOT80FhepeJYMDR8ePuP870bDGzzVXK/
	4vfbteOK0khirZDJsILbC0jIkRfyI9I5JtgfU2if4MYvJSI1pF+eA5jtvHqNU6EWnkCBlr8jvZv
	orW7BGigjCUYJxMU0p6C62Cj04P5kb5DpmpGD+Oisxv47Rx1tzKWdtTJDtWP2iSe2fV5Vzi5/Wx
	Gq+OkpXOgiGKMtL2G+E58SyBBwwoPB8GMeywcG6yqkg6+F0G20+KCBwtuV64rFQXIavnyoLI=
X-Received: by 2002:a05:7300:a146:b0:2c5:60d0:701e with SMTP id 5a478bee46e88-3011708531cmr2740286eec.3.1778692621911;
        Wed, 13 May 2026 10:17:01 -0700 (PDT)
X-Received: by 2002:a05:7300:a146:b0:2c5:60d0:701e with SMTP id 5a478bee46e88-3011708531cmr2740240eec.3.1778692621289;
        Wed, 13 May 2026 10:17:01 -0700 (PDT)
Received: from hu-aletran-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888d3af4esm23075939eec.25.2026.05.13.10.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:17:00 -0700 (PDT)
From: Alex Tran <alex.tran@oss.qualcomm.com>
Date: Wed, 13 May 2026 10:16:54 -0700
Subject: [PATCH v2 1/5] powercap: arm_scmi_powercap: Log number of powercap
 domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-scmi-client-probe-log-v2-1-36607e9dd540@oss.qualcomm.com>
References: <20260513-scmi-client-probe-log-v2-0-36607e9dd540@oss.qualcomm.com>
In-Reply-To: <20260513-scmi-client-probe-log-v2-0-36607e9dd540@oss.qualcomm.com>
To: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linusw@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Alex Tran <alex.tran@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778692619; l=941;
 i=alex.tran@oss.qualcomm.com; h=from:subject:message-id;
 bh=IWeomyOh1Ae5xTrTn3KT0pUIoKGaJ6fwTgGzVci0FIE=;
 b=eYcVU7i936b/87IEJANq3Fe77/zHJ+AvzRNx5TeCA/mVoSm099367r2A/+6SswcY3A1YG+/rf
 uHQ/wReFD31CuchIdzYXXVih9AwybSWgz42qZ6LDlL0I/3GrPN1/A04
X-Developer-Key: i=alex.tran@oss.qualcomm.com; a=ed25519;
 pk=vKab/gw1fXij5UviWoglv+ho+H/oOiTHyETCLfayPE0=
X-Proofpoint-GUID: eKBpH7gNNfORkD85o0nELG4Sbc-3GR0Q
X-Proofpoint-ORIG-GUID: eKBpH7gNNfORkD85o0nELG4Sbc-3GR0Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3NCBTYWx0ZWRfX4o9TbpVzjUqf
 JhWzxZOEVu6KIoNT8mE6FI29CXRs4UGHpAO7LStSzqzgD31yi4iKXLv4thDsyCFAVRUjDL4iUTF
 9jFP+liFphziswVeKEXLarokINagse6YdJoVgij+yNOX9RSoyHRG9wEdWN2wu0wgN1AqsklfM8x
 9AftFTYxTYtAs8ZGEy390IhPyvJkTOdXmMP47dtMiA4w+yQ6rVQCtjEeVbHjBXAdLxw1mGRBvXq
 PGbGrmUpX3IavjLZ6m5jaGqM6HnbQb8rJr8lKmd7X9g/nPB29nwr5eF0oectgOpeshyVQSx8nnp
 LLRpbrwdJEK3WYq2ohmN5CwtY8phg6XFXJSeE5EG4py1gPtYS1kxBj8hJG4doUPbDhg6RtuMDib
 T6avqeyNlosClygPAMP5TSQxmLN3zgBviNXlZnlXgIPZUVsfECOGPATJtRTfRwAiiiwffgIKEX0
 YxZBdNsmQicvQzT4Uiw==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a04b20e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Bjf1dfg4zo7KOAcPRCoA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130174

The SCMI powercap driver does not currently report how many powercap
domains were discovered from firmware during probe. This makes it harder
to confirm the firmware exposed powercap resources during debugging.

Log the powercap domain count after a successful probe, aligning the
driver with the existing SCMI client driver logging pattern.

Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
---
 drivers/powercap/arm_scmi_powercap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index ab66e9a3b1e2..3efe3743cce0 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -496,6 +496,7 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 		return ret;
 
 	dev_set_drvdata(dev, pr);
+	dev_dbg(dev, "Initialized %d powercap domains\n", pr->num_zones);
 
 	return ret;
 }

-- 
2.43.0

