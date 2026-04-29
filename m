Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6101317174
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471442; cv=none; b=rYmjVyBSdLcH4yW540Ac6OwY6BgRGaRTZmI+C5jLu3qwpEcnNzlQ3OJnhB9MoZofvLvqHwDBnJSa93KbiG+YZegYBJAZZOA0jepm3Qj1cFZpqu/8EC/7TJrOhmHXc8OtT3ufHUJV6JArx6tFeNG2IKPlXBkaWreL8WywLMO2vaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471442; c=relaxed/simple;
	bh=TFNBZbF2AykqlmAlNRgGuyEzwxEGnJlOKVQCArTNHJk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wwl+S3uDRWcl2C1Dc8Lq3Crc3OXuTW1yS+mgvvOW9phhgCYcu+BFw9C5nCcso/EVp/+EQoFkudQODvx93ZQJ2sECzU18s0pWWXAaGVN1QK4IGmAkjTj/NAcH4JFFXv8sQvTABJqjGcf+bXfQ4xzqOUipnbztSseeCxA+peNKgFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CwJqMuqo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fdFy/q30; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CwJqMuqo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fdFy/q30"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TCeb6D317184
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zAUEpmuNkB+tZxSdEw+3Gm
	F38llUPVXR8WmpxBRa8gU=; b=CwJqMuqoVo96t8g803mCCxDfql2cIvgS9ZB4+M
	Q60HRONsMmLd6A2lFqz7Pn16BH1j3suDGPTz4POz7+7BJQIPL0DUtSnWXwozLO5g
	lPJKwPeJKE19RwUpJBCMp5FdoLoRTtdYV/3GiFceFVuKqgqD+4IRmO+YEWHw1KMx
	njS6a4iYmFbDCKd0fc+lXwzlz65Dw8qEY21gQh1WiXwxhE+sf14dySpic+r5c+n/
	C2M6XcwnJk1NRJoPqSMrmHaamBJJNKDp38sZACwrUL60BRSbmXQEdzyKWwpAJU49
	FwT3d58ba+ZalSKZ0Z4y8hV0jElnsvjhb+fMNM0qwGDXZNyw==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duj6t89be-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:04:00 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7985951fa83so312500437b3.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777471440; x=1778076240; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAUEpmuNkB+tZxSdEw+3GmF38llUPVXR8WmpxBRa8gU=;
        b=fdFy/q3084YC6dhc2JDWniOkKP/M0ZKpX3RTnb9c/8KQwHu2ZLGCH9ztwHu8iPREtI
         9pgt1HYBt9wrON7+qUdIF1HvwsIWJfAXkWPoO6H8/QAFd3GksnBONousi6v9lQI0vYVT
         Zj9wpica5jV/Ek49BOXpjzEfPTeSS+uiIGUqRDDkN/F7YLyc1C8wg0eCpaRpVSSWepg8
         MstrsgP/GA0PFjkSfC5AKCAqjVdbLoQ25FgkczDDlknb0Eh5QyqZi5OdFb/cuuYWMQZw
         J37knm/iq+LcNvLaDqp2N2dbTfzNlzCxIWSvoLnUi80KC9IKcxKk6WMJmW1S9ve0nP//
         EffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471440; x=1778076240;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAUEpmuNkB+tZxSdEw+3GmF38llUPVXR8WmpxBRa8gU=;
        b=ilv0iDtg6ys9kV39LEPl9nRBIyMUwKuKII9TP8dabLuiSKNIZ95uNHXA6dwCCdn0sJ
         gZYA8A9WSV9pBNj5pO1jsxiCyGkRtzUq8dccBHEKQsZldv1AsCq9e0fPVVXjlqb3SFAi
         RQhQhS2EVziB3oXtSBGrqAvIcbY2cn+9DYwbRy0LRyLs8RQYR95/vcFkSJgRomaVqw3G
         lk+cRB4QkIbDdOWlFUXRNTIWmGgYZYOGjNRwm5VhSF+DpOnxzSmgaATtOCMLWvrNO7Yh
         f8+bK0YMVgbGeSMwSYpaHXUwfxwiiaCbXgXWotkbKqAbvCNZ8cK2EL9Jz8OfXGMVeeE6
         a0kw==
X-Forwarded-Encrypted: i=1; AFNElJ9ImHh81PObyZ3SvIvXhKeD/ryPpBZXI92CZK3qgt5IibstuzK05u3njRi9W1oG44PsqvJtie8OLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj3AxNivCFNf9bfZYx+EJWJ1FMYeFr064pzZzDh5XXW7b6j8A+
	PgoAWIZaW+xyd/6B1e55RP4kdSRFEigDARaCC26eGINkBJh9z7jP39OL27Ce1PunW9yueH0B/vR
	pOBh60+jA75qNkKAqYm+ltv9Uw3FfrJmkPNgZVXA93MBPCf6dO5sicf+gujoTAQ==
