Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626207;
	b=zn5WXlAnqBgOicgiPUIPdX+3rrFhKphc0HocE9yiWBv0NRRyQN8tFyfHjtlhho0eL/vy
	 G8LK30+5GPzSDBwk/GdKlR1TV0s0NJMBvqZz64kOosG2Gon/CuxPoFLK4F1LG1qy+GoXj
	 CT95spQBbvSPsZMm+SCW+YIDyp4H2Fuh2uuw4GzvdimD5z8GvQHOFsU5XtltaFB+zOENM
	 JtmacHOq/1IT8EA4T12PFIy9lzNNOWPGzON9KLnFuQnJtiNAYyb9yaVsQ19w5+vUTy+kU
	 uis6cqYpzpoDpkjPez+MaG56EobrHweUtXPetiqtAJY4OB3czt2HapOrfMJAMua4YLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626207;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MaHSdSC68YCgPi3lz8iuASH0f6ZOoGx8qQJK3v92RQY=;
	b=r0s5TEP3k4Awb0+A8RNGtc5tYwtRKYyAdcMl1jA2JWjj2VGuuyFt43PiumU0kcFew/B0
	 5+m9BL/nmT2nkSM1493C80gS1qjHNS67NEn3RSYw8FFEmp8/BGlc4hIrXeGB+gQXUB4ty
	 haJM8Ef6C8Wi7qbWCzl+9hpHwJjRgcYSQ391HQ66P23s1VWUSFbgnz9fXnHPdgT+kP0pF
	 uk9RpBFsKZC7X054wLfIIW1u0p1Cb5BhCXgea1jl8L1hu3id28k5uILOXu6x390FT6H38
	 OsZTijk7kMm6oGnN+Y4GO3rgKjItpkFOy8Adx9WdGwJM88S8BUL6JlPQ6OqXJLdbehw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZutqRrGj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FF3VqCj7;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FC6606A331
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 13:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46FC6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZutqRrGj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FF3VqCj7
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DAl6Y2360269
	for <linux-pm@vger.kernel.org>; Mon, 2 Nov 2026 13:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MaHSdSC68YCgPi3lz8iuASH0
	f6ZOoGx8qQJK3v92RQY=; b=ZutqRrGj9Qy7ij4ckTkadu5YKgyRayrkWPiVgddp
	TrmgYQVhehE4pI8aHMq9UfhDc0LNhNLjZdcD8Sd+I5ltaJF+gPj74JhqOWGvrk52
	NPGe/HEcu02bQxGOS3pksJ7JXFNNhcd+ewnxudTifFrlYLih5FnUnWvsJe5J6Siy
	Pj+aVjwow/37215QXQhfgZMa2nmZOGjZetepgLzfFMx42tTtjmfeM6/OkCBjZ9QP
	v/R2xZwpWvu/PxmGIudZWZfKkLEIGkjPOpWyEmdV1YVHGVmLzG7dlGs/aiRPsCiS
	4HciFR09ADNU+5Mq+7bhky/t/GfbRkE43fa8PY4IK3miKA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4huy1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 13:29:48 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-988be118d98so583299241.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 05:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793626187; x=1794230987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MaHSdSC68YCgPi3lz8iuASH0f6ZOoGx8qQJK3v92RQY=;
        b=FF3VqCj7/p782XIzRyJTXW9i8Pt808MrlF7U9B0/BrjVwU7KJ4yPmHdkbkDNN+7LS4
         qnwkgh4ivqGk2Usqcj/xQkT0fIQcap0xhBvBSEJvLsj5GgIfk833hcwaKa9ffUSUUBQS
         8Ts2z79Hpp4doEhaPtmBicILLG1p1vnGtK4InDxQH7PXVLXRjrUZLmW5Ae10ntKbDwuJ
         +eysul4BuMFAPxGffAr3y3MvCfLEkumnlj2arb7FmqrWSZmM81BsxL1dr4aS+LR9rOzs
         aUmhCrju5yNJGSeaKTp/0n1WLSR8/FPoOFvhISt8BpIFRYizmpCxEV9+UddZAU34WHNp
         ki4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793626187; x=1794230987;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MaHSdSC68YCgPi3lz8iuASH0f6ZOoGx8qQJK3v92RQY=;
        b=Gs4zo5+VZCWaa9o5LfhLsi+8WeI07buYSb7pWOCaj5e6STfkgV7f2jB8it1MxaG/ZK
         FIeZTK14sgfgjVvfQh0tEBV0nh+ppgC9Ryt5bA2RLBXFVtubnygZSe1/zIAUej90SiyW
         Yp+lv7IP66NthKrfYANYeXo6D1NtFwLH8RIbX1NpKjUOlq2HpijrhYTMyPHIi5/cWLZ1
         5kXiyB44G/omjjlX5zL1ZlUXqThZsbixuyw6axsjlCuRCUuF4s7LZaue8IEKr/8XauaR
         IAu8fYGYmTrXC0RIKieZ68/3qSDp8mHETcdpcfgUp5w1CRpRsA5IHCcW0mq23Evw5aGK
         Yk1A==
