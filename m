Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010377;
	b=eJCLuBUzIo9YJdnaM5TqgWxYcBMOa5rnnC3wA29FOMoD9onopNfRmSq6bNs8Y/be/rpZ
	 /C/0O/3C1Ad39kJGs67yGFEH1L8gYzsi3jXOe6Swt+iaarVor3QmxF/ex0gLYTE8a4A/h
	 D5B4BVUtUYlfdzN9PnYVKsJ3DqjQtFW0k8hwHvT6pNY0T4YaNZaJ/SWsPijdCI4p7LQSL
	 8kh+dX1NDPEXd8rCFRdY1L5/7DoHgpSFdJDjKTWjdJ33ObuyM8dnJGb6eshnIaYxbvmWM
	 OMjYbKmYZ3wL+9FPZphSaKXiNvngMdjKVm/gx4e4/4av703rFykv5sEWlp069FpL7Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010377;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CzEqBIxfIy3PFZ999gUK4nxX81cdRHhVWQgflrCkHM8=;
	b=C6hduG3tsjsnrUbF4Ed2gScxlb5YXH3S8pJoBcDiXqW2fPzb/cBQwqwZknKStSFtChJ2
	 teqjJJiqy7Wacntr6hDHA7mzwfA5zjVE3m5++PpVGdgHhw/3RJl4puvRybHlX8cfaorLW
	 qsabZz8cpbcg79o6J84LY5EoIlmD1Fq1MYQdAV4fJrZLTqpHKKErgCVO+W31+49z+/dd9
	 e0XjwG05L9pkraWKtk3KVu32Dyr4pY7FIQg8zS3VSjyt3z95TPUtky/Ky1o22k+8VULAR
	 eT6pMp5PQN0KS19nFPyRcYIUwN3e2XAcasYysRYu1EBFG09NIhjD37Eetgi1H6lHOVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ni2s468t;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A7TTwT0k;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E704E606A325
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 13:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E704E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ni2s468t;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A7TTwT0k
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQ1TK3846150
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 13:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CzEqBIxfIy3PFZ999gUK4nxX81cdRHhVWQgflrCkHM8=; b=Ni2s468tHFInyAgk
	FZcgpaZD5vBAhq8wPpcOdTvDk0ABlar3uJHDnSRA7400KpIH9d8xcsNjrM0Srw2c
	8EoNC124rkbMfDDdmMqTwm6ZVNRgH7/XdlV5fKOzp3dvMkdQD29d7otmsraQiFlP
	zBfdazo/k1KGjPRbx7E+URj5ojkF4dSP86RUdId/kNAyrTAnUc5Idb8kZsgfP6du
	2OKAd3IY5A6KtGLf2hxeL5wx9PUw84Kk5Prsgb1XTG2gWV8KJ2PCDDz2SZpZ1VRR
	62XvL8xMyYalE34ZGdPOg5QMjY3n8tfTr3Ix6m+tV4QsJBt4ODB2lENQFHULJb+L
	J3Vpxg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvaua0v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 13:59:35 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a05b68f851so1679368b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795010374; x=1795615174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CzEqBIxfIy3PFZ999gUK4nxX81cdRHhVWQgflrCkHM8=;
        b=A7TTwT0kDZQ1Zxaq7Gx5agjyWf1yCowMmWoBdbUpW5jkfJL2p2Vphol/HSePY7yk+s
         +I39ssLR+WhIRmjKQFUUzAwNT+LxUG9hBbyTX0ZGjNHuLUajJrsGZkh2QulOwtuC4acq
         o81AqTN4HaF0FeRM4H2XNjwmJ+rlA4pa19JuLnxnKQPTU+G+JZcO8asm3mmDt9b9glB7
         khE+M/PVYRLzzj2Dzt/K3i4sDACHvhsC5pFa1HYhxWVtnMSA19h8PWRnLPq35t+jYwCB
         Nku32b3D7SAn1PAbqxwdEw3WqaojECw6bkHF2Dyn+H7xXP+oJKzpXWOkRqjvjhIGhIh/
         Qahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010374; x=1795615174;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CzEqBIxfIy3PFZ999gUK4nxX81cdRHhVWQgflrCkHM8=;
        b=BbEFzC5T+Sod3rhhLhzY9g953pHG31w5yrMJ6fm0/YEmTvGKm+MmLC3tg3luiSYYBb
         +OvTxkYA9GS+HslZHQty80bxX01O/L0ZkbFIYAjkGMsXNCyOwEibX3zgt1NDJPBvO8+l
         ikCNhWBuA0UNe3SVwEIhBPJQ22wK7BO5NahDgryqg0uADd7xHH6aHtXJuiNS8GocVRn6
         1RBSFWc2FFJLMlEYD1Ax+HUWRDcBYmC/pWw/zzGW0+9wi8WMQcmremQM9iMXlv+mBqTH
         DMbz2DMIhWdoaxEixxCjT1++R9p/VRcy42/r+sRsauknZQtRVvsYK7JlZFOOqlAazNUn
         ypfg==
