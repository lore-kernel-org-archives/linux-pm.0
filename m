Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3135E1C1
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313561; cv=none; b=R1ansWnjag0pmdPcBGcErHbPmz8PEIkNst/RHmD0x1KzN2wnNQBjMSOIhcDyHoZsFE1Jx3vpDVujBun0qD/tAJRRvF1a77v+hiWLPXpW+wa7LbjbViKCKoHl8VypN1bgeRwpGCPY3h/ZmZ+gyFvUbFhKbiFNcF9LpbuZN3Iycmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313561; c=relaxed/simple;
	bh=KinhUJbjrVceL/4Wl+dsdy4Ce3twecfvD0JpSPSj5UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgC+9EH0Yz4CII3mw3laxhNKy0i+E6fdo+dS9MHBZXBhnN6LmsuHjABk1Wwexl11C8ekJb7NWYp1AxmSDbJjykL9c2I31Zu+zt7a9VpSFkrjSkftX1Fl8lcNb3ueOdxMSvre7f0zTINJTSpH145pF1sWl9tLDerus6WS6GbjdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i2lSDYN7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aCX6dJ7a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i2lSDYN7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aCX6dJ7a"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518did04110250
	for <linux-pm@vger.kernel.org>; Mon, 1 Jun 2026 11:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TcNMxS8xRhmU7EwCryiVhoez
	FRvWo2OX6g5i8iYoWQE=; b=i2lSDYN7NYJxU/JcM+TRKvV+SVJvK80al4qrAUCU
	TQXhsnY2ZjxRYmiDpGi12d3DHuxBWjrvuXXNhNgoDVoj+O5KL978gktcCEgT7gsD
	inuvM6f0jC2ryPNTVA18oQsQDxTraYtrnnYhRio5Rt1uZgUzOEdmzbC0nOSEPM4u
	0Yfjat9FIyckDkSK7ZDDFVq81tZ9qomJHOIwEv9rNTjYZj7PAJwd8j7ps41tUBbM
	gl9OjDIeE0Jt7Bm55yr2ATyP9Ux7IcS5NsT1wjw68rUYascAciT38gJz9WAer0A9
	LI+IIHr7C6eml5ARDUvwJLiUP1IEg4Y9lrUrdIZbzOC7tw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6s3rnbe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 11:32:39 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6c77c80d967so2065117137.1
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 04:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780313558; x=1780918358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TcNMxS8xRhmU7EwCryiVhoezFRvWo2OX6g5i8iYoWQE=;
        b=aCX6dJ7aKCyZqclKAa7Xlg99yK8GbwfmJw8CkCk+/zyLvhMUw56evDeTQgNzbGbmPV
         HEeAJ2UcJuYF8uxFtz4GWW517C8JjKJuBiFOKisxkwWqKEp9Jq15DRBOkKBZ/EdjJZIR
         WxtBrgreV+Uxjd3486CQOyfUVATz4l9OljzD5qepngyyUerJkkViqQUtuFsk0adGIF9I
         c9Ml/LxoWTyTk1BaHIw2+r5XSygkuwmCLInbIpGQyrsXpVM31Erdt7x5cgdj1QuXqe9Y
         b/2UvDBZKotJ6ZVKVBZSZyX/vMnir6wZK6rTVjlSHX+shx+28wDrK0kWTrCGvwLdZkFN
         Mq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780313558; x=1780918358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcNMxS8xRhmU7EwCryiVhoezFRvWo2OX6g5i8iYoWQE=;
        b=nh0xF4LhE7XY36mpFdAnmkuKMVeWC4Y0rgPOpAp5/9jv8y2GjDaUquJ8UESiKXiErC
         VFjTxvfbKeePh5wZFX7ABaLkPZC9SJ8fN0i+Ae7P1NEKv/Vqvuvc+GsgCHj+HGCLuHbd
         BUVgxagEBAMocuOuju3la4wXtbbYdEisto6luHRbqGZhHxD97LlUFSsQi/y+a3gE/I3S
         xWE3vqs8xC6HpmsLyyn0Ac5E2DUslbCTiYJruRTxutD2AWIab2p2o5DZWp+u98nL/GUI
         vuVsyMZx4Uifxol55ee9OU8r6IeQawd7CTYkVkMup0L0utK7AUXuDyDLsOH9bBxx31aO
         0WZw==
X-Forwarded-Encrypted: i=1; AFNElJ9Sn8xLvyF71Gr0x8ipsOjQRp0aLo5rG21ujFv8OgOMUwvRf8VGP91EzCmiWCaPJyHBHiCco4vmeA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk4g9R0ZGIZh6hRHWEH/PquhoUeuIJIVjRG5qn6jwHQYs7So//
	ODSo/oHz4oNxZg8V8yulcrVGvj8tipzJU6fzReB1pK2gXO/jd8bLSwy/RzvmmUjwkiNa0rN6qOH
	DlbfJ0G7sKlYIUmg8oLF/4Bk4SBHUJM1V7OIC5tPSoMjavg4IG8ofQozsJ3fBJg==
