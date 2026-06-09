Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3919B40C5CA
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006944; cv=none; b=faexewizDIHZKzgbbprver2lpPqMieq88Iv6Qe59TpWlkvFP+QD0Dh/w97efDH4olYKAUh1i7OOI0qruvPubE5gpJ0GJ+RirixVYjexilC8jH5ODRUHnaNlDbdM7BwVh2BcDqaLPh/X+5gstd4d33Fr9782ZxrjBKRGbvqKDR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006944; c=relaxed/simple;
	bh=1XiWFLWsxujiQANn+NvM3ghNX3eNtkTv+Cq/YH89VV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I57S0MhOzp+1YpjCFZYcgppeuOHj4pfOfw8JJg7ue0kbvRK2gnjxUXSt+m3blV6CDAE5w3aV5CocV/7KBWG9GD/O5k/HkZfc0XmK1uY/d1JnDwbDx8y+pCXWK1ezksr+cZMh/Gzp9lvwW89BzAZXFOCwPeO3lKcryZ4VHHkHU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vehoqstn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G3hoT5rr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vehoqstn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G3hoT5rr"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659BnLCJ2051729
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 12:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dYYsHxVGk7Sj544332KQB8eb4Ow5NsC++ELEMmHpcPs=; b=VehoqstnJpt0qrV4
	8+bnw9wPALFYNur5hUGGFcu6Wtl8T1TkhSAXPivti7QD34bCHGvIPw+ocERkFD8K
	u/QQvImFA2xWxsd8v1e34L/fnpVGd5bwfiZ4ErZ4bBoXP8P3nCLNWQCbP4MeAH4n
	pEMSDeTM0zCi/IFgxCB2MVNtib7wLVKwt2kWMXJO6eupcJ3qtaFngGec09FUZC4n
	buR89V2t1zi4e5Awj+GWiRbXvKxl3+hvUmy7sedrkEveSfRprMaiwNk4fhmmeUXr
	53AMvzBUU3QX9x/752j8v6e9m5fcChrX0zmE7C6E6Xv9YMInxW6aPGUtFF/iAimO
	tBURmw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epenr92uw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 12:09:01 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963a02dca36so5400301241.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 05:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781006941; x=1781611741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYYsHxVGk7Sj544332KQB8eb4Ow5NsC++ELEMmHpcPs=;
        b=G3hoT5rr5sP97l1ZJgxqjPSPx5pd6JHJrAIKx4MKVO/36pXYmjMVNd4hhxDBmALkX3
         mN6wcTbjTOWaz2xMY3amxlJafYDf+1lt5yzY+63eC2NBBrkF7O7XRhBeq9UqOvN0w7zO
         p0EEPQH5NlsKau4iscpnJzSdGjjY3FFHds+4k+FT0rbs8MP0AGpgtJDERzgDR9C26hGk
         U82xwbLjDW85VqZrExdkovH1hu6rAW0Yo/22AN4FdXoPK9uXW3Y/evmb/+Fpxz97IVnx
         O5C3cujHDptul8H1+zbH2ohXF+znRz1z2BdTaysLSfBtvv3HDXy1BZ7Mlbv4Mc5QLF1o
         mSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781006941; x=1781611741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYYsHxVGk7Sj544332KQB8eb4Ow5NsC++ELEMmHpcPs=;
        b=l1znwtRvguCBHz7OolH9ChozfXd46Kbx465gu1AZRfqqwXrghLt0+ke4SXXhNiTr32
         3lLjXjRD0llz/rqbI26cZs6SCvL/7sKlcMfNoQ7Uw287dC99oH9d0U10FFxtSsbhjdqJ
         6kbmf1JpEHxkB40CvHmYfgwr/yhqFvkgUpCzmgj17tQzH/lAn0M+FK3UN/o0OcZ1Uo7f
         +bj+fcJQaB69ABkLQyP6DrTkrXYZELjYCSXBx1tJZmpQq53fh+9RMY7X+kRG7l//am4T
         MaBrZoAMTvmJ6KteulQaaxsNlhtxPZElNp3SPp0F/e09YGNO5migAGM4jtDRzmngxD9S
         5CKg==
X-Forwarded-Encrypted: i=1; AFNElJ9y73AHTIEmeSFGilG89B3XmvCzL4FhDEBNlV6sZTZR8Mc7PMUPx4WjbCU3h87eF5R0jHIptsJiKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXTF8VqFoicw9qQve3e1YaCF+hL2uKXZVzEk1CHQlykfGK1dyn
	L8kQqjc0unuVImK7jvpU5EkkPq0EuAiNFqlkuJsNAkVBUzjvgBMsnLbCDMIGPo2AKsOcYzFUckA
	byo+iAi+7duI2MNyo7U/S4Xtj+A4JLrg9qHzX+GDXlxkUlLgaJk3YBpyVVt1f4NOUs/a+Qg==
