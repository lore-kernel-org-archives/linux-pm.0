Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6703290BA
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682136; cv=none; b=sJWg021w5pBoeZpnFsSe5l5ES6bTY0qkc/xDQcmsCGFcjadCQAxK9LeMYMpUYUpgWbUUlW8TtdRsCiUzaYrXJqcax5RNmidt74VPrd7BUh/WLPK+zSPf6Ga3W2z8ZPqbN2ccpBqNl3EiHxgFO9AmQwz1A7POHvc8d5XhLo56NoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682136; c=relaxed/simple;
	bh=yuwG+GQqPDxDLqa/iuf/1z9T8pkREhiSS+Co1wPvLtw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PFpzOID001YBEU5WrfwOk0MWte99FeOgdqDgM9ACkmCTwj7qmo8hofV10/g/BZ9HuwbLKmUVEU/zVqcewuuQAdl+R1rCNmdlDx1ez0fFb2lKHkOeJyL8ZvkLbT1QsFdtqMrp7RBgXxXF1FEKCTRuM1F4CFg5LMALpK/Srqx1bzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ruukk2KU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aGZQY/t3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ruukk2KU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aGZQY/t3"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DCc05v2965290
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 14:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jXzlpCGiQvqlBY0jfxDaEtKLtM70/40EGKAZonN0dNs=; b=Ruukk2KUyt45XQmU
	t5JxBn5tdz4i+cUgdv7fRNIgrqVUMPz24ZYKWupkD9N2pzVodJBAkV8OnLNKErcl
	QIwzvbT86O6hjvqcx1asf8cpQvOTaQrrrKXa6lHEWdZu0aD4MrdjIcrBh4Za+ii5
	aB6kjvCS0Za693ksIrjMgeQmzVBUkpbauISE1rVbd8id+QDS5MO8yl8PbMTmFjX+
	FGeFAj5lISK6sGBuE5tIsJW9dzjPH4KXIBtQlhn+pRgEZzXdVTT+R5PuL4CEoPxG
	oEwJ0E5+BSYZHPCPuJhzcafkfB258UEnS22nCG2X8eN9H9kpfvETSRpX6y9tP2ip
	jiMaOA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4ma59rwa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 14:22:14 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-958a0e94ff9so2809767241.1
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778682133; x=1779286933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jXzlpCGiQvqlBY0jfxDaEtKLtM70/40EGKAZonN0dNs=;
        b=aGZQY/t3yE4CXAX8ny8sts1vdpXH2hmNbWBrqT3utCtM0g9s05s+Zmm4fyMSpq9Wf8
         6xJDTTB6xPbB4w4cAXeJ4vS3nToPmpd5Rvfv6tTq8me5g7x2tRoZVWpqPdhwrrSqvPi/
         LhShifNpJUhfeG3hoYVWVcK6RzA93YTdLdW/byTNYdrlIaLTapV/omv6vsp/bNf7NAqZ
         ZkzWaI9NioDwfAaykYbGu9a5pPBct8RH6Jhobcgqs0rMUrPOKZ5lbS1aFybnY7vBXRDN
         +F1cqzkmselnxGWdQqGY8CM7S1fxlOj2xLXefX9eMlDV67JApkgc+NMhO6q3YWowCEWa
         5rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778682133; x=1779286933;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXzlpCGiQvqlBY0jfxDaEtKLtM70/40EGKAZonN0dNs=;
        b=sQdwFee9UFdCY5d0ANatkSbZilzd9NaCjB18psbkflqgcTyQCBhUHrlvbIdnAHb2Tj
         ORQP9Is2b+SyxWeHwC+uhcaetWSWPUolMlZFcFGKEB4I4sJf0meaYa8VieYqKanhBAhW
         B00s4QQdUWO8XWtCxy9aELBLdKC9N+JNGeIpadLzXrSERRhxSe+uFtUDmtrhgAx5D2tF
         uy0wdtR6G327dZuuv7ZfydJyfwzY5GdnvYYLAOAwwyisYksU/Q4Z8ANKcTXZWgNIEqyR
         u3o9j8/EGbAVOavo6gLcnROogQPOJaHJUmvklyvgJ78c8TQmoIHKB2Y1G7pBdyEBdEVZ
         g8QA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ibenz55d+ErNvwSiFLxcZmiax2eHsBwzlesAXEuP40q/JG3WZssHQTvmViRwl4y7tWalwzF2YVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgYlUxIKQLbkbqNudJCXx5EVDk6SY7hFrSbkocQzZleFjjqmuF
	gtoOY4xR8i1ypSS8FsXgGhBlXHK1JW+ON1wKIlf/UWsrZAUYxdZfIGoD0Gl11KyphecyTmhIvEa
	q2LB2EzPTCCp0ckEertCU+J4jSvoCglR6GvTfuaHoj6guJGlANrj+8hrcXydDjA==
