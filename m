Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018CF2F83A2
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 06:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504084; cv=none; b=VFsqQ8a0EurFpLzVw0v7BQhARyxefKkA7G7Lq7BKfqZ4X9ArJvHOM5ZMWei8FZiaFosyvYO/K6sq5ViRJ7GmZRxnsTXp3uzrZjhG2dKbkCXHr6tbRJox3YJh+S4mtzuAUKTiJC5oWTRZeDfX4vuMtFG5537V8xJEtDJY2uDIgN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504084; c=relaxed/simple;
	bh=RIPYm/CUa09goQMugAIcuhg/UpG0S64W4m2O0sjKqWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVCRwP5JEEOfVo6AlFWrijo0oyJCE211zD5ZDYdDbrsOKA0Ft8Ul7pt24b6j6srJlRi3NEbtXu1aQozzZl8Cd0jfa9JSYXl/xbM7OK26egLuq4eFkMQqtuErtwI+Liidad4omiipxVHg3Tev7qR/DFEYZJr/Io7AJ9p+IN5yfYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lHH6tC92; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xu1lS0iW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lHH6tC92";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xu1lS0iW"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F1iSVr2739642
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 06:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YProC4RAIvitDzBqe9nWs3TI
	F6R0TVSPPxcZHWa5Bo0=; b=lHH6tC929dKrqi7GucUZWtN0cq9wJHW+LhvEhXUa
	A3bFcKLduGBEmN8dtmeSNgEhikLtivuQFm2DfhZ75P4Ujin61ZCJjZpCd+7D0vEa
	A/C9wwbI6LSzL2xLFyX0lnJ+E9OpL1iVOTsf67jy26dQt/CYuPEqLAUKcXP9ngkn
	mR0OMvjqCgTyncDNXpgpdRjSkAVRYgkRlBKWwqsczv0yhXxIw5ytMz6g4429aUKs
	eZGD75GLsAJGcJ2pMn0qSgNTZiyP4vTFDPNOfa31ldxfDEta89UKwE5280L9WO6a
	+QGBw8c9jtHbEnHQHFcKh71wmaEOBX4Ub5WsQQ1HdTCumA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery9fdtuw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 06:14:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8604fbe71eso4085090a12.3
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 23:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781504082; x=1782108882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YProC4RAIvitDzBqe9nWs3TIF6R0TVSPPxcZHWa5Bo0=;
        b=Xu1lS0iWk08AKma2JpXSSOTX+eHo2k8qbkP8WRK3naqSXpYV5vvlPH/i2wfrIZo/eg
         MpkM7YZgDIydxtCRfCgN0EV/POZ/enQYZBpqBhLY7QxQFqpaInloQUBbLxg/QwzCcU5o
         FLoSgdoYNi9hLL1OZ8IGxzrUX/wX4Tugqhu4odRaELeT78EgZmdsNAmI5xclQMPhz9sy
         L84+bccW6zdsdmRenE3P+pYnWvPawoQa3rmXgbQO8tYjYxEWTGbf1Tlf+dgCIhNhnmaV
         /Npsra2uCJ3+96l5/h7tADJx0lM3fbvkawDcruu6QWX4+Gcp3YNoMnCyqKUZboKR3MKd
         19aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781504082; x=1782108882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YProC4RAIvitDzBqe9nWs3TIF6R0TVSPPxcZHWa5Bo0=;
        b=Rgh6iXMUouBnvwana9DNrfb2kGBDKuaEiAzIxacgrlS28jXuzTrS4nI3XBufaM396G
         GYPlh1JNwVVbCJNsrJGE5N28sr1hz9/EBa+R7S1N0abYHAHxLcX9csdMs8Eiv20z3PgT
         iuYJ08GN+n3x7TrxoctttyOlAJ/vZbnpVAA8Hd4FkszmGx6F1xKMkGDxyfj0MtNtAnbY
         8YO74ik0pVfOjX6U9ea/CjGcKf3WCDTMHlkn8A4irivbVui6lJjBv6qS0rRv0u7nFKFa
         IzX+2k/8r8HuCknR9zZFEHPNUXzejMS6KVWTrjr4P375zy+ih4DnxBidQz7LS4GreKGQ
         gsZA==
X-Forwarded-Encrypted: i=1; AFNElJ/iWFdT7gaTfV5vbzADl29IYCxRsBjt51ILkYVQQShUgfEaKousNuskJw/eVQgNsIGuQM6wR39MNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU1StVpxaUVbHYD3SUtIwjcfG5DxJ9s3XSEx00jcdak8RPNV0T
	9fGL9BXaGIhyiPYB9V96VDhwEmW74sdqL4ac4S/YzU3w5ufnKK+KUCbKKffWs3RRnHe22092+5l
	RjQDEO00UNKXux1FusYkwEY6JgbSV4TkiUH5epr3t0+9OB/b68qcqUcHaKjBwTA==