X-Forwarded-Encrypted: i=1; AL+hErHFZuDdRfHKQacYRdQS2gtmvSFOeGk2fxxtG3uvExrWyrfWr6ksaR91zah2qXFW55UuLlEoMPp6XQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8YSsSBuciFJR6rXlpJqigWljq3kn7K1kezHn9yoiskGrxm+zvS
	Pky5rRZKe66DS/0MaF1RsVgj+KoZe90DkD/PS1nu1r8DkQZkoPdJ/FQkhs0Rm3JSuuAQXk7esJU
	O7tSLfzPVtKg9XBDdNZU971Et+OtucxO8N0WQnKcYHiv2PqNywvr2XObWA75YkA==
X-Gm-Gg: AYBFou0xUL2+JCgzWiFQNhOIgcQP7fl8XlZhkCqtzAsHo7ArrH7GkjWlqrRjfe8/HQn
	5M/wp8RRuRzpDL4Mhg9pIvmkaeJjj/ftWAg+pT5+VAK67C462Tn1XqzHo9Tg28rXjXSywOVFk7j
	Br0ODKyG/8iggg+pCEszC+G0nT1CQttdgnKkRIusnXzgqK/vMsiI4QfoIvFFGH6+k4SWxGktRbV
	DwHT7/9rta3EmJV902sEglVwgpXdjbYzses4vz9kZgkLBvYGyh4vmk3TqImWy2o3q3w1X9aXCL0
	8NsyIpS7HLBHglS661BuDz2mv8pTW/r0+O4wWrDj6kS/8BPO4kbRr2FDsEjbSy/WLe6x4UAKjDi
	/PheVDvhLw2lq5T/0lbDin9HRBOSu19OSQUPYueJzsRs91uH0X0S57QXjq0Y+BUDKUb7mNiEOsS
	5Iak8x0IF+masoRdde7ynDdzUoE7SmXf2eAJ/jSC6LiQ==
X-Received: by 2002:a05:6a00:2e9f:b0:89e:db6c:f199 with SMTP id d2e1a72fcca58-8c5d305331fmr1837800b3a.14.1795010374098;
        Wed, 18 Nov 2026 05:59:34 -0800 (PST)
X-Received: by 2002:a05:6a00:2e9f:b0:89e:db6c:f199 with SMTP id d2e1a72fcca58-8c5d305331fmr1837774b3a.14.1795010373422;
        Wed, 18 Nov 2026 05:59:33 -0800 (PST)
Received: from [10.133.33.68] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5ca7aaa8dsm1277469b3a.10.2026.11.18.05.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 05:59:33 -0800 (PST)
Message-ID: <b4a1994e-abc8-4810-be27-ce322480bc57@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 21:59:27 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Exclude boost frequencies from inefficiency
 ranking