X-Forwarded-Encrypted: i=1; AKwUvByliO1lCDu44Uj/OXxgPjJ8LfvhChGAiGk/HUkbILYMxdkj0XBJmljqR3AYG+y1FVvCWwwxgp7wmg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9a7M+2wAxdNhdQx8x3RLkEIdQXn6b/Q96mATCefTXVtaWbBpW/
	MtX0c6eZsL83jn1zWPinz/idjyEp2QYyj7ovakKqDfMyFBgeKlmK3vPSGU/OuIpoSVBOEtEA8rx
	eVtgceN9mhAQRIN2xfCJAuOD/wvHSKhY3qiumsIRTe6BSdoDILknDuL61qnL7mg==
X-Gm-Gg: AYBFou3e1zdjGW8q5h5jFGQpbnj7PpN6ia6jZkWAD6QWWdJ0BALXcS6Tsp8MJyWkmUG
	T9Fg2IsCFsLUc/isqoYi3UOa0AMr8igkFHqEfLBB1BYEgXLbbug4OrayJtfGM0h6pBXm/MMItlB
	nr02+/QdxbG+d9FGa+MEnrugx2zB/gBl7Iy2CLdNnv8ywcHNuKzu2HCdaub7vT6mNi2LvXYLIXs
	L4xLKX7p1ikR31EhCGG437HCyenn+7oBsfuEXpOu3CgcpUaklw6gUvPYjoM1VCelpfpl1rFf1MB
	e3dytd9HgJ2u0aRpo2GlG9R9hi2481o6E0A2nWd2D6QS9PLPQZk8nE1E8RYtQGDRgXxg8alIfCn
	Cb18OIEI/UDILAh8uC+1FVI7mLzrYImcOzp8yq9x1o7+yJ9mzPStJe1g6o2sf6F4=
X-Received: by 2002:a05:6102:5486:b0:7c5:4da3:aefb with SMTP id ada2fe7eead31-7d0728c1b0amr3490568137.34.1793626187256;
        Mon, 02 Nov 2026 05:29:47 -0800 (PST)
X-Received: by 2002:a05:6102:5486:b0:7c5:4da3:aefb with SMTP id ada2fe7eead31-7d0728c1b0amr3490562137.34.1793626186628;
        Mon, 02 Nov 2026 05:29:46 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80333sm21455580f8f.32.2026.11.02.05.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:29:45 -0800 (PST)
Date: Mon, 2 Nov 2026 15:29:44 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] powercap: dtpm: Constify some structures
Message-ID: <ujl42bbqnsbakun4wffbtgtytojsntebdyt65vlpgxbz6mr2s7@cjqsl5j2kbm2>
References: <a4737f7c69e044d35348c1e9c7f69f229070d29b.1793524483.git.christophe.jaillet@wanadoo.fr>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4737f7c69e044d35348c1e9c7f69f229070d29b.1793524483.git.christophe.jaillet@wanadoo.fr>
X-Proofpoint-ORIG-GUID: -2s1AaQGWBVQBL522c0RBOISzviox93U
X-Proofpoint-GUID: -2s1AaQGWBVQBL522c0RBOISzviox93U
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MyBTYWx0ZWRfX0HDEZl0jXjPv
 mNDCTNzBdJzwnyK+++/BnHZ3tkMbDUZeK2Hb9/AUECQKAfwt5gx75sYPFvRR0yGhLK8uSLYo06X
 aP7ZtY4Bqq2RfnCcIDjlMktXJBoe1pA=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae8904c cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=5Yrv_TkWLuZ8LgkGlGMA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MyBTYWx0ZWRfX2cyI+MTzGJlx
 6zvbjERUxjirLzpBtIervBZhdSsnYJ3PPwWWJxsK0HKhu4zfjaNmc9k7ut80ffKC/H6q47pbYsd
 tb35QILB5yBuP/PWVXdnMAA1MW297Ja2h6LJzvpcw7zwmOi1xvjoqXInj17V0+pB748P4arWAHl
 kpOoutMv/XtswpphKX86hrORjK8pK2F4d1k2e0U7GcwZeWw5W5hNewkKOyDkujbYZ2bbIh8kuoM
 uT+4O9htQV5HJAn9LLi4mP2ooBf/BiLJAg+Zkg0D4q9HiOIiyO4LK5SGaVuAYI+fKduKuPw1kZG
 HqVB1TpxLAO551AL+PS+zjxi/VDAKTdXVNGkyMITbWiMuLoXPg0K5VFWJGd0YEZygafKMNl0UZP
 wodmHWm1XQAvzbI5KbD7wDs0Sj6MRsFjJPuSGDNqE3L7FlFq1Yb3i/odfIjA+rUw5iGpB9bsefK
 lD4jdwfudNrQ0LDfB+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020053

On 26-11-01 10:15:06, Christophe JAILLET wrote:
> 'struct powercap_zone_constraint_ops', 'struct powercap_zone_ops' and the
> 'dtpm_node_callback_t' array are not modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   22049	   7736	    128	  29913	   74d9	drivers/powercap/dtpm.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   22273	   7512	    128	  29913	   74d9	drivers/powercap/dtpm.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Seems straightforward enough for me, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
