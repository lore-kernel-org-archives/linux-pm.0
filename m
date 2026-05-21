Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACB399017
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350410; cv=none; b=sEIr1fmeOrYXpOq0OO5fezQuIvAGUC7yOU6//4H34SgMFvHitdQxEvJtlJDCDf5Z6DtgnOoZBbBiTGRCk9Yr0hHtHIaBAqY+4rUV1XlIJXw2fV0qkC9U6qH+5Jr7l01z6CsQrJXGiW8x80q5eOgcFuiOUEse4N2d1/qsL43E+pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350410; c=relaxed/simple;
	bh=PIXdGqeVUA9gIf8fLO/9smTMqHiJUQLQYlG0rQP84Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tuwtLJYxhYfFX7eBsWUMx35KkZPHxI6nv+mpp969oizqE2c/6x+5ppc+OJmbohnTJmJKtNPDUIY/B66NBCFl1LLhwoVXQQZAiWnxDlu1E8IkfGdemjw2W51eMceatTWnOd76I4t9Hl+OqjEz9LysEcAqNVQ1RmuX0WSJNLZ/7c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=faC0/XMS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MEkZ8tfv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="faC0/XMS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MEkZ8tfv"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L72fJL3049891
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FOltQE9tPpawJwPt3pLzjokKU4kONo8BTpdoRrWvcOU=; b=faC0/XMSoJerD1AP
	Xpk+BoX2bgGjtD4vqg9S9b34oxe+Me8ZLP9WAfPDAV4OWNMDXjLoJyiy8RXDR7Ib
	oFpeR99e4NlRdedMV9z2WUBQR98OvW1o6EYteguRuVKSLHsWftTEsxrs0A1BEsmm
	EzORaCy7hABAwBM3ZmCEmy4CX3ESbelJDb8PW6azZefp3YmrtnmIB4jGCk8RLhN0
	WgI23qYBqJBBl7OgCYrw7DiBSmHqDxzQwKJc7OlcM2DHtSYmLCe7pUkRaGflZ/CF
	BK6lgCMQ2sOQ0d0bQrF+KD6g0dViGsE5EdaVv9BQ1GhGVeku9ExzMT9+8Cx/LZdI
	Noq5yA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9wahr6xb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:00:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d5d076d88so14633261cf.1
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 01:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779350407; x=1779955207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FOltQE9tPpawJwPt3pLzjokKU4kONo8BTpdoRrWvcOU=;
        b=MEkZ8tfvAUpnwQyLEjlCiHYzbJRMpepOgZff9rPraEv0/M8f+Ib3WMf0HvDaO1v0tb
         txsYc9s/atz/Oz5/bOGtjKwpS2i7oZ3n+MTDOUjA1lS3NGsfiHh97FrXRgFF5Zy97kg5
         SznstDrdLC4cypHXHDsniFzY/O5Du/wVEiQYq41n2ZV7qaPjT10GBP8Z3DnyrVE1aASp
         36MP6OYb8653mD/JsVGbnbXuD9apUDuIdv/XtKaiNqWkNAhovowYHVEtHNkLmyQc00CI
         +HK2l977Ou4UhImkPnwakIBS6J9PYjb3/U+8CrdpgUds/qS3rcL7NvHV8u8ZG63jDwue
         0UeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350407; x=1779955207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOltQE9tPpawJwPt3pLzjokKU4kONo8BTpdoRrWvcOU=;
        b=ea2KRnmsLhjbfO4FmQIzoqEHOPjbB0wDXtYTXUD8Z4RkOKlIpKWkw3HOhtpL4m8Yu0
         vJSYeflTYYKpsTDlZAmaL45kMvIoiO98JIvyya76/gsrY6PWqKx3foXP5xGPQcxr1aHY
         Fk/ExI1L9FoZC1TkOWT8ged5RWjfr8vkjMoGRLwA53LnqhzOlEmXL10FGG6SnI9TQLr0
         /4m1a1xLQIdUvjKqAykP+gM91iN/ImBhtz6odd19YLn2eogSZw1gr3GhR8Pawt6cSPZL
         /WTGMwmE5sLXwY+WFfC3z4dO8YAkK/mXdKqM7481slyA5pJ6r5YfLrKFaeLhqLg+uG3b
         NBsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/u8RzDQrOywrzApE0WwU0Icyj5EyLNYRhcM4+OhNUCHTPzOIKYrkjAIjJTRT7cRCSWQ54JwqOExg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6A3zuVFdAiotmvA7EQnj+JjWSKh9QA4ij4Xns2kLxNIO/XqaZ
	e2C7nJN9QAFIWz2c2iZtrGmaUvYOHDXaWs5Y32qBMN9RGCzNp20rNHrGNmf5e8Mvq6xYw6YPa3a
	bibDGq3L7nBBg4Zvu2qbcGCAAX3adfSNZ1Jj5LtospOTMDDkFr17hmrleAcawvQ==