To: Guo Chen <guo.chen@oss.qualcomm.com>, Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        xin.liu@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
        tengfei.fan@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261103-em-rank-boost-separately-v2-1-5a13d1b38d37@oss.qualcomm.com>
 <CAJZ5v0hy1D7anTe=CXNXZyMNSN_yHh5hOt6B0bEHTEONRJFMhQ@mail.gmail.com>
 <3e7c3a82-6a99-4c2f-9568-2382ea77ba0e@oss.qualcomm.com>
 <1dadcd02-19b0-482b-b16d-293430227c5c@arm.com>
 <901516c9-d1be-4918-840e-e3617f2a1782@oss.qualcomm.com>
 <6b0ee061-38b9-413e-9a83-90446b484859@arm.com>
 <CAJZ5v0i8a98rjFdQ2Jhu_Xk=qCGiNafMfhzNs26cEJNCYB6Xdg@mail.gmail.com>
 <4f0c8581-a8fb-4bc4-82cc-d30f2f56d2ce@arm.com>
 <CAJZ5v0iX8wYDUo9uUjkqkKq1tpLAu7iaZk+iQzWGigNAqfrsNg@mail.gmail.com>
 <bb99aa3f-fd15-4bdd-9319-ccedffc281c8@arm.com>
 <ec04f795-6cc6-444a-bbee-70c7982932e3@oss.qualcomm.com>
 <CAJZ5v0js0pbcKRp-cNVu_aPstT4meF-u_z012Q-AA=pvvOY=qA@mail.gmail.com>
 <58dbf12d-dae7-44c3-b7da-b65a4800c3b0@oss.qualcomm.com>
 <cdfaaf7d-8b7a-46d4-bf40-e0dc5300eb08@arm.com>
 <f238e73f-6439-4849-b044-eed4242a1dfd@oss.qualcomm.com>
 <c9ffcfd1-3ae9-448f-a4b8-df316896d41b@oss.qualcomm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <c9ffcfd1-3ae9-448f-a4b8-df316896d41b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SMzXx+vH c=1 sm=1 tr=0 ts=6afdaf47 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=tCKHeOpHoKB_qHqX7qoA:9
 a=wgMl34NRhLa018_G:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: F0BF2v4JNimJNENDUVaUiJRLwNnOtXr_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NSBTYWx0ZWRfX9mNXPsI6rYNA
 XBFlXJeDzhzBGMkUF178UWRyCL10lbu2CAlXuJlwzMG+S+B0h+YlDx1vsanJu1cOcuyxx3Ljz0I
 RdeJRTUdB2bARvLP7p6/lpSCDtBE/s5jmJ/MS/wATa4ipreGET2piaCD0B1t3S145QH9T28Yn41
 1OUjwl3yshDxK3hajyF+mioO5fUlW8VOieBQatYbJPmyl141aPM5dvxZ3h276QN7p0HmN5fKeCH
 b589lWybLqhMftRxjrvIJlDlN9yf/AP9+vQ+CfVKCkUQkyjcR//TC5TMqVnvjsP4+1sMAjGmU20
 y69+68fTdmnAsUKpxIGDYVwnU1ov4VmJ+j8gYh3OSXD2z7OSADKH5U4/j3dwdgbl61eyCjTVqX0
 +N77QFjXOOZS0Ri/XleR3UOs1cFXP3/5M8ETiyEoPhagw5hX2+IA3jxLoGalR0klQ//NaOvHhPO
 ZbNFqj5oWi3yUDWzOpQ==
X-Proofpoint-ORIG-GUID: F0BF2v4JNimJNENDUVaUiJRLwNnOtXr_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NSBTYWx0ZWRfX7EmBblxs6XW1
 QEO151UMVMG/GfHjy95cIPA0ccwSHecFNRtcImhpbYv9SIeAR6c/Xo+0r6h/EHkisiUa28m3ln/
 jAcETjjVy3xNiQuJKpm1jD7ZsQsk+6g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180055

