Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9210E3D1AB9
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643275; cv=none; b=XFTUuODWL1aDz3Fjl93908Y5sV9Z+465br5fCDuHIgNKdEW4saKWsxIkVZ/F/quCY4nsSCKesnwweeB3uDJ6WrO0QYDKp04FR6P05cylL5XexHC+EXOeGJM+Cil12awTEh0LnwZdh75bWLXa0nReQJ43K9uUad9Otndmg53vynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643275; c=relaxed/simple;
	bh=vyxandif7e2Gp1fI07oRfATGNarPjCLDQXEIPwqMsj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQvHp6EgMALgIeFEe727HqWuM7RhQpQzTYYjx7z/xCMeExQkNviEvvD8EVSoTGk0mDeK070TiJ9NE8OIcFUxmOPSluGmsXJbN86WQUfYWL5g7R+exXRosdHySNiY8E4GibT4G5s+qwt+c4Lt42cAxbZCEjZQ+x3mRrQ5c/xYrKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DY16voI3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ff0XVv1k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DY16voI3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ff0XVv1k"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2R4kN120411
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 07:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LBVWgoEVbNT5Sr8Zx0TYZA21QAWuf428PE7XhlhKrEE=; b=DY16voI31GQlqpoc
	rwvFVORgU8wBYhbpGGcXOl4xJYbnE5McA7OBUZr1Sc9saBkwbku7J1DBuH9DuEHg
	R/YZHQr39cVLvwcJBXKQK65lXtkgSKwwZtqNGN84xG5lArPC/v3PPyM9ZE8tqveE
	CPwL7+2/iQ20sW7OTAHwDNsxkRQuHmXy0/Z+sl5OLplfHkFP0anChhmMLR5QXwpu
	UOn3UnV4hx5q/45eVfYgQtT8DjOKBDu/E6fcwsaxtkyaAqsGbB9LDJ+GMprisG0u
	XB7NHWgkeBb4cXC++1qD0Q57AsLAkXKfRB8XsgR2qmurmcLNsQj4UDlKbmtKa6T3
	VIsqbw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8t3dtqwg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 07:34:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5174a23afcbso63460501cf.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 00:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787643271; x=1788248071; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LBVWgoEVbNT5Sr8Zx0TYZA21QAWuf428PE7XhlhKrEE=;
        b=ff0XVv1kXlcRDpNmBSnnRUJQ/59WHCtABUcwKy2jxgv3uJWwwJmqDWrM+K3WSSpM1k
         GBoLWdFz/wSPHpDTXTIH65sNx9kMfy08WQX97a6stBsdxrB7u3ygfkN/1huH+MmwGLBX
         96RnnYwz97gMMXnqKJUj6sp0bxcuVosNAP2IrtA5smONshMJjCYcWfBxArYKpECuOcJq
         Qy3r6ew7opNWCdRScEOls1AHsXH/jNGCygcQ+jAlObIXs1jbzHReFxbUVGUmFqNNRSZf
         buj2EIkEpv9ffQ9vDkTx6dfJM4tzcy7RbJzvFFx0IjaQtgoute20gyS9FeTG+1xMa44p
         UP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787643271; x=1788248071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LBVWgoEVbNT5Sr8Zx0TYZA21QAWuf428PE7XhlhKrEE=;
        b=iAQt6S/mN+8u0LCQeh2+wSlgxmuHbe+OFSSPPkljdJMbmkUtgOqKzbrtzU3Wk4uPM5
         ooSggx950Kjk1qmBNMB2wQW58Uq3YFqaSi9zktMD4uhSeKusKrCHCRvqiLw998X3SZ20
         ucpUa2SEjXm/J3U90nT+S4QWUfI4z5aasTsx6JMvj1CRqXOzUWNJ7Maiux7JBDItsT5C
         2vEhn5EgTOPq/STCmufOB8uMiAqhzZuiibRAN74K8X5NftImDYWaxmZOa4SA4T1+Fdnl
         NSOFtgEQ8JSWokSMtaxDDhArzz2QlUv6aw1QZIQA1T9TJuCgZJwJA5YZ29dR3uBMjY+W
         yzCw==
