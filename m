Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D6E3EAC76
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352082; cv=none; b=dqlXoQsKcsuBA5z0Fn96dDtqmboUTSZKfNP3Y1kP4th7brLiMvDpg5LrmyWG7wvAd7EQboA1ubxr2zRDht3f1csLOTnnABXJGSybbHTaZvw+qGtLiRDq8HiXsJTHt5NC3rkXiFM/I915dA52NeAFDKf0raNHtjsJtotH1+KWY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352082; c=relaxed/simple;
	bh=uGVKFNxgNtVtvj48f+UoSa6UUkgugrajqAExR1/m5xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQFQaUKj2YmDPRLGorZ/WrVHzVCmEDmpGIyQ1Ih4q3VYFvlbqX1Bfwl5TFzqgApMeVURiys43WuEJ2yneNT1mRZOIF8QrXyMrj1rV+ov2Uxlm86y977dPoGGuGPDvo1escIEM+PDhklbHq6A64F3M0iv95k3N0b47yUf3PjzvUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TfKi5Ev2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XKQEpXBk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TfKi5Ev2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XKQEpXBk"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O9ZkMe3903726
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EkqAg9UTp/HJSq1hFA8KE7U6oPq3yJOi9YW72TWgtH0=; b=TfKi5Ev2T1fiTdhu
	wUtuBTNFTStkP9FmQd2U+VdpOwWChIjh8vZIR4HaG9cQOXJ0m/YA98F9vzE5oe41
	GqdElH8SvXXPnOc+ly5mGEA28/9hKf1DJ20ZnBp4VuLtq3Y5MXRkqtexealAYyY3
	swL4tocu1v0KduYbtqiPyCsLnTJDLk45JR6OxHxzQ1LgzJxUvtxYBXxelhB3hkoJ
	gWDVMiBB2fCe05MDGQnXO0Gflj1d/vHOCOgpK7oXcO2zr1Ao8h5A2Wr901JpiFJF
	+V35EwpvxzTyxrGYCMxPdbQL4alpL78Yu5fwVYKGOwb5+wewhyG0MyjY+kMeY8me
	aOBimg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3jt0hnfq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:34:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b2d15c360so40374041cf.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 04:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774352080; x=1774956880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EkqAg9UTp/HJSq1hFA8KE7U6oPq3yJOi9YW72TWgtH0=;
        b=XKQEpXBk3Ok5lIBazPDiImQiZPMIV5wv2POaD/vn58N3zG7IYkFNt+tScAOeWImNyk
         90dwgcmdXgDhQYSXInHJQtFk/fcCkxIBXe3aWy+gAbj/axt5DTOd5rVKSojWpWE8AWxC
         em6X9Jl9Tp3Bi6MuDSNpB/EUa7QRUe7UiIQTJCqtG0x93/Gx0MeUtHX09Q4UwEsFUInv
         kKNIz33bb2jbI9EGohLUsU39xmK5/WY8cet8ebu7jiO18QHaaD5GBDchnKCw8C+uDfqT
         ynJP4d1HNXr3f+b1HlJWGt7ozE7ZfyooS88wYaEM/yw7Jj1bk40m57/I5dHN44riRJ73
         RfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774352080; x=1774956880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkqAg9UTp/HJSq1hFA8KE7U6oPq3yJOi9YW72TWgtH0=;
        b=rQYmAbBBhKhSU7NgN35HgGXajvhIMB7ybjI/Mc7W092sudXb7Seu6BfuO0YZ2vGmfY
         BxyMcabxnBPDetxqHbE+4zVJefe+64CC/32qAlKXs+sDvEFHPfmju6NY0RhjddX1Ltx2
         4QH+Ji+WtiReuVzHekzvQ+bNCQzjbIV/HJydqnW2v3FqyuFMliHQbcFLuSW0jjsesGmo
         6xehAXC30Df9IpS60rG/SipadbVDzvRfC1MqKer+joUmhyjLxbgQjovG/pYJzXjNqrt9
         /LhOdcNPaLy6TQgAiWdhrwNeuULA7rGDtKVf2CLL/Ng0tCAr+tlidQ0HaKg4ibZuR012
         S5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiXiCTvvaFjQdfMIS53uYJrusaGbi/i12JuE0RmRXOfBhVcweQ39ahqztyJgldH2jUG0Nf6zmcGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy9ABhcGmTkgKtjMDcYnY802Vym9y+oEuvMpCgnB+fqiO5Pf3O
	A9MVWpK85Mg9RzNzFYcVksNFMFAlRSQnlpoU+MuMjZK+f2d0R7tFFt+YQoLT11IKj0BYNt+m6v1
	SgH2jDy61OnvLoVTIZ9YTgkPY7w1P3YIi8REe1IWBNT/pZBA0OwEiOx5ak2HjOg==
