Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81817481FC1
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082346; cv=none; b=jjiW+dv9fEhLDbUzc6GU0vmV/XU+CKJPHIRhqcSV1ntcXsKyUaUT60HcXbCDrSR0eCpLENucny2wDN1NKsybPI8BoUKn+MQABrWJ3RekY20vIpFf2BJ1TGLozWfwhk4X2/uCBrmKPJdmWWgFQnlGwt4+AYbBrEfZYuQG7PqmrjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082346; c=relaxed/simple;
	bh=wW3KT60mhlRBPGGoki4f0myfgS8OT7dAyWEoZyoXaqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfg5Gw325d/+Xv9nyI8R1l0th34GMEX3Q5JSX2D9RbDXEK0b/4t91ZRfo5a5wQgMYMeFku6er6aO7MGGGSfVGRqnSPBEnvKnu1JArHZHHxmmlUALkZroaSwlh6tN5LgMKYTXkat9Tn+GpcYkE0tXL/lJiXxzQ1yeV2CuOJbau9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C3z4/vfs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jr7wOGpk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C3z4/vfs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jr7wOGpk"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646DsNZq2428163
	for <linux-pm@vger.kernel.org>; Wed, 6 May 2026 15:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XAWiO8jyWxuHFA9LI2PneskTKm60NIuJWI+rTsOF0sM=; b=C3z4/vfsDyjTFiHD
	ZsGZY1tqAs6+zstnqi8VPB3L0comfh/8AmhhCk2hf8cdMH5ckJrKVAOE+PABkYou
	eKgDJ5Ac/fH9LriqF9eIge99JjYckYv5eqC77CbD9hxotOytvOb10MvyKZYnCfyE
	LhcEziYQcyVRB8yLHEtooq8QJi6nI2zs5UoLwbaB9QAqU28V6MTIAtm91jnUARAI
	wbwVhpIXidol08Jyrh5tqkZpNZeo93RMwJM3nAAzyt4jISLYwReVAzKo+QvPtR6a
	L/oJ2LfNVvBbjr2bm3v6b6+h3PCK37imXCUoYILowiO2aBX/8dhZZn90vjoJLebz
	3V1Vww==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e01ph1td0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 15:45:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50df4c130dbso34615071cf.1
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778082331; x=1778687131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XAWiO8jyWxuHFA9LI2PneskTKm60NIuJWI+rTsOF0sM=;
        b=Jr7wOGpkq8Z+X/oYON3bv07i7cfe/BDgzCo+JFC1uHnoDMjsBHUiH3jb/W3BxwCBgk
         yjIIt6XPJGxRl8HVYbkuyhvT+B6+Eu4uR3DwYHufxjxRc6Pjd4Hgn4EVEvOQ8l+KWBFr
         JRJkqkUcB/FuvOrmcYsoLZviGvK6MY7o0egHP6cNlGCtqg1+1IOxZpKAvqyysE6Pumvt
         PbYF3BDXW6HdoQBYqoemrXY70eYOumqV8mLvuRtK7+W7r0yUGPfwvq0c2K5CEt4Qehwv
         PeH91UTbzX9P+ZX0j+YojnbWtPuLUzCqR4pqLhNt5kmrCB+4YefZfWGGo6GURxgyxJEr
         1G6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778082331; x=1778687131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAWiO8jyWxuHFA9LI2PneskTKm60NIuJWI+rTsOF0sM=;
        b=rGm8QYEEUJRdGsVx3WDArUjlzJAtOoPUf9V7FsLvQkCDm/Ra9nGOXk7mjc993ezdZj
         nAZUgj85z2W07gvZe6VwGlLGxjhO17tr3aatUDuvnncyf2z8kqTYui2EfGjs5wSgdoGu
         HfBGIXSxdsw8tvwbr7liyrAF3RXCKNLh2qjQyktBlFOxBj71z0vnRZ/GbugpnS1MczmL
         taYF05oXOZXvk+++yzSStvjDjfCZ0HOKxvKKqTlrFGZA8mBllfYQTdIqz76ji/k7sHwR
         evXj5LGj5cTszBLaUzoRN7z1Zh1PJef4bNOPjDzQTp2bhDClrmCDzlU8nHM8gUj/xhY7
         52pQ==
X-Gm-Message-State: AOJu0YwFzx7bxq0ot5NXGlo58TrdRez+aHRvuhTd2dP4HlNNDE4VDWdR
	8JEndysaTFiUFvgD0qClmz9+FavvjVXs6WrbkGJVVnpPSAcAglDeigze5Rgi3mKy8DVqzgN6rlZ
	44aPv3BnpwcsSbiIWDms2ZuK1EQ8HUd2/9Ys7/6nqE4y5t1Oja/8Niw3glspzMg==
