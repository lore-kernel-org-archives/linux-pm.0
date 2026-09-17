Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEC2390230
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659677; cv=none; b=hZ7mOx1G9bpg98ET3TBIfSwV+FkVhPDONGBo/EQegAkuKldiyO9lBh8BKBsXeHSjxwjhWgtMOCTUTf5MKyDyz6wxRUFlRpdrNetER15oCXmqSmajBtq/FmXxMDX0p0GX/Up2I6ju5o0EasLM4zKrFP73LeeacfNk7Do0J5bMMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659677; c=relaxed/simple;
	bh=niHJvKcGc3sXIxEu8fC5t1ndvGH1g95O/YBiVkFfwJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE1t7zYzcFUs4FG7TfA5cYmIqOq8IM3Dx0BgUU4nvzLC8prapuOsIdlyYVDlOH58JJpe5Uxtylj65Vlj9WeH8ult4xjOQm5wF8BvBKJOCAYFUHSyEmV7N8IjQLVbAtmkhXN8OKvVQkXJquNTAIkl8TDcCum4UVGMTGIh9XTrKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KGKB7onL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BWBQRiiM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KGKB7onL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BWBQRiiM"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HDiWGd2974908
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 15:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kv+f2O5HtP2UyzQFqxgl0Ck7
	X1yB8VDtNQPrqEOFNsU=; b=KGKB7onLVmzH2nA9sBMm60L5L8sxKuiGItypEMRi
	mIBVtN6RcDV71YuJ3n9O56uxKryNptHQN7FmDKTrDePq4VI+GVvEBAcubco4eDcj
	h3mMQXaFEQ61IUTZalhGat6QW8GVeALeNR2L3vsc+umk8EmhCs0Ez/mRClKEVRJU
	oQ1gj0G3tBSWWR7EL1/cuRHsHQjH6BERl6WsF25FxUrvJqia3bBWFWMyNSOk1GGV
	O3gMVtlUBChNqh/07gLFswwJi0VvNUvSCaPyITb+Jv6eNRiog8podyT0Ie5gt4U7
	tKzqyFNElAqLPR8s0gJdtmgfsDauX29PQ3UbcnW47j0t7w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grdd6hrk6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 15:41:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939f3426a7cso193869685a.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789659666; x=1790264466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kv+f2O5HtP2UyzQFqxgl0Ck7X1yB8VDtNQPrqEOFNsU=;
        b=BWBQRiiMXhF1HwFET0v43wpLH/xcy5Ohq8pzXEtLCQKgeEktcAIRGOiTOObaci8hjG
         /TTLWAiqWDwc/HzUAfGmSQuNNmTN2H0+6gfzsuU3doV5wy8bIlaexq5e6aOJK6kj1JWS
         yMQPbbC6E07ufG82hh9jVWtABp14Xh9xjoKeHv5ovfSXGhnb6oyFWKOJOITc20+TIYax
         YpFllMbo4dTN3B1x9i87aMDyTLrDBoASI9lq/SZEU9pZNT6BFqvpef27PSZhAGjaSBe3
         +ARpy1Tohm7v2xSr5VVGqvPEnt60wcG1mLwarFed9N1CJnUyHAoWYRVpmJQocOl1aur4
         AGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789659666; x=1790264466;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kv+f2O5HtP2UyzQFqxgl0Ck7X1yB8VDtNQPrqEOFNsU=;
        b=R/zHWE/083DF8GTWrxVp+jHAMH3w+xVazXvM68s9wL6FPmTBoC4jxGdhHuh5uhPJ7q
         sVkybvakfzps4f1iHi0W4R26uKRIiQecpXifuzJ1Y5E+XTnACw9LGJkV8FKaivCNl70P
         U00JV0LSfFbFuSFM4gbCN5CYUQrrG1U1JDIbjou9PTOk5b6UXpyPYJK4xgxxLXWWqf0d
         vbxY4aNrLP4vEF/ghS5hqiB61Nh26XCTy7S3XuoOs2s6EuxC67fE1WO25fBucX/+Y6Y8
         o38nM8V+Iif2D8F7lJ7iKTPLJ01ybhujqfNCc3zZBqhflSMiCNN7wnbdKidF974FBfP/
         28Pg==
