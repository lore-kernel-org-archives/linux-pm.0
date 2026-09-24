Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0551030E82E
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257724; cv=pass; b=qjr6wshh4y3dwqHwKGAmMEYwIDwcO59aOQrJdq9AUKmsTy3TpRpY3B5T1+vQRWiNUzqNvYjus6UfwcUpoBJMUjNb7puwfi6p5dart5b9bT9kGTvj4Rj9CHvKEpRG3Qi9ZiskVryf3zZNwKR7O7ZU+EWJEfS1gpO0QAkaSzbDk+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257724; c=relaxed/simple;
	bh=gIzGgpbn/bLfRecbbJR8idZ+V5oVFq52ZNmGReij2M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTiR50YWLZquX+vmXhth5YlQHGeY+lzgiNAwQbFeeASFK+/xAK486tM/PSgQYzGNj6G/zNJzaQfQOWfhcYlHM7bFg4lSl7lYBYjNTRmHHbiJTrfIESt1zGySjqi9PZNBKtcp68PmPcHlnwiGkFL+7BR8bIcmJFXue3jVQCy4zZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eHjiz8y8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SrUM1yW8; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eHjiz8y8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SrUM1yW8"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC54iW805059
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 13:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gIzGgpbn/bLfRecbbJR8idZ+V5oVFq52ZNmGReij2M8=; b=eHjiz8y8YIHa5or0
	11zmYv8N8YFWNIrLMP+nSz2/CY2JsZMAGAiyHU7KTwUOLrN/RgQ55IKjEboEug1E
	nydY3hdgllD8W4Mbr88/Vb2+WaKgXhFBIxOTgRIgZ0m1mdrkgnEUJ4ZQ3yEAZh/n
	u534i+M34SCuyNfiBEd+Sei3pRJLNbufiIlZqP1o3sJIz6cTwDK/fAjOqRTU8T4F
	lU+6mFAQdEnJEAuk+6PGMgD1LnD72JlZtJIFbFDz7ulf1r9gFBFFty2DO1wwRiOt
	y4aPrllNI8TZVUbHydTUVIQUDEoW6IWah+KSKq2AJDUEVqfPwzQhEAMUr/0r5QHX
	WbYPfg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1sc8vgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 13:48:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db3734d06dso19081115ad.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 06:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790257721; cv=none;
        d=google.com; s=arc-20260327;
        b=PMXYp+ZHQA7FoYWG04mj/BCFV2dz9v2IERYxoVcpiAcSGT7ERlEaTcmGrQU7EjV3gu
         2APJvESV4ZRrFBZmjcaDLdhyKFwI+xT/58zTxAgwM1MhZZE7DgvXE+FPd6U11z8JJZMJ
         2S4uAi0Q1LHZXM448D3ScAnW05wlLQmcKAtaoJsU8SAee53Zae2f55SmrE4ovfvAkU9U
         FDa+5xZiQPXIKxaSvD+M+cTYi5z0TCIQO2slppJ2UzqJBW94KkaApyt72eVAIFy3+Clq
         oZONMOI3G9NisxKzSbloPsoKjy2qzUhMBOgp+6GURv6gDG6lFoiY/L26OkcIrzOOADI4
         rHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gIzGgpbn/bLfRecbbJR8idZ+V5oVFq52ZNmGReij2M8=;
        fh=n20Px4I93Y9oCUe2zd7aaRG4kqXwdN/utyoyBZqDiHA=;
        b=SaTXlTS3y8OsVJ17Z+U1iLhbZEphE2nzMz1X6uqxRdj6uXfh2+o7vvFaA/xhEdcTS4
         Dp4PaiPrKGO+e9PYqJlL74bkzdLYk9QNzc0sSC1R6XUBSfCCn+QJ+X+KMNP7BZDZkbJT
         sDpPc9Xzd7Kg44AAtTnEIB9pGlTSyt+bJ8Q/ZSIRlEdgP8Of4r+cy69RFTQHjvFkfEoz
         +Rg4DvaEC/3qo6GrB0H93jbB5FGX3XiRvro/fJx8k1K7XKHu6DcXf35TvSkxP+aetOtp
         hXFWZC4HFfpVLY5uhiUWH8uzqA1NEtwuBRc8LTa800Gj933WkJ4Io4j19nh8z8wMFFDj
         vYlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790257721; x=1790862521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gIzGgpbn/bLfRecbbJR8idZ+V5oVFq52ZNmGReij2M8=;
        b=SrUM1yW8xLC1wmJaodaOKSVAGd3DyrF+vPXywMd0+k12w1zUgv0guH0BHPx9CvvFgM
         2zBgo1ukdX2DTFqGy4PnbxvR7Wo7zXZgR9XeVm/np/oGKo3fHnjojH19ttLDXY8pc5HP
         Yq+YqW/8aP1xUGm+pd0goN06SNuNQxPLJgLoUWn+4J+wTnLayaCsQLzHmD+eJz+JYr4h
         MYnB1JxbdCd1X6mq5xagOMoc8oPRSQbFhr8h4zY1DzZInsYcMLyHmyBjLBiRvW5b01Yh
         bdSkGuYqZOh3TrRc002hTc6D2KNE95yKSW42s1BWhECKTQUZ5AZ66WyWYNq3X/njZy3y
         RfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257721; x=1790862521;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIzGgpbn/bLfRecbbJR8idZ+V5oVFq52ZNmGReij2M8=;
        b=hmy+uk7kasG3xiECV+THJ8czPwKIiOPy3L17DkPWXFdem8IQ73HoCAvXcp72ND09qL
         6b8tx5T2rRQWJV8Rp/TPvtfkka2IfPbaPxRF3EnHAv9xbEaoME33kyLpDz6gkG2YtZe9
         QVvDpwI+ORpn0XEZ+N8N3amIwTuilpUYkObYVw7wdpOP8XxZQtMUOFxayq6Y3EePGB6I
         XRBB7yY1G2Kp1dXBt1IA1CSt0Id+VGk+VdHJCw1XA5hUKxT3AxPX+icfhqPYq+HfqjJd
         aYusUMFfvH4e4LpTdCyE8HQevEjQNIX0pP/kfOgHdpYztTLF5+Pvnt5Su9XZYxhmuJuK
         FAVw==
