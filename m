Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7533515E2
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583506; cv=none; b=h4id0UdDQrte9wZQzBevJcseIs+bigrWcHVEOAj9M78OSoYNZsKb7eSHz5S7mbQ/dhvZr96Wc68gFryz5Kn33tNBeVLqYkDnZyFb5OIqskXJ/eVU4+8gbGVt+22+Ii8PYYfT5x1RVedkrQwrkjbsOhd55d90hOEZ/mcLlfKA9kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583506; c=relaxed/simple;
	bh=sV7LRWxxlIj9O5J0NrZ/m+X+w/pYcNHRDRmxMkRNZp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvese/2FwE1ORHJTaAuTTX9kfsdR1EPrQ+RLwiYwTckF+GnSdaeoLnJatpq1u8TM0C6g+HfvBiP/d7lRIX7uZdKgKZ3PpDjEfhwuRDcbEKH/k/mUIZjXXHr1P3YnFpkklcrpvCePdORpQSuB0KaRAWcZj/5e9lxjC4mED17/xdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hhYN+khC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XGAOayD3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhYN+khC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XGAOayD3"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCvDf92006930
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 14:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7yMYGRsSAF5SF9le8WlaBTBssyzRoC8qWApQAK5q9q0=; b=hhYN+khCexrhNx7F
	hcjOxeBDx6yzO9fGZ2FoohKEcthI95fq4Qfj/0meUoSBcsYJQ8kdxKUoOMPAcgQp
	tkh8rhNwNMplykSjFvQ3CjvhnCyosVt/rHHmJfL7rApeP1bdrikr5jJi/N8NZUIc
	iAZb5/SocjoG1uIKO6q1M1lgfcp9ItNFV2F2MZE9nbXWvRBqwz0QJSnZ4cEv+zjs
	RhrHR1nNozoUOVlYXvcI92TzJBqLWt2W8ogBbLl6SGUMPLzX3FkEWSrZ8EsA2IdO
	BdQ8np/5F1WammAerUy6VS87ItnPfp0mvD7QbqDWDA0tbvdVwKdDYFgcMf96Zme1
	e9LH2A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kv798fq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 14:58:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52845bd815bso6983321cf.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787583503; x=1788188303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7yMYGRsSAF5SF9le8WlaBTBssyzRoC8qWApQAK5q9q0=;
        b=XGAOayD32RmGqN9lsYGe2/H7Em5eu5roo8cna8WrAgs9Tkt36sWXUFMUZ4rqg2UjG1
         JU6dfQoWc+G8prjFmapRFt3Hl8mV25nfe1uapfdcRcfW7Q6zIaKRusQoOv1KZ8jAsqGB
         q+xjYADNay+fw6VgCZDsZ/2dUWLqM6EiVlDzMvYvsJGgpGdBzvGKECjonSWYZYIHG5qa
         7ojWysWK0hLID6b/iCvC3uHCVPF4sti5XzElJdPBU7MEtxQu02I+6M2slBUAgkLIM5hZ
         w+x3K1EHBYtK39RpGfwkqiqivOr+0Fk72FQJCxGRKgndMdwRBA5n9sXpMkMGKG28wKtr
         pdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583503; x=1788188303;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7yMYGRsSAF5SF9le8WlaBTBssyzRoC8qWApQAK5q9q0=;
        b=Z5baZsNHowms0pOvGJpD74rEffW3mzHivf4Q/2qkJDbe3MQ6SobgOdYtk6lzXA0TaB
         arBJ+amLowCzqlyPXp/zytj14jT3i9IPU5NDgB0UwhLOCgNDJzXP48DNAdaESMBWPsrU
         9AYBOmOIIx4NTdkuhkrvt5gYiCeZvvKSI8jaIXFlmk83wfz7ATj/yWH9t2h95wDJk2SK
         n1c8N5kdfCzy7TyabhqlHNzZeup+vp+Avqu/bZ7yH+fPsNWMcgJsdW8hf7HziI4PK7SH
         xQq8D39u08GGAK8WdWf6Se9mb0Tx2jlQtYQ6VLegpgla4B5PuFm+8SK+6OkZAD7qWD9F
         MUpw==
X-Forwarded-Encrypted: i=1; AHgh+Ron+q3rQdbXNEiQRYDkSc0UAcVffrOUJehG8m0S6rsO66SEdeAKAtGiznhupqbHkJyJlPD4Im+kLg==@vger.kernel.org
X-Gm-Message-State: AFuF++kvWymRSm/+2lmfPO7IWIYTBlQboBDp3N3OJ2AF/vEHX1rFpPAf
	oJYzl04U5AXvzI+QXM3SL+Aw6n82Bn59I0uF9z42doej47mljCfjNE0iuGpjVhpbR1D8CBXZmJ/
	tRJiqBbPT+T0xVdKzFlhonKdZL+z7vvVwxrS3bqDVKx1BnHxuMuPtdY+rJA7+fg==
