Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34F378833
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112204; cv=none; b=UFyBm4dzDi+vmfx9i8W4TgvqzZsSiVtQAMjmNvz8kRH9DgqO+DagsCPmq2XhObEfuRoQWoIcDVLR7KUCHYXaYD7VRWk+oCDYGsSZ2Yh8SP05PsKFSivNF51oxL6WeFnE3tdHp95dAj5tLCRg8M4EO2cb4rww6o/HcOrJFjYX4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112204; c=relaxed/simple;
	bh=AlGBGljytiN4hDB9oPg2R7DR+x7S1E5bboaK2Vh4TXg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FQ8UWwJAYcP2Hs9yqeUhcZKXYYEZu/ekD/LP9RNWTsUzycIpRmVX6RDJpxxzTyMEe03psc/y8NX30bncQgZQ16ZclIyYURm/zz1JWWG2L4imhaxAtyPVXu9EAh8itfE+46VEIbU6vxWnts+uYmaEjaYSq1rZMuCDidYyOFYGqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mLoe+VM3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TQ5NjmPb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mLoe+VM3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TQ5NjmPb"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IBHRQo2482392
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 13:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CC0Pys7yhh/moaCo/yEEim
	J2CkQSGIL8p0FbL7FdrhI=; b=mLoe+VM3eBbzaYBOL9UBa9fAAycg3gl9C+gUF3
	pmYIJd9yiNGV8ZCGxn3BugOQUZX/yjxDQIFqTrQFv8rPdPd/sxOq7kArRGOWZfg2
	3gJFGXx15kidvlcvGeaSqwkFzT8RIraIdYEpcFZS2pgEYxb079w03/z0dFQTIbHo
	wshfu9rHB+mHBfuBw6D7g73sHUhIVlcVQhS+GUmChkGt/TQPy5aB7HLG1AEwSath
	16n9rt/dT2NxVvoQv5e/tluuLHIT4V6NadgVmDyhMpzr7a2SQPatiKiBQGTQxMHV
	yvQZ1LXpF+YoTnRtfvQ3WGKewOIW58czwqxUZT8R28OhXV0g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81rvghwq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 13:50:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2babbeff9e4so25288555ad.0
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 06:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779112201; x=1779717001; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CC0Pys7yhh/moaCo/yEEimJ2CkQSGIL8p0FbL7FdrhI=;
        b=TQ5NjmPbPsG88J8Wl+xFT8WJDq4DAHUDtfyphkMGdgGU1pVwbTXjOYNBpPRUone/F7
         Xa1Id3W0122nVdeGlDKI9x9poebvzSnLp9ELQEiuAMIFUNrFJyNf6SPaMyy2C1bqZgGn
         vkbKIevPtlSEbmS6i4wNe4cc+/y4d2/KO9f7LgnCD0btH4OR8RbqHl0K6D/pwrXVSTEq
         xbIkjCFv8atzHLHLFysxDYEMu9/QbnMCWYDDrzDT61cU7C1zeN4cN1EVm2Fg48MH+GaY
         TxVhIDEJp6aUNSoAmSD4eHmgY2mqROcFf6enW/xotsmGetztoY1xBf7Cf1X0cUHRLHlX
         Y+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112201; x=1779717001;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CC0Pys7yhh/moaCo/yEEimJ2CkQSGIL8p0FbL7FdrhI=;
        b=lfHAXLo8aBi7QDbBmtbA/tz0yPmsXLk/siWZFa3RAbdz8OyiKAsEaRdotW3S2F15D5
         TYfLQnHh2bpq8QWYa9J1EnURcIs2+BEaNCv7Pgpxgr7Ok4E59IvWyEAUTlE2cUz38Lnb
         s0qYzVKa0y9dgtLTlWOSHjTrhoyhFQ09znKgWnrk1Fd+sYU1H7CaIJU7kLkKF8f644Re
         9gQJnuPz9ChwZ0xEpJW7LE0s89Ex3cIq4APSHsGdMi7LSp9zI6K8d1su4D3ofTdHfjyH
         STD10oLo/++l5Ea/W+2iPdzo1MRrJFAQUP8bHUIMdOZEnTOLu3jtQgzITSJ/VD3Nv3vD
         H2xQ==
X-Forwarded-Encrypted: i=1; AFNElJ9R8KMZ5a4Nh6pnD0wTZdnND+GNZWpX+XejTlf+O0aQf/jYyCaufvWjGO6fx6EuyclPF9Gf+kKwug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZ5mfk1xAh/nEC/IctX2nR2f+FJFLyt+q/hEpANF8SR1Tkyxw
	DGOixbE3XaYtxKbgMjiyAd7DdEexKFAumn958pKSptVUGKTCblnp6j1qXCnf188BO0Pb8Epm2sP
	Cq6FeW2I+eXx5cZJak5bCW20fbzT4XstkATaFyeTxMR2O7tAuhN2WIV4SfgHdz4XwixRG
