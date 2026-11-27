Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789633;
	b=VvlmY/Gc7Wqd9Ny/E6f2yRAdNCqZOyXW6ZES8RGYKxhJ3CyNSc0QaDL0YAKniNFDRLVY
	 f99cupcXbWXY+69Fy8G5BYuCn0uRaSY/6jvMAWmAnvMxyPQYVgzbj47kMhV0+eImQy64l
	 n7If0KC1e3aUU5qjUoPwAifJsuDUa6EQw+d7pYmxxvllng1UybrLcesM7qSO3QjKUJWnj
	 gJETv30ZAqMezrlgGzSSKi4SIv7McJPJo+8WNk0IJ6VhhmmpcStjxtTZdSFBEwS2gW9sh
	 Y3RgPu024iJ3xN+cWv0rdg+lDFBLqgVqgBQnZLHrSmt5eobN4KI78L7tZc+6y68luxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789633;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1o6z2aU8TEfy6TuFMORcIkoD+2B5LKkELvOVAJXToCs=;
	b=dcAzmQAa3wu9DbZWk/TfecEeDE74QcTp1cYtz4nzkxGDAmyhyOdNGSL6gtEisQBJerSI
	 BltiXc8ZAAjDd3E3boqfI5ZCTPCNtIOif9hoKtks6vnZNcF1sPuiya5UatDVfnFXzeO8l
	 gAm5w98SUZ2EeIrsDScb7roDdYR0qKhnRobWL5pfAGd0IGQJr3mSf03WmqTIW6x1Kj4Ha
	 k5VaYIoOVlXpcXkbJZ/IfI9k93n0ViyivwQXPv5p2ZBucGczy1oFTXixtqVwcw5ptXPkQ
	 zF3Y31GAhee6M4vnyFZnWATO7Zw+4QXlCwZPnMd+O90BEYfdRCzgwKprAq8TMvEDb2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KNK1Bhz3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Pyp5WoYi;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D11B606A6A8
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D11B606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KNK1Bhz3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Pyp5WoYi
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1Opl686094
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1o6z2aU8TEfy6TuFMORcIk
	oD+2B5LKkELvOVAJXToCs=; b=KNK1Bhz35DSVTFgHwS5tWLGs9K7z9/xLYBDRmS
	jk8ytn1/vfdD5wyUEyz5a/LkuSPhAfL5nrv8O67WCBzTNpRBMS17A5BNGRjyuSha
	Uzge/oJ72qW8ld08UcPi61UQoo8cLLUpuNvBUa7p/ZMOFf7fkWIFDMEApvucAPz5
	hZn91+lnmK9GipkV0Y9xAp4bQ4gvPbpvikmlqWyFPos5dwydvqYjcPYhCbC74+rP
	Srb76bGCWbxiJaassc+PWgovs7hA6YLZa5K74XOXH07I0S4fC9T4P4nla9G06LJP
	lk7JRdFdTEfZGir9djWuXq6v05JTto94O7nCMi0EvuvWFqfw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u49bcx3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:27:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2f04e19d945so61651075ad.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 06:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795789631; x=1796394431; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1o6z2aU8TEfy6TuFMORcIkoD+2B5LKkELvOVAJXToCs=;
        b=Pyp5WoYiQXBdWBrznKWw7ZldgLQaMm6x7dALpSSdWAwBrMgoFN0MMeQ/V78whrKp60
         cyfxfOLWpVgzjtYacIwwKDNkXBhnE3EuQNyHpUFL+NHm6MSFmQ6G+iP7H8knc8HA7IOL
         y9RniRENgPWhj6BywMXMQKckF0n9eb2lblAIv1SWucSrjL2rehZA8WvvUvcT4mAWNogt
         4Btj4H3RphjSFMWEQd8dTN8JIWYBLgct/9oCTJd3h5MAdxgLXW/neHdwh9cXbJZ6tVRP
         G+p8dDZuhewGD3efhh1+CenZ0qBILyDwSpUKuTdaTtL1g+ZoSB2zGYzP2xSQ4tSEpCGe
         TlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795789631; x=1796394431;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1o6z2aU8TEfy6TuFMORcIkoD+2B5LKkELvOVAJXToCs=;
        b=x3udNNlGDlJrM/krqxIcXcFkivGu2k/H+6sNTmDMnD4tFFaikslwiNfCwWuxos75Tg
         3tXMeeBalw9PBTfuisl3P+4f7wARfdF6D0N4JwScqUb0n9rtYbztPtq56Cv0Ol65m4VA
         Oi4qcDH0L7Pb+XxMevVd50BEAv4+PmVj3JgAn6HjGvD4CfHejV5s1KvyUZmQ7Ih+1JER
         TFeb4NQXWq1h3/Fp2tpuizbm1TP4ek6VmMgTDKbCc3zH2TocykVQ8ixn8EaAf1Pc5k/6
         CUjhYiPJmKkZMxTOjBpMoTH4VgEvYEv4xKwfoSyDTUKySoTha4wjam5EaSn3/Z3dkNZh
         4ibg==