X-Forwarded-Encrypted: i=1; AHgh+RpFwKEKLDgc10hGNTZiDjBhlE2oCXmQeu6E9VdXxl9+ZqKJOuCByeTdNAZSOy5/Yh3haQs3zn4uOA==@vger.kernel.org
X-Gm-Message-State: AFuF++m2JA0/7NZtvjGARzoS5uuuLEST665eS1zRuyAa4k8+g72IIbUL
	1iHBcOwqDJWxQ9s1o3MoVK7ArmRqCfFxN6dJkd8T5Q5ll6loCJgiYmbOqtfxvnNf61p/uJfa5u3
	zDTMtF1Us7V7YRNdIrFG0+vdVUTL4ykhFcZEjgbbCWKfBNIQHaNahK+/QVbDXsQ==
X-Gm-Gg: AR+sD10ud6FFb6+rciku9AHZwrAHHFro1+iB7cd1U4H1uhlD/ky9nEhdlAijZqpEPcS
	YJqUTGQrlVRWsOFWu/BvpaluEiO7wMTrrjMFlgvDEbm0wtBgMPLhOCWfxzuO+nEp5KG7DkX4O9e
	qyq3iPhWFJlo21IxRPqK/6t6tIVPdRid1eKKNXe0gZuNCpi7OXDUoA8e52LJ5EQll1ypkcm34nR
	Z4Ytg6pjerr8l8SKhAPndqAkmOJpDwmg1L+aIVZkyaQ8+jAM+m+/2/yhEl3p43iwzxC66ctMf1U
	GLfMPLC4j2Zt6wDFi15ksHtq6gd/cU8bG3r03erowaovANhYXTEhetPVlQGIA8X/F/7Ic9IqzLa
	CbwuyH+4iMTAr
X-Received: by 2002:ac8:7fd5:0:b0:52d:9637:554c with SMTP id d75a77b69052e-52e2f17ff37mr48128501cf.43.1787643271518;
        Tue, 25 Aug 2026 00:34:31 -0700 (PDT)
X-Received: by 2002:ac8:7fd5:0:b0:52d:9637:554c with SMTP id d75a77b69052e-52e2f17ff37mr48128051cf.43.1787643270949;
        Tue, 25 Aug 2026 00:34:30 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1790020366b.8.2026.08.25.00.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 00:34:29 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:34:27 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v8 8/9] arm64: dts: qcom: monaco: Enable CDSP cooling
Message-ID: <zacwmavu3huggr5tb3f4pqxw6ca7hsxuaye7okqgoh5fnnf6zf@73yke2jd5eia>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
 <20260809-b4-qmi-tmd-v8-8-b15d47adc379@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260809-b4-qmi-tmd-v8-8-b15d47adc379@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: SFx2G8XQ3hRDlnaykmjcvJvDZ242_q2A
X-Authority-Analysis: v=2.4 cv=OLAXGyaB c=1 sm=1 tr=0 ts=6a8d4588 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_nN_CDt7C_a4776dohAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: SFx2G8XQ3hRDlnaykmjcvJvDZ242_q2A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA2MyBTYWx0ZWRfXw9E/CLFg8jg4
 kT/jZlGoAag2G4JoGLTDrKSewM/yD1BOr2vY9s/EoiVN3VC0tFvVNalAk88sAuD9+FJQqd0yzJL
 wYqddAv8pmQLDOKCF960D+J+dI1xZXU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA2MyBTYWx0ZWRfXy3J97fECXxLL
 QSEOuGxt1MBGTM2/9eiJFY1KhtvAGpO7UcR0rIRU/3u624WsWUaNqID8M3nzd2EtLUA9JXjtIzY
 hym5ahGuk7jYaY7rVh5uH/gvS5I2pEmQY4eN53mvL2CkK3LbvQV9Aw5qbFiuTC9j0g81C5qtjGD
 Ip4yUXth9MpHJok2iSZAVHzREqEPZeB3FDsIymFBoOlBNMTPzAawLXTq+0efLhSgPwj+ZsRpRyr
 w3N4f7vVRijyWoSvSPhmu24F4eo6BiI3D2nnZ3WQa1nmZXEBQ+KG7JbNL+SUIQqy5YgBAsLZVZ1
 ol6T5klI5/AxZAyMX9tfVPe3YveNo4KndgPnJCYo/Qkq0bG8AkE19prHAjscj0VKrz1mQd1EMA7
 ma9KfKd8em1GfKgINXx28/kOPlywg7L54AAg/c/toFoCTcMlG/O9Hyq+PxWJf2pAyzcwsuDBe/A
 eRHMi8BorCi5viMC1FQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250063

On 26-08-09 17:59:04, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in monaco.
> 
> Set up CDSP cooling by throttling the cdsp, when it reaches 115°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

With Konrad's comment addressed, looks OK to me, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
