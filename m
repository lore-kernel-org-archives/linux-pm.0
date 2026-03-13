Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C02F364035
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385425; cv=none; b=WUWsCYT408TXEpflJgfsrNJg8Tai4nPSslun7SG/a5Mg24d3zMIqu1jfKGZit/nFEq17QKWHXHzhuLkulYAAiV9s34SDBYxixMK7jWExGWLsJjOkIxfNrylKA7ysh0QuCi59z8FqJ9XddWuRxVfw8ZQu05Suxt+o9D2LGI/QMp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385425; c=relaxed/simple;
	bh=Rn8wHtCLMEv57Olj+9qoKpCygPJwlSOUIiqpDelPERk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgu8Yr0XU/1S3I+80kXx2t4ZjriRMYIT/UOqOL7WKktzNyPZAzAuOaum0MbEUYfsFQ1LSPlX6cg0Qn0wkSsWaGaNE07GT5qHCfzldOCk63GsyMAzlUfKxC0rjPrX/dZizLznLBP7Bsin0beydlI0hr80NxuymUqydwqJUTC/V9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I4QKlM4U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CPzWt83P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I4QKlM4U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CPzWt83P"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5tmxq3844431
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 07:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zEP0RLQ1FcdKjb0SaePafyEpkf9Bx0Hizh3a1ioi+V8=; b=I4QKlM4UymqKZXFP
	PKcF6zPyg9UbFQB1MYYkLiw8zjs/DVth36yYp6nHYC9Bsbn+0TT52kaJ8YyqGOnl
	9NkkemP4jZekyiG9CF1W5hMZzhvJ4A8UXG0WqdGInso3z7QaZr1eEtGNWNq9E8h/
	CRRF+St3t7p16Ku/zcj2rbMB10hgJofduwIhsqWlW1lHIrKM9/y+DKkTvnVPQ0IV
	AKomOC8lIJluZlqDlNOzkYzsIHIXy8pJwFTKjsvrhJjNbjaVtKQ9X7k8fsxT3bN8
	zrAGV2dl9nhRvY5kgZwuXr+v7cKFUiL7csF6Gt1Dfq/wAtaRt9rS0NjbZ/VFn6j8
	AJpQng==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh54vuct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 07:03:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2adc527eaf5so14223305ad.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 00:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773385422; x=1773990222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zEP0RLQ1FcdKjb0SaePafyEpkf9Bx0Hizh3a1ioi+V8=;
        b=CPzWt83PMwARBsvHOylBdh4EU9BB9bRNMKHvc5vtVxM9GM8n5ncpqaMfWsqDsPleY5
         Scj+uoaHp6gffbUQgIy2Z3iefub05VbPB7f5U0sWqg+WOzXWApW45jzK9G19BZRw7Dj9
         g6ctr8dkUlAUpEXgs2dy68GsyQOP1wcYOZq3r8URDTXaOTmBeyf+I0w7gTO/RS8FO8Ny
         MKFQWxqTEuM5mB6pU3H3fXt/vU6O1ZlaL0Qnj8vEf+qb2rp2epY8D6ZrSEQ6kJTqg/Ou
         U2tpm4dVnEG5XAD5YQTBwgV76ykJd2WH2fgk9l28NmsX8TbqGplIhgwNjCIk6sXtcble
         JciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773385422; x=1773990222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEP0RLQ1FcdKjb0SaePafyEpkf9Bx0Hizh3a1ioi+V8=;
        b=sbt+f6yRbbgyN5sqqPrFSvCHwBIajCrl39IZ8yUFIhxCL56QQOHHcQr4lSwOtzVs7i
         enOg/g6pTEt1gG+tWlYGZEUFb2Et9qzZJ+nXka8XbqHH35AkJiqIe3LA5pOdL1kdB7cF
         GjG23G66dVhnRwvIACUPk+QpI0qXoIrkc+V5EopMmbcJVY/+PfNBpRTe2D4JtmTMVFmp
         x4ujxlFqCCKGHryco9l8aKqNx4ifaGqtt8T1WyAK7z9mx8o8KYYByX0CkZv+0qxCGe84
         i3H7z0QF7qTS2p0HLoCxofBWTGyzaLTYo8ikln0E02qzov7zaLntF6uielGmkAANR93l
         7/wg==
X-Forwarded-Encrypted: i=1; AJvYcCVy2GCVg95O0ZuW53aaJDRABneqDM+1S22QD7aUE3HeG/VuRQkjP0nb1+e80gdA2CMv9O1ueR78nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSrzHweAP2NIorwxQTgvQJXyxURZMt+lja/V0zVe014NFzzOAA
	pTz3mNiesvuy3W1GGZElbC3IsxYmb/FxL/0eY3R/qBPy2LdyNfYoveJNIk33akiUkLwi2n8Pa2A
	l6c8S7+CFEJ8Nn+8m8zYJiUf4qirppFhBZcNINIkHmLDKPfsGLOvo17QTkOcUsg==
