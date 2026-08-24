Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458F1404BC8
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571064; cv=none; b=Kj8jfwGM3XbmuT1sUzzoJkgxYH76yrXmMWgXS1BCE9F+VLISFHDUKAfdgXft+9P3mhH54qNYonELXLd9dIUnNQxFNceYdeMDRaWotG+00hI8L27q6H7+oRQ8H8f1j+r4HBNF0pNkD0+RKghYjTGKkOMXqM43kZqdmtkZ5NU8sL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571064; c=relaxed/simple;
	bh=pkW5trsUQO3O2M2WtDJOUPV0AyvMmpVoPKx5fTZEaPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF3X7mXqgRKDJbhe/65za/WzsYMx3Kbw0euzAUvH0671EWv1I/819YQw0HbECaAhmko2o22z8xksHqYlxgLdF3Hfon48Rkxxj5MdZWZRdc32CbkZ83u5iX1MTYP6uFSlpQl+RBg3qVoBTPUTnv98RqN8SycRnjjz616HBNq3FHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OYWLqoEG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LwMiE5dl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OYWLqoEG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LwMiE5dl"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBMt722377206
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 11:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KBcF3v6N3cNbIQQxRfkuaUX8
	wTPsyQxH9smMZXqQRa0=; b=OYWLqoEGssz/m7iECFiWlIXeP5MbL9O/UejApR1w
	xkuHm5qt2yguK+ma5PwMbB5gQn2Na0/jsaMALOqEHLLSsuO3z3bQKPBYqVeFF+Nd
	Bva8oKE0xEH6isPQLEj/qY4deya/3kjz+zfvsisWN6D9TY4zwXotyefg+fZesCDN
	eD9Xhp4fEzOdAoqcVcbtMLSeMor0SEzkjTW5dpY6jO8Z2ENGkwu7x+58A2qnFBrX
	VL2Z1gJ5DOKUkPT8L7HmedI4LTJIDTATi8cmynVdeb+jYKD4TO/r0Wo8rGY1ZNWi
	XbNcX2dFtgYYZ9nxzOCOKluw29VW7DAskIGP96Zz1lQpBw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hbth1tg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 11:31:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5174a23afcbso48018881cf.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 04:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787571061; x=1788175861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KBcF3v6N3cNbIQQxRfkuaUX8wTPsyQxH9smMZXqQRa0=;
        b=LwMiE5dl/PLxHoS8InCzrYmx0ZJadvfrRT68jrvts89gl50FGCyaskFH4tqaIXUDRR
         HvxHUB+So2FmUqEtOAIENLZ7QDh0grZSR3+O4GMWRPIKcqiTJ3tefwxu6nggpUr2CFqZ
         qv41JUagQaAChia3RAJXpuMCC26p64zcENgP9LWsqJGf/0eSl1qFiV9PVqcdXN70pt+h
         YGsn6ReW1oJeUKwyui6vtJoEulX6F7mVUKrnYYKQOxui0AN6o0XM+oXPbFAR7XRs8cRt
         bws1FnsxtmEE4SGNbb9vSfICIrSfcgh5+Lz1X0QlmWn/2Df79pjEsag9hKY+34BvTDy5
         b5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571061; x=1788175861;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KBcF3v6N3cNbIQQxRfkuaUX8wTPsyQxH9smMZXqQRa0=;
        b=LZiyRHpWNfwELYL51gLSHjp8b0yd4a29t4/dSO3Xmwzq3/kgbX5E0bIkCQ+I2Dd/d9
         7h5OPnjw+nG0ZWRk+NQ7aqmJ+Tq/AP54S8q0v6HRzFYpFtzUf+9/Y9NPPubh+/WitCo7
         ET6E854FNIiotfryGSWRmAmSPtJU8A8RMAW37teRiwVXMtFqN956ZeWl4bPS5XnTwRKZ
         Fjscgnr7a/dMbDCLyWtIGKEi9yxBzIOW7T34KZiriAnGj4Z/qK1lnCQHh+uo2aEbOPnA
         nG8v6riAb1Fvnp1k0B0i9S90dFjbYUGOiQ0Q+RpWxFhi7VJ4FsVjC6MD8JF0GosXOE3E
         kKDA==
X-Forwarded-Encrypted: i=1; AHgh+RpA/WgklMHJrYEQ3VGCRkaM+FOQ4FMzy72klN89Q7DRLGcJIMZ/rVMqHgFe4FxE/dvFK8OVRJULwg==@vger.kernel.org
X-Gm-Message-State: AFuF++m06tKyZCI//ESFepsWzzOhB9Ay2BAxX7eGdqQJ6faUfVoexd1a
	wZqXUksZd9PYCrC7x3yZL0zEgyROXybK5aAjz4bMo7uYziWI4RNrChI/mPLxpnc2mBlXe0v8lxn
	dL2gY7FMyAeaVLNR0ulxSD76LJyPd954P0peGQWVtoWGijsh6/S3Kx3h5nUGQDg==
