Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56B279DA6
	for <linux-pm@vger.kernel.org>; Thu,  9 Apr 2026 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775765897; cv=none; b=MD7WLjRxzt0SNY8BYn/VU3hk0/twcwyBQKoC8H394R9Bc9aRj4PV6CNhvgxfHYRMROdPPva/wSRu/8Saxvcc5oIQ16HpPTey5C75mDa9JMkPJ0jUu4iK6pqhV+KaPWnLlzYgjziVMMJHcmt+zB48boqll5+CFj6fmJMlRAtnnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775765897; c=relaxed/simple;
	bh=ZUagoTez5iSBKk9anS0zp0RsDOFt6zUo873vCGlKftU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Hf2t2cu93cEDRJjwjY5jZzhe4aj11HdXNseF9sxM3eFF6AUe7D5jehrqYyiMHhXb5My/lp00HW0UeIijZJWDv/tperwkTT2mytPS5cX0P9BfbpbsNs2BNVBCplpaeJgS6VUJLcTiIgsR++2glZln1n6LbYqnRGHbSF0LnuDAf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lD6/8ExV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F+IFS30l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lD6/8ExV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F+IFS30l"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639JBT2f2866413
	for <linux-pm@vger.kernel.org>; Thu, 9 Apr 2026 20:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wgDHwK+hWYIpumn+2Wk7se
	Nmgq2LwTS2SjOeMajKm5w=; b=lD6/8ExVhD0ZjhlVWgXgx0nJVmPQqFN3Y/89GU
	hhU/eGWYqugwRxf5IPbSd0JfgVVj0VNoYbHqv8xnO5HtnRtbLdb7E0VrJxltGMdE
	xrNZCHZYgSKIewoiZx/9zFF+2mURN+Mgu2cMyEXoknZNZ+xeNvTBvy+Gwb/KpwdI
	ZvTgxxB2/KsVJA4QqNXQXLMEsBO+27y7bOXAHLB58NGmNe/i+r/kA67FvbXQSBz6
	08DMazH+tVA2byUQIl2v1ZBunE+VK9ygf4HUdNehLDv1XoQblIz5d2V1pv5DiouB
	FXLit8MqTH+J8w+9vQwW+U6X0KBzXYc7AQhtvttTCwgfwSFg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decayhpat-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2026 20:18:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d5aa81907so34787281cf.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2026 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775765894; x=1776370694; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgDHwK+hWYIpumn+2Wk7seNmgq2LwTS2SjOeMajKm5w=;
        b=F+IFS30lhU+7VI36APfqohNgGl7YG/UIDHIyBzWR7hn8O0hbM3uNefE6BeHDhssh6s
         9+wZ0+WF1I3v9L7fpb5BFRRy5htKqSvgi/HGYO0N/45t2Cnbw1c0wJAqXeZZ9PMEcVy8
         lEsJnm9+4A3jOALy//wHoyIIvmPxCfxHn8Hj3QnYqTNQL8oDZevLomrVozXBxmr4ugEY
         gmkzovRRl5qkmOd9Mm9fwVE5ZtiMbzj1reZxq78HlXv42iB80Bvdt7Ai0r9peFQIvxRx
         LRAJYqPdgWAJXx9AsB5R85NunzHLAO5+X0xGsueBaVJV7fORpWZ3yejXe/+zw1JGiE4R
         LhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775765894; x=1776370694;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgDHwK+hWYIpumn+2Wk7seNmgq2LwTS2SjOeMajKm5w=;
        b=JLeTbbOE0hOOjbvPQxxTUyzgpD45V2OAQqYfYq46WlYCVWzku8UJpmT79ZLwWZf6Jh
         JfVYOrYTwJRLIKtUPCw82YQ/qm575wsjnTTdQcM0KNLigf4SnEZk/NNg34TjjPBUuyDH
         8YJ+beYaXI9bj5Jw3cTeifNtvaodhwKkI6LrQ3Ol2VK6NKyK2vV2SXressC0jXcZaD6v
         tnRI3joBEqqg/uyR/Z4L/yQ65pjxZd+vukbBmjvnRYnOvEty1hPoVWkENG6ri4VqKbnW
         RNLTzDLz/oHAokc8nmGj9f8TH8XH0SKe9IIe+4XzD1RQBf938lQNbCu/FQAWQCQFixdP
         X9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWmTYdaXCtqMGxhitGOF4gdMJACDhS8IziAfo+JeuiVB0J8uMPfJ2aNjk2EEIQ15yWFbzq6iTUjBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvovorCw9TgN4syIXGZXwmMzhjgDMkgk1IKf3lrb+naIYDKCjH
	H9KsIERK8lz3x7UbSKmHbaom6UDbpOqngcnPALc9sBQGQkdiPuLsUZ6xEc5Y28wJJoxEI1CHB0o
	flOAUiRKHXwKLTvKguxvFrh1pXmJ9ie1gW0LzWWM8iknSLIF+eO1mWp1nV9NNDQ==