X-Gm-Gg: ATEYQzzCPuPQsP3zQlx6CfBoBsu3sMMGE8S5iNLgMFrJGe5I7lZG+tpKo1OvQYN+aHz
	XZciV1YYeLCcMVZCbCDMK1kvZdIBLvtvdwoX3sUSbqBpDNTCU413PkbH8Abi6UW5ZBDufUAA7+a
	Mb+ctIXg9UJ71E+hvLpxo/UWfYa4WFrdTYN+KoLwtXz0NqBLjMspowgW1ImFXZiZKDKMAwHdBT8
	9odTHD3pXYtoGYOYHY2+zcfHb7B0+oY4SBj0WRV3pYC2jmMTIZeV25kvKc+hqhdn0yqmy6Q521l
	81G3eY4PtClwXzxuBwMYYm6kctjrj4Jaw3AkYKOBGTV1NhpkZMzf9U/cu8WQQZg0miopgbVWRfz
	2pd1gtb9WIoOsLnOkO411j/sv4nwoJJvyUCMR22DCWXOisTJ3/jcOAw==
X-Received: by 2002:a17:902:f690:b0:2ae:5a70:476b with SMTP id d9443c01a7336-2aeca9e0906mr22825725ad.15.1773385421946;
        Fri, 13 Mar 2026 00:03:41 -0700 (PDT)
X-Received: by 2002:a17:902:f690:b0:2ae:5a70:476b with SMTP id d9443c01a7336-2aeca9e0906mr22825295ad.15.1773385421470;
        Fri, 13 Mar 2026 00:03:41 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62d0easm15764975ad.39.2026.03.13.00.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 00:03:41 -0700 (PDT)
Message-ID: <54798338-83b4-4088-b2b1-52c3cde960b2@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 12:33:35 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] PCI: Add support for PCIe WAKE# interrupt
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij <linusw@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com,
        driver-core@lists.linux.dev
References: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com>
 <CAMRc=MdF92kriuT_-Fbk3pj6YeJiNv6RSiDE7aB0AKL9oFZg5w@mail.gmail.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <CAMRc=MdF92kriuT_-Fbk3pj6YeJiNv6RSiDE7aB0AKL9oFZg5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cf0jU1FZLy-pNCE-2yNGgtGx1hD0Mcen
X-Authority-Analysis: v=2.4 cv=BNG+bVQG c=1 sm=1 tr=0 ts=69b3b6cf cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ikd4Dj_1AAAA:8 a=s8YR1HE3AAAA:8
 a=XA70DKTrLd0yiFKK3swA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: cf0jU1FZLy-pNCE-2yNGgtGx1hD0Mcen
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1NSBTYWx0ZWRfX27dxgqNyT8Zm
 DW6C3Ty2nIoPVzIOMtDigfGDliE3dACGpdDlIMVsZMb7+QYwxSD7yjJIm7IJw2i+8RuaHCmF/DK
 rITjvHhprb/vL6UU9ZSU5rhWtFD9/0nzt2fSC9N6hM4Ctj9qSqHxVDdKgT/mjAIlODWucTHfwdu
 FIvv1irNz61s2kY0N1dowvJ0rGP7UcHFlSB+p4f2ebYY0oY0wbyNJvhiuE9VAVypcEUmnnjdhzR
 CqFuT2o5gHUDO5k89xSvQnL/iDMdcQ4bDSfIILtX90QAdLLyXDEjzuDyWwIRonxIMeBlYR2Gfde
 1HEg+Wm5hVUf1e0cVprjSLih0uxMtII78Z9H4i5go/SDrW4FADeeFk8hRwv8XC7q2HNj6zsTSCV
 HYbkW08ye833TrJnccz4WxrQu5Ju911iJHN7qyjxTmIWw/vOaxmYIuK6XCtHjFGPEgKKEc60Om0
 2PjyeTe+DFso/n0+0uQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130055



On 2/18/2026 3:31 PM, Bartosz Golaszewski wrote:
> On Wed, Feb 18, 2026 at 9:12 AM Krishna Chaitanya Chundru
> <krishna.chundru@oss.qualcomm.com> wrote:
>> PCIe WAKE# interrupt is needed for bringing back PCIe device state from
>> D3cold to D0.
>>
>> This is pending from long time, there was two attempts done previously to
>> add WAKE# support[1], [2]. Those series tried to add support for legacy
>> interrupts along with WAKE#. Legacy interrupts are already available in
>> the latest kernel and we can ignore them. For the wake IRQ the series is
>> trying to use interrupts property define in the device tree.
>>
>> This series is using gpio property instead of interrupts, from
>> gpio desc driver will allocate the dedicate IRQ.
>>
>> WAKE# is added in dts schema and merged based on this patch.
>> https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
>>
>> [1]: https://lore.kernel.org/all/b2b91240-95fe-145d-502c-d52225497a34@nvidia.com/T/
>> [2]: https://lore.kernel.org/all/20171226023646.17722-1-jeffy.chen@rock-chips.com/
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
> This spans three subsystems, how do you want to get it upstream?
Hi Bartosz,
we can take these patches through pci branch, if all maintainers give us 
the ack.

I will mention this info in the next series cover letter.

- Krishna Chaitanya.
>
> Bartosz

