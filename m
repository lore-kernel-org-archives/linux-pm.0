Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA899395AFD
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778649209; cv=none; b=IjXY6cYzdmjj9decwnhlwlPm4QHCwJ0vO1bxZiviokgn5gWqezyA8IdoavXqdK/aRuCbg1AvNzcQqxlvWCgrXPa83wfVnTU5CGhiTwB72Wpy6etgA/rQGt+3SoEXA8dwYDiehJ00cAaPM6wuhQF7BMcLy+89I5MlVyeeqEy9s7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778649209; c=relaxed/simple;
	bh=pM2DGxGrkoKJcE0Bm07o+fMroy+qeI2cYPvBR9adGSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNoPHm79yxeqpV3VBb3QH/zd2lKkCccqXbJuEObgKOjxQcrSb1C+bLFDdPlDH8Kmll3sZx1oXj0PR5fa9ctGdqvQ+kfpsbc0RUhtumcijEBhNREVeF66XoupdSjhZey0nVm5rACcNRYYli0p/y/uQ6Z8vm38lOtvaTi3W0Ldtx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CpKJSi3a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CEgA01po; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CpKJSi3a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CEgA01po"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4p9Y43527635
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HC9njI7Ve8bSEzotMi0PMuJUNcf0jXH4lvEu4Vd9J0o=; b=CpKJSi3aE9OwJ9Q1
	mPX563krRDiFx1NVP6MCY32g4kWUSvbMlmjY3WuFoPXEHgSXRAJ8TtsWviVIkJxO
	cnz8nUwy+Y1RmzKLX+AzjtftUZHXo8QJWizUTJIeCBHjdeBcqnWF+Xbl1bTWkVdN
	hPYgOQSMqsuLcCj98iixQ5BMVY7KR0Emgb3EQk9jbXfX1lp6GzJuMd2stTRt+3EY
	FEnMCpsjtF7K0ExIyv3ZQfXnaTtqhMSNqHuiiWaH7SKxtLQ4zzelllKilqVD003R
	Jz01kOIQtGWxE2qRdX9l4PM+2nyxcLfEimrBV+AUa1NZs44TBRs3oCnED1is8sUO
	PhnA8Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e44f3374b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:13:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba6ca20ceeso69944905ad.2
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 22:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778649206; x=1779254006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HC9njI7Ve8bSEzotMi0PMuJUNcf0jXH4lvEu4Vd9J0o=;
        b=CEgA01poh/4pne6sLv9nlIPs50qUn+ANR6yeQ4zrGMTM80iC2UqA/us0SRynzj1hD4
         AcDnpWLbNFE21HsVvN9FnfmKgXMUo28vTmNVuWODRfm93fiLfaHXU4UH9DBf4TkQNjng
         sKdsb2Gk+Qo2A1OY3JU+/Adm8naWD7E+0PcaXrBXQn8FydVxfmLwgOzU5cb/Bsz9Yl1y
         DMF4xxSroWd/HxwWvsOkD6/MCvkYT3MKZsPqx+0bgAhONXrZ+krWyaZaB7xYedhuwNXT
         sxbUh0eLrodoKTHw7VT/P+//hM9r7YKDjZMvkiflCtwFGmj/uK6hnqgvlWFtgnprCxqD
         MovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778649206; x=1779254006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HC9njI7Ve8bSEzotMi0PMuJUNcf0jXH4lvEu4Vd9J0o=;
        b=DyMJMDeHM238KvKIeuj78Ydhnq15E2kgWQ9O+oRmf942nXVxVp7DfpQZqF/9FlhuG0
         rFE3L3NVI4SCG6kCHnHHEHVM6+wuFU82/JtqC3klg3pstzBJ3X5ZXq163rTMBlLmR17K
         ytZyM6exIWDLvPWJ9YiPp3WQzXpz8hIlKG+p61ZekQM1dDXCAnnsfyyzu4iXy9tSMzcA
         SQ7YTtCVDWWlaYKPCqRuBEPOXQCO7RwEjBvJF5LkYFFfE8e+kqELAx653RpUKKh47l/1
         88U1MoKCFE8vT3bWAcPFfcx8JpGI8MT2ByyElNZljKz8pOKjgFMD2XJmRnBZbBhJFpaJ
         bDeA==
X-Gm-Message-State: AOJu0Yy3L6O9MlzK28XI930NwkOSliMbgUn+BGh3Tmh8cvTd2pfxW21n
	tVwVxpvtdn9srqIS2qQiFVIh16oBqUOuJTGrYCxpo7qNRWyWno1ob2iK5i/B4e9obg+FTiXdWVQ
	Q0xeNFmXxMFUDVXiFIEu48zA96iZuRFh2j9G2V6GNI6ILTFfP5B6zEZM8dQFYc3Obk0Uzvg==