X-Gm-Gg: Acq92OE/imdZBpr7z97TYUXlQqnq+FKcAmgIWYX4c5hgDMG5M0Ti15VxMNE281qImEl
	/V3ibO694zbOaXOqVLdRHmZ6Fn02UFziT8atu+U6OC+xUEktbeDoVuXplNPhgPb2pHyd/gUiNum
	yJ7Kr4+6DYhWPJVMpJKO25cHypUuRkR+qMuw095L2EvlgGPuY0y+0ws+Zp9Wi9nP+R1VwNKMnw2
	Ao4aejTqyGu8KJ6MMTsQOjStXXBmfw5YxGmEiLXRYVpVrIw1WB/eH5lu4zKHrkEEUjNMNEr5Xr7
	bnvgN/oFmgcvz52aMZySZ9hkquhrfW4mcVVmoUyWUnT5awOjIX7FwhGlKDBFm55MDL+glFpR1Bb
	imZn5+AGh56itP1WUhPNlPhh1maE83d781tDTBq93eEcVKYLhZ1FGytYngwE31Q==
X-Received: by 2002:a17:903:1109:b0:2bd:d6f1:3388 with SMTP id d9443c01a7336-2bdd6f13874mr43024635ad.28.1779112201412;
        Mon, 18 May 2026 06:50:01 -0700 (PDT)
X-Received: by 2002:a17:903:1109:b0:2bd:d6f1:3388 with SMTP id d9443c01a7336-2bdd6f13874mr43024295ad.28.1779112200943;
        Mon, 18 May 2026 06:50:00 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f36fsm185411275ad.21.2026.05.18.06.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:50:00 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Subject: [PATCH 0/2] qcom_battmgr: Add batteryless DC-adapter MAINS support
Date: Mon, 18 May 2026 19:19:38 +0530
Message-Id: <20260518-add_dc_in_support-v1-0-31fbaa329879@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPIYC2oC/x3MQQqAIBBA0avIrBNKK6KrRIg4Y83GRCuC8O5Jy
 7f4/4VMiSnDLF5IdHPmI1R0jQC327CRZKwG1aqxHbpJWkSDznAw+YrxSKf02mvXo3UjTVC7mMj
 z8z+XtZQPi7RmU2MAAAA=
X-Change-ID: 20260518-add_dc_in_support-f3f3c4dac6e8
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779112197; l=971;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=AlGBGljytiN4hDB9oPg2R7DR+x7S1E5bboaK2Vh4TXg=;
 b=AajfUv3+tI9ERd3k30BSORtEcMBzSPSdqFnpZ7pmCx16dx/V3w/9k3XHVKgWLxSiNMY02HevE
 bVGQ9kIT/fRC2yMO9VEQEJFwKPWUup4Bv9CVsr+OtqpuaRUAQILbwLL
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNCBTYWx0ZWRfXxbiHgzJSPchG
 8MJh5JvQ7xN0k4ZelCzHOYc39I9RagT50S+duEGK9Ap7tZu9ToiAg48npVOZ9+eCJVl9HQk201C
 h1Z1j/GdMSfm1KmTHLhN6kUZ45acuGxglVIn8DJnveL83nVD/mtIEgyf+fSi/VLCqyZGgYrztjE
 MwFk2u53oz01z9iN17ww0XXA8AGcrNNn91vBqvXnYr7NGfHIHup3V9sqO5y5IAgyuOCl4YSYFOr
 JNqcvnqLru1ci/3m/tRkaTE4elWX8mDHrJFm/LdS4R0bm2drDOAgc3RsdTosNiJ8TpShg0wno+I
 dR3QNR2o7Oz3Ikz8a75u0uqlp2W/ZbDpWpsclvdVKOKhgrNB9FBDlyE4pDKQ8d8W+3SPs6ZCUIt
 42k+NFwn7PLyhRZVqbaVh1B9RlngkIFqMeTPsp0HHroLjUOFzh7UYqR4uLHF1CXrbTmzlBQIw88
 4uT80UE0AIzpD6em9LQ==
X-Proofpoint-GUID: gAXyji2PF2YbHPts_mzJxpVLlWp246zy
X-Proofpoint-ORIG-GUID: gAXyji2PF2YbHPts_mzJxpVLlWp246zy
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a0b190a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=sIspjCRwiSg0d1WxQfkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180134

On batteryless boards powered by 12V DC adapters, registering the
power supply as BATTERY causes userspace to incorrectly trigger
battery power-saving sequences.

This series introduces a new "qcom,batteryless" boolean DT property.
When present, the driver registers the power supply as
POWER_SUPPLY_TYPE_MAINS instead, accurately reflecting the hardware.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Rakesh Kota (2):
      dt-bindings: soc: qcom: pmic-glink: Document batteryless property
      power: supply: qcom_battmgr: Add support batteryless boards as MAINS

 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |  8 ++++
 drivers/power/supply/qcom_battmgr.c                | 47 +++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260518-add_dc_in_support-f3f3c4dac6e8

Best regards,
-- 
Rakesh Kota <rakesh.kota@oss.qualcomm.com>

