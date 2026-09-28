Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A429312819
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610904; cv=none; b=DF05hJh8XWg3/UX0eFDPigN2P3g0HTP8ShpI5aRLmigaeq0aMI+67ps3jeis18W9XZ98+Z3nWN0IrJzk57zp7wtq9LDd+llIdHAQlflowY+t5gwzGHKW0VgB2Edk/5Mj50Y8/LsC7mCDcZtK3GkgUoSQLP1vrEWJ7K5hexms0VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610904; c=relaxed/simple;
	bh=YNC2dPejWWJCrvIzjQvWnjPjhFgFgkqk/a9V/LXIx00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlA06gBYOV2b0vW4oX+ynrgZnVKNUxknF69AHY37gDnQ3q1nPPNR3RgxPlW/OylmaJzyNKIvgpQA4dZZJH4vIJ7RBuE2AVrmFq9W8QILAzWt/qy0iB9Rn4BF03Q1xpD7Xdl/RUyO2+UOyUsgW7emPiFMCfAUGPT3jvBcn6u2X5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AKtc7pSt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WlJIRamT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AKtc7pSt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WlJIRamT"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEe7Ad1647384
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 15:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oiM7Id/7T8AcpXTBsrdSOsZ5pYCXgGljuRR69wTdWB8=; b=AKtc7pStN4SszjDx
	RjmGX+EIAFghAIIo8TsDVl4WGoKd9suuC+CjpAQvZWmh7+hiWA0beMOzmtY1+2jE
	7dn+kVNfFFteaQAB2db31PDDKVJFMGdA6hD5RddQEijWY5fNjxfUNeWNJ1bxKo2Q
	xj3Fo1icu7zimzviPVREAvFKyiPM3rv5jH+Wpu/cUzcDtmvGmuGuChMl/bcNcqSE
	J5n9GqQXBK9fXHj9OT85ZYYiWGSwgdqrYlesDr221/JW8TU+dGNltzvSy/fQWnkH
	J4ELy7xLh113IT0iOBBF8DN/8t1ToJxW6Pqq00but3lmT6HinBRP95+FhgcbawJz
	FgwrUw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc1hxv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 15:54:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93bf4c0af4eso753166485a.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790610899; x=1791215699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oiM7Id/7T8AcpXTBsrdSOsZ5pYCXgGljuRR69wTdWB8=;
        b=WlJIRamTkyV+C0EYARJLA00o267HPTpNAZJXDmpZLmrwjl+iV0HIXC3VXwVftmb3+g
         ZlaWvgUb4UIQwtwWskc4PQ4TNKh0RkdpPkuPpCN68+sWaMvSqnsjjLNCzz/CWE8oTOlr
         W0KOOIm9l5/6MWrhhEI/jSmIoUZq7mdj++cOq67pR0OtgMv6qX11LUDxIp3xOFBotNk3
         bzkPltNK53LqlLRbI76XpVpLl8Fh+ZmHC0KF+ea3kdVWtvjM4cjxbpzNcoHXf5CWQzb+
         7vWeWl+Utp2qQcQAXC4wj25z1ZjYMWoOlvUt4QzS9RfggBT3aAlZ3KW0iCvdQViza3BY
         ygvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610899; x=1791215699;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oiM7Id/7T8AcpXTBsrdSOsZ5pYCXgGljuRR69wTdWB8=;
        b=M7qC5T8eL4nKIzdCXDCWatm2YaRBt1cTkMDRizoyxSlnrhQeJKTv0quhM9W1EkewRp
         hPvvMaz7axaiaHYa7o/skJudetUIfGBTTLIPdgHNOcFRQ9OWLuF3YmsHRHa2vTbNWT8g
         0gJxoJlPAw7+fI4Mgm5MZOyDh4SqxgP9GuJlI7mvCKDRn7B3Gl4KSGOhNdMl4gi3tJAW
         fAhEK2TIMSVdpOaRyXbVjjw8XruDQq8y4lOpKo39DMpJngwa0JN2Jq2FIca6QZyBqRZs
         sXGZ1qKUtdbkjunCnbWGV22mRGEoCWpDndr6DuOdMeVcHGSiNNbu530WkHKIVKEHf8dP
         4mBg==
X-Gm-Message-State: AFuF++k/TAeVnwz1tZRnVztvlcbj+DsDYFgDRbit8HDGc8O3fnUemVdU
	YgX/O9Mb0J7zEotlfGvkHV0uNwIUyVCYg2KltqRh+fkgPkRoMXStpTv9YqXZExhwel/4IXj6ebw
	QmYKTIxeFXbYsqzXIiwNutDDmhpaezQ9b6J5NYCG94LYqnF2tbtfddtiwAisGsQ==