X-Forwarded-Encrypted: i=1; AL+hErEbfTD5MkATKa2T7njajd/Z2FeCQL73cmyKFwH37iDM7fleXImFkKsLlssIM4/KVRqfc+XDZjRX8Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9F9qURVuWJ7eJip7QG0kk+c1/Kq1sRFAxsHR/CFppxYbODZawa
	XwIDa+Pu5vzkIkfF+XinJR9d8ujz/mNQg9v9msXLsc1WLfdnUst/0rNaWoyHRaUR0mfQaA9mtWz
	YhAHeGwpxxCYPPvSxTD0qDVRMvYaG6WC7AZTqNMuIQ5i+vWVM8xug8/w/l27C4w==
X-Gm-Gg: AZFdTZe4gOMxf/CLv9L3fbgv9UnnotLqpYVW1siTNVhPhmRw2Fg9gAylFBBBjl+HOw4
	mg+6Hkuln5kmgf7ydIVj5MZY4Ig06TsnAppEwKy4ZnYgj8WZa4wRlMhke4gdR17ZZ8OU1PiNtqd
	97N2MnoPhwur9SjCaQdhAzLNmxvjh39lChi87uRx9z7NPRkFwLPxJLgGKgUpviZ8H4qAQ5IaZgL
	lj3xThmu9nrCPACxB8SsAMDpJPMQbnl1CKUN4vSo7lzWjBglHzWMn6vPqwfduzOEMM2VRd16rbk
	hhetEJ6+YUSEO/rtmVGcAoCW+9tOhsV6LGP+dcrsc9F77nkWLR1GR4jSooytH5E9HneK7H69ILN
	nbp8FShpZhryoYQYzZzumJM17fIIk3MSSzWSCRVRbJcQnmBrckP2XA/Eprge+uQjImw+McjQKfc
	yGyEFx4hKoMA==
X-Received: by 2002:a17:903:2f90:b0:2e8:422e:19c5 with SMTP id d9443c01a7336-2f03f249c41mr244195785ad.55.1795789630380;
        Fri, 27 Nov 2026 06:27:10 -0800 (PST)
X-Received: by 2002:a17:903:2f90:b0:2e8:422e:19c5 with SMTP id d9443c01a7336-2f03f249c41mr244195135ad.55.1795789629532;
        Fri, 27 Nov 2026 06:27:09 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84285sm120324055ad.3.2026.11.27.06.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:27:09 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Subject: [PATCH v28 00/10] Implement PSCI reboot mode driver for PSCI
 resets
