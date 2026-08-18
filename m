Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A12A2BEC45
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047234; cv=none; b=ugH2tAREp/nD55ey0Ckd8EX1X+c1cX2tY+lHFZXtkBWFewiCDjzkR/f4FSVokp4ivfXFU7OeZVOUhv6niwOu9btohVIxdMoYIZKLL25LI0FB8VGGu7w7KqKon7pvjYMS5gl+3ddaQIQTVs1a9NJ7LDSMALiJcv3brH4lYlMe6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047234; c=relaxed/simple;
	bh=DGHCyM6EgNROxkjHqWkuJzh+ya7ky284zeTkekMfqtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0VavzESvDbrFqG4WMhTiLMsn/FhcMAbcvKfSoLavQu6VD3ifZhugdk22+/pGOLAr5c47CMn6qAs947SpkaOV48lYLexjxfWCH+DiazQ4iOAyzLROEYIfdnGo9Rw3ZXAyLucjK4EIUE/v3hQzOp3Rvg0jFLzrYN8s/JMZFcDzLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z5HyMVuM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L5HKg6jr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z5HyMVuM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L5HKg6jr"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I8BKWw547275
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 10:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CmC2OIm3QkWdoYT4PvRcnLDW1LDruaDVLoidQBfzW4g=; b=Z5HyMVuMfyYI072v
	J4PgVkyIprWfDUtRP6fncs4Ay0NsPNgezNEM+DNK1cO320NjgDzGXinyYdAVMRIW
	MpraNxa6B+ouCuhSwR52oyU1jx3jR/mKz3u5UAaKmqupNv7RRMYgM8tGXa2N10mI
	YaORhRLaoTAMZ9Lr7iKNNFsqY3g2JkK1sRvkoegD4+gbEIzxaMt2gxDD5PMVmnkz
	PXHSd5K96grNzqTCsViWqoz8uOuJpBQqZ3MSuob6EFLJdwoaX0zAR7qSM3OhSFvB
	1vcivmo9zNvxzPZqYs0gVIPIaLGJTHgQD7qJluxjj/7E/w//GZkw+H45AfUmm4oZ
	1/mezA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4g2p1dpt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 10:00:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936e393061dso275411785a.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 03:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787047231; x=1787652031; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CmC2OIm3QkWdoYT4PvRcnLDW1LDruaDVLoidQBfzW4g=;
        b=L5HKg6jrB1ihYHJLCHpY4XFblfGYo/F0h4YT7JbXayi9BMvp1/iDU5aXeoAnMzsDwT
         KO1VFMQ/7MfVkZ2kOCc9f5jUXEHKYCjCF2wvzsZTvrJfnvGL8QtZE+esTLHkSUC954R+
         Vow433DJfaB+GrLkaFjWO1sIUVpZevS9e5tJa6PhOk8ND4gPCVBhNDgwxcnDYGqwUZr7
         0+4aee+U51XZs4Pd8581ZMxdG+R4G3O4YbxdNgyIxChqyjnmXHSPl+xApxZ7Q7lXIw2q
         JgcBK3Sp91r0cDpA2NZLPwWNXVtVHfjS2Bg7b4qqXHqw7hE3LToDKasPXdBH2XVpkPQP
         1KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787047231; x=1787652031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CmC2OIm3QkWdoYT4PvRcnLDW1LDruaDVLoidQBfzW4g=;
        b=O0tw2SKKsSvFT3FWGziDkctfpHwsvrS1tDbT/jcTeeTFqQowZpRGgw8XsvJY7M+uha
         L43LgoU5epFoOHj76cM/uDeZG2oAuBho7fz5369NsITKTWmfZl85Sh9Soj7CxsXLQu7O
         C/DnKoC6YMNvw+IfX149YLyVaq9kAYwae/R72R1i/xG/Eda9TffSJZIdZczdP9Riq5Ao
         oMY3GvtvKY+p7aCTH+UbmvJTkTumMPGgYmYE4r2r3al8ifatOpHX8E/fS0TqDPRa8G1L
         OUKyRUuJcDD5OGNl+iqxfpbqA/lnGybZkyBN2EFpMXoSofp3GWDAeNXn1MQOToPv0D83
         gEHg==
X-Forwarded-Encrypted: i=1; AHgh+Rro/xW3OHRmZVb4iNEFn+QmbfO9vI0GqiyQbTa8gVknHUzOHdnkLdTdemA1jJwwZ+2dfCkBx7EzpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK0BhCXYCz7ZpkbR4Ec4i6+T9mWwfmXbQ+Bc0RwSJIssF7X7D9
	PBwE9mxMOhDLqSY16FMYInxqGWSB4lNqaGaxmnzN647rd+9ur2xkSQCfwP4ofjDlY0fweM1JoZG
	y1m7w6TZ1jQbuGDo9oWfvLoREZ9iPeglCWR9NFLEdwSql+UvEPt9LRSWbxWMUIA==