X-Forwarded-Encrypted: i=1; AKwUvBxTKTQdJNAyrCmtDSWIZZ5wjriL9BOh9A6JC2IJ4vREa45n4kifPLi6sTrqgsJlJxqFRFRhNjv2JA==@vger.kernel.org
X-Gm-Message-State: AFuF++kORajM3GuXI7+D330b/lP9GWC5trPZuqYZWfPbhGw1Ja+fz/k5
	lXnnvGSt6zIFJVjcEpd/cnCRHN/DagLV/5UZopLUDxbyV34EA+xXwtst4jJEnD/iMwrc5wy32JH
	DIjwDSAzSddmOdgzXJ6EIzkobV7c+lCbbnb3deq0nlMAkgmz04SRfQQF1ltEp8+GD57gZ3PE7ba
	SxSJpSxi564ORD5MrTUwbNi4FfTVxi6U+LoKRkyjZISyLH
X-Gm-Gg: AYBFou3pFU5o1hldlLREEonnq4j9xhwa9hoIQ5APPhrQDlxu7p2FZiq5/YM5+RvO8hr
	mOPdLmhxEJ03CtRaYinpFnqPQbKfCspr1iYK7ElOy5H2QjyR4g1rX+gbMeZo+I2QgTkwjT+sCNn
	wt4h6frhDDNG+IR8sWbwLcIwnHBjVz74dfaHpl7ZNmabcDsCYr6nFKhazmtw==
X-Received: by 2002:a17:902:fd8e:b0:2df:84e0:9021 with SMTP id d9443c01a7336-2df84e0985dmr10949305ad.7.1790257721289;
        Thu, 24 Sep 2026 06:48:41 -0700 (PDT)