Date: Fri, 27 Nov 2026 19:56:53 +0530
Message-Id: <20261127-arm-psci-system_reset2-vendor-reboots-v28-0-da05a33b08d8@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC2TCWsC/53UUYvcIBAH8K9y5Lk5dGaMY5/6PUopasZeoLu5x
 u3S49jvXl3KZqEV3L4EDPibiZm/70OWbZE8fHx6HzY5L3lZj2UB/OFpiC/++E3GZS4vBlBglFV
 u9NthfM1xGfNbPsnh6yZZTjCe5Tiv27hJWNdTHmmKrBSRTzENxXrdJC2/roU+fynrlyWf1u3tW
 vesVX39p4RWnSXKtlGNYi2hZcSZ4qc15+cfP/33uB4Oz+VRK/+XGmDGwAxB2Pyt1g84a33ftO3
 mdeHnhAIBNGPEFg93POhuHgrPNviIEglAWjze8/3dY+GnwDMgasOOWzztPGvTzVPh0c7gknE+O
 t/izc47gG7eFN5GQa+YLSfd4qcbr9UD3U91chx7mb0HlObZ253X3Ykq2wpPkyg2IXqKscXzzgN
 gN8/17CF5J3aS1B5Md89zN+9qWENwZlIGVXNy4HYXTAoV9fJQUxuTnZHKeKKFFq93nvrnHq6pj
 cmhtdaIbR0OwM4b3d99TS2wN2EWZYmbPO68fYDH60VJBqMhjtCae6CdZ9U9OVBTy+yANVpkq1q
 82Xn3QPc1teR9MlG5YGLz1053fP9gwjW1QAJILCzNw7mldtIKulMLNbXJU8CUNBoX/sFfLpffY
 PAHl4kHAAA=
X-Change-ID: 20250709-arm-psci-system_reset2-vendor-reboots-46c80044afcf
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sebastian@collabora.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795789617; l=20380;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ohXtc7Kgzw68dyyMSjb1S0n2khn+lfJl2ZvmqcNl82g=;
 b=viX/f4hnTWhtlzVC0tLk3USdVynD2koxDcpDyBfKM0XtqS3lycLwOi7ktvzSM2ARRvf5iYyhe
 VOWuxZ0rJEeBsO+qJ3AB5lCYrfUrsfyvNdsmLPSjxL5+Bg1YDNMXRFP
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-GUID: 17P1E0bw4_XXABYtRZa7z0XCWomXMAri
X-Proofpoint-ORIG-GUID: 17P1E0bw4_XXABYtRZa7z0XCWomXMAri
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfXyMNdiWCPS95z
 0p4S7vBuUKvt7vOTvgWC511x/wp1tNPjyYAQe3r5YPC+GP8F+9QTx2sH0qcB39FBdC9uJ66/PNr
 roeeBLOhsNDVYmEw74JHNk3My342zcM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NyBTYWx0ZWRfX6NqjIrleHasZ
 elS02lootxk2UKvVx+jILws1j+sjANNdSHczgQPe7/axpYPg2OkQ5Nf349GH3hl39pCgmzgz5Ty
 ebJ/5zvz65QUemo4gbwUYjW67HqVoIhiXKMSl6MX17y+GNzgipgZPq5+Mfxv321W6pMAsojGTXa
 c6Ww56mVMB5HE12QKE4AVeW4p6ernCfAw+/YP2As59xzaJIOLu7baqCbkIH4TnLqauUCf2kh5po
 kaS3g8SjjUMin3p6pnQwSpiYcSUtIXdbwCNvi6JKjjQccSCEObtYMd9pCvoyLh8PZHgQO9VSU52
 aOGXb+/HioTbnXANq6mXFOHuaICRBiH+nZhWrELNlarwyhpqJFf3Oxm7pc/pakFQOjuRfi2Olr/
 CjfpARnM5+FIq2hBSBZgZ6SV7ID9rnj9L+mb/UWABr+Abezsc3OzOfx0bkiDLf1sF7/GiVlNZCD
 n2GrenzSrYsA82+m5lA==