X-Gm-Gg: Acq92OFTeSRDrresz0sq6nRjyFTI/Vo4oi6Z/1zf1Vtw3ZVm6JaJGRtj7ezK0muEQBK
	u/Xn+ca84NOKeb6KVYrtQXz7OHGwGqpQv4jyzdKg6dIitnxYmFwIVxpX51kdCTa3YOxCMkEyfY8
	PFRq7Y6wOXUUp0/tBTfI7bc3LTJMV4QshYr64OgN1KgOQfs3pKl8x40FD2zylseDXcKZyIGbxhl
	SY08RXDeXnQI3G189OdpjzZJIMbhoWrv+NAtlDR19OBMdqj15x+NY2MNXrX7kqqJsfLw3YjFT7z
	z9etSt+Iu7YVlp31mvcj4tq1EeAw1N8Wkgke1p/IZdgMXAi+GTnd6Ti6BfX8IZvk4dXj+GF2Rp0
	+DEQ6snxsvgtnMAU5lZ91atoXq3zjCFKk09HnvB94gqBHIN4IXGpQ4Zs4P073YZyfSa0++piI6C
	wMZkJzU29wuOr22oxjF7yK+llf89KfQ/NjqZCb6zROHDBvPGnbbtI=
X-Received: by 2002:a05:6a00:418b:b0:83f:250d:59c with SMTP id d2e1a72fcca58-844e1a97288mr10503345b3a.39.1781504081636;
        Sun, 14 Jun 2026 23:14:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:418b:b0:83f:250d:59c with SMTP id d2e1a72fcca58-844e1a97288mr10503312b3a.39.1781504081115;
        Sun, 14 Jun 2026 23:14:41 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9bfe1sm9310494b3a.12.2026.06.14.23.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 23:14:40 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:44:33 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: tsens: add ipq5210 &
 ipq9650 compatible
Message-ID: <ai+YSXiHMolyk/YG@hu-varada-blr.qualcomm.com>
References: <20260610081241.1468507-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260610081241.1468507-2-varadarajan.narayanan@oss.qualcomm.com>
 <20260611-active-strange-porpoise-7dc9db@quoll>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-active-strange-porpoise-7dc9db@quoll>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA2MyBTYWx0ZWRfX7PrKjRa7Es3s
 04XIIV6NNNOojvVDIFBvkHHJdH70d5mrjvfJH/dF1/bSPFMg6ii0oXL6Y5mnrMcuwU/8oEp2uKI
 6prhSjxdzkI47FghGFXJSjTAkjO0JYF7JaUYX2YoIjEj2vodqww6dujBIl+V70TFDw6GCII5+ow
 NchUahk3KShnvnpdrS/DMbI0hbySQjlySOLcGYSfuWyigcyrT9FY+9MXnb/Fk2oDc6gYOU0rj9T
 Yquy+JoUkMMzcFtUQX+U2mOI5ceX9t8unqVELQmQaqfkTiStCxX0oVOXP5YYhDVY4j79sNvQOOJ
 6cm9GV1vTvQX6ygYzPczViOsdJw7+m7H3PNr9mCto1hAit8BvhvbXFmITOnn4R+bRPq7C4P6qFg
 RZbR46GY2r3XYnnY/7mzIyCeuuqoXUobi0E8beYiyUIao92lxPUWsvncriqeb+W/PgIXTktI3nt
 4vbk/KHXKanf9a6OSDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA2MyBTYWx0ZWRfXwdkZyBo5O9x5
 n0isBxb8hjYhSwMYOctpKie9mKy3aKCD5fPgemC0/VN0gpvFqmxVUGE0eo1IG7htQJzfikKkgOG
 FdOnB/y+E4Fr/0glxyDYn6gy4Gia4KE=
X-Proofpoint-GUID: eSqjpCL_PhY8wD9NEmxpEepIMT5cfr4o
X-Proofpoint-ORIG-GUID: eSqjpCL_PhY8wD9NEmxpEepIMT5cfr4o
X-Authority-Analysis: v=2.4 cv=ULvt2ify c=1 sm=1 tr=0 ts=6a2f9852 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Yz-oc_1U6DHBXyOLHCoA:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150063

On Thu, Jun 11, 2026 at 10:24:46AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Jun 10, 2026 at 01:42:40PM +0530, Varadarajan Narayanan wrote:
> > Add the compatible for the thermal sensors on the ipq5210 and ipq9650. The
> > ipq5210 uses ipq5332-tsens as a fallback, while ipq9650 is added as a
> > standalone v2 TSENS compatible with combined interrupt.
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > ---
> > v2: Fix fallback definition
> >     Include ipq9650 to all applicable constraints
>
> You already sent v2 and received comments yesterday.
>
> Please respond to feedback and version your patches correctly.

Sorry my mistake.

Have added the additional constraints to ipq9650. Will fix the version no.
and post v4.

Thanks
Varada