X-Gm-Gg: Acq92OGcX8vLbieXmmUedjBMNkVHdEGu3eAPRbzMGj133l7Iyo5/yNfeg4IL7nyzkNs
	0/E9O5HM7kq+lECTrCp4zOoUbS6LxSA4GcAQj4W3UCIqI4Kp64cFmGZmju0DyK20Img8bJOmH7O
	IAqOuaMVTvHruO1I3RbvhmBgCbg3ApxawEifXtBvx5zOEa+dyyY+ZyXhiQp3Qxet9R6X/UpETDm
	Xi6J7Au8AyHGb1dJ15Agyi6mSj4+Gw9FwHD7Rjo1pXNY2EdQ3zsgamEXX9GX9bqh+X3j1hRuF42
	FrnCL8uyUg3eQfnMtOZuOOCc++7Wl+KVGb8wzi3o0xF+pl/NEjdcpM9BrPbxMI7XytIyAK0gvBD
	L7lRXTzowtcL0EUuPXe1DwmIvN7xEYyNlcm/jvxN1MjJzntQf1qzXAuDD1jjYy1avKmZZ0UqsA3
	NWz+0=
X-Received: by 2002:ac8:7f0b:0:b0:509:2b5a:808 with SMTP id d75a77b69052e-516c54c0464mr18827201cf.2.1779350407123;
        Thu, 21 May 2026 01:00:07 -0700 (PDT)
X-Received: by 2002:ac8:7f0b:0:b0:509:2b5a:808 with SMTP id d75a77b69052e-516c54c0464mr18826611cf.2.1779350406434;
        Thu, 21 May 2026 01:00:06 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8a50594esm12245866b.33.2026.05.21.01.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 01:00:05 -0700 (PDT)
Message-ID: <2b5a516d-f847-4cb6-9ea5-21f56448b00f@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:00:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] interconnect: qcom: x1e80100: Revert ABI break
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260520184944.182148-3-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260520184944.182148-3-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA3NyBTYWx0ZWRfX9wMmHGoS4geU
 QMp+9+jr6sYkSj6c5a/qUQkIuRP7C1v9VXVkaDqYj3TM4jg/PVMm5W1OmpjRDkgI6W/vapjMubL
 EGn0DOgzTpA2EIEWlKgEY/37mNrdEwzJkAkdSbBJdsBs0sY3tgDPBA8cD/F6eqZls+DopQKNcAT
 fLQJqR3Or4SIfQh7XkLK0hogZevrvwAAh4Dg7iiZZ0OfKf/BYqaKHGeeLasJwsKcRlClMdzrwix
 cV11Jt6y0y6os6tijTo7psrZKnGXL4YQvswf4aw+aHkBGEyCaA6A1u197dXct6LsGOUnA0MML1y
 a6OKZXeG6kKptGfv3bxlULl7D/BC+WnZPk26tyOPMqnuUI+MTToWkBajptM8QLcOsue2kV8IM1A
 Tn7ZjRL5XNDLtYiJ67X3lw9KAECg91sWXb1rqagxALhbtRz+AmanqfbSdfd1eWpN6VvMkjMyuXC
 6YzMs7O2eWtUKMwkmoA==
X-Proofpoint-ORIG-GUID: EkX91R_tJ1jalTwXvKKAf1sQJbu8Wux1
X-Proofpoint-GUID: EkX91R_tJ1jalTwXvKKAf1sQJbu8Wux1
X-Authority-Analysis: v=2.4 cv=H8LrBeYi c=1 sm=1 tr=0 ts=6a0ebb87 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=mQNDsmP-micbF6_pwTUA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210077

On 5/20/26 8:49 PM, Krzysztof Kozlowski wrote:
> Revert commit c70f7dcd0921 ("interconnect: qcom: x1e80100: enable QoS
> configuration") because it breaks the ABI without justification what was
> broken and what was not working.  It claims the clocks are needed for
> QoS, which might be correct, but QoS itself is not a mandatory thing for
> the device to operate.

???

Would a saner resolution not be to simply adjust the bindings change to
mimic the other post-factum QoS clock additions, where `required:`
wasn't altered?

e.g.

e07f3b8c9e1c ("dt-bindings: interconnect: qcom,qcs615-rpmh: add clocks property to enable QoS")

Konrad