X-Gm-Gg: Acq92OGBLXqBsxIydH39uXMqlbTNRZ7oa0Xm0SL6NAVXoVBrel67uupkedo4ccfW2sy
	11esbV6N8Um5eH98j5/PMYl/o1vpeBlIGFIHSKkbB18YlkI4+fxHiw0/kU71CTpEKbcN2EOCHge
	aY40yol50No4bf1mx/iMwsdamkDxm/uIElk+D+ESh5B0g/9kHqjhO3ufoeZ/VbaAym69riaAnQT
	o4/zrNboa/4OZ+/tggDAkBEHT+4YO9VFDGCHfr7gYWY9egdziClu8373fJO9iqQkOhDzeI0dAyr
	MNa7e+Rw3IzHqsepvozqyM1fnaCqhvRyRIpCdi5y4KRhSG2itrtUm959m5yjD2FzuF8XkYMru4D
	9R9/ZbyXCEgc7Oa9x5Y7UGPaRXlLDmq/sC0LBO2a9cNiFR0lfWnXsuh+llr2NRMxPtXejfW/HFy
	yx3I/+R9UI
X-Received: by 2002:a05:6102:3909:b0:5ff:cee8:660c with SMTP id ada2fe7eead31-6377487373dmr1615556137.31.1778682133110;
        Wed, 13 May 2026 07:22:13 -0700 (PDT)
X-Received: by 2002:a05:6102:3909:b0:5ff:cee8:660c with SMTP id ada2fe7eead31-6377487373dmr1615514137.31.1778682132497;
        Wed, 13 May 2026 07:22:12 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8164:8816:f817:5d0f? ([2a05:6e02:1041:c10:8164:8816:f817:5d0f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e5dd3e1sm73227655e9.1.2026.05.13.07.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 07:22:10 -0700 (PDT)
Message-ID: <48c1ae15-3fa7-439a-a492-c82b39fb0a89@oss.qualcomm.com>
Date: Wed, 13 May 2026 16:22:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] thermal/core: Decouple release paths for tz and cdev
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: lukasz.luba@arm.com, rafael@kernel.org
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
 <ce06dddf-3f47-4492-ab30-d3fde92e3b2a@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ce06dddf-3f47-4492-ab30-d3fde92e3b2a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0NyBTYWx0ZWRfX7KxnR4ZqTPg6
 MmWC5Lza/KyiCHyfwSr5JOqvAalZcn/gMbcBfh0jvMJzivLIbpKlM2ej7g+gqxVve1ZrLk/RFf0
 f6v0N4i0pk8BCIor5daalZlvZv0A4Ng2+WW6PfU/BSrkKfR9Si4jLcJrkRJUp38GxrKZNFfBlKi
 qSCZYJLYsV997xNQxH0LxayXbG3L4osJUt7CmFZaE1k5+V2RdJmvZCER8QUaL7GcOdnM1xA2h71
 LJu/skrU/CT1aX02vsqgq9PQMe94VbJNTLs+JR7N0W5VhsbUIheXz1rLdTPcqUmFvjlLvsr89b8
 MlgGwYpj/FMEVbhaIMmtpxjRjjCcg3K4G4vOMJASjFp/ZKtqlDVtbOld/DhO1foK6eqknF7I+Zz
 sm7Vm3LSJwW6M9bp4QLCkkFQdW7Sad2c0pligLD0OCPJfMs/wZjRxEqCbDxEsXfoNL6uedzRt8o
 3t/6AwIg8TKpAas1Zvg==
X-Proofpoint-ORIG-GUID: 0N_CGqJZ9N73kZtJ8LfPdrQI1RGHNTfU
X-Authority-Analysis: v=2.4 cv=TJZ1jVla c=1 sm=1 tr=0 ts=6a048916 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=M6oQX93JJpSEMruNXt8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: 0N_CGqJZ9N73kZtJ8LfPdrQI1RGHNTfU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130147


Hi Rafael,

On 5/8/26 20:10, Daniel Lezcano wrote:
> On 5/8/26 20:05, Daniel Lezcano wrote:
>> This series cleans up the lifetime handling of thermal devices.
>>
>> Currently, the thermal class release callback handles both thermal
>> zones and cooling devices by checking the device name prefix. This
>> approach is fragile and mixes responsibilities across different object
>> types.
>>
>> The first two patches introduce dedicated struct device release
>> callbacks for thermal zones and cooling devices. This removes the need
>> to rely on device names and keeps the lifetime management local to
>> each object.
>>
>> The last two patches convert the thermal class to a dynamically
>> allocated object and simplify the initialization logic by using the
>> class pointer itself as a guard instead of a separate boolean flag.
>>
>> Overall, this results in a clearer separation of responsibilities and
>> more robust lifetime management aligned with the device model.
>>
>> No functional change intended.
> Unless I’m mistaken, the patch sent to split the cooling device 
> registration is correct with this cleanup.

Were you able to apply the patch splitting the cooling device 
registration on top of this series ?