X-Gm-Gg: AeBDieuHDoeHAn9GsEe/IXJzaeLiUNFhajnBG7TjFNWESpb6rpdbZi1qhybeHNse5vF
	7Rdq96LOt+z2AyeC/lp6aGv+tvLayi3+4sMkMtoelfeGXjvt4+mLOgwRSnl8fbqyFzbJiAACLly
	VAguc8FsODOiVo/hKARtzyf4DoRxKRYHX/gImr2GSbEWXDUBsnzvy2rUkQmSPhtci+HsvI3SKdR
	3HWXhh0JDmnUxgmjn1WGTxCPx0kF0EUmFx2G7FX3gW/zFKpoESS0j/vMNLUtKG65qp6UULkM7dW
	1gsZLCgEaCzKXzoOH9GVHno+chmkNmPBsPZlWUCmd6NjOUXOHtYHT+4jCwAeczfoOTL98ErmBWh
	I7fSwBMaqvI13vQQaoCgUDoviQXStaz1ZfYDRf+m8HAF4WzxTDB9gGpQ=
X-Received: by 2002:a05:690c:c4e8:b0:7ba:fd82:9113 with SMTP id 00721157ae682-7bd1d3787b8mr40117467b3.5.1777471439757;
        Wed, 29 Apr 2026 07:03:59 -0700 (PDT)
X-Received: by 2002:a05:690c:c4e8:b0:7ba:fd82:9113 with SMTP id 00721157ae682-7bd1d3787b8mr40116737b3.5.1777471439121;
        Wed, 29 Apr 2026 07:03:59 -0700 (PDT)
Received: from [169.254.0.2] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd258ce06asm15382827b3.36.2026.04.29.07.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:03:58 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH 0/2] Add interconnect support for Qualcomm Shikra SoC
Date: Wed, 29 Apr 2026 14:03:47 +0000
Message-Id: <20260429-shikra_icc-v1-0-e3439903edf1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMMP8mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMD3eKMzOyixPjM5GTdJMO05NQ0E1NDI6MUJaCGgqLUtMwKsGHRsbW
 1AMUig0tcAAAA
X-Change-ID: 20260320-shikra_icc-b1fcef45122d
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Proofpoint-GUID: PGKOYoPwbokS4I14ppvOpZM9CJ1YBNQz
X-Authority-Analysis: v=2.4 cv=KcHidwYD c=1 sm=1 tr=0 ts=69f20fd0 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=jFa1RlLEcyH7Bxs9oBUA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-ORIG-GUID: PGKOYoPwbokS4I14ppvOpZM9CJ1YBNQz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MiBTYWx0ZWRfX9eFO3OxO80Hs
 tVyPLegTnGUoaVYAzc//65aMFkOPR63h36j4sZwEKz9VlbBhR7ocD0qt+Z84lUunFui64gMNL5x
 UPwAri/U/rRkb0TPlN7Se0En4bNada2aipD0lFG67YIP7uR/qflLz3Tg3neMq3lzFHzXRNZOVSz
 fQGFfeQD7XMu8kNqNsVZrgcbzCidLYCz3rLkGLs0YgE1RvmRlYmXHMGKGYGgB0bCSKU8xP9okZ4
 9iP6vNRANrWmp6HnPQfk46dHd4soJwOiqVhkAYVhQmoqpdPzM/VGxdLkOHKBOzwxq0i2k3A6UEM
 RGmzr2BXYEHUnS/7mjw2Nt2U7+YFZRltxwgTRQ5mmVP0mDXUVpHb916ozZC7Ho9NJ/1znESvaY7
 MMJj5VYz4XdCLFrsymDFF1phCVoafqGDrP505fWOHi4RcOLSOEdKLX5BjPhmE9YDo6DhRcIkYDq
 OwE9ECLGewS6xlDMKrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290142

Add interconnect dt-bindings and RPM-based interconnect driver support
for Qualcomm Shikra SoC.

Device tree changes aren't part of this series and will be posted
separately.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: document the RPM Network-On-Chip interconnect in Shikra SoC
      interconnect: qcom: add Shikra interconnect provider driver

 .../bindings/interconnect/qcom,shikra.yaml         |  135 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/shikra.c                 | 1837 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,shikra.h     |  121 ++
 5 files changed, 2104 insertions(+)
---
base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
change-id: 20260320-shikra_icc-b1fcef45122d

Best regards,
--  
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>

