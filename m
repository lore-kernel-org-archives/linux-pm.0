Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0C377034
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162373; cv=none; b=EOoCb2jqRGFszBI7KSjrlUa/Z+rrAcs/sPTGnaOb/Vkl0IxdoryjvJwLYT4Y/8MzNPOuL9SHJfHQHvjXKlHy5CS3mLSuAxJEFsNTu+O3ZV5QXCkbU+ZMVZebifG8mNWKWnH8DayfUtpGt/s9s1hR0G3FUy8wo+HnRGLJPAAODC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162373; c=relaxed/simple;
	bh=xBrj8om7cZyJutOzs5H4xLwjicqpb4hECpicCs4d5Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9EkCLqHo3Dlr50JrM8TAsFZ0TxbnO1Dnx5lGH4CqfDtC3UnOX/r+8Gt3hXLUf83+Ew16jJ65h/rFsZ1l4J+cQKKQeuKbe1Toq8Brru+rJKCuFqeXq/hrVeLESSDyRKlBHSseqv5U6Dw/ZUtXSxucVN4vh3uKaEDME/rw7sUqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fw39adlV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hmZ3S4mR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fw39adlV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hmZ3S4mR"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlWlX3895520
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oy0mH4sOH578efJ6Gq+6ZULd
	BJ7VNf5OuMq0T7ZLoOs=; b=Fw39adlV1Dw8yAT9DITYXrSv26tgBA3e66fmtToj
	mEVio62D5SLx4V4uI6n93+d1Xj+TGTvIRCZcvBCPWqBTFzLGBv/RiMrHv44f/zv+
	QQ8qAIVgJYIeWVj0EvXWyJFYhXyacy0MUJrDYvQ3D2qREgMg3hoWvu5BzlZbF47j
	NvZGAzb1mfNwCpP55/rKGOzS05XRUFsgIiRdTRE//Rekd6dL7lpZdjAKEbIg34Yd
	lDlGv+aAHtDdho7apKCxjgcKbljJ0WS3MK2LUgiKfOHbcEoLqqxnhvrQNzYJXDCy
	yfWGp5Pno/s2bqeEidhQdCjqNE+wndeiX0PMW/q/pQn8QA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fnsxs30hy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:26:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bec738909so28553771cf.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785162370; x=1785767170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oy0mH4sOH578efJ6Gq+6ZULdBJ7VNf5OuMq0T7ZLoOs=;
        b=hmZ3S4mRIG7RedK8Sjza+l8w+50hMFUF9yWQLS/FaiGBza+BMeJsHhpJMrvJxIAtGg
         rXvGFCvMdK3aHeaPx4rUc1hdNEWmR/qvKt4hp1FPzVvXk0JWg8pf7p8iXFKOYCIyM+vk
         EnZ5+FIgWzyO/ZjQeGnYusz77SkDaby5jNHuE+zKxqN2g2JfxuJRw/TiwcYh7pRVweun
         G4t7XVekzuV6BbZKg1DhukyZd8ITGl2kPCmSEz/31qtRkpzgK5NWlSXkvNtzT37z9rd6
         3Bdo1PqR5IjxocRzkqNxwm1/01j9pwSXrVeuIIcYeuWGJGv7CYFrvpz0mmwm7tvBGwXD
         I7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785162370; x=1785767170;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oy0mH4sOH578efJ6Gq+6ZULdBJ7VNf5OuMq0T7ZLoOs=;
        b=Ltckm3hcOupkZh1b7Ps3X7ltNEe4AsqL6tG5qij/tpodeyMJGm9ywA8RRZTD4jhZE1
         gApmq3JL/FCS7xWNOjx4tVeD3RlptwXAyIXTLrb7VacsOgB/CRC8D3lGQnc2SXQM08dT
         MroJID0w8w4OXb0cUhdNjgBLduEXjwo3eoiIEn8y/imx5Sfxg519dwrBtk615h/zB3zD
         z8WLg3oeNaChDYdftrBG130T//Z6uzrXr14OjZgyU9cfVF/Cq9jPPv3kNRpzBq9jH036
         CJ5J513u2KPMlB6yZwSYKFioRtnBbVgLMnuQGJH17Ce0xNzPC2Hd+VCg1bslNkN1auB8
         Y3XQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp6SS7y3ylIJmxDa4mtn7Px/xn00BbFAQKvsbLRNItRRuanadrIVgPy/eXth1NSm0ZGbDh6+3hfdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5sz6gjBlg3MW2XwXXYZmYLYiB1A7vcMpIplNwophC0PzmQFbM
	Ftdrqeqf+w+KMH89t4y4am8qV16ORmfE5qiYtbYjDvwW+j6CSV5teM85MR49tVeoglyf6ooAch7
	La2HN/on8eRaI5qZClZLPfvgL06ROjnyioiq0NfvEO7+J9+8is/vOpC6vFA77xg==