X-Gm-Gg: AeBDietD9UMT2s8GpeDWvUDWU43QDSjpQkJANHskhL0KptWqOwV2XFDh+i7qzwRHcYC
	0UXVA7U/m+t4grixIqB508Zk6QmH/9oUHFoDEsrZxFA5gL52I9orFODDoqVRaTEm7QG+svsS8QS
	v08hqgK2gCKGa+h5NReUSwegL9BmKCp5CR5UwFr8hbABU5NyrRYTQjoeA5/FyKh82A9AkVRa4xK
	iPAjni2Udwu+ry1mJPbRCUieVSU79Uv4AyO2VCopI4Rgq6nodaqvPhJryP+JLDJ8Asp1Ndf4fB6
	Ofl5p3lcrZMBd/cu0+jxXUHFQVHRht+zLnksec197aV7J3guZHZzxBBJ+hOjJB1sI0K259EtNWt
	S9q1LxhOhb5Z1IiAXpKY2UsvLWYsCOwijTrKqqkt7wcOJcUWJEdQCWrJCtUfZua2h9NBsBmP0FI
	20P64TZsHMj720AapzvrQ=
X-Received: by 2002:ac8:5a11:0:b0:50d:815e:7977 with SMTP id d75a77b69052e-513053313e4mr105266811cf.34.1778082331298;
        Wed, 06 May 2026 08:45:31 -0700 (PDT)
X-Received: by 2002:ac8:5a11:0:b0:50d:815e:7977 with SMTP id d75a77b69052e-513053313e4mr105266011cf.34.1778082330603;
        Wed, 06 May 2026 08:45:30 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:41ef:7b80:b3e8:2c1a? ([2a05:6e02:1041:c10:41ef:7b80:b3e8:2c1a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53895cb5sm51330525e9.1.2026.05.06.08.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 08:45:29 -0700 (PDT)
Message-ID: <f4bd99bc-00c7-47f6-a914-e398dd2c3bd5@oss.qualcomm.com>
Date: Wed, 6 May 2026 17:45:28 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] thermal: amlogic: Add support for secure monitor
 calibration readout
To: linux-kernel-dev@aliel.fr, Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20260424-add-thermal-t7-vim4-v5-0-9040ca36afe2@aliel.fr>
 <20260424-add-thermal-t7-vim4-v5-4-9040ca36afe2@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260424-add-thermal-t7-vim4-v5-4-9040ca36afe2@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE1NSBTYWx0ZWRfX/j5kfMO7okFF
 fw7xc4poUAjTQhA6eIKnyydysb8WctViwYG/4HO55UBnEmqK85+gJh7P11YJyd4GSbLDqLNOyyS
 vSHLjbiY0TvAjQ2OmOoSuJlGdrL7hK7zuFIwyrglsJPCDmDZr41rRcyypNzds9GkqkbxTUQinTm
 cpcnE8c/3rce7P3x2b+2l54eJO+IYQcUfJNUVwH1DpTvpeCNx+yLjNiWe9C5ExSJIPwx5lRV8Fh
 oH9vZ+WxxRPzVgHnhRPO2Y+6d+Rn4gIDcCtbpntGmlFKVG2lvNH4OxWF18zUWvef3w0HyFfOTH8
 hOcxDlMo5S+P9bFPVUV0z8lScoJ6XbzdhWurD76DSAAVerf/tq6oCiEieWgmu9/7nWgNtAXKfbX
 9fPiWgbA2/0YJfJf0uQf/aimHh/SgilRme0I9VZ3pjb25Zc3cc+dwtcfJ3E5z3paij3pMzwSJBX
 JqboDa0j5OX+WVCyt1g==
X-Proofpoint-GUID: m4FMEkTe6mX2H_FN5g6PCK275zUipRpd
X-Proofpoint-ORIG-GUID: m4FMEkTe6mX2H_FN5g6PCK275zUipRpd
X-Authority-Analysis: v=2.4 cv=MYhcfZ/f c=1 sm=1 tr=0 ts=69fb621c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=Gq1lbteDWWDUjDXoEKoA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060155

On 4/24/26 17:45, Ronald Claveau via B4 Relay wrote:

[ ... ]

> +static int amlogic_thermal_probe_sm(struct platform_device *pdev,
> +				    struct amlogic_thermal *pdata)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct of_phandle_args ph_args;
> +	int ret;
> +
> +	ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
> +					       "amlogic,secure-monitor",
> +					       1, 0, &ph_args);
> +	if (ret)
> +		return ret;
> +
> +	if (!ph_args.np) {
> +		dev_err(dev, "Failed to parse secure monitor phandle\n");
> +		return -ENODEV;
> +	}
> +
> +	pdata->sm_fw = meson_sm_get(ph_args.np);
> +	of_node_put(ph_args.np);
> +	if (!pdata->sm_fw) {
> +		dev_err(dev, "Failed to get secure monitor firmware\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	pdata->tsensor_id = ph_args.args[0];
> +
> +	return meson_sm_get_thermal_calib(pdata->sm_fw,
> +					  &pdata->trim_info,
> +					  pdata->tsensor_id);

This driver has a dependency on patch 2 and 3. Shall those being merged 
through the thermal tree ?


> +}


[ ... ]