X-Gm-Gg: AR+sD11iQmoTKhq5EKAhW9ht/NWG36pBd2xtmz3lBtPL6f4fJuuxfDCOfNEE/km+PPM
	PbNn8KNV+ZAx3H/niEpziOleMsZDObYoeD+yv8Hx4/7ycDJOE5gkCmx4XFNszbCRFnx/COsKhVp
	tOELoGgBMu+DUuW6x33PWhKfm1Cc0I4UmhOxZT77rdx/0rrHQkULSposUiaNysPROvZ9PKdOtQ9
	exbPcWM+d1tL3vs0YEDWGrXyX2VkViD/vGJdTHSpFgtVekgxwI5L9SAp/jj1By/9DPOUmVXz4nG
	q/cfx3Pa8555x305bw0tbj99UQ6BbQshnVl620MGuKVBdUYmohr6US9fYZfRk9cFrYprJ/koM9S
	RADV0dTKTKSEp8k4aRGM/HnIl
X-Received: by 2002:a05:622a:34e:b0:52b:4ec6:52c1 with SMTP id d75a77b69052e-52df59fbd50mr211834211cf.3.1787583503263;
        Mon, 24 Aug 2026 07:58:23 -0700 (PDT)
X-Received: by 2002:a05:622a:34e:b0:52b:4ec6:52c1 with SMTP id d75a77b69052e-52df59fbd50mr211833791cf.3.1787583502825;
        Mon, 24 Aug 2026 07:58:22 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629a901sm1453437466b.25.2026.08.24.07.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 07:58:21 -0700 (PDT)
Message-ID: <5d2504be-0691-4174-9d98-7759205718cd@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:58:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] soc: qcom: geni-se: Add helper to set SE clock rate
 via OPP
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-3-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-3-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Cfg4Irrl c=1 sm=1 tr=0 ts=6a8c5c10 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=ieDA_EM_2LYBYmKFcIMA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX2FNsxRRpkhN6
 B3oglpihPfAFJdfeFdHjoU7Pv2SD9g11UwMExYDkIINEr6Nr/q/TcUcY2Eg2pJcNkK17LQUXZoh
 xhESkKkM0nOkCjq+4C8MzF2vRbUv+o8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfXxzU71sf6WkAa
 siiaq9UKxkUsTJXg4gAMWuEi1uMd1WHG20BD6HNONbMRpIGR2pakQ6ZPV4GC3d1ZPx3f3sQrdj8
 UZygpKf73pW9zswfRmehbE366cJ1Lm9nJm+mBoYBMpRJj7iENJoLgpGasQQiF13IAHOE8a3bZzk
 JS5j2hyZQOekAXDDza84TxA8HZy147YNLDZ8d9sb53ISj0KIyoMvC+/RVCxMbwjs1FH5ZRgWbYZ
 0HgNhAoIkygmSQfDX4yg5/W58hsSAACa9oJQM5NJMCJP1Q32vKixMbJK9vcAP98xPnnavdoYiEQ
 WVjsUwVQLpFMPnvCddOVu7TpDN9mSKY5MPtwhHcfdoPnaB6ZJ1DAzbSk8+HfnGwGT1rvViUk20P
 wQHT5aFD9eMaDwxc0Q7mrkNEznmxqfuYbrdlfcpDe2PUMueKVXYNUR5HWG3oQjjfzXnGjkH8Xoj
 svKoRfLXRybUEfiF0iA==
X-Proofpoint-ORIG-GUID: YpZD7KTX_YU4U7F6vYU3-7NKxISCgMio
X-Proofpoint-GUID: YpZD7KTX_YU4U7F6vYU3-7NKxISCgMio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240126

On 8/4/26 9:57 PM, Praveen Talari wrote:
> GENI protocol drivers need a common way to scale the SE source clock
> through the OPP framework. However, the device that owns the OPP table
> differs depending on how the SE resources are managed. For Linux clock
> managed platforms, the OPP table is associated with the SE device,
> whereas on firmware-managed platforms it is associated with the
> performance power-domain device. This requires protocol drivers to be
> aware of the underlying resource management model when requesting
> frequency changes.

[...]

> +/**
> + * geni_se_set_rate() - Set the SE source clock rate via the OPP framework.
> + * @se: Pointer to the struct geni_se instance.
> + * @freq: The source clock frequency to set.
> + *
> + * Applies the given frequency through dev_pm_opp_set_rate(), targeting the
> + * perf domain device when the SE has power domains attached (firmware
> + * managed path), or se->dev otherwise (Linux clock managed path).
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int geni_se_set_rate(struct geni_se *se, unsigned long freq)
> +{
> +	struct device *perf_dev = se->dev;
> +
> +	if (se->pd_list && se->pd_list->pd_devs[DOMAIN_IDX_PERF])

The latter will always be true if the former is

Konrad

> +		perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
> +
> +	return se->has_opp ? dev_pm_opp_set_rate(perf_dev, freq) : 0;