X-Gm-Gg: AR+sD11SxPzAj93HU+mJrD61bimMtcWQ5p/H9F1MiQijUVfGrfb9sx8vSuBKMOWfJ9J
	RSQDtDp++w1vsPeTYz11rMpqY4FBtBOfQN3vB4USL0r9c0aiZo2xbYwa0VadNk2OnGc2SJ+OiL/
	z6e46eknFo45e6ZFJ2jVFjm52r2WHAQSRAPIGjuDV0fRB86dtVeQ8jtpFa1a9Jt09Vmn1XXqLIO
	fyeDL22GrAb+PnVO278LH5f9mK6DFVvVoFN0y8ZlaEHF36Xda5wIGUoWYN+vt6+3UO0u73jLEy2
	wuN6FuWsUotdd3aXduKC4WGvoeNu0QPkujf343x3AQjhxU28xfJBcLp+WhJ9Ctnci+CoabkEsX0
	C4z10UB4ifGFlNEg=
X-Received: by 2002:a05:620a:2683:b0:915:673a:617b with SMTP id af79cd13be357-936d22cf71cmr3145480185a.24.1787047230938;
        Tue, 18 Aug 2026 03:00:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2683:b0:915:673a:617b with SMTP id af79cd13be357-936d22cf71cmr3145468885a.24.1787047230252;
        Tue, 18 Aug 2026 03:00:30 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499877d5548sm269379435e9.1.2026.08.18.03.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:00:29 -0700 (PDT)
Date: Tue, 18 Aug 2026 13:00:26 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wangao Wang <wangao.wang@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Add missing MXC and MMCX power
 domains for Eliza
Message-ID: <pzfjctbfuqghiluu6w6wteihsx55xudursi2ifsqylqgc2jgux@b2rgwlctk2l5>
References: <20260810-pmdomain-add-missing-mxc-mmcx-on-eliza-v1-1-5e10fad1e456@oss.qualcomm.com>
 <CAPx+jO80r_QF-hqGuRV4BnHyKoub3+j3EPbnZ81ejz+wKBBQ+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO80r_QF-hqGuRV4BnHyKoub3+j3EPbnZ81ejz+wKBBQ+Q@mail.gmail.com>
X-Proofpoint-GUID: gCdXiXqBfcUyQhJKB5MK6n_0hCzchzbT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3MyBTYWx0ZWRfX52CY29cYI8SX
 1AbUvtR/o7e93RffJBwwCQ3XhzceVEU6cORebFz96CtEguB5rp2Anj90hiLjc61xwtVYILKuN70
 SvK/31FZLuhEfmbD0QyNMXFS0noJp3w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3MyBTYWx0ZWRfX9ddM1dWzXZVK
 B+MPbZX3axof1BNkSD3g9bWxozzRgCJo0c+OSeLqFrecZctnYgJ/5XsauvVKB7Awb7xuqto/gs+
 Kd9ntHVapWKv3m17QfptgrfIr7P4iyc9Jh54KPg4zoug6Fw2APKMBcYJ8lvxbON+DTWdsDTy0W2
 g7cB4ssEVrM3rX2uu37pDvAuy/SiJvc97oD8jdRloDyEalmIZTnK9U5TgaHHnahyEFJwkMgHnb9
 JMfIzuaqKhEVTe1rp+mAlt36paQgJl/PiA44pxqQL2iL54y9XYJTLHU4zsM4sBXrmBlcucQde06
 M3D5lsd+qzoVFmW5psJz3qJxJBnZKBQ+Xr+fpgQtBl8c9+wrB85O7tgXQIg0Ffbbd32APEfP3l7
 5be6J2VKUe6ndvJt8+mEd9lwp5u93y+6l6XdSW0nUnvwXsD1jd68b8H5OcU5vUlerEtP59DHH+Z
 jyr2TNX4r0NAdZuooOA==
X-Proofpoint-ORIG-GUID: gCdXiXqBfcUyQhJKB5MK6n_0hCzchzbT
X-Authority-Analysis: v=2.4 cv=bfRbluPB c=1 sm=1 tr=0 ts=6a842d3f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=V1eyK7yU7IpJqu2TsEMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180073

On 26-08-11 12:30:42, Ulf Hansson wrote:
> On Mon, Aug 10, 2026 at 1:10 PM Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
> >
> > MXC and MMCX were initially omitted as they were believed to have no
> > consumers, and they were not present downstream either.
> >
> > The Iris video codec requires these power domains, so add MXC and MMCX
> > along with the MXC_AO and MMCX_AO.
> >
> > Fixes: f387ecdd492f ("pmdomain: qcom: rpmhpd: Add Eliza RPMh Power Domains")
> > Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> 
> Applied for fixes and by adding a stable tag, thanks!

So I think this one needs to be reverted after all.

The MXC and MMCX are indeed available in the cmd-db, which has been the
main source of information for this until recently. Also, Iris video
codec bring-up engineer thought they were necessary. Meanwhile, after
discussing off-list, it has been concluded that these are indeed not
wired up in HW, therefore, even if they show up in cmd-db, they are not
actually there. So I'll send a revert for this soon.

Sorry about the whole mess.
