Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215623A544E
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882120; cv=none; b=U2lO2CvO3IHdej59Dnm/FBRQiOoaePoNezsXCxI77FTYlN/N64NMUmoMbaNMLB4U2UExmOClAmxIZJRLmVNLjduF/tur12m0EPpjG90xh3RJBL1kC0hveld45Jk42ESSbVXPSI/MDsXm5P60Vy0wNCegVkw25/fHyfwF/VpYhe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882120; c=relaxed/simple;
	bh=/sLFkoQtI+WbaO+DA0v226vFfEE7WVVyAp/OcA12LRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m48KePGmCIWDDmlnmTGBgfoL28S5w0keur55qeljCP6d//Rz+jc9Pa/BJA8YIbfN0n1RallahOeRonkpvbt7nmDUBRD2TvNOEl40AeqKtyuJgUC+k3Org/Sy9mGmAlDqxiEZYp5WNU45YLeg04Ot5nKBkD5R7RXDC8K2RpVuBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kdWn20E6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IFzXqcZ9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kdWn20E6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IFzXqcZ9"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JD9tKW209727
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 15:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rvm7EW1AZ3kby+gfRTDdQGVNrJ/dblRehYXBCDNmPIU=; b=kdWn20E6Dy7hTtX3
	eUjFJSoMcs9DrxAI+WrgPpm0ktgwPGhUYvgzCpllWZEX2gtSyEHFYhjsKRq6yNaD
	WyEiDBE2KUgtXhOrVqywTMAkNaPa2N8JQBKsI9mfAGf8I9H/ba4Eu/cXQVB/0qdx
	dkj8vW4XXKCZI3smkEY6l02Lhn7CX9KR4bZs/dWSgKAQ6nvkkN+Sr2JhTyH4/AzH
	x0OF5GsS9De8HEyeQZM6u9CzWD/cJYMpDTQtNtm1RWXfjCUyxpaUknp2qdPltjSs
	8N+B6CPN3Qm6Lxrnj9O1CWG+mZAflcN1ZeydwaSHVrbXa1uc6+iVszuyIvZKdSb9
	1CbZuQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evy72hpsc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 15:15:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9160006de85so51033885a.2
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781882117; x=1782486917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rvm7EW1AZ3kby+gfRTDdQGVNrJ/dblRehYXBCDNmPIU=;
        b=IFzXqcZ959hhXiy1ZOpdnJfLRTHg57zIqyhVp1ERRXKcv9e4azaq7m/AMrNp2qglOL
         s/ogXDiZzRUJZ2ds47hYNWc5pRVoXVpO4mCjbEwoMQ7JYSCSNdQyRvHTsU7jJvEkAJzD
         v2BhHhy1nm7SB9i5nbHvFreKkKitSpaql3z0MMavS4zQuHZqe7dwhlZ7uc8BhLfy3Ra9
         JOuH+kSiJiCFbnK+zmkHInnCheK6xn9phQ2SxXEYDrhmIKWvpXKwsFc5VAidl1+ajdcS
         AS6BzAgn6vetcmxbdRGSAsDIPH9UB7eWM4OvvPUNXELjgXcBei9T1V4OKJGO8za3Yhef
         KvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781882117; x=1782486917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvm7EW1AZ3kby+gfRTDdQGVNrJ/dblRehYXBCDNmPIU=;
        b=b6IU90F47eqiD6z4oWadZuqh7rvVslNuuuDA7P1ss1OJ6YGfpAY5MV/or/Ry1YW9Et
         8fNjJ/0pS4gtKgVK6rW+dXFHWx9sjgjmVHibTVQ0M23oFcg4pN991WsY8ZNCQScYZkab
         sKx+bXY53WTGIgytVs6bZkTQ+I741NlEsv3G8WoIWVNakwEcDHFkwjTbPUzlUXf8vAuL
         /oDBiQy92/P2z5X9QptqIGeRkvbLn5L+xvCKFKIPRdSKuV9/HG9pItaK1kBWcbF9pk7A
         QjL91k6sngYRxZumfjXSCgjMlLSUJxtGfS+RA/OTPrTi+pk0uwdTv90uVQjD/Ou0rw/2
         rj1A==
X-Forwarded-Encrypted: i=1; AFNElJ9LvsR/O5gB0cA1E0XABERFN8D2/DiKfHC+mYCBSj1VjQRurtFuPk58X32GNPgPMuFzQCsk25KlnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz668qvJJC3P08bcbOTCez/Y9a47tLjr/NIve1Ky8x8fbLmo3Uo
	JLK6oMFLgolEqSNUXUYEO970I6/3OeV85F/F+m4MjGkbqYpoKPwUX8wDPuyhLo3/wIJ8WzpNuwx
	3Dfw3ImospvUgyLtPasCtfkSHSYSZKerKATiXOgX2KkeU78vbXv+hsLe8h/4GrA==
X-Gm-Gg: AfdE7cl+Bpl2bJ19dn7BXBkN1AfQvYvjsFbT/fHgE6HbIPC+C8+YmmZCASaYd2QYGfo
	xHX4c67dM4ZAVW7vEKCCJKEvGWjFdsJWUb7CPQjWHRUHtYBZjRyMEJiwyCgyGzScry7rXsz8dIT
	WT/ppdC5lrS0+JiqYZ2puPwoVo3sePjQah7jwoaFF+ZBmXpUAWdSZ16tE+GM6oXYpoTnxdvGTaG
	WArRnlYGxKlRichJOoUrcoAHks4y9nf+oYgIZGNo/PvmRqrH3HZeEQbHmz2TJ1qquFMF8KlZFBR
	LWtUsXHNbxF/1jfRE4wComJpzXurTIu3sl3ucmz/n6+z+5h7mwKtzg58yVLRR/t8K9RmHK4MGTK
	mhoFtzJc9fT7X6A9WR0vwzwGOrAVBofJQpfM=