X-Gm-Gg: Acq92OGXT7answtPKfoMX1n408uG9oehzwN+MZChr1wyiitjJ5r0M3VJUBBtICBjMBN
	o5hNETNtVqiUOTskTuUwuYzqOsmjaz5vsD7Pnm8o+gL4Xbry34VJ/EdbwWEdy1SSvz0xPq6Gi/h
	3ld2TVYsPO6akBmJ4i4D7V4zbW7Di8JDwSgTYtLzhNM9wK8yVve2fmknNSnTP3sVV0IktwCHD9h
	ZCaWbs6xia/UKhCD4mzsztDS+WWMsX15vpPQGtmCFbAiE0DO235l6aRzbZRnYlm8MZQdgsxvpzp
	8Ex/2mhbqWiqRV++yLUnC2be7nN/1ATpBznclo/Yfsq+p3hrJBwVISRFetfv0SGPp1D/zQUAlI3
	ZowYMpdMk+51U3XHGOKAm9ZERqG7ip7Xd4vNTQROZbA5jquYNwv8=
X-Received: by 2002:a17:903:907:b0:2bc:e216:db47 with SMTP id d9443c01a7336-2bd2713c36cmr20428765ad.8.1778649206356;
        Tue, 12 May 2026 22:13:26 -0700 (PDT)
X-Received: by 2002:a17:903:907:b0:2bc:e216:db47 with SMTP id d9443c01a7336-2bd2713c36cmr20428405ad.8.1778649205854;
        Tue, 12 May 2026 22:13:25 -0700 (PDT)
Received: from [10.218.50.10] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e99be6sm146767155ad.68.2026.05.12.22.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 22:13:25 -0700 (PDT)
Message-ID: <15e8fb71-1eb0-4440-a8cf-26f19f66b2bb@oss.qualcomm.com>
Date: Wed, 13 May 2026 10:43:20 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal: qcom: tsens: atomic temperature read with
 hardware-guided retries
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260511071024.3130247-1-priyansh.jain@oss.qualcomm.com>
 <06073a6c-1f75-4dad-9309-9bc47a2b4708@oss.qualcomm.com>
 <eab8dcf5-080e-45c2-985c-b0711185bed9@oss.qualcomm.com>
Content-Language: en-US
From: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
In-Reply-To: <eab8dcf5-080e-45c2-985c-b0711185bed9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oSsjBipW-kp6N7aLRHqwb9KIUL9_qr4F
X-Authority-Analysis: v=2.4 cv=SpSgLvO0 c=1 sm=1 tr=0 ts=6a040877 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=hyQ3UWTvvJBRuYoiHNwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA0OSBTYWx0ZWRfX2w1zX19qZh7w
 COVvRSnD6g+pf6VkQEiVi0vNChfCWG++6DX6Bhvj9bU51FOWWyr3bcfndy+QSy81PmHJcUk1vaz
 KTAjdZCswZWlrc4doeAv8POjSrOqFHT80cfMsz8mgiZ8yY0T+6pbGTD6jsL3KWNSUjFjZPivTkg
 kbo+9c4xhAIy6btgDwDtBMKlkoW39Z9Wnx8yJ2C2o/OmXfYF9SAzXPLolnDh9BRsxONBksToEb9
 a0n6C/8bVFpPhxvKx9NKprcp7mBmZ3hwWefc1bx9Sf10Q8FEnlhXAulbiyZzoUiXpx+/P74ZXpS
 fQjom3OQHyAAx4b9SV8l+TDSdW+CrZ6OAHyXokP99f+aLxiTXSH5A6MJgQl5wucE7bFk6LPeeFf
 9jLEn1xJh9EdyuB+IwHCNhPhbpV4/HUmogYDJ0DETza3IRNPkKYmnxhgBxfHWn6m2QMLwWTMoGH
 xqFVb/IKdX27LW4vkxg==
X-Proofpoint-GUID: oSsjBipW-kp6N7aLRHqwb9KIUL9_qr4F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130049



On 12-05-2026 02:59 pm, Daniel Lezcano wrote:
> On 5/12/26 11:19, Daniel Lezcano wrote:
> 
> [ ... ]
> 
>>> Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
>>> ---
>>
>> Applied, thanks
> 
> and dropped because of:
> 
> 
> drivers/thermal/qcom/tsens.c:819:9: error: this ‘if’ clause does not 
> guard... [-Werror=misleading-indentation]
>    819 |         if (!ret)
>        |         ^~
> /home/dlezcano/Work/src/linux/thermal/drivers/thermal/qcom/ 
> tsens.c:822:17: note: ...this statement, but the latter is misleadingly 
> indented as if it were guarded by the  if’
>    822 |                 return ret;
>        |                 ^~~~~~
> cc1: all warnings being treated as errors
> 
> Please next time test your changes before sending

Yes, I compiled the changes without the indentation flag enabled, which 
caused this issue to be missed during compilation. I will take care to 
avoid this going forward and will fix it in the next patch.

Thanks,
Priyansh

> 
> Thanks