X-Authority-Analysis: v=2.4 cv=A875rKWG c=1 sm=1 tr=0 ts=6b09933f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8 a=s8YR1HE3AAAA:8
 a=etiEgX_XAAAA:8 a=Q-fNiiVtAAAA:8 a=ag1SF4gXAAAA:8 a=JfrnYn6hAAAA:8
 a=NaAwsCBgoBuX6sx4gZIA:9 a=BFgVCsvohV6piVbU:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=jGH_LyMDp9YhSvY-UuyI:22 a=MLbIUA-Bjd6y1alW9qBG:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270057

Userspace should be able to initiate device reboots using the various
PSCI SYSTEM_RESET and SYSTEM_RESET2 types defined by PSCI spec. This
patch series introduces psci-reboot-mode driver that will induce
command-based resets to psci driver for executing the device reset.

The PSCI system reset calls takes two arguments: reset_type and cookie.
It defines predefined reset types, such as warm and cold reset, and
vendor-specific reset types which are SoC vendor specific. To support
these requirements, the reboot-mode framework is enhanced in two key
ways:
1. Support upto three 32 bit magic values as arguments. This enables to
support for a 32 bit reset_type and a 64 bit cookie).
2. Predefined modes: Add support for predefined reboot modes in the
framework.

With these enhancements, the patch series enables:
 - Arch Warm reset and system reset cold as predefined reboot modes.
 - Vendor-specific resets, configurable via the SoC-specific device tree.

Together, these changes allow userspace to trigger all above PSCI resets
from userspace.

Note on introducing psci aux devices:
Based on feedback from Bart, Lee and Ufee, PSCI child functionality now
uses aux devices instead of an MFD driver, with psci-cpuidle-domain and
psci-reboot-mode probed through a common PSCI aux device enumerator.
Reference discussions on this:
https://lore.kernel.org/all/CAPx+jO9Hi2R_UnCEhsXLwf74c3RTb+RodaJ6SOVXbQX_eHt++A@mail.gmail.com/

---
The patch is tested on rb3Gen2, lemans-ride, lemans-evk, monaco-ride,
qcs615-ride.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>

Changes in v28:
- Updated to use latest prototype of kzalloc_obj/devm_kzalloc_obj - By Sebastian
- Rebased onto current linux-next.
- Link to v27: https://patch.msgid.link/20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com

Changes in v27:
- Removed unnecessary headers from psci-reboot-mode - By Bart
- Rebased onto current linux-next.
- Link to v26: https://patch.msgid.link/20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com

Changes in v26:
By Bart/Ufee
 firmware: psci: Add support for PSCI auxiliary devices
 - Add a static struct with device info - By Bart
 - Move full multi-device registration code into this patch - By Bart
 - Remove extra header files - By Bart
 - Change psci-devices and cpuidle-psci-domain to arch_initcall - By Ufee
By Bart
 power: reset: Add psci-reboot-mode driver
 - remove compile time check for PSCI_REBOOT_MODE config
 - select AUX_DEV in kconfig for psci-reboot-mode
 - Move full multi-device to the preceding patch
 - remove extra header files
By Rob
 dt-bindings: arm: Document reboot mode magic
 - remove refs from item entries
- Link to v25: https://patch.msgid.link/20260914-arm-psci-system_reset2-vendor-reboots-v25-0-4aaf5c09b5c2@oss.qualcomm.com

Changes in v25:
By Bart/Lee/Ufee:
 Dropped:
  - mfd: core: Add firmware-node support to MFD cells
  - mfd: psci-mfd: Add PSCI MFD driver for cpuidle-psci-domain cell
  - mfd: psci-mfd: Add psci-reboot-mode child cell
 firmware: psci: Add support for PSCI auxiliary devices
  - Added a PSCI platform driver to enumerate auxiliary devices.
  - Converted psci-cpuidle-domain enumeration to the auxiliary device
    model.
  - Added optional psci-reboot-mode auxiliary device creation.
  - Added MAINTAINERS entry and updated Kconfig help text.
 power: reset: Add psci-reboot-mode driver
  - Moved PSCI reboot-mode support to an auxiliary-bus based driver.
