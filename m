Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E9F52D2A7
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985181; cv=none; b=cOqAACacLyRfeTqNE1T9jnox2cvpCLomZrxdrsWS/iLNGpnWhCPSF7N6zTac0qgy/FrtcLEp+1NtUwU7RCQg1hW9GGje/KsDinNDJNMJcNkGECO8rdpQjoenfhWzYG+fw5Np45mAmQ1Uh0XL+ja1U6Mca9Focc5lbhGbNB/8cRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985181; c=relaxed/simple;
	bh=yJRtTsx1Z/dlS18YF82FYZYEB/5T+QeuKE2x3uhnYLA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jkFzJC5+KougQbJwBfcpfMN1H2p2t845gmtigSDUQTGCakIYoq+bpJzxqLK+lXh7m/X0ckJDgoenSmFInRp6eJ9xaMCdTKgYVF4wWGfbmFqFblxrfPQvKN4CNc/fHhivx97JctLUbXS+Bw1fwqTL/GgqP37tyodlwdDGGIV6qu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YtA1vLiV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DfzEXzyt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YtA1vLiV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DfzEXzyt"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBq0WV2088269
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LU5iwxOOYRR9huRXhO8Bq+2PBVQhVFp9657Vu6mwVmk=; b=YtA1vLiVcUl2KR1m
	No50nfDkZJL942+jlsU/WOkZtwrlW2gbPRPY1BCnktLUQvF5Cm8zcnXJfLCC5FC/
	faE0yendvZ2SgPCtTZAgwNr2Sy4p8rLENtynYy3geCT63vIuTRDhnvioRzYjFDXL
	VNXJp5htxGIwSdmtwH57RPHmnjjR8V2d6SuV8ewgB82LeuSNABEfgU5lbhzdYSzw
	6VL3brA6BH9nS6Ijk3X6ifXUe8fhl/4MndKm0vXT7iVEcsJPR3x/zX5dpb8hVjy4
	RahcgPvUYhLmx9lzBowBJT+0Wfw2mRmRLnS8BhIW9iU5cOHV8A735abU/haK8eqE
	Xyk9zg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9x49k3py-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:39:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93bf4c0af4eso178611785a.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791985174; x=1792589974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LU5iwxOOYRR9huRXhO8Bq+2PBVQhVFp9657Vu6mwVmk=;
        b=DfzEXzyt6xHDTQGhw20e+ZtWZ9gOreWy5ABz1z7CMLE/7o/8rS1JJY+vNnTttMEAqK
         CXmk/XDAAlKW0CiD7PTqpryFI2FVhtx/QwYQU6cILX4ZMrG7KZ9ZPamgcpMKa4wvJbX2
         WZ/4bpm8m/Evbpt3PUa5gX9hhlwrKxGEyf1S04iP8RdUX3FiL9qOSZTxKoMW5Df80FH0
         ABsrwbAqsTV0omg83ASxI58iHd+Ai+s6d6JG/6bz2KmoLQMWfvW6qKPFx97276CgXRVS
         2ZJced7LOzVe0DsFwf6S9xLNNfwVqml+iPXr642d12qqRhb0n18TtKTy/ECwo23S14tY
         qHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985174; x=1792589974;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LU5iwxOOYRR9huRXhO8Bq+2PBVQhVFp9657Vu6mwVmk=;
        b=FsOvP6eEndwfmpvdxS88j13Po6LcZjh9VpUKhh9eiXJtTxok+LkmxNFksbL4M9P467
         9w8fMKt07A9VxsYs9Qp8e6O/30+A8EOz63IlxFN91Z7dkLXKwBv7+Pz8N7iXdxohhTrg
         qsmugFlWxDGDpN2wVcJA4a5Tr+8vfljCPpr0i7AjzwDqzo/V+VLWAS2RkRIBv3/1JuHY
         Z1fYE3XDEvr6pK0HpQSxHSiT6niyWB6wWp8N0lys7RFr3ZqoOq3GZs8e62Uv/PvpKOPv
         nP59eo0QxR0m+AQRGqsG3n2t5g3KKlOTh32qMzDwSjFrpvm8BkV1iF9Dx7QNB5+y8M9n
         BZfw==
