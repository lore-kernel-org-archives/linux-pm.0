Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F1323EA97
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773485180; cv=none; b=PtygsCOn8RhR6CLhy74VPp3Qlrb9FvgaUMyHHtblJZrQSryCKR7IL2C/ICWqJtAVvbet7M3E92+83CCr5s4PxwZh5ml/H9d9/azUfoUyL1zRUHForI13tqX8LXuJ9/9wAPcSJYt5r1mByllGRV9pn3v8Iyx+jSMqMLtb94N6ROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773485180; c=relaxed/simple;
	bh=VO/ejbKJKTWN9wqCY8JTlHi79NeKZjNOdR21IcIVe7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxahEbgMarUnkkVryP37eWykZTz6ofEV/aTlbQAwRqzeeIaDH9UMGCRxRZr5tuNoBI33tqE7sXxNERuco5gVMgRXq36sQp4K08JS0a1mKnQ8VTNjdRqqWPxc3HmzPpC6s3uF53/YTlcBJBrROdw0KrbB0BlQ6VmqGTzTJlhyhec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G9d/BxDZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EZ2bR+u8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G9d/BxDZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EZ2bR+u8"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62E5QSnx2995628
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 10:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VO/ejbKJKTWN9wqCY8JTlHi79NeKZjNOdR21IcIVe7U=; b=G9d/BxDZ0k8gWaAc
	oIudLIsHzRFOylZGebnaay0wlycmRH4RdK3bp9T64NIwCpUqDPzEjnz9sgAV2n/i
	vDlf6JN4Lo8++7bqxwJ/zQWktCGqOrkKZpJvfu9pM4mT8WKM2geX8yMhK9+36tGo
	PMXn+0uI3x9dwR4L2+v4c1Ji7zssfLRCBzHB2RnXd57Ri62x7Ep5fibIpDtvFTLu
	VDEyl0jmdJkmYYlQOLf14BXipFHIlbymamfOV52gIdxHql4+U1bp1dxXjRlsykq3
	O1j7WYfXJUorHkRhWrWy4d/2UHy+fFEcU/jGK/ayb+IwPnlbX5DsyBZkVSMaZwKJ
	wC2zig==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvyy5gkxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 10:46:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd722c1a69so1786937285a.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773485178; x=1774089978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VO/ejbKJKTWN9wqCY8JTlHi79NeKZjNOdR21IcIVe7U=;
        b=EZ2bR+u8dSjMxm2zD/kjHgukuhfOZM+hsBSRvRr/PRJJhdXSDEYn7out/I5AEbcoQQ
         diXSWuns5QrpPMugUaPWj4WmR4Zh/mDX9q+DOlo9/IdBjWSwg1eGl3omCJitWKYjG+XY
         Pp2/7/r7yR4U3scf7sPQOBLKPWIyyMg/QHaTUVVt2a73SU3pRzfxniI/SsWAviD1SRQ5
         DGwsCuhXGU6gZmQazm57Roxd1hCyDm4VscsF5S95ERhYxbAhTWk8Jk+ADD1wOmhzxE6m
         lUL7qq0JjoT7cQzDS7EBFBSZkyaIsNi6Zn2Xn94YrNc+G7/NhAIAA9HXxKlrq68IksfH
         2o8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773485178; x=1774089978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VO/ejbKJKTWN9wqCY8JTlHi79NeKZjNOdR21IcIVe7U=;
        b=IED5b+25K5QJhfKgcOLrJvWceq8QukYX7afai2UT1+7XK9hnPEgJW9swyhJ0M/FTDb
         588qC01z5yhSG22M1dCOzSp070czOdW2Ywm+bz3y92WucZc88ooRMg3nR3ug6g4XexLT
         JVxrMBtacex16pV/NIRX5NuvT1wOePTY5fyYd5oI18/t2WIVzvGSCPC4lDTgOoLUvRyh
         k/GvCfOlE1hCMzpT1baX+auGyH+ngluCREvSwJi8lVm/TbuAuQ+XPXzBl580zoncCYvb
         8Wl5tKjj+uQTarp8xNz4ojNrbw9r1Sc59p+N1fW0XhhDeFepObksHlzSO8WkNdlyDV7t
         q+gw==
X-Forwarded-Encrypted: i=1; AJvYcCWmWoYWDGaiwTHhLhqvyayFeFlsnrGyxSzlOyuN1zxSlofVOlXqYbO6u4DEYKQghBY0B8zEeYmOFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwUpRmYbvCPp0WCJM4wig66eGNow16Y12d9EOaPDWlXekN2Dbk
	KDPVP8LpXbuG1FRCk1d583Pawr3tHDgHHU6e7XfzbxUIyaYyjAGB9fDqCXpjrr5xziE28KjEjlW
	9ur02dCPNAOmyIOa29XbEsSQCIZNsjgiPHdFIgnXnqur3mC+jhsPnVQchHp2Jig==