By Rob:
 dt-bindings: arm: Document reboot mode magic
  - Addressed format chnages.
  - Fixed dtbinding check error on maxitem.
By sashiko/ Alignment:
 power: reset: Add psci-reboot-mode driver
  - Added a 32-bit system check for 3-cell cookies.
  - Added stricter magic value count checks as per the PSCI reboot-mode
    ABI.
  - Added in-code documentation for predefined PSCI reset modes and
    cookie layout.
  - Avoid registering the DT reboot-mode node when SYSTEM_RESET2 is
    unsupported.
 firmware: psci: Introduce command-based resets
  - Added 32-bit validation for PSCI reset command cookies.
  - Updated psci_set_reset_cmd() documentation for PSCI SYSTEM_RESET2
    reset_type.
- Link to v24: https://patch.msgid.link/20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com

Changes in v24:
mfd: psci-mfd: Add psci-reboot-mode child cell
 - Remove the explicit check for availability of the reboot-mode node. (by Bart)
 - Fail psci-mfd probe only on fatal errors(-ENOMEM) while adding the
   psci-reboot-mode cell.
mfd: core: Add firmware-node support for MFD cells
 - Allow MFD child registration even when a named child cell not present,
  to align with of_compatible-based registration. (by sashiko)
 - Move named_fwnode logic to a separate function.
power: reset: Add psci-reboot-mode driver
 - Remove dependency on OF. (by Pavan)
 - Update for new changes in predefined modes.
dt-bindings: arm: Document reboot-mode magic
 - Fix the example DT entry. (by Rob)
 - Use unevaluatedProperties as false for the reboot-mode child schema.
firmware: psci: Introduce command-based resets
 - Update in-code documentation. (by Pavan)
 - Update namespace-based exports. (by Pavan)
 - Use synchronized write/read (smp_store_release / smp_load_acquire)for
   the reset command to support lockless atomic reads. (by sashiko)
power: reset: reboot-mode: Add support for predefined reboot modes
 - Remove the predefined list in reboot-mode and add a pointer to
   reboot_mode_entry. (by Pavan)
 - The registering driver fills and manages reboot_mode_entry. (by Pavan)
   - reboot-mode list to append reboot_mode_entry.
power: reset: reboot-mode: Support up to 3 magic values per mode
 - Add separate write function pointers for single-magic writes (existing
   drivers) and multi-value writes. (by Pavan/Bart)
 - Update count to u32. (by Pavan)
power: reset: reboot-mode: Remove devres-based allocations
 - Drop from this series, Sent as separate split-fixes patch.
- Link to v23: https://patch.msgid.link/20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com

Changes in v23:
mfd: core: Add firmware-node support to MFD cells
 - Add named_fwnode-based firmware node support in MFD cells.(by Bart)
 - Update the release path. (by Bart)
 - Add checks for duplicate fwnodes.
 - Update documentation for usage and limitations.
mfd: psci-mfd: Add psci-reboot-mode child cell
 - Update for a named_fwnode-based reboot-mode child cell. (By Bart)
 - Split psci-reboot-mode and psci-cpuidle-domain into separate child
   cells.
power: reset: Add psci-reboot-mode driver
 - Add COMPILE_TEST in Kconfig. (by Bart)
 - Update to support up to three u32 arguments to accommodate a
   32-bit reset_type and a 64-bit cookie. (By Sashiko, Lorenzo)
dt-bindings: arm: Document reboot mode magic
 - Update to support up to three u32 arguments to accommodate a
   32-bit reset_type and a 64-bit cookie.
 - Dropped reviewed by from Bart and Rob due to considerable changes.
firmware: psci: Introduce command-based resets
 - Update to support a 64-bit cookie. (By Sashiko, Lorenzo)
 - Update the flow so unsupported reset commands and any failures during
   reset command execution fall back to the
   Linux reboot_mode path. (By Sashiko)