X-Gm-Gg: AYBFou3NNyqq/1G4LH9VOwdq48ruyNkM8gH643AowiyqfyQBgr97+sppB9MOV0PRj33
	my/SzD2ko3otom/85Uyxv0wfKeWDiLmm2aXeYJ0SW5/rcCB65VI1rYv4ZF4u8AtstrASiBL46V5
	WS6/hvlCLTTivnmVGmi415QYYL2sPcO+crPSmmbWMG2gsTIEzlMRCEUqFvVbuUt7MIDPZ6HVy5D
	zvrauSk9lXHNRk536fKlpjxxRkJGuVYWKVZlJyfPFX0vFn263Wz14R9zZXqCp2UHgZ/lRxKoHKQ
	20W3F5cXZEgQB/qswMkDFwu4NB4jri8QFz3v2zZ5PHcORxqaoUvvn/VXc5O9iY5NPrtPH3CnQ8P
	3+ksvoDzFAUzx4TERRA==
X-Received: by 2002:a05:620a:488d:b0:93a:1196:ce5 with SMTP id af79cd13be357-93c43db73demr1951460785a.33.1790610899115;
        Mon, 28 Sep 2026 08:54:59 -0700 (PDT)
X-Received: by 2002:a05:620a:488d:b0:93a:1196:ce5 with SMTP id af79cd13be357-93c43db73demr1951438685a.33.1790610896262;
        Mon, 28 Sep 2026 08:54:56 -0700 (PDT)
Received: from [192.168.10.46] ([37.167.7.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28879319f8f.12.2026.09.28.08.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 08:54:55 -0700 (PDT)
Message-ID: <c07dcd3e-7d0f-4c79-9d99-25339f441f10@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 17:54:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: of: Match trip property helper types
To: "Rob Herring (Arm)" <robh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260612215009.1884665-1-robh@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260612215009.1884665-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba8dd3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=K71sKCzDSiMJbZmyObbiAA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=aSnnb4sgh-RbRcL0VzAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: H6fu4Ocq1hP3GQ_PZ_kilD178-2ha3En
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MyBTYWx0ZWRfX61/+VRa0n/qj
 hm75Ka67N+s3KHTjho8k2c499Ol+anNzJn+0SLAlCqTfz4m+vAcbMYM0bwiX6nv2Hsn518caeNP
 5M8prturJpY55O4snYXkZmetIpr/VzgNTr9UsoYrvbK8rmMXF2GnvZ6C2EucmwrZpDDB4exqWg8
 LWGrYU60TKKywk3b6YciVrHgCCDWJ4xBGhRG+3+j3e9PQQoJglqPD+qBFOSNrUIBeTG9tPW6Kr9
 NY1lrfi5QeMtWduhIUrQLcPqwoJG/Vf/RBTP/a666+ZraRaSazyTVE/V+Et97QGJl9Ld7sLbm2u
 7RIcGqWNNFh2cwPPKsC6ZwZQO+L3txq6lPMBVf19Qsi1MTTvOcaKChEFmKCakf8+V/MFkVGs6nn
 kpcM+IJUBdV2L7kFnR5bvzl9VnWiVUMgJDSkPIwkHooA9+QOydLg/hHdc3jZuSe8pOEQCbQCg0L
 x2IQ6Tk9VkBhnQKgzKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MyBTYWx0ZWRfX4L+MrZJEJrDx
 wgX1cOVwUVIHCgmyrZCtPQAkfhA4P1JjdxTfGcKDy3yE5u/QFny085P9I0P9QVmhYENCqmMDwnP
 GXEeQtBGhRj4oCkjejkLcUdevkX4oHk=
X-Proofpoint-ORIG-GUID: H6fu4Ocq1hP3GQ_PZ_kilD178-2ha3En
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280063

On 6/12/26 23:50, Rob Herring (Arm) wrote:
> The thermal-zone binding defines "temperature" as a signed int32
> value and "hysteresis" as an unsigned int32 value. Using helpers with
> matching types avoids dt_property_check mismatches and preserves the
> signed interpretation needed for trips below zero.
> 
> Read "temperature" with the signed helper and keep "hysteresis" on the
> unsigned helper using separate typed temporaries before storing them in
> the trip structure.
> 
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied, thanks