X-Gm-Gg: AR+sD12gJYFHVcfLOp0p2D7Yj3OFXfdpZeEwG494kh4HMbTboQBTiN8l0wjTaKDgmBC
	tkNViMOVyN3eHGCmZrFG2Qw1xTHst2dBcLjpw4qEa0OYpczUsZiQNVVT+mLLROxjJ5vpUqRNTE0
	8K65hgfUoBnlXIzjV/zzBO2YAcILrsI/k1ziZHz43Ssvbyr8NiSrjJOdMxBY2JZhibmLKMh9rCZ
	zpM+LUjTElJhDP1KF0MJjm+rOrh0LBwxqxB51FdGjXq85phMNchRp8WZkfcORuz/D+ck2rMKphE
	7V4ilpVxnwd+gaFxj9gFY63zi1/otgGyL7F6Pk9QETwFgrLbk8pgibPI5q1M6PTdP+fif2MHJUT
	FAz2aZbWIYeo44jw=
X-Received: by 2002:a05:622a:258e:b0:52d:9c11:8937 with SMTP id d75a77b69052e-52df5a07b1cmr265826381cf.26.1787571061000;
        Mon, 24 Aug 2026 04:31:01 -0700 (PDT)
X-Received: by 2002:a05:622a:258e:b0:52d:9c11:8937 with SMTP id d75a77b69052e-52df5a07b1cmr265825181cf.26.1787571060355;
        Mon, 24 Aug 2026 04:31:00 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e7esm1342817666b.46.2026.08.24.04.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:30:59 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:30:56 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
        p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com,
        royalnet026@gmail.com, u.kleine-koenig@baylibre.com,
        chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
        alchark@flipper.net, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 09/13] pmdomain/rockchip: cycle optional power-domain
 resets on power-on
Message-ID: <ry7vprhcjccrjyujmmpf4jgzjblhm744yborbnldvamj35h3wg@auo3ajz55com>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <213e3746a36f821798d3fd3e5d832d89dcf2ddff.1787568944.git.gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213e3746a36f821798d3fd3e5d832d89dcf2ddff.1787568944.git.gahing@gahingwoo.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfXwKfRPy4z5CJN
 Z0WYw2Vfvbu5xxCpsQJ3IXVChnuAdPEQaG3T2JhJu7BsG+AY/Lei26tOwWBvmV709jI6R3t416O
 Bh7x7EfvznmO4VobUhVfkExxGxouq2gH8Dngk0of34g27UYWqilJJxmM2eHnkV6uQ05Q8DU5Eut
 C5FuvbHebLJ5WmmtwuYPF5oTC0Vfgoci6fmkHcN3WsBYmOYSkGmkXqr47UWteQAYaqFPYd5FXXD
 0Qcu3Z4uZ8VpTqS00GF68fpndUvwdM7C3z25qul69vnz1KCRdsSSSQkyYpJHjKGJVlBfm5dm+6x
 XtJ5qWajUln4YPxkRKDT5ddKI04ArKVrKH4h8qAGA/gpRAuvVZ8W7UuWKeWTogstr8QoTwIETq1
 9dZrtT7YUdqMsUtPS1x3WSXBRMF+GimqKyZgmyAO0U3VNG3z6teER/z20RWLPpffoiF4eK5St+P
 lOijYqPj2mBL5/jR/zw==
X-Authority-Analysis: v=2.4 cv=JL0LdcKb c=1 sm=1 tr=0 ts=6a8c2b76 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=9GNsruGHAAAA:8 a=EUspDBNiAAAA:8 a=u6E1p9BJNrHIpMXxc0cA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfX1WXB7WgPvaD0
 zuMAGqyJ5HpbbI99x96zsnXCKwvr/pv0BrpCXS4zHv+drp5QLdaoefmUCRSz1JVD4UrCG4a/Qv7
 CtI09697A0/Jdq0BN5BlPF+RizzuVZA=
X-Proofpoint-GUID: PfNvibfE2hXyIy5aTEYby_uDXmwUOp2A
X-Proofpoint-ORIG-GUID: PfNvibfE2hXyIy5aTEYby_uDXmwUOp2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240096

On 26-08-24 23:08:58, Jiaxing Hu wrote:
> Some Rockchip domains come out of power-on with their bus interface in
> an undefined state. On the RK3576 NPU this shows up as a hang on the
> first register access after the domain is switched on, and pulsing the
> domain's resets at this point clears it.
> 
> Take the domain node's resets if it has any, and pulse them between
> releasing idle and restoring QoS. The resets are optional, so domains
> that do not list any are unaffected.
> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