X-Gm-Gg: AR+sD10MzrQvfLS61QtV1uERzpVBl6aSR3ZOkRWEYBaL+JAVLCuPguUMbqF1m8zKV6+
	3PLVLf5SUNQADcTUtN5XcFQyFtY22U/k4k8UYm3C6PZifAGdPVma7zilP7FgBSrrlXsxnhuafTT
	4210zk1CpZCqCY8hcvXabsbjwEa+Ij6+yGL7wHiVeeaEdqBlY+l72jX1EbkmIfQ+bMFL6jjkZpB
	T8LvvtDnmGDPOwmzEeOqIswqKZXSiG5VZrnnei4n04R8DUDRxX0q4vzzvmFwpxC2ER2aSRk3cUv
	a3W8RRc/TxQSKCucPBvuqaQ2aN8yWpr95jE9jQ5Bei9QRBjkuah68DsIJG52iVL+wRGAA5v6w2a
	R6WhVLEFMoWtKuyM=
X-Received: by 2002:ac8:5714:0:b0:517:87bc:9b47 with SMTP id d75a77b69052e-529a85ed059mr87169441cf.39.1785162370018;
        Mon, 27 Jul 2026 07:26:10 -0700 (PDT)
X-Received: by 2002:ac8:5714:0:b0:517:87bc:9b47 with SMTP id d75a77b69052e-529a85ed059mr87168661cf.39.1785162369415;
        Mon, 27 Jul 2026 07:26:09 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.163.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f864305f5sm48323508f8f.17.2026.07.27.07.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:26:08 -0700 (PDT)
Date: Mon, 27 Jul 2026 17:26:05 +0300
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
        linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v13 06/12] spmi: Add helper to get a parent SPMI device
Message-ID: <tdx7aygeu3li6gjmzsxntg24mgcg5fkiz7c6oibuhucedupwjo@iqpnvtiohstz>
References: <20260721093626.96264-1-angelogioacchino.delregno@collabora.com>
 <20260721093626.96264-7-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721093626.96264-7-angelogioacchino.delregno@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX1ub0Zd5SN5Pr
 ewmcC97zzCp8dgPZLdziYuZTffvWXMgtNHqd9rm8ryH4cK1ffOJ0YICkWV2KAqprxwqkP2QlsWV
 xvWuK9EqVZJaZTJWUJSndSXZcFrTFOJylLUrg9k5XZb7lvUA8Ho3sQvJlc5H2BzjCjfQK04j7ZM
 mCGwerAnJIu5sAavZdHhI/trJQEGzslHcjh9Be5AtVtJS+PMDCAQ9O3XEUVb73UghiBpEihtBys
 kTL5aUSQEHbN0aOtA5tghrvdlXCVpMirqx20GS8mf+E6ahW2klYMNnww4AaKUFgTRFnN705+uJc
 2amak0UQI5gtrf3bkL1gjRL2Am6h5oQOQihktTX5S0UphBOr5Dhx93l66D24K+WOhdc+JHUvRTe
 kCnnDbbFO+GQaKN/2ZAkM78OujeBlFPUv8XnGvcN+WyXi+kCmosGYI8dZAfs6kbpDtGuWim3Moz
 a5zBK3GKFJ1VmDF4L2w==
X-Authority-Analysis: v=2.4 cv=EYr4hvmC c=1 sm=1 tr=0 ts=6a676a82 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=6dw9+iwJWV8PcCi9M4lOBg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=vXzjEk_Rc76YdSX0aKIA:9 a=CjuIK1q_8ugA:10
 a=zgiPjhLxNE0A:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: -H3KAOPC868b8TVsieJqhJetVDN6xe-P
X-Proofpoint-GUID: -H3KAOPC868b8TVsieJqhJetVDN6xe-P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX6GR1HUGAHapB
 R34Y/ExRCLkIixycikLxpUMgwo5eV3fdQda/LLFL++P3JTyTCkQ+B37VNdIlTdbBVatB5Lywb4M
 71jp57VEFCbTjzCJOOLFZ/rViYqHhOk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270136

On 26-07-21 11:36:20, AngeloGioacchino Del Regno wrote:
> Drivers that register a SPMI sub-device as a platform_driver are
> not guaranteed to have a SPMI device as their parent: add a new
> helper `spmi_get_parent_spmi_device()` that takes a struct device
> and checks if there's a parent, and if that parent is actually a
> SPMI device by checking if its device type matches with SPMI: if
> so, returns a pointer to the relative struct spmi_device without
> incrementing any refcount.
> 
> As a note, in the specific case of using this helper to retrieve
> a SPMI subdevice's parent, the spmi_subdevice_alloc_and_add()
> function does actually call device_add(), which will already take
> care of raising the refcount of the associated parent device.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Looks good to me:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