power: reset: reboot-mode: Add support for predefined reboot modes
 - Handle errors and free lists in devm_reboot_mode_register(). (by Sashiko)
 - Update to support up to three u32 arguments.
power: reset: reboot-mode: Support up to 3 magic values per mode
 - Patch for 64 bit magic renamed.
 - Update to support up to three u32 arguments to accommodate a 32-bit
   reset_type and a 64-bit cookie.
 - Dropped reviewed by from Bart and Sebastian due to considerable changes.
- Link to v22: https://lore.kernel.org/r/20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com

Changes in v22:
By Bart:
  power: reset: reboot-mode: Add support for predefined reboot modes
  - Add reboot-mode helper to add predefined modes.
  - Add centralized init for reboot-mode.
  - Dropping Reviewed-by from Bartosz as changes may need a review.
  power: reset: Add psci-reboot-mode driver
  - Use reboot-mode helpers to initialize reboot-mode driver and add
    predefined modes.
  mfd: core: Add firmware-node support to MFD cells
  - Use callback function to get fwnode from a MFD child cell.
  mfd: psci-mfd: Add psci-reboot-mode child cell
  - Use callback function to return fwnode for reboot-mode.
By Pankaj:
  mfd: psci-mfd: Add PSCI MFD driver for cpuidle-psci-domain cell
  - Make MFD_PSCI defaults to y as ARM_PSCI_CPUIDLE_DOMAIN defaults to
    y and depends on it.
- Link to v21: https://lore.kernel.org/r/20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com

Changes in v21:
By Krzysztof
 power: reset: reboot-mode: Remove devres based allocations
  - remove fixes tag.
By Lorenzo
  firmware: psci: Introduce command-based resets
  - psci_set_reset_cmd() only takes reset_type/cookie as input params.
    - updated this as a encoded u64 reset_command - from Pavan Kondeti.
  - Update commit text for reason for explicit panic_handling.
  - Clean split of reset flow in psci_sys_reset via handle_reboot_mode and handle_cmd_reset.
  - Add psci_has_system_reset2_support() helper and PSCI reset-type defines.
By Lorenzo/Bart
 power: reset: Add psci-reboot-mode driver
  By Bart
   - Drop faux-device based probe.
   - Convert driver to platform-driver model (probed via PSCI MFD).
  By Lorenzo:
   - Use PSCI-specific predefined reset mode naming/magic.
   - Register arch-warm predefined mode only when SYSTEM_RESET2 is supported.
   - psci_reboot_mode_write to directly pass reset_type and cokie.
   - Add MAINTAINERS entry for drivers/power/reset/psci-reboot-mode.c.
By Bart
 mfd: psci-mfd: Introduce psci mfd driver for cpuidle-psci-domain cell
  - Introduce psci-mfd driver.
 mfd: Add psci-reboot-mode cell via fwnode
 - Register psci-reboot-mode from psci-mfd with reboot-mode child node
   fwnode.
 - Update reset Kconfig dependency to tie PSCI reboot-mode to MFD PSCI path.
For alignment:
 - mfd: core: Add firmware-node support to MFD cells
   - Add firmware-node support to MFD cells.
By Pavan
 power: reset: reboot-mode: Add support for predefined reboot modes
  - Move redundant logic of adding modes to list to a common function.
By Arnd
 - Remove refrences for Linux reboot-modes from code and commit text.
By Konrad
 - Updated all dt changes to add reboot-mode for supported board files.
- Link to v20: https://lore.kernel.org/r/20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com

Changes in v20:
By Bart:
 power: reset: Add psci-reboot-mode driver
 - Check for psci compatible in init arm,psci-1.0
 - Node pointer should not be assigned in device probe.
   To Align on above:
   - Remove probe call for faux device.
   - Set node using device_set_node after faux_device_create.
   - Register the reboot mode using explicit call to psci_reboot_mode_register_device.
 - Updated in-code documentation.