X-Gm-Gg: ATEYQzytX8QZ0q5nQ/S2U+kdV7nxOPi5Anz7RI6hbE4cpy/kZDlDGrmowCiFea31/LQ
	ErDm6ETnGoBLOw7rSA3xddnCcxZtAXNqrst/qI5870nIM1f5hIpuL2/eUn3klCDV9izORaXlkF6
	5UBAfaefKc/rEbVZh4gjc3pB1YM3xSFHN8pYZlU1Vf24UpiPVbw2G8UAdP1taFpkT5h9ND+W153
	7rYzrzez4HtSU2uoVOE7xeJ4Vr0rPzlgAY23hEXVDKaG/1r9Mcnz+vwtbtqmzfRxIi2OG5PIT46
	zqEG0Lu3Up3fTxkLNFr0n0We+jy5FNaczN+S3+jFb6/mO6hLAmkeyD4MsHwRrHykOfX4ItwjYG4
	sOozxfhiVtzd60gI2XRFjUd3PQrq4EnqzMom97/+bkrVfdQaA3qmuAtCUn3k3DPR1AIfndeFmbS
	HbxhI=
X-Received: by 2002:ac8:7ed4:0:b0:50b:6890:fca0 with SMTP id d75a77b69052e-50b689100b7mr34046761cf.9.1774352079482;
        Tue, 24 Mar 2026 04:34:39 -0700 (PDT)
X-Received: by 2002:ac8:7ed4:0:b0:50b:6890:fca0 with SMTP id d75a77b69052e-50b689100b7mr34046291cf.9.1774352078974;
        Tue, 24 Mar 2026 04:34:38 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b983365dbe4sm620521666b.47.2026.03.24.04.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 04:34:38 -0700 (PDT)
Message-ID: <1376fad4-efc3-4b7d-bff8-9510ab0d3800@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 12:34:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] interconnect: qcom: icc-rpm: allow overwriting get_bw
 callback
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
 <20260323-msm8974-icc-v1-4-7892b8d5f2ea@oss.qualcomm.com>
 <abb14718-3d94-426a-a0f0-d101470951ad@oss.qualcomm.com>
 <75zgkrwvjsmnvjeyosl326vcudklj6yhhyskdrsm23kbzhgve3@64nezs6c54kz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <75zgkrwvjsmnvjeyosl326vcudklj6yhhyskdrsm23kbzhgve3@64nezs6c54kz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7NQphb3kmg6BkI2fQKoJEtV7SmsiDEga
X-Authority-Analysis: v=2.4 cv=Nc3rFmD4 c=1 sm=1 tr=0 ts=69c276d0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=in80v9g7ds5Yhk2LA68A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 7NQphb3kmg6BkI2fQKoJEtV7SmsiDEga
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA5MiBTYWx0ZWRfXxm8XNJ6cGcsd
 92k4BBX/sG3Z2QrrVpSeTWl1ighK1fKvETzPtevlATuFRMqgc8f/1ImHGBYLyOrAfLvE3OAGcn9
 DVO8lV1KSMYYJVhthdUeFtjMbi4p00HRnaZdi/AycCKTD2URjEKcVoH5f9bpgxU6zu5MwzLKO4m
 95O/Fw+wKVYHxwvT91dZ2+klYH3u2FZsoSvY+vVMLFJ4AolfMMhcaZac+PdzfagfoR1aFkQ0Sdx
 pyFq2vczDaQY4KThfe46nN4b2NM5nFel+0NqPsgBxRcWZlGe0UuI5MTHVXQ16pK5SA2Hbh3Zk14
 Bjuw76AhHX75u8nJ/2RExERmhiYWlhkEiWnmd6eUF2TXUz5C2qAbMCGSYgas9YtfKIu1jmeVmxf
 Pwt7A+ZZS0qiDolOLWasVipYWRrVOli1EJp0w7CZinQdoqmbaickKWUcm2wX8rJYKwzlnBtc+F9
 xtXy6qIieBFZQPJU3mQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240092

On 3/24/26 12:14 AM, Dmitry Baryshkov wrote:
> On Mon, Mar 23, 2026 at 11:32:33AM +0100, Konrad Dybcio wrote:
>> On 3/23/26 2:17 AM, Dmitry Baryshkov wrote:
>>> MSM8974 requires a separate get_bw callback, since on that platform
>>> increasing the clock rate for some of the NoCs during boot may lead to
>>> hangs. For the details see commit 9caf2d956cfa ("interconnect: qcom:
>>> msm8974: Don't boost the NoC rate during boot").
>>
>> Is there a single specific bus where this causes an issue, or is
>> setting *any* resource to INT_MAX problematic?
> 
> I'd refer this to Luca. I didn't experiment that much (and also note,
> this behaviour might be firmware-specific).

In case anyone's interested, it _seems like_ it's

(RPM_KEY_BW + RPM_BUS_MASTER_REQ/RPM_BUS_SLAVE_REQ) failing with certain
nodes

> My goal for this patchset was to port as close as possible. We can drop
> the get_bw later, after enabling more interconnects, writing the QoS,
> etc.

That's fine

Konrad