On 11/11/2026 7:57 PM, Guo Chen wrote:
> 
> On 11/11/2026 7:24 PM, Zhongqiu Han wrote:
>> On 11/11/2026 5:31 PM, Lukasz Luba wrote:
>>>
>>>
>>> On 11/11/26 06:57, Guo Chen wrote:
>>>>
>>>> On 11/10/2026 10:59 PM, Rafael J. Wysocki (Intel) wrote:
>>>>> On Tue, Nov 10, 2026 at 3:56 PM Zhongqiu Han
>>>>> <zhongqiu.han@oss.qualcomm.com> wrote:
>>>>>> On 11/10/2026 10:05 PM, Lukasz Luba wrote:
>>>>>>>
>>>>>>> On 11/10/26 13:43, Rafael J. Wysocki (Intel) wrote:
>>>>>>>> On Tue, Nov 10, 2026 at 2:11 PM Lukasz Luba 
>>>>>>>> <lukasz.luba@arm.com> wrote:
>>>>>>>>> Hi Rafael,
>>>>>>>>>
>>>>>>>>> On 11/10/26 12:15, Rafael J. Wysocki (Intel) wrote:
>>>>>>>>>> On Tue, Nov 10, 2026 at 10:58 AM Lukasz Luba 
>>>>>>>>>> <lukasz.luba@arm.com>
>>>>>>>>>> wrote:
>>>>>>>>> [snip]
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>> That's fine, please continue.
>>>>>>>>>> I have a couple of questions though.
>>>>>>>>>>
>>>>>>>>>> First, why is the ondemand governor mentioned in the 
>>>>>>>>>> changelog?  In
>>>>>>>>>> the mainline, the ondemand governor cannot work with EAS, so it
>>>>>>>>>> shouldn't matter for this issue, should it?
>>>>>>>>> The ondemand is affected by the EM setup code and set 
>>>>>>>>> 'inefficient'
>>>>>>>>> flags for some OPPs. The EM is also present for cooling devices
>>>>>>>>> and can work w/o EAS and schedutil, w/ just ondemand governor.
>>>>>>>>>
>>>>>>>>> Because EM marks the OPPs kind of 'globally' as inefficient, then
>>>>>>>>> they become CPUFREQ_INEFFICIENT_FREQ entries in the CPUfreq fwk.
>>>>>>>>> In the EM code we have:
>>>>>>>>> cpufreq_table_set_inefficient(policy, table[i].frequency);
>>>>>>>> So maybe this is the one that needs to be fixed?  What about simply
>>>>>>>> skipping boost frequencies in it?
>>>>>>>>
>>>>>>>>> Then ondemand check for CPUFREQ_RELATION_HE will skip them and
>>>>>>>>> pass to __cpufreq_driver_target() with that flags as well.
>>>>>>>> Thanks for explaining and all of that needs to be said in the patch
>>>>>>>> changelog.
>>>>>>>>
>>>>>>>>>> Second, why is the issue regarded as a defect in the code and 
>>>>>>>>>> not in
>>>>>>>>>> the energy model?  Arguably, boost frequencies should be more 
>>>>>>>>>> costly
>>>>>>>>>> than the non-boost ones.  At least the idea behind the boost 
>>>>>>>>>> is making
>>>>>>>>>> higher-cost OPPs temporarily available.  If they are sustainable,
>>>>>>>>>> treating them as boost OPPs is rather pointless.
>>>>>>>>> IMHO it was a bug in the commit mentioned in this patch fix tag.
>>>>>>>>> It is affecting more than just EAS or EM, since the EM is 
>>>>>>>>> working with
>>>>>>>>> all generic code and all cpufreq governors.
>>>>>>>> To be precise, the EM initialization may affect cpufreq in general
>>>>>>>> because inefficient frequencies are used for CPU cooling.  Fair
>>>>>>>> enough, but I'm not talking about this.
>>>>>>>>
>>>>>>>> I'm talking about a reason for giving boost frequencies lower or 
>>>>>>>> equal
>>>>>>>> cost relative to non-boost frequencies in the energy model because
>>>>>>>> this doesn't make sense to me TBH.
>>>>>>>>
>>>>>>>> And I get that such energy models were there before the commit in
>>>>>>>> question and now they are not working properly, but IMO they are
>>>>>>>> broken, not that commit.
>>>>>>>>
>>>>>>>>>> TBH, I'm too comfortable with looking at cpufreq frequency 
>>>>>>>>>> from within
>>>>>>>>>> the EM code.  If that needs to be done, something is amiss at the
>>>>>>>>>> design level.
>>>>>>>>> I think this edge case is special, as I described above.
>>>>>>>>>
>>>>>>>>> I'm happy to hear your view on this EM influence to some global
>>>>>>>>> setting in cpufreq. Maybe it was too far to establish this
>>>>>>>>> 'inefficiency' flags in there for many usage?
>>>>>>>> There's nothing wrong with using the information from the energy
>>>>>>>> model, when available, to amend cpufreq, but the patch goes the 
>>>>>>>> other
>>>>>>>> way around: It tries to amend the energy model with information 
>>>>>>>> taken
>>>>>>>> from cpufreq (in order to avoid making mistakes later when amending
>>>>>>>> cpufreq with the energy model information).
>>>>>>>>
>>>>>>>> I think that cpufreq should simply refuse to set
>>>>>>>> CPUFREQ_INEFFICIENT_FREQ for boost frequencies. Wouldn't that work?
>>>>
>>>>
>>>> Got your point. Having cpufreq directly refuse to set
>>>> CPUFREQ_INEFFICIENT_FREQ might be the simplest approach. Let me
>>>> summarize my understanding. There are two cases where we can
>>>> simply avoid setting the CPUFREQ_INEFFICIENT_FREQ flag:
>>>> 1. boost frequencies.
>>>> 2. the highest non-boost frequency.
>>>>
>>>> However, there is another issue. If we refuse to set
>>>> CPUFREQ_INEFFICIENT_FREQ for certain frequencies, I think the
>>>> corresponding EM_PERF_STATE_INEFFICIENT flags in the Energy Model
>>>> also need to be updated. Otherwise, the EM state would be inconsistent
>>>> with the frequencies used for energy estimation in the EAS path.
>>>>
>>>> I think we also need to update the EM_PERF_STATE_INEFFICIENT flags
>>>> accordingly, something like the following:
>>>>
>>>> for (i = 0; i < pd->nr_perf_states; i++) {
>>>>      int ret;
>>>>
>>>>      if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
>>>>          continue;
>>>>
>>>>      /*Return -EOPNOTSUPP if the rejection condition is met. */
>>>>      ret = cpufreq_table_set_inefficient(policy, table[i].frequency);
>>>>      if (!ret)
>>>>          found++;
>>>>      else if (ret == -EOPNOTSUPP)
>>>>          table[i].flags &= ~EM_PERF_STATE_INEFFICIENT;
>>>> }
>>>>
>>>>>>> I see your point now, about the direction. Yes, you're right.
>>>>>>>
>>>>>>> Since we are taking the information about 'boost' from the
>>>>>>> cpufreq, then refusing to set OPPs inefficient in the first
>>>>>>> place makes more sense.
>>>>>>>
>>>>>>>
>>>>>> I also agree this should be fixed in cpufreq rather than by feeding
>>>>>> cpufreq information into the EM. However, refusing
>>>>>> CPUFREQ_INEFFICIENT_FREQ for boost frequencies seems not help the
>>>>>> example in the changelog, because the frequency marked as inefficient
>>>>>> there is 4.0 GHz, which is not a boost one. The problem is not 
>>>>>> specific
>>>>>> to boost either: with 3.9 GHz, 4.0 GHz, 4.1 GHz and a 4.2 GHz 
>>>>>> boost OPP
>>>>>> at costs C - d, C, C and C + d, 4.0 GHz is rightly inefficient, 
>>>>>> but if
>>>>>> policy->max is capped at 4.0 GHz by scaling_max_freq, thermal or QoS,
>>>>>> RELATION_HE for 4.0 GHz still resolves to 3.9 GHz. I think the lookup
>>>>>> should not skip an inefficient frequency when the next efficient
>>>>>> frequency above it is beyond the max limit, which can be done in
>>>>>> cpufreq_frequency_table_target() without touching the EM or 
>>>>>> looking at
>>>>>> boost flags.
>>>>
>>>>
>>>> @Zhongqiu: thanks for the example. I think the two cases are 
>>>> different in
>>>> nature.
>>>>
>>>> In the case of the changelog, the highest non-boost frequency of 
>>>> cluster is
>>>> marked inefficient because of the boost frequency. A sustainable 
>>>> frequency is
>>>> being affected by an unsustainable one, but it is not really 
>>>> inefficient: I
>>>> don't think these two kinds of frequencies should be compared with 
>>>> each other
>>>> in terms of energy. So I think this should be fixed at the source, 
>>>> by not
>>>> marking such frequencies as inefficient.
>>>>
>>>> The case you describe looks different, as it is dynamic: policy->max is
>>>> changed at runtime by scaling_max_freq, thermal or QoS, which would 
>>>> mean
>>>> ignoring the inefficient flag every time policy->max lands on an 
>>>> inefficient
>>>> frequency. Whether this is really necessary seems to me to deserve a
>>>> discussion. Thermal and QoS limits are there to keep the frequency 
>>>> from going
>>>> above the cap. In your example (3.9 GHz, 4.0 GHz, 4.1 GHz), if the 
>>>> frequency is
>>>> limited to 4.0 GHz at some point and ends up on 3.9 GHz because 4.0 
>>>> GHz is
>>>> inefficient, the original purpose of the limit, not going above the 
>>>> cap, is
>>>> still honoured.
>>
>> Hi Guo,
>>
>> Boost can be switched on and off at runtime as well, so it is no less 
>> dynamic than thermal or QoS. And with boost off, 3.9 GHz does not go 
>> above the cap either, so if that were enough, the changelog case would 
>> not need fixing; in both cases the highest allowed frequency is never 
>> reached.
>>
> 
> Thanks, Zhongqiu, and Lukasz for the DT example.
> 
> You are right that boost can be switched at runtime like thermal or QoS,
> so the key point I see is not about being dynamic. It is that a boost
> frequency is not sustainable, and I don't think it makes sense to rank it
> against the sustainable ones in terms of energy.
> 
> I agree with Lukasz's suggestion to address this in two steps.
> For the first step, I think fixing the EM is necessary because the EM is
> intended to balance performance and energy cost. The flag needs to
> be corrected at the source because it is also used by the EAS path. If
> we leave the flag unchanged and only adjust the cpufreq path to
> select an appropriate frequency, even if that frequency is marked as
> inefficient, we would end up with inconsistent behavior between EAS
> and cpufreq.
> 
> For example, suppose 4.0 GHz is the highest non-boost frequency,
> but it is marked as inefficient due to the presence of a 4.1 GHz boost
> frequency. With only the cpufreq-side change you suggested, EAS
> would still never use 4.0 GHz for energy evaluation because it
> remains marked as inefficient in the EM.