For Alignment to use of device_property_xx:
 power: reset: reboot-mode: Add support for 64 bit magic
  - Use device_property_count_u32 instead of device_property_read_u32.
  - Check count of properties before reading.
  - u64 magic changed to u32 magic[2].
  - nvmem-reboot rebased on recent changes.
  - Update documentation and commit text.
power: reset: reboot-mode: Remove devres based allocations
 By Dmitry/Bart:
  - pr_err to pr_debug in case of invalid reboot-mode prop.
 By Bart:
  - Use device_property_read_u32 instead of of_property_read_u32.
  - Avoid repeated code for free list. Now calling unregister from
    error path of regiister_reboot_mode.
 - Fix magic assignment.
- Link to v19: https://lore.kernel.org/r/20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com

Changes in v19:
- Add missing To/Cc entries (include devicetree list) – Thanks to
  Krzysztof for pointing this out.
- Fix compilation error in reboot-mode.c for ARCH=powerpc by explicitly
  including <linux/slab.h>.
- Link to v18: https://lore.kernel.org/r/20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com

Changes in v18:
 power: reset: reboot-mode: Remove devres based allocations
 - Update commit text for alignment. – Bart
 - Read magic before assigning kzalloc(info) in reboot_mode_register. - Mukesh
 - Update error handling path. - Mukesh
By Bjorn
 - Expose sysfs for reboot-mode bisected to different series-
   Link: https://lore.kernel.org/all/20251222-next-15nov_expose_sysfs-v21-0-244614135fd8@oss.qualcomm.com/
By Bjorn/Lorenzo/Mukesh
  power: reset: reboot-mode: Add support for 64 bit magic
  - Use FIELD_GET/FIELD_PREP for u64 magic wherever required.
  - Update commit text and add documentation for structure of 64 bit magic.
By Lorenzo
 - Remove direct reboot-mode registration by psci driver.
 - Add support for predefined reboot modes in reboot-mode framework.
 - Add psci-reboot-mode driver and implement a psci-resets to accommodate
   all psci-resets including warm, cold and customizable vendor-resets.
By Bjorn
 - Update DT patches for qcm6490, lemans, monaco and tolos.
  - Update commit text to include more details – By Bjorn
For Alignment
 - dt-bindings: arm: Document reboot mode magic
   - Update reboot mode documentation to clarify that argument1 should provide
     full value of reset_type along with the 31st bit wherever required.
 - DT patches for qcm6490, lemans, monaco and tolos.
   - Provide full value of reset_type including 31st bit.(eg:0x80000001).
- Link to v17: https://lore.kernel.org/r/20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com

Previous versions:
- Link to v16: https://lore.kernel.org/r/20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com
- Link to v15: https://lore.kernel.org/r/20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com
- Link to v14: https://lore.kernel.org/r/20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com
- Link to v13: https://lore.kernel.org/r/20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com
- Link to v12: https://lore.kernel.org/r/20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com
- Link to v11: https://lore.kernel.org/r/20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com
- Link to v10: https://lore.kernel.org/all/569f154d-c714-1714-b898-83a42a38771c@oss.qualcomm.com/
- Link to v9: https://lore.kernel.org/all/20250303-arm-psci-system_reset2-vendor-reboots-v9-0-b2cf4a20feda@oss.qualcomm.com/
- Link to v8: https://lore.kernel.org/r/20241107-arm-psci-system_reset2-vendor-reboots-v8-0-e8715fa65cb5@quicinc.com
- Link to v7: https://lore.kernel.org/r/20241028-arm-psci-system_reset2-vendor-reboots-v7-0-a4c40b0ebc54@quicinc.com
- Link to v6: https://lore.kernel.org/r/20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com
- Link to v5: https://lore.kernel.org/r/20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com
- Link to v4: https://lore.kernel.org/r/20240611-arm-psci-system_reset2-vendor-reboots-v4-0-98f55aa74ae8@quicinc.com
- Link to v3: https://lore.kernel.org/r/20240515-arm-psci-system_reset2-vendor-reboots-v3-0-16dd4f9c0ab4@quicinc.com
- Link to v2: https://lore.kernel.org/r/20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com
- Link to v1: https://lore.kernel.org/r/20231117-arm-psci-system_reset2-vendor-reboots-v1-0-03c4612153e2@quicinc.com
- Link to RFC: https://lore.kernel.org/r/20231030-arm-psci-system_reset2-vendor-reboots-v1-0-dcdd63352ad1@quicinc.com

