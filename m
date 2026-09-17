Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC24D4879
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659649; cv=none; b=GWanEIp+4bgljOlbDlSPojWhgipaF15FVj8Hr3DqwcWfRzNXohnOR2BEIRJOuxf1J3XQw2NFLLN2RmlnWQXk47zJIeRMyoVPCiM1Mdtdt1otkJP8zlj6HKVbHV554JoQkQ56I7sEocF5z1BVBnXmyLVkqmfMElt4Pho7g3BMAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659649; c=relaxed/simple;
	bh=0169PdSspGVHbanC1hocz9PvDkOeJJxBDXCyXDu+qV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5eYPCgq580J8L5/fIsuEgJ0VsXoyaZ4yrS/8Tjn16/EgTWHlOSLp+Pas2WUybk7bKbT6mvqYhOerS8jh373eJWio3d/77Sa9a8VrDHrggKBNSbqnlwM7u7Mn0pVN2UgGnPq7RO2rygPLgOgCkJ0f2+na4N3Wr5EXQ8x7tQxrzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ayaH0sUI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b9pMKQc3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ayaH0sUI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b9pMKQc3"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HF9of72024586
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 15:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rr9nZ43kdvMALTpIFc6ok99/
	5qlXBkKCu/1I9wfOAFA=; b=ayaH0sUITjabaDdIPAYhHTVjLBCsnm63mijwgCk7
	Niqj3+A8zLP57KpKvEyyOfgbjRN8eCIOMejql7Fe3tJcX3s/ulsH+n2wksOZGgOY
	fahRWNVrGmoL+BIi4qDo8oDcUMskD2vd/bjTvabG4YjErWKubI8LNhEsO3IPy+3N
	3MFgqkRsU1dxGvYB6kCjsrNdSD3TY5cyHFYPbMDuQsunZHQD147AiMwtNkZddC4J
	nltaNxfqda1+CtESX+asQB7zL22lSp1UeUd0WL+Yr/IR1NkHPUIULs1lfYrMhSlJ
	Yk3NS+TDRJSPhg/x7NKi18yUB69chI3/nVrlCXgL79vvPA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grjkt04mg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 15:40:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939f925ba4eso262352685a.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789659633; x=1790264433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rr9nZ43kdvMALTpIFc6ok99/5qlXBkKCu/1I9wfOAFA=;
        b=b9pMKQc3562Mu7JIsFZVhh4BI5Cb7K5jjN5uZuQtNYwzRoLfxce6zK8T8zZppVr5br
         qDm1X+hm+S6/5C7BISrSZGB6a9XwrbZLXPDEWJjM+afNLZnGdPzIwH++Gliy4oynicR1
         FGB3X7H+PN52GnpKwdRgcesIle1tFXZwfEmwS8MgN7udpbtntlmO2fUWrjSDursyi4jl
         ld5eNCpBYrOQ9xwJ+rL1y4MfurjHuSq8j4lXCv1FdyKp888GrD6U9IUSC27mkyjmn9dm
         F2NU8VDvxpsc0E9cJabi1PCfbRi7Fqc27MdP7I8KA6GIXFSMWF2wsTCm3Qrcw4EAIedU
         vUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789659633; x=1790264433;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rr9nZ43kdvMALTpIFc6ok99/5qlXBkKCu/1I9wfOAFA=;
        b=mWezvimk7S48IUyC/RGlRCZYTvjq/bjcg7ucXBj4KJIEwvr4rIK2nLHeWK8BLYz4mX
         rREefJNKfE74H+7kGIMAPkHB8dq78u/6vXgleBjkpifPJm967hGKMJ0ImKBtKfqHWMZO
         c86m1EydnDYt7Up5kQzJi0aWAMhk2gnOq1Hzj8obogda8uum+xt+S+7YqjONfloBT+hY
         TJatIiAIOtUcFvCoS44lnr7TjGx3fj4XhBQ5rLUjQxUzhq/dlBxgjk63CF90tt2/hWrU
         ksbUmyIA5yoS9V5iW6WQXQNSdL7Ja6BNvS0uSSN1a355UeA0i9Des3Qht4LYcK1C9La1
         MmWg==
X-Forwarded-Encrypted: i=1; AKwUvBxx3uocLhsczrBBiczN0Bnr6PKRSsC5T992kmLIn3S1pjXb/s2DAjetZCj1l+6U2aMbacFvx8WGKw==@vger.kernel.org
X-Gm-Message-State: AFuF++kjTrksScu7grHJk/QVfK1G/j8qQ5fgPUl/1OpQFd4ZSSs8KhFJ
	3JBeadfkF/NB9frC/NIN8qnaS9VeCr8pLOFAqRdHPdSE6jjpMYjkmIkoejfjGtepyIZxisxY7f4
	73dJijjjmS8R/VM0g37qNnCeO1Ss0eJeGFlpKynwArhJ+qQs3RA91IWCFSEARFQ==