X-Forwarded-Encrypted: i=1; AKwUvBwvtlTfsh2IpfTdL2V/ysLTBHVz99ou62tHWQwQcTNgXe8RxsNge4SAECGR+gbjDfYEl88jVy4exw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKTh0io9WTy52HIBpY15ZDv8MQgg5Pfar1TB4hhiGbFfLekQbYB
	y82G5qOR3yPpYEMiDns4SK9WL2aW7JMUohguV7srQPUWZlXqcdokfDZYU7tF0B2GFHy3u4ao7/G
	TIfbOkxlhK0E1K5f75oGk+Dy7puTdU8sjYYGXAdvwdqJoEF5gQIRhAL0HPU2vFQ==
X-Gm-Gg: AYBFou0DQFz1EjaelQ+gjV0+fhwug9OID/SDCDHZK9nfcX1lMXHI976iKoxc9M8vsRN
	2St/oczWPcTBW2MMAlE11bi4RJ+IGtqEWqCRk3GVI5W7c37mkzP8FgTnZaJCC69pPYVyXvyQ+jx
	RSo60GJvkC96TgqKSt8pAy8n5tgmy5IvygTGWbFbOV1hKolib8aaI1bIzB8/T6x2vliwz9yjdqg
	fY2K65+K6jbyg1x+PX1uC7B4QZNTiWmY8SV201NSDQU6p+kF7ZKT2aJr6bT0kc1Y16/VCAMKGZ2
	ufBbaB3KGZ0SL2Zqy2+CG65Y2RijRvJNxT/mp4kqAyeE3E/mzQYGwubZ6fV0/1zTJ/hduiHJbyf
	FmUqpKf1//wJcgng0u8ywpTlnHQ9r4JWPLLQKmhnyn75H0r71OxnXgVsd+2rp6477YNVf/42+Ax
	kCVSUTgZP/1mZLsW3IORqb17QGBp7DKwwaUOu08EV2J5w+aBW+EjHn0Ces2aM59rTHqQ==
X-Received: by 2002:a05:620a:294a:b0:93e:60e8:c9ae with SMTP id af79cd13be357-93eb95e2c20mr2595644685a.10.1791985173699;
        Wed, 14 Oct 2026 06:39:33 -0700 (PDT)
X-Received: by 2002:a05:620a:294a:b0:93e:60e8:c9ae with SMTP id af79cd13be357-93eb95e2c20mr2595639485a.10.1791985173150;
        Wed, 14 Oct 2026 06:39:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9766209sm720315966b.3.2026.10.14.06.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 06:39:32 -0700 (PDT)
Message-ID: <21f3a18d-88a8-4c0b-9ccc-590b311f0aeb@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:39:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] ACPI: battery: Evaluate battery methods exclusively
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Armin Wolf <W_Armin@gmx.de>, Rong Zhang <i@rong.moe>,
        Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261014132703.93355-1-aliamemis@disroot.org>
 <20261014133013.94097-2-aliamemis@disroot.org>