X-Gm-Gg: ATEYQzxqr1sdCIMCiiGFMCuQYYjLN0XICYU7JHOhLYuSKS3bgf3QG6OburtDISRM0mv
	7sSz7cwZ7cxRrH16Ihn2Bcqm4fQOTfAEPYIQOBYT05Z/pT39xwvJkLvHvwEjOXgfXdAuaumoyr4
	ckMFYz+i3yIlB2Dn5oMRNNW9kHZk2+woE7RIr+UZ7RUQSLAJa8NBdiANre6HRX2K2hiOANHI6as
	o4wllkEt+inJ9G4EMT7qQb4WceffZ5dy3eYMlCmKhbTu8/WFyvnQiQmhUzlrUuubi6F7RzAibVE
	gUrgsHwhoiDasQdn90CnN80PI6XZ5UFdSQhXQPpRQwLiYaISRdpDiBMOOc/u56N8gsfph7L9H7r
	0KFGB3TnGKgsHAOZQt5uknxPirva5vSfkiKfeG1HyPrjE6ZZqk3YPW0y1iwugpdkvrICjkXtig0
	q3Rqb+Qw==
X-Received: by 2002:a05:620a:24d:b0:8cd:c077:40d3 with SMTP id af79cd13be357-8cdc0774143mr332912485a.25.1773485178275;
        Sat, 14 Mar 2026 03:46:18 -0700 (PDT)
X-Received: by 2002:a05:620a:24d:b0:8cd:c077:40d3 with SMTP id af79cd13be357-8cdc0774143mr332909985a.25.1773485177836;
        Sat, 14 Mar 2026 03:46:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:136f:df3:89d9:875c? ([2a05:6e02:1041:c10:136f:df3:89d9:875c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a0b2db487sm9068085f8f.28.2026.03.14.03.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 03:46:17 -0700 (PDT)
Message-ID: <2f10bb1d-bf48-4146-8a6f-345b35738352@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 11:46:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: thermal: qcom-tsens: Document the SM8750
 Temperature Sensor
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aastha.pandey@oss.qualcomm.com,
        dipa.mantre@oss.qualcomm.com,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <20260313-sm8750_tsens-v1-0-250fcc3794a2@oss.qualcomm.com>
 <20260313-sm8750_tsens-v1-1-250fcc3794a2@oss.qualcomm.com>
 <20260314-macho-solid-tortoise-408b0f@quoll>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260314-macho-solid-tortoise-408b0f@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0Lh2pDyf-vaWgM8aToUjV2F7v16qFuNJ
X-Authority-Analysis: v=2.4 cv=QOxlhwLL c=1 sm=1 tr=0 ts=69b53c7b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=pKYB1mvBG6tSaCQwR-sA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 0Lh2pDyf-vaWgM8aToUjV2F7v16qFuNJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDA4MyBTYWx0ZWRfX8vw5HHGCrdaa
 6+cPMJHE3/aSFfZVAa7Nvlc3VZAKa0U+Ns1bgQ65mReYpjN55P0SavcGI0l0I6yOnR95ovv9iJT
 +Du9qRTLl+xcivPLKaIQbAVHMoO2V54nVEi0inPgTGohCmwRQcdQxZlEyVk3pR4BbEntrpMApvQ
 q5MbMC2qcLUejufdoUAqI3++eDoyKS0JEHuf6OctQ3XpJ9cDBKM2GAXKkxlkJGjRZtclXLjiAnC
 0EviHO9KrlJXMx2pDQXmokiWOL5IGFv5j3CHJT7uWcFnv4hW40GcDpLlNjHBR9twY9jjCc3XVjs
 4jV7pLzFAKjK/IZ0m4OS5n6/aYOzSCTunCXYWBitAP5cqEmhatyKsjTeZmGh3D5F68qjV7jV8Nv
 WlNfcdkpQ4Etqf6I7QSxbMTBuCTqfLA0vzPGOi1zAsdstnka5qAk/DhtWPu2iC6AF0pt23/gx4B
 0AW1NnxwjnM+7r1zx/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140083

On 3/14/26 11:30, Krzysztof Kozlowski wrote:
> On Fri, Mar 13, 2026 at 04:04:17PM +0530, Gaurav Kohli wrote:
>> From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
>>
>> Document the Temperature Sensor (TSENS) on the SM8750 SoC.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---


Applied thanks !