X-Forwarded-Encrypted: i=1; AKwUvBzxZ5Wvk8N7fCOro3HKqC7HV/qo+e+4FnjDdj30MA/crkJQ0JSm3Iu2Wi+qZRZDtI/310BQO6SyQw==@vger.kernel.org
X-Gm-Message-State: AFuF++koFRHVQeffrULc1Sfvvy5r9OftqSdDILQZvpMMKqqXZDVYXDzn
	VnqaWjtskt9bFR3pib0Dn8C2GbHbCAdb1lUPKL2Yv7UKZBcq7n1Ld2j73XPOY5ppprIIj6rYVb6
	2zOwkw65oZs05x89ipsOpziMxGRfVuJ1R91G3QnasxLdznpvwKMvE2Gkau6ytZw==
X-Gm-Gg: AYBFou0remuhAzaBwoMZhdKYHQTtEL1OJNmQUfYcxHvxF3sLQK00Jsa13g79vVBSIGt
	/VLJSvXtKG9FZEJLvfH1nXJrizm3dByOy4mxwu3Zbi6wJSNCmGh+1cn1ISeJU4ZSmmy/Fr8lA7e
	Gz++8xR7tZ3rsOtb/DEAjIwx8908CYySlWCo3t4CgbfdGHU/q453pYJmC0vGZ45iEcijqw5keOu
	E3Tpo252VBNlhBsG5Jq0zuSt/uuj7rWSxBe+CSWdgh7HAYHjz+MXaLo6rY8oMau1OeaXVeldQDf
	RXCdEmARh4J/xit+Ox8dV446TfYGj4n5efw5zKrO0ilfJdt+Hm1dP/m7yKB2zTPnQCq5Xl5IkNX
	ZipitgRSg/HYi0A==
X-Received: by 2002:a05:620a:4621:b0:939:deae:8ca1 with SMTP id af79cd13be357-93bb793775cmr1229079085a.44.1789659666289;
        Thu, 17 Sep 2026 08:41:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4621:b0:939:deae:8ca1 with SMTP id af79cd13be357-93bb793775cmr1229075285a.44.1789659665701;
        Thu, 17 Sep 2026 08:41:05 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd24034esm101548365e9.15.2026.09.17.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:41:04 -0700 (PDT)
Date: Thu, 17 Sep 2026 18:41:02 +0300
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
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v13 04/12] spmi: Remove unneeded goto in
 spmi_device_add() error path
Message-ID: <7xf6fvsmcpqjpkto33g6o63ejagcbyitoaetvxww6pdijirbkn@etvrh2weic3p>
References: <20260721093626.96264-1-angelogioacchino.delregno@collabora.com>
 <20260721093626.96264-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721093626.96264-5-angelogioacchino.delregno@collabora.com>
X-Proofpoint-GUID: wA_tT5_re5tvYfTXIg7wUGXlC2snw6W8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIyMiBTYWx0ZWRfX9XmFw25kmyR3
 vm1ZahFILKhnR1ik1eeYwVmojs32iwHtvUiEptixDmMxhMAY0dK08PmKz/OHrCq+NQKi/xmJd3V
 lFp/6rulK49KMOdJG9s0RlR4aHyipFtqpm89142wy5sJDB2VOpD1Oewi4V08d71R/bvrZGNtOX9
 f/zxO4ovJvko/ChZtvqEpq1TTS8YPikLBdeExQ1/CZZHBxH7aFb9y+n0FAPY+tDj63kBc3ia0X6
 RJg6Cx5uHwy2Dal7ClchffLyMUKpI/8WUzYS8darKEv2OKsO3krDzn3ypyygro6bGlwdyVR6Io7
 bJlbmdANxsPb1K3zFHSqvtilURePvwBdgMzSLm9ZwKkMtx/hpG52/bohERNa2E0kIkcwU3idI6N
 btZSnwkTqt0xYs+8oAtttRwZ7FPJjiK6+ev8QiHLx7iv6qG2sc32NAfuuyVErJ7FuD7ycIzQuc/
 RO6XLDG3bhievM4km0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIyMiBTYWx0ZWRfX+b3vBH1ZfjA2
 SCFdeFzY0rtYlEmxs0vEDOV7ZqFNZOXtXBFK9c1Ppcxe3CS+o4VwpWIHQi0D3GhGIcdlSkv+BlF
 al2BUIaR0YeSddD10sXKtGBeAExWv5E=
X-Authority-Analysis: v=2.4 cv=GeOCDgXL c=1 sm=1 tr=0 ts=6aac0a13 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=RPqXdwRs98PbUg5oA2AA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: wA_tT5_re5tvYfTXIg7wUGXlC2snw6W8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170222

On 26-07-21 11:36:18, AngeloGioacchino Del Regno wrote:
> If any error happens during device_add() just return inside of the
> conditional, as the goto path doesn't do anything else if not just
> returning.
> 
> While at it, to improve readability, also change this function to
> explicitly return 0 (for success) at the end.
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