X-Received: by 2002:a17:902:fd8e:b0:2df:84e0:9021 with SMTP id
 d9443c01a7336-2df84e0985dmr10949065ad.7.1790257720872; Thu, 24 Sep 2026
 06:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915104328.45901-1-gahing@gahingwoo.com> <CAPx+jO8EixqfXmrD8zkMkJe_B+2AATo=YNFJraAdE_O9X4KM-w@mail.gmail.com>
 <20260924090816.38457-1-gahing@gahingwoo.com>
In-Reply-To: <20260924090816.38457-1-gahing@gahingwoo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 15:48:29 +0200
X-Gm-Features: AclHuK_QXocrU1FUmDoQ1C4eNfLR68g-9FvqDtL-NyGnjY3Q7BSkJqEHWuwlS6Y
Message-ID: <CAPx+jO-zAr+gfEGG5xvWXz-72cU+mw2HOnm7xVBYGhMenZWSVw@mail.gmail.com>
Subject: Re: [PATCH v13 00/14] accel/rocket: RK3576 NPU (RKNN) enablement
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: heiko@sntech.de, p.zabel@pengutronix.de, tomeu@tomeuvizoso.net,
        chaoyi.chen@rock-chips.com, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 32znIyS7Cb5ofXbU_LUK7d7-5dmsKXlT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfX8Kit+fJbE4fB
 elOcYEyufO8uq4kjFRf4gA+reUxhIBBFmIGjJsKGLzfRE9klFpOANjl+LeNCKKKcnxk5pUIP0X/
 Nly1fA5P4162msqMo0kXYd8HT8bLUzOnquynZRKdk+kuW9LbnKp0YpkX6Es1gldc8Jja6bfzgg3
 nCiUacjO+vbMRpNpqDmFaELOq7k8PXzjACT8hmBBW+OGcv+EMbu4mQFuMq6aGKo27AYVa1E+42R
 hiaE9DYQBEgs/S8iIuJaHWvItnmB8nR8XeD/fD4aTqIAWHAHDzVjAM+hUcuZSTO00lYP146INLW
 L234BS3aNRhN/VLsNlsLXSvZJiAC1VBeOSwl+BP2ckk3GE6NSVqYTwhcWyP8TA5JJJ2O6cRnfCv
 cm8OrG7tXWqmpD49QqXnrFE3tgg7D26zTBLYOYjK5R3FKVhTM9LFDIeXxLaxoq5ZTuroXv4q9ui
 vL/fEx4lFI7ZpCLZwXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfXyJ2PvI/9aatO
 PYNq1S1QgjmNWQpNHLbpzKRZDi7UQ8aivthYZNqQMIVNr3WybPnUnkqfgagGPfqnlzt1nBbruQg
 EpppIY42lRbGVVmFvQFrvWEUJCtiPas=
X-Proofpoint-ORIG-GUID: 32znIyS7Cb5ofXbU_LUK7d7-5dmsKXlT
X-Authority-Analysis: v=2.4 cv=GI+dgeNK c=1 sm=1 tr=0 ts=6ab52a3a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=9GNsruGHAAAA:8 a=gHPckg_Ghvi-cCk_7foA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240056

On Thu, Sep 24, 2026 at 11:08=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> =
wrote:
>
> Hi Ulf,
>
> Yes please. Could you take them from v14 rather than this version?
> Philipp pointed out that the binding allows one reset, so 10/14 should
> use of_reset_control_get_optional_exclusive() rather than the array
> form. v14 has that, your two commit message trims, and Heiko's split of
> 13/14.

Okay, good!

>
> In 9/14, v14 keeps one sentence beyond the two paragraphs you kept:
> RK3576_PD_NPU also gets need_regulator, which makes
> rockchip_pm_add_one_domain() power that domain off at probe on every
> rk3576 board. The subject does not describe that. Say if you want it
> gone too.

I will have a look at v14 and let you know, thanks!

Kind regards
Uffe