X-Gm-Gg: AYBFou1J/WdpLaxgLw0nhxkw9nbMcuzr9pmKlDdynr1m+g+0Pm72t6wCIiT7b3gnHd1
	oVtDXIExPCKHO8BxzjIPEbcykz5V8DkqIG3iM5MU1/A90qetY2NsrxvSzOt0NqFcImCVK/3pWgX
	LLaRjF0gtvA7t3utjO4H7Tba5UE2DjekzoC/wH0j5FDmcb5bD/VTrbsTAw6dpUOiQKA58+akDX9
	t9OC6ScerwJ8Qg/GYdCBT08U2/FPk45QmwWvsDslCzggbaLaTiBEjZ9PqeRk91pVtoeHJMa5WyI
	jByaR7g1oRH4LRIYb3FDUDNcZe+g6ToqJlaa/S2bxQNFIdArMfbdJhIdE2u7khCiQRNnkC0/ENp
	8BEGSXsTiXnurew==
X-Received: by 2002:a05:620a:bd4:b0:939:6dee:4b09 with SMTP id af79cd13be357-93bb7963c2dmr1203600185a.51.1789659632509;
        Thu, 17 Sep 2026 08:40:32 -0700 (PDT)
X-Received: by 2002:a05:620a:bd4:b0:939:6dee:4b09 with SMTP id af79cd13be357-93bb7963c2dmr1203593985a.51.1789659631742;
        Thu, 17 Sep 2026 08:40:31 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd247809sm142192815e9.11.2026.09.17.08.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:40:30 -0700 (PDT)
Date: Thu, 17 Sep 2026 18:40:28 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, sboyd@kernel.org, dlechner@baylibre.com,
        nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
        neil.armstrong@linaro.org, sre@kernel.org, krzk@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
        melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
        ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org,
        luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com,
        mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pm@vger.kernel.org, kernel@collabora.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v13 05/12] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
Message-ID: <7yyxwhkygfqiu4wprnnnuvwbazaidtymp3ljndyy4a32gmdndf@s4nu7nkahzj4>
References: <20260721093626.96264-1-angelogioacchino.delregno@collabora.com>
 <20260721093626.96264-6-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721093626.96264-6-angelogioacchino.delregno@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIyMiBTYWx0ZWRfX/yH1BKYZ27bo
 wWnIfOsozLIEbQlLyJfpEOP/VEF3E9lk3e62EEOAky1ZiHBUA2UgNdSmUNNZg2HlJA4kvSUstYO
 UwTtVi3rf5+ixm8PWq21S86bRV8XR7wwIrBmtPvBCAUP6mzLrCXluVayWK3xMt5SuwUlaQ+etXe
 8irbdt2pLImsL0oHCkoWtvHILyR0VmWaeW5yoLBGGW1A7le3hdduAkIdeqPJtpHH4jmPstZQayH
 x9ibBnSmhaup1TQsq4rpn0vU1ak54pWx2NE9FxpZLiqvIVJMUDFcEQjexVkITz3zY4sIqj4EOUH
 OrHEVSprdce+3WNMLF3GyNRnbz6dKyvo07xFwOzz/ByRrsfljZo3kkWoAbRCZnLMVJoR9JUo3mf
 NNus0AR20JnBJlMH+mkzXKoZlYrd9tItmrJ1GsSVr15dYK/XOMsB4MD25Snwde5RmzB7GsU5GAK
 TpmtcYsnITbqgnZA7Jw==
X-Proofpoint-GUID: WxTXuB4QW9wHcu7y_4NrIU5TrnkId4l_
X-Proofpoint-ORIG-GUID: WxTXuB4QW9wHcu7y_4NrIU5TrnkId4l_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIyMiBTYWx0ZWRfXwhfLQj1C2OcI
 XIqIShUOXYbdBysQw7iy2IUgnLDGX9trgKnPbNW2hDQEyd7cpBvf5kKMCTJbHV1oBetaoWlYtY8
 REbRD/HevMgzt094+i8NwhGvC78T7ME=
X-Authority-Analysis: v=2.4 cv=Y/VtIReN c=1 sm=1 tr=0 ts=6aac09f1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=i0EeH86SAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=EJeNmy3Av9R5Y2qGVSAA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170222

On 26-07-21 11:36:19, AngeloGioacchino Del Regno wrote:
> Some devices connected over the SPMI bus may be big, in the sense
> that those may be a complex of devices managed by a single chip
> over the SPMI bus, reachable through a single SID.
> 
> Add new functions aimed at managing sub-devices of a SPMI device
> spmi_subdevice_alloc_and_add() and a spmi_subdevice_remove() for
> adding a new subdevice and removing it respectively, and also
> add their devm_* variants.
> 
> The need for such functions comes from the existence of	those
> complex Power Management ICs (PMICs), which feature one or many
> sub-devices, in some cases with these being even addressable on
> the chip in form of SPMI register ranges.
> 
> Examples of those devices can be found in both Qualcomm platforms
> with their PMICs having PON, RTC, SDAM, GPIO controller, and other
> sub-devices, and in newer MediaTek platforms showing similar HW
> features and a similar layout with those also having many subdevs.
> 
> Also, instead of generally exporting symbols, export them with a
> new "SPMI" namespace: all users will have to import this namespace
> to make use of the newly introduced exports.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