X-Received: by 2002:a05:620a:470f:b0:920:6579:bee8 with SMTP id af79cd13be357-9208b292196mr366921685a.1.1781882117224;
        Fri, 19 Jun 2026 08:15:17 -0700 (PDT)
X-Received: by 2002:a05:620a:470f:b0:920:6579:bee8 with SMTP id af79cd13be357-9208b292196mr366911785a.1.1781882116580;
        Fri, 19 Jun 2026 08:15:16 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0a844f855fsm96816066b.4.2026.06.19.08.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 08:15:15 -0700 (PDT)
Message-ID: <a0e7c439-e377-4607-9468-d7c1681ded4d@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 17:15:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] power: supply: qcom_battmgr: Add thermal mitigation
 support
To: Dhruvin Rajpura <dhruvin.rajpura@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kamal.wadhwa@oss.qualcomm.com,
        jishnu.prakash@oss.qualcomm.com,
        Dhruvin Rajpura <drajpura@qti.qualcomm.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Umang Chheda <quic_uchheda@quicinc.com>
References: <20260609-cooling_device_reg-v1-0-e15bddcb0086@qti.qualcomm.com>
 <20260609-cooling_device_reg-v1-2-e15bddcb0086@qti.qualcomm.com>
 <d99447c8-f140-4ac1-85e1-a235c37eecde@oss.qualcomm.com>
 <CAB8MRjTAbpwcrD==eZuaJdaprQoEsgr2L1EEU6x+gEu8tAVijQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAB8MRjTAbpwcrD==eZuaJdaprQoEsgr2L1EEU6x+gEu8tAVijQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE0NCBTYWx0ZWRfXyf5TyPsKxRt+
 ACu5UsPkJqdTDCmB6JxBTJ4EV1qBGh2I23q6kyFPR8c0gjTOlclbrWxI/v0y5QoHsthSI1mq4pr
 yPccECXHAOBzTTZ52gAS2Ox35l7FuB5tiTQn7lBsdGBh9xh2XUwzsyYt8ei+J1gLlKbCRy4iJrB
 0Krf1Z1pjmJtJFFTOvCQzG29KSs4qWmbQOdws/T5IVERve4+j0jzB4FYl+F6iLuJhX6UO4clY1p
 oCBMA9TlbdWRw0wPQ1jJ4nCNlOsdXHlWO3vD+McjWWhyAp8N5c/MTe1pJNIkOQdUC9+K+FegPBM
 3RFY9KZhmghuRM0isbOu7QDL3lRtU8Ph+WkOU1s3H8RlnYuRA1Ax9MTosD2ihG2Ae2lMYBommi/
 VhQS2xJmTcqdoWPPWRd855WrjYIGulnNEaalSsMIPCcfFEtpA2jg+rqT4FkLpAT97AA07Nf1kNa
 zTmTClniPen7y7MkhFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE0NCBTYWx0ZWRfX1chwmGy605V/
 mYDKqe/wYvx5mr9gBjSvOBZF1lJGJKLk+jRy34y62Cym4q7kE+hhaleXw8wFNmTfANNp0yCurqe
 7BqPHiS/jbidpN2boLTX00XqvgY9EDM=
X-Authority-Analysis: v=2.4 cv=I75Vgtgg c=1 sm=1 tr=0 ts=6a355d06 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=2tevii4blPheqIWeYmQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: iyNEb0_h7SGtOCXZ066D1ADYZ19IJHXD
X-Proofpoint-GUID: iyNEb0_h7SGtOCXZ066D1ADYZ19IJHXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190144

On 6/11/26 1:32 PM, Dhruvin Rajpura wrote:
> On Tue, Jun 9, 2026 at 3:12 PM Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> wrote:
> 
>> On 6/9/26 11:16 AM, DhruvinRajpura wrote:
>>> From: Dhruvin Rajpura <drajpura@qti.qualcomm.com>

[...]

>>> +static int qcom_battmgr_parse_dt(struct qcom_battmgr *battmgr)
>>> +{
>>> +     struct device_node *node = battmgr->dev->of_node;
>>> +     int len, ret;
>>> +
>>> +     ret = of_property_count_elems_of_size(node,
>> "qcom,thermal-mitigation", sizeof(u32));
>>> +     if (ret == -EINVAL)
>>> +             return 0;               /* property not defined, thermal
>> mitigation disabled */
>>> +     if (ret <= 0)
>>> +             return ret;              /* real error, propagate */
>>
>> Does battmgr really expect the OS to house this information? Can we not
>> retrieve it from the running firmware?
>>
> 
> The firmware exposes only a single maximum FCC value via
> BATT_CHG_CTRL_LIM_MAX, not a set of discrete throttle levels.
> The thermal mitigation levels represent a platform policy
> decision - how aggressively to throttle charging at each
> thermal state - which varies per platform based on thermal
> design, battery capacity and use case requirements.
> 
> That said, if the preference is to avoid DT for this and instead
> derive levels programmatically from the firmware maximum, we
> could generate N evenly spaced levels between 0 and
> BATT_CHG_CTRL_LIM_MAX. However this would reduce platform
> flexibility. Happy to discuss the preferred approach.

Following up on what Krzysztof brought up in the other branch of this
thread, does battmgr only allow to throttle the charging current, or
are there toggles for e.g. power too?

And does the reported max limit current adapt to the selected PD voltage
level? (I would assume that's a stupid question, but never hurts to
confirm..)

Konrad