To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
To: Souvik Chakravarty <Souvik.Chakravarty@arm.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Andy Yan <andy.yan@rock-chips.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
To: Conor Dooley <conor+dt@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: John Stultz <john.stultz@linaro.org>
To: Moritz Fischer <moritz.fischer@ettus.com>
To: Rafael J. Wysocki <rafael@kernel.org>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
To: Lee Jones <lee@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>
To: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Abel Vesa <abelvesa@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Andre Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
Shivendra Pratap (10):
      power: reset: reboot-mode: Support up to 3 magic values per mode
      power: reset: reboot-mode: Add support for predefined reboot modes
      firmware: psci: Introduce command-based resets
      firmware: arm: psci: Add support for PSCI auxiliary devices
      dt-bindings: arm: Document reboot mode magic
      power: reset: Add psci-reboot-mode driver
      arm64: dts: qcom: Add psci reboot-modes for kodiak boards
      arm64: dts: qcom: Add psci reboot-modes for lemans boards
      arm64: dts: qcom: Add psci reboot-modes for monaco boards
      arm64: dts: qcom: Add psci reboot-modes for talos boards

 Documentation/devicetree/bindings/arm/psci.yaml  |  56 ++++++
 MAINTAINERS                                      |   1 +
 arch/arm64/boot/dts/qcom/kodiak.dtsi             |   2 +-
 arch/arm64/boot/dts/qcom/lemans-evk.dts          |   7 +
 arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi |   7 +
 arch/arm64/boot/dts/qcom/lemans.dtsi             |   2 +-
 arch/arm64/boot/dts/qcom/monaco-evk.dts          |   7 +
 arch/arm64/boot/dts/qcom/monaco.dtsi             |   2 +-
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts         |   7 +
 arch/arm64/boot/dts/qcom/qcs615-ride.dts         |   7 +
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts     |   7 +
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts        |   7 +
 arch/arm64/boot/dts/qcom/talos.dtsi              |   2 +-
 drivers/cpuidle/Kconfig.arm                      |   1 +
 drivers/cpuidle/cpuidle-psci-domain.c            |  35 ++--
 drivers/firmware/arm/psci/Kconfig                |  14 ++
 drivers/firmware/arm/psci/Makefile               |   1 +
 drivers/firmware/arm/psci/psci-devices.c         | 120 +++++++++++++
 drivers/firmware/arm/psci/psci.c                 | 117 ++++++++++++-
 drivers/power/reset/Kconfig                      |  11 ++
 drivers/power/reset/Makefile                     |   1 +
 drivers/power/reset/nvmem-reboot-mode.c          |   7 +-
 drivers/power/reset/psci-reboot-mode.c           | 101 +++++++++++
 drivers/power/reset/qcom-pon.c                   |   7 +-
 drivers/power/reset/reboot-mode.c                | 208 +++++++++++++++++------
 drivers/power/reset/syscon-reboot-mode.c         |   7 +-
 include/linux/psci.h                             |  15 ++
 include/linux/reboot-mode.h                      |  27 +++
 28 files changed, 703 insertions(+), 83 deletions(-)
---
base-commit: a9c48428cbd8d96b26f92631d0db6f8519c5fcc5
change-id: 20250709-arm-psci-system_reset2-vendor-reboots-46c80044afcf

Best regards,
--  
Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>