X-Gm-Gg: AeBDiesuv83qCfjpTKThn8NB30YKR1OOTxLjZ1VumivIUtkw17cotJ+G7qBOO8gQgsz
	G4M/9MxxSwgp/9Hnt7Pu4rGR2+GP8dza5P6pufrwLhIqHou9qmhoyQiLHQfLOsOWT7NQAzX1UXi
	opV+jZTIfsoCUAtSw+N4eOF5ZN5TEYt51GalHaoI5FvOUjYokF6Slt0gc9p9PrPrVPjtRbJIYIn
	Qg2yUqs0qnK5r95ffXI6xQ1CNdh20eY/hknxsBKkn7yvVxdZL7ESqMLsIWIW3UoUr8GO40/1Gi5
	Ng+737977MzH8v4jvUPavCumMxzeMPJQgXYaZFKTs/fC1WaNrNnhIMekOSMHMytfLKzOKw8oLR5
	3tYN1kTLxIaeE4lsWzunF70HLJL3AD2fCse/JVp4JIp3+Gg/qZYE1rXAiBhgqRoxJl2oKD5YnDu
	FIifSuaA==
X-Received: by 2002:a05:622a:8f0f:b0:50b:51eb:c353 with SMTP id d75a77b69052e-50dd5b77801mr7250441cf.31.1775765894301;
        Thu, 09 Apr 2026 13:18:14 -0700 (PDT)
