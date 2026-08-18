Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0B449B19
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046857; cv=none; b=OFNEYgE2p1jm5n8NaCSHnEov6ZRf0WwuJiCX26171e4jTs8Vvywkbo/91wc5q5uS7dOJ5YgYYWhp7vrKZBMvryY+WUZBr/2oNei0UyBljLvizPAw88Z3AyhEk2B13Ghh0DdHUUp1CFIj0A8449+H6rl7Ue4XiI3hHrvCZLh/Gy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046857; c=relaxed/simple;
	bh=zy2JFeTgpyJs32UM9HTCRmf/W1CVw+Z3BoFu0sXvHyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESDzO6fAAWJ71BlsdR/yU/xuB5dLiq3j4Rz8aDyMrs870LpKgGAEUy6+/JxdKKgceXThd4hrzht9plVM61lEgWdVSpXHNZZN7yzJKZyAieH6ttBleW02a+4ZlNZsq8+W8HrHL/jR0ZymjOFlnaaFTcwO/c2xD7O6kY77dXEDhWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A0o/HeB1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jn6C+bIJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A0o/HeB1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jn6C+bIJ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I8BLOs310046
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 09:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=r3Mm+8oCJJc/ap6W3LUSX/4Y
	m6UjXCdaaNW3eV8U8VQ=; b=A0o/HeB1yychTlA9jQWEZWE3C57LT9ihqc7C7RkA
	YXuevxtWWBusfs7HynoY1y70sDWPvlOaDVo4+l90mRFR1LkMVsJrfXuBP+0G3H3J
	nOqDGZ/nXRfVaCIncsK3Z7cl9VQ1YgWbdNZg4KTLJFfYXJITGa5r6U65sWoRnlr8
	uR2mRg8gEEXoTgc1KLENjGYx7YWP6nH7AkMDGAPwbB45qZmpImUssdIW97rbvtdJ
	Ueq48qri68SwPgb/Xcc9SbDFyl4EzqTVSoPOpfdlHUHshD+q+FwSYViRUKXQ1/tB
	p4jqsflIdboUVEys0R7UTUk3fiL9jfI5X0f9ruHRmijN3Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fba9k17-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 09:54:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93494527488so736853385a.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 02:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787046854; x=1787651654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r3Mm+8oCJJc/ap6W3LUSX/4Ym6UjXCdaaNW3eV8U8VQ=;
        b=Jn6C+bIJ/MADS92ipSF6rTAZ1okyFo7wxZ+og7NugyKZPACG7gGi+56GjjxdIEnymC
         m2XU/TYDEPYkA4XXypOkl/ZP7FgqahstsGXzMTS5IgfY5oUqdAbF0MNOVEmcW0UsldLU
         nxxpzAzZ0ALpHJXd410nqqHRRyeV8u0YoOjtpkP4du1uZcW36ag/0g/VybYcayNh8RUS
         V1Ivf9J9zuWS1OHhwOT4XjIsVJ6eeI0sHlxRpOiibhUiEA47NKreyHZZaXJikgz7PPly
         GkfKKSO8Xt+PyFXwWr6Aq50BY5au/aiula2vTsFq1KK26N32lPmkYJ5QeUY8aU0h3bfx
         e3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787046854; x=1787651654;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r3Mm+8oCJJc/ap6W3LUSX/4Ym6UjXCdaaNW3eV8U8VQ=;
        b=rR5xfNVHim8BEQAtZYYuv84BTKiXLBfxX/JqUo3neG/TlDGVaGd+kZdz/oE9GxZPBy
         orK3niTM0iv3xld+wyL1e9wvNIHKMbV1+1BpT2vwkpetvpTViz/+SZC2eR8PsLAtks3q
         N00nIpMJgxpeIPNu4Cc3e3rMB2Vx05BFBZZ+9ChRuTo6Sj5UDyOymzI9pR6JbxDIZ2mc
         iEvtQQOXSs0xgJfAlpmTFj++C3FbVvp0/a7GZQqHFWE/WrJy7pQPwsvmPoof4RJlkQp7
         ySCWG2+azdhgBiJw1gG52jo4T/K//gqVfI8BkCLf8gZ2hwYMOFL1kDYDxtGNN8rFZpt0
         gWZA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4XnzU8RSCMy31v5rnGUiaH8/VqxgHQyCovS3ekSfvvJVaVDgoaxT+ROigTV7ONzB1A/lPv+pbYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmVrljyGjC+DIQdJU5iA1WHFppN0A1QXrQXF2eEPrXYLKnnW8
	Q+PpXvpz1hr41A2P5IzqlJTSdrifK9MozK6eSv4/h0mxIGSjfD6OwQ3wH/SzE4os0rCRPc+OX0K
	o6RkiMECa08z4GEE0CGuhVJH6TYNLTiXG/bzma6qBhA/JZFM4TmICfLknYtX5uw==