Hi Guo,

Sorry for the delay.

You're right that EAS still won't use the 4.0 GHz state with the cpufreq
lookup change, but that is the same as today: with boost off, EAS
already evaluates 4.1 GHz while schedutil runs at 4.0 GHz, and the
energy is the same since both cost C.

v2 doesn't seem to avoid this either when 4.0 GHz is dominated by a
non-boost 4.1 GHz and thermal or QoS caps policy->max at 4.0 GHz.

v2 also changes frequency selection with boost enabled, which seems goes
beyond this bug, so I think it is for Lukasz and Rafael to decide which
way to go.


> 
> So my understanding is that the first step Lukasz suggested is not
> only about fixing the current impact of the EM on cpufreq, but also
> about making the EM itself correct for the EAS path.
> 
> As for the separate issue where policy->max is set to an inefficient
> frequency by thermal/QoS constraints and that frequency then
> cannot be selected, I think that should be treated as a different
> problem.
> 
> What do you think?
> 
>>>
>>> There are platforms which have ~20 OPPs and the difference is ~100MHz.
>>> Those at the top frequency they are inefficient but exist for this
>>> thermal purpose. The throttled frequency can be more stable and
>>> predictable in time, thus also capacity delivered to randomly
>>> scheduled tasks (which might be unfair if the freq gets lower
>>> by a lot and some latency sensitive task got a spin at the same time).
>>> Therefore, we do care by making each OPP (at least) available...
>>
>> Agreed with Lukasz in this point.
>>
>>>
>>>>
>>>> So I am not sure that handling the dynamic case is needed, and I 
>>>> would like to
>>>> hear what you, Rafael and Lukasz think about it.
>>>>
>>>
>>> This becomes even more convoluted now.
>>> 1. The only call to cpufreq_table_set_inefficient() is in the EM.
>>> 2. EM works with thermal and all governors, not only EAS and schedutil
>>> 3. CPUfreq fwk holds those 'inefficient' flags in generic, global way
>>> 4. Inefficient flags were introduces mainly for EAS, now impacts
>>>     non-EAS setup (as patch states 4.0GHz is valid but not reachable).
>>>
>>> Here is an example from mainline DT platform. The goal was to avoid
>>> the frequencies which have the same voltage but lower freq, e.g.
>>> those from 200MHz to 700MHz and pick 800MHz instead.
>>> Same for 900MHz and 1200MHz.
>>> That was the main motivation back then and research we've made
>>> with a few platforms and EAS.
>>>
>>>    freq MHz   opp-microvolt
>>>    2000       <1312500 1312500 1500000>
>>>    1900       <1262500 1262500 1500000>
>>>    1800       <1237500 1237500 1500000>
>>>    1700       <1250000 1250000 1500000>
>>>    1600       <1250000 1250000 1500000>
>>>    1500       <1100000 1100000 1500000>
>>>    1400       <1100000 1100000 1500000>
>>>    1300       <1100000 1100000 1500000>
>>>    1200       <1000000 1000000 1500000>
>>>    1100       <1000000 1000000 1500000>
>>>    1000       <1000000 1000000 1500000>
>>>    900        <1000000 1000000 1500000>
>>>    800        <900000 900000 1500000>
>>>    700        <900000 900000 1500000>
>>>    600        <900000 900000 1500000>
>>>    500        <900000 900000 1500000>
>>>    400        <900000 900000 1500000>
>>>    300        <900000 900000 1500000>
>>>    200        <900000 900000 1500000>
>>>
>>>
>>>
>>> Therefore, I would suggest to tackle this is steps.
>>>
>>> 1st, let's go ahead with this fix which is for mainly EM.
>>> The EM confuses the cpufreq and then the clients like ondemand, IMHO.
>>> This can go maybe into the stable kernels, since it's small.
>>>
>>> 2nd, let's think about that 'boost' thing wider. There are
>>> already investigations how to handle correctly the CPU's capacity
>>> and to not confuse the task scheduler. This might create
>>> the right infrastructure.
>>>
>>
>> Hi Lukasz,
>>
>> Thanks for the explanation and the DT example. Real platform data like
>> this is very helpful for this discussion.
>>
>> May I know wouldn't it be better to handle this in cpufreq alone,
>> without changing the EM? The EM change may not help with thermal capping
>> in general: your DT example has no boost OPPs, and if policy->max is
>> capped at 1700 MHz, RELATION_HE for max seems to resolve to 1500 MHz, as
>> 1600 and 1700 MHz are dominated by 1800 MHz.
>>
>> When the target is at or above max, the highest frequency within the
>> limits is wanted. If it is marked inefficient, the frequency that
>> dominates it is above max and cannot be selected, so maybe it should
>> not be skipped. That would cover boost off, scaling_max_freq, thermal
>> and QoS, while targets below max are not affected.
>>
>> Something like the below (compile-tested only). (Please  let me know
>> what you and Rafael and Guo think, or if I have overlooked anything if
>> you would like)
>>
>> diff
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -1077,6 +1077,7 @@ static inline int 
>> cpufreq_frequency_table_target(struct cpufreq_policy *policy,
>>  {
>>      bool efficiencies = policy->efficiencies_available &&
>>                  (relation & CPUFREQ_RELATION_E);
>> +    bool capped = false;
>>      int idx;
>>
>>      /* cpufreq_table_index_unsorted() has no use for this flag anyway */
>> @@ -1085,6 +1086,16 @@ static inline int 
>> cpufreq_frequency_table_target(struct cpufreq_policy *policy,
>>      if (unlikely(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED))
>>          return cpufreq_table_index_unsorted(policy, target_freq, min,
>>                              max, relation);
>> +
>> +    /*
>> +     * A target at or above @max asks for the highest frequency 
>> within the
>> +     * limits. Whatever makes that frequency inefficient lies above 
>> @max and
>> +     * cannot be selected, so inefficient frequencies must not be 
>> skipped.
>> +     */
>> +    if (efficiencies && target_freq >= max) {
>> +        efficiencies = false;
>> +        capped = true;
>> +    }
>>  retry:
>>      switch (relation) {
>>      case CPUFREQ_RELATION_L:
>> @@ -1102,9 +1113,18 @@ static inline int 
>> cpufreq_frequency_table_target(struct cpufreq_policy *policy,
>>      }
>>
>>      /* Limit frequency index to honor min and max */
>> -    if (!cpufreq_is_in_limits(policy, min, max, idx) && efficiencies) {
>> -        efficiencies = false;
>> -        goto retry;
>> +    if (!cpufreq_is_in_limits(policy, min, max, idx)) {
>> +        /* Fall back to the regular lookup over efficient frequencies */
>> +        if (capped) {
>> +            capped = false;
>> +            efficiencies = true;
>> +            goto retry;
>> +        }
>> +
>> +        if (efficiencies) {
>> +            efficiencies = false;
>> +            goto retry;
>> +        }
>>      }
>>
>>      return idx;
>>
>>
>>
>>>
>>> Side note:
>>> I personally don't like calling some frequencies 'boost', because
>>> such frequencies were there but not labeled that way and they were
>>> OK. In this example, 4.0GHz is non-boost freq, but 4.1GHz is 'boost'.
>>> At the same time 4.0GHz is 'inefficient', which can only happen
>>> when 4.1GHz has the same voltage. I have seen such platforms ~13years
>>> ago and the 'boost' flag wasn't needed to handle them properly.
>>>
>>>
>>>
>>
>>


-- 
Thx and BRs,
Zhongqiu Han