X-Received: by 2002:a05:622a:8f0f:b0:50b:51eb:c353 with SMTP id d75a77b69052e-50dd5b77801mr7250181cf.31.1775765893832;
        Thu, 09 Apr 2026 13:18:13 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7170:4b1:90c0:91a1? ([2a05:6e02:1041:c10:7170:4b1:90c0:91a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec295sm1304768f8f.14.2026.04.09.13.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 13:18:13 -0700 (PDT)
Message-ID: <298af5b4-f008-4a09-a6be-7c0652392ea6@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 22:18:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Richard Acayan <mailingradian@gmail.com>,
        Manaf Meethalavalappu Pallikunhi <manafm@qti.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Gopi Krishna Menon <krishnagopi487@gmail.com>,
        John Madieu <john.madieu.xa@bp.renesas.com>
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Subject: [GIT PULL] thermal drivers changes for v7.1-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=69d80987 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=y5noMjRDpjWCs1RZGCQA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE4NSBTYWx0ZWRfX0LmiXoW/xGNN
 7uxZ8kPU1VdQ4hhS9ntlyZCA6T9aAPxk1hMX8BBLyFzaGFDou2gkjVfJeMA5T+YzJt5XsIcw4+E
 QLUv9MGOO5cCF8ED12ZFvLYH0KwfoTbmROPzT4ZGfsvqyUNIrwsEytGHfBxwlSuQzi0RGewhb45
 UW4I1iTx1GJb72k4d85r//u8HXuAojIa6zBGth58OfRdwAWSb3/4m0k4ARQUTCEXKH6lNdgoon2
 1e5xvv30ds/r7fVHqJLRCylMGaPqGg/Eh3y3s2BwL6BlnNZqhizsekVVIlTtbiOubYIUm4ElShB
 eAvbcJGbXmot1Ua3yQU3qn2HNabc+2Pw5TqlJSN7m0aCP1+Z2N8CewZS6PaXzpIQ5BOjpFnbEQJ
 5H4DTKEtG7Exl9EOIbtN9b2XAd2EWPv2T67UZff5vLXXC2+qYvL1EdCm33V79A2d6qVJc1bHzPK
 Ph5my3z1ZoZABU9eXjQ==
X-Proofpoint-GUID: pn0vMTjozN7IkmH4uoFAyZ91rIFpdoyI
X-Proofpoint-ORIG-GUID: pn0vMTjozN7IkmH4uoFAyZ91rIFpdoyI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090185

Hi Rafael,

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

   Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v7.1-rc1

for you to fetch changes up to bf746e2a41efd98668c97759e06d436ae5af5a82:

   thermal: renesas: rzg3e: Remove stale @trim_offset kernel-doc entry 
(2026-04-09 21:47:15 +0200)

----------------------------------------------------------------
- Added an OF node address to output message to make sensor names more
   distinguishable (Alexander Stein)

- Added hwmon support for the i.MX97 thermal sensor (Alexander Stein)

- Clamped correctly the results when doing value/temperature conversion
   in the Spreadtrum driver (Thorsten Blum)

- Added the SDM670 compatible DT bindings for the Tsens and the lMH
   drivers (Richard Acayan)

- Added the SM8750 compatible DT bindings for the Tsens (Manaf
   Meethalavalappu Pallikunhi)

- Added the Eliza SoC compatible DT bindings for the Tsens (Krzysztof
   Kozlowski)

- Fixed inverted condition check on error in the Spear driver (Gopi
   Krishna Menon)

- Converted the DT bindings documentation into DT schema (Gopi Krishna
   Menon)

- Used max() macro to increase readibility in the Broadcom STB thermal
   sensor (Thorsten Blum)

- Removed stale @trim_offset kernel-doc entry (John Madieu)

----------------------------------------------------------------
Alexander Stein (2):
       thermal/of: Add OF node address to output message
       thermal/drivers/imx91: Add hwmon support

Gopi Krishna Menon (2):
       thermal/drivers/spear: Fix error condition for reading 
st,thermal-flags
       dt-bindings: thermal: st,thermal-spear1340: convert to dtschema

John Madieu (1):
       thermal: renesas: rzg3e: Remove stale @trim_offset kernel-doc entry

Krzysztof Kozlowski (1):
       dt-bindings: thermal: qcom-tsens: Add Eliza SoC TSENS

Manaf Meethalavalappu Pallikunhi (1):
       dt-bindings: thermal: qcom-tsens: Document the SM8750 Temperature 
Sensor

Richard Acayan (2):
       dt-bindings: thermal: tsens: add SDM670 compatible
       dt-bindings: thermal: lmh: Add SDM670 compatible

Thorsten Blum (4):
       thermal/drivers/sprd: Fix temperature clamping in 
sprd_thm_temp_to_rawdata
       thermal/drivers/sprd: Fix raw temperature clamping in 
sprd_thm_rawdata_to_temp
       thermal/drivers/sprd: Use min instead of clamp in 
sprd_thm_temp_to_rawdata
       thermal/drivers/brcmstb_thermal: Use max to simplify brcmstb_get_temp

  .../devicetree/bindings/thermal/qcom-lmh.yaml      |  3 ++
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |  3 ++
  .../devicetree/bindings/thermal/spear-thermal.txt  | 14 ---------
  .../bindings/thermal/st,thermal-spear1340.yaml     | 36 
++++++++++++++++++++++
  drivers/thermal/broadcom/brcmstb_thermal.c         |  8 ++---
  drivers/thermal/imx91_thermal.c                    |  4 +++
  drivers/thermal/renesas/rzg3e_thermal.c            |  1 -
  drivers/thermal/spear_thermal.c                    |  2 +-
  drivers/thermal/sprd_thermal.c                     |  6 ++--
  drivers/thermal/thermal_of.c                       | 20 ++++++------
  10 files changed, 63 insertions(+), 34 deletions(-)
  delete mode 100644 
Documentation/devicetree/bindings/thermal/spear-thermal.txt
  create mode 100644 
Documentation/devicetree/bindings/thermal/st,thermal-spear1340.yaml