X-Gm-Gg: AR+sD107WWoT/u18baJpPDTe26AhGnDybo6EXL82EqPL+NS+ydSa1+I5kslBPylNXVY
	QVu6Vy4kopNhUy4oTeb+8o3wORYlsDScE4wuAbIo7lF6+XrbdmHoXhvUFLEnEI/F0rFPzup+a2h
	IermaSEKOfXlz68IUM2Uy2iqIXwa4XUqoSbMJEvOmLWEHtGlHl9YwbQeX5E1P79Tu1n/EFDZmvE
	BCtUoP3fG3WfFegYG5C26Swep1zORvqZ5NZFsFRKo8DPE//oMehB9I2h9PKjsfbFfxhC2DXFlOZ
	UCg0tp8YVyDJoSrHSiG0RDnXLBNgswuyWAJY8GYRR9LygnxJ7CSZK41sC+l33VAPb1F+bFZYYzR
	oiE38BRz6/D4q790=
X-Received: by 2002:a05:620a:5cc1:b0:914:afc1:c66d with SMTP id af79cd13be357-936d201c77cmr2685404685a.11.1787046854081;
        Tue, 18 Aug 2026 02:54:14 -0700 (PDT)
X-Received: by 2002:a05:620a:5cc1:b0:914:afc1:c66d with SMTP id af79cd13be357-936d201c77cmr2685401785a.11.1787046853563;
        Tue, 18 Aug 2026 02:54:13 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999619a7c3sm208222495e9.15.2026.08.18.02.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 02:54:12 -0700 (PDT)
Date: Tue, 18 Aug 2026 12:54:10 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wangao Wang <wangao.wang@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Add missing MXC and MMCX power
 domains for Eliza
Message-ID: <jcbosjb5hg45lklhou6d75vbvqqjgno5vsrrvhlbzx3hukqjtn@5nowx7zdjxxp>
References: <20260810-pmdomain-add-missing-mxc-mmcx-on-eliza-v1-1-5e10fad1e456@oss.qualcomm.com>
 <wcmnmidvbgfr2zmkb7vs7rhrwrxutca3lbfd2xb4llzfqqv7w6@bzddrstbb2xd>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wcmnmidvbgfr2zmkb7vs7rhrwrxutca3lbfd2xb4llzfqqv7w6@bzddrstbb2xd>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3MiBTYWx0ZWRfX7v0LcnJIWMYb
 rlbn9LHcLduW6RNQzJQeF0viW4j4smt4gGpFmFio8tPpWSXrsnA2HBIh4MEq8KMzzc7qGV45CFP
 iSEYoGhd7D+6R3MlBmgTlqNfayaLCXg=
X-Authority-Analysis: v=2.4 cv=VsITxe2n c=1 sm=1 tr=0 ts=6a842bc7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=1so8R-_4SYReG1rYBfYA:9 a=CjuIK1q_8ugA:10 a=QYH75iMubAgA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: D9PYZmZYGPmzlHt92AhzjYzMWVNJLJDP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3MiBTYWx0ZWRfX0qbd49Xpx63Q
 LNAVw1gqRXdyEypPGxnWrrNEo0cm+nANowzlCi30cFFdPt0b96wQbSFxWURERu4QsMD7GGIUaYO
 GoRJ2oX2oONX+7VcoVXIxelNikyb7HxMxjzoOr241/zNF136hY34y0VymRvr959JeOTWfcDacdO
 Xzi+XlMA7q3lL0h3zHA0lZ9ZLgTe+4wDeBAOr6itDQQN5Gnz4exfm+YEx5VYNK5R/II+GpxdZel
 o+y24yGr8lf0g9E5lUvUJY+6LYN6uw9BJoDj0w4v+aSYqGNOyk1XHFOVjQBG0PLW/aE1a0w2OQ2
 dVwGJ5CrymHUXoyI0su6iLYSnmkiYBUbu1lo5wghwgRa3PeWo3AUPIOrQrEkN0UZLJH3PfP9TO/
 79aCAAcDqRpStlTZVwEXTnkPiEFNO1Ks8d2W7aeVZ82jmiWAjbYOUbsM8i3Ieu4G5RUDALw7PaJ
 1lhFeWeY3dsj7AOWOUw==
X-Proofpoint-GUID: D9PYZmZYGPmzlHt92AhzjYzMWVNJLJDP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180072

On 26-08-11 17:09:00, Dmitry Baryshkov wrote:
> On Mon, Aug 10, 2026 at 02:10:38PM +0300, Abel Vesa wrote:
> > MXC and MMCX were initially omitted as they were believed to have no
> > consumers, and they were not present downstream either.
> > 
> > The Iris video codec requires these power domains, so add MXC and MMCX
> > along with the MXC_AO and MMCX_AO.
> 
> Is the display completely sitting in the MX domain?

Sorry for the late reply.

Yes, it seems display is in MX only.