X-Gm-Gg: Acq92OFJ8wwrVwnJ8Jkdsmc/EWi11xME7V39qzN1Q9LUYzaBY7Ye4PivmN8DT/rFKPi
	3JjB4+p8eDjB5sT8vYOenKLUDQFE7t8IJDmLQTsEQXEuWAvIvZrOWzk0SROyv34pJ3gmBuiQTJN
	UGfx9KxpxmyBUcS6sabQkEh37Im5jvOCAleMjjZi7FdEsK9Sxvqc5SoJp0bG7sUgdACIvk153sK
	Vod9zhlP8SzM3PsgWnuXt1fcqKldJxBirvUaWiliqo2wzbVy7JpljC/X0LkxTPXNc68Qa5eWkfp
	Y2PUjSm8C9Y6azbOP7pGvOws3CnktckOHwgESg5b3jCptoNlwU7hPcga7/aTri/2fp3kswjZdJK
	g6JiRd+DeBhh0fNYlZ79KcAcTiWm5GTAvsbLEGR8JghDax8+tx0VEsBHn2nXIQJPwRboPQhFH/h
	2tLOtLfs2woz3ZpgCa/Ns=
X-Received: by 2002:a05:6102:41ab:b0:631:4e25:5e40 with SMTP id ada2fe7eead31-6fefc8b764amr10390561137.25.1781006940553;
        Tue, 09 Jun 2026 05:09:00 -0700 (PDT)
X-Received: by 2002:a05:6102:41ab:b0:631:4e25:5e40 with SMTP id ada2fe7eead31-6fefc8b764amr10390530137.25.1781006940179;
        Tue, 09 Jun 2026 05:09:00 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:78ff:9b6f:a837:626f? ([2a05:6e02:1041:c10:78ff:9b6f:a837:626f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc412sm64030956f8f.4.2026.06.09.05.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 05:08:58 -0700 (PDT)
Message-ID: <33fe758a-a733-4f27-8824-3dff398e1cd3@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 14:08:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] soc: qcom: Add support for QMI TMD cooling devices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Casey Connolly <casey.connolly@linaro.org>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-2-291a2ff4c634@oss.qualcomm.com>
 <pyt62qpa75nzdatp5xl7vcqrdzmrzsf5ethw6wq62bzg6b7qtv@ts2v53im4bos>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <pyt62qpa75nzdatp5xl7vcqrdzmrzsf5ethw6wq62bzg6b7qtv@ts2v53im4bos>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nK5yYURZCQfmbvnS0qGAiR2EfjGxY0Yp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDExNSBTYWx0ZWRfX/48ljjKn7nem
 3FlSTe/rUzNM0f0xsfh2dKJpXHW1zBtld5TyTOef017jZ4mPjYoCAqrCbshlAFS+1kL/dMgYndm
 mse+BuvBG04TtKfQfWydoNQXOooHY+eou0GX1XcA0EFif6Q8jOeYhFn3N+JxNDLG4XSNROLPG7P
 pCSRM7q7rHqnbPlq6/XnSaBLk3Exki/hs8ikz2TReuksDVwPyVvLWdYdOUfFsP7T2iIDq3sh2Pw
 znx6Jg72/Ut8x8faG6zr3Ehj21C71eRLV6AWjI8XhadgcMlro5Cb0a/LCF+VfGG8r9+07m97AgM
 aYhbAcD0jdD0efL+w+o927ABnWCMlGwAg0R6IVpT/Shz9hddfQPheLF9IPWnJi33bshSUBCZo10
 cAOMX+aC8uvtNp3LBCVu++PfpA3OjVqcAFqubPr1Bki5czvEcG7Zuz0SxfZeGs/T96emCNx9jGZ
 o5RpQJck/L2YAFR8+KA==
X-Authority-Analysis: v=2.4 cv=NKPlPU6g c=1 sm=1 tr=0 ts=6a28025d cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=JfLJAETMnmGwVqR1u6MA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nK5yYURZCQfmbvnS0qGAiR2EfjGxY0Yp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090115

On 6/9/26 13:30, Dmitry Baryshkov wrote:
> On Tue, Jun 09, 2026 at 03:52:57PM +0530, Gaurav Kohli wrote:
>> From: Casey Connolly <casey.connolly@linaro.org>
>>
>> Add a Qualcomm QMI Thermal Mitigation Device (TMD) to support thermal
>> cooling devices backed by remote subsystems.
>>
>> On several Qualcomm platforms, remote processors (for example modem and
>> CDSP) expose thermal mitigation controls through the TMD QMI service.
>> Client drivers need a way to discover that service, map DT thermal
>> mitigation endpoints to cooling devices, and forward cooling state
>> updates to the remote subsystem.
>>
>> Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> 
> Wrong SoB chain.

I think Gaurav wanted to reflect the changes did a back and forth 
between us, so I ended up in the delivery path somehow. I guess adding 
Co-developped-by should fix the SoB but won't reflect Gaurav and Casey 
did actually most of the work. So I'm fine if we remove my SoB to fix 
the chain