X-Gm-Gg: Acq92OE6E9aaJt4dAUUMP9uXTKu/2BUmPX6v3L+NabAw3dQRtvLCpbv5Id0e880HlSV
	ShW4lbynfDyIpTV8iYrLmquWDyzXJxGsuxE7XJnlPfZ5JHN9i2Jwt4IeQWMPA51l8XKR5MDyFJv
	fjdmhHViSuq64b8XYS8VJMx73uXdjgnQnkiHyVc1EtFSGgEtvSrRw5gyj4/d5Q17Hbyz1O0O7NE
	oPcOOJ4y9VN50V70kXSlGks7hftltjhhSyjVqS0zNdmtS9oFGUlbqfIxYK+bnFSvUZr7GRbnma4
	jGsQS0EdqfC46j+/RwCAKQS8T1MC3nSgYmp/FJO0LsS0GWIPg85C3ezlAid6M2mNpKPZV1ihbZ9
	v0AcL0Cf44C4eBh58MiTPnwt8MbvrBTemhkorbZKEBbSzmTzrWPjDLSTEuRwJrcz93i3syBXDna
	iKWQ3YCN5/8pN3Qw/OKYtOL2jNSlTYkPfnEcJeRdMjzTW6NQ==
X-Received: by 2002:a05:6102:9d0:b0:631:ff40:22b5 with SMTP id ada2fe7eead31-6c6a72cc962mr3699799137.21.1780313558121;
        Mon, 01 Jun 2026 04:32:38 -0700 (PDT)
X-Received: by 2002:a05:6102:9d0:b0:631:ff40:22b5 with SMTP id ada2fe7eead31-6c6a72cc962mr3699774137.21.1780313557681;
        Mon, 01 Jun 2026 04:32:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396840dcfa1sm6288321fa.40.2026.06.01.04.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:32:35 -0700 (PDT)
Date: Mon, 1 Jun 2026 14:32:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] pmdomain: qcom: rpmpd: Add Shikra RPM Power
 Domains
Message-ID: <l63dp6mv6nu3dquqs5mzjw3izg7rk652dszq42qddd2yj76yai@bhxr4cekvu7w>
References: <20260522-add_rpmpd_shikra-v3-0-632838e2428a@oss.qualcomm.com>
 <20260522-add_rpmpd_shikra-v3-2-632838e2428a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522-add_rpmpd_shikra-v3-2-632838e2428a@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=AP3YypGC c=1 sm=1 tr=0 ts=6a1d6dd7 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=uP2ZawwrIzpawsG4yqYA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDExNiBTYWx0ZWRfXzH4fHjWlMqAc
 796AeMZDOAL4gc0Xt0OgRx2aSuRRWfc5zro1U4uHLzvHkH3bpTZm4lXPd7sWaDKV2hkO+/dIkpm
 dQULizi064T9AQpD0jPPb8NyjZH6NYAzILFWAx5aK1PWGAdlT17UegROUX/iftRxkyBzuIt5d5I
 3+d1IfsGGWVF8daykikfADVSDWVPb9oUlSoHukXXxHVjzs8bAFoHFyUCYfE0lmYkFAm8V/koaef
 jKYOeETut5gIkO0JDWGalanQ+uXcMPnGVIRAfGjkrNh8NIjih7Gf74FOwQQ+KVe3RBSB2bJypOZ
 YlvndYvFgBFPEb373WirrhMn+DbvsfjdbEsxLfVf3Bb1NOswVBZ+el/VMs4MR1g+K8MQYx6Uir3
 dH84gl//X0kkYILOpZ1YvrqtFmYN+KBIYKyBE7il/eWC9YYFAgHws2fgPFznNM9nKYFub+YLi/J
 WFt/BvdJ3sb/JZIN6uQ==
X-Proofpoint-GUID: sd9QacVSxoa3-WS6kftQZA41huTm-NVw
X-Proofpoint-ORIG-GUID: sd9QacVSxoa3-WS6kftQZA41huTm-NVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010116

On Fri, May 22, 2026 at 01:51:55PM +0530, Rakesh Kota wrote:
> Add RPM power domain support for Shikra, reusing SM6125 power
> domains with RPM_SMD_LEVEL_TURBO_NO_CPR as the max state.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> ---
> Changes in v3:
>  - update the subject.
> 
> Changes in v2:
>  - Collected Reviewed-by tag.
>  - reused SM6125 power domains as suggested by Konrad Dybcio.
> ---
>  drivers/pmdomain/qcom/rpmpd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