Content-Language: en-US, nl
In-Reply-To: <20261014133013.94097-2-aliamemis@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YJcKWhGx c=1 sm=1 tr=0 ts=6acf8616 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=LpNgXrTXAAAA:8 a=EUspDBNiAAAA:8 a=RHI-k3j4eS9Gi5hBZt8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfX/OG/7DRais2D
 tsnMhPgnP3XGNrVpDlst01KpqBWEX19cjU/oOyq9Fym+cplYOE54qDc8opwgH7rVa78ViG7D83p
 w/rLchLoW6AlO+QY86e5LXhnoQ5MmnQ+shQwOuwqrPyrIabX4NWlgDe0zupMtpUlMpQXQFThEGR
 f1XlmtuOHUEvuAhzl7HYj91+8zszE+VPAEeMINiN4N7GuVF9st9PU9cDDHGgJwaDht4aY+90cHy
 8YDKLn5Yy/QRicGNaRzfIHIxf2eiZFnZo61LJzQMyobj7l3WxPK6I3z3a3ig6X/nAAYqWgPoFc3
 5QbBEj8R5wuW9xerUA/stJxZ/bGcHN6GkIjZKXfkD1MOksiXuaVwxHVcb3B8Ei+zr4+YcWaMzm/
 22WH94T0jDJeLm9dG6c8Ef5aocLRBXyeIC0OUnpiWGeXxLY5O/BrUoZKmImh7/EtgWyh7Jp2leF
 s73KliNWSB84xZtirBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfX7SylJFfA2z36
 1uR442Cs1mw7GA5RvFxZAgMtJ7ZKERX96Fe/8tCuLsstqaGlr/tq61ffmJmIvLuItQfiqFjdMsw
 /OrNMOJDRkmB1/gUwCIJe3b088OYq8E=
X-Proofpoint-GUID: lU2oFR_sOK3R7nbZuCD2pj-oXVD_H6nj
X-Proofpoint-ORIG-GUID: lU2oFR_sOK3R7nbZuCD2pj-oXVD_H6nj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140054

Hi,

On 14-Oct-26 15:30, Ali Ahmet Memiş wrote:
> On ThinkPad P1 Gen2 and P53, INT3403 _TMP switches the EC page selector
> without taking the AML mutex the battery methods use, so _BIX and _BST
> running at the same time can read the wrong page. Since commit d33e89d12295
> ("thermal: core: Suspend thermal zones later and resume them earlier")
> this happens on most resumes.
> 
> Evaluate the battery methods with acpi_evaluate_object_exclusive().
> 
> Fixes: d33e89d12295 ("thermal: core: Suspend thermal zones later and resume them earlier")
> Reported-by: Charis Stratakis <c.stratakis@proton.me>
> Closes: https://lore.kernel.org/all/37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans


> ---
>  drivers/acpi/battery.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 670853ec3a4d..61de3f5be51f 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -583,9 +583,9 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
>  		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  		acpi_status status = AE_ERROR;
>  
> -		status = acpi_evaluate_object(battery->device->handle,
> -					      use_bix ? "_BIX":"_BIF",
> -					      NULL, &buffer);
> +		status = acpi_evaluate_object_exclusive(battery->device->handle,
> +							use_bix ? "_BIX":"_BIF",
> +							NULL, &buffer);
>  
>  		if (ACPI_FAILURE(status)) {
>  			acpi_handle_info(battery->device->handle,
> @@ -624,8 +624,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
>  			msecs_to_jiffies(cache_time)))
>  		return 0;
>  
> -	status = acpi_evaluate_object(battery->device->handle, "_BST",
> -				      NULL, &buffer);
> +	status = acpi_evaluate_object_exclusive(battery->device->handle, "_BST",
> +						NULL, &buffer);
>  	if (ACPI_FAILURE(status)) {
>  		acpi_handle_info(battery->device->handle,
>  				 "_BST evaluation failed: %s",
> @@ -667,6 +667,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
>  
>  static int acpi_battery_set_alarm(struct acpi_battery *battery)
>  {
> +	union acpi_object arg = { .type = ACPI_TYPE_INTEGER };
> +	struct acpi_object_list args = { .count = 1, .pointer = &arg };
>  	acpi_status status = 0;
>  
>  	lockdep_assert_held(&battery->property_lock);
> @@ -675,8 +677,9 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
>  	    !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
>  		return -ENODEV;
>  
> -	status = acpi_execute_simple_method(battery->device->handle, "_BTP",
> -					    battery->alarm);
> +	arg.integer.value = battery->alarm;
> +	status = acpi_evaluate_object_exclusive(battery->device->handle, "_BTP",
> +						&args, NULL);
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  

