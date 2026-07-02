Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE713D6CCE
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993210; cv=none; b=l2oySFOnBKUgonudImTU8QJkKNVxal3W47NUG1DuSnAHDSsFO+bqRmGWtgdWprDuHgDs3oCvp6K65Bn30IPneySTOlQLUXeH/eGl34HRkP8MxuZ5QQPPXYvNVQKqTC+nng0osIXzk/mLSKmBhYFOEP4fSK7n/M5B3zL0fhdlmsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993210; c=relaxed/simple;
	bh=iQs/O0m1YoOXpDL1qFq1QeXVEZYVWU0DuKi+oSvZ27I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OX38j0ANMm3es1s/tvBolXrxsORQJ912Ci/xI1WMkVTyBA2PZWj6tI3kTrwL13imWVtzG23WlBRKMBr8WR9R2ON72gcFe1mq1EB+u3rshsuULce/sJ6GXVwAFRAtXwHse3wUXvaig6VNoNBRZVGJiPaC541MJNVtHE81ZO1nd20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E7iI9mpb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gW4+MpRU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E7iI9mpb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gW4+MpRU"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6627TtwE3964266
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 11:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R4PQUlUFrH6cer1y0BcGOBwg2mPTIaOdshDz1KarkeA=; b=E7iI9mpbwfWUnOD9
	cgdsx38NMJSCv/mYBRtxefeHArYjQlhganxBUKL23X+wJH/+k3XOZyoZO/HklzvA
	vC/6G4IAyj8LTaFDCAv8CWDadyFKNfDGynsDPMe/WkuAs+cUJogqFcD++rlSzb/7
	JYp1DIp4eRD5HvUocRuKhvN2eBZ60ZDibJSrBmaM5CRI9AycRpAxPpSyXTf7+Drm
	UXNwzZ6Hn+69s0NcL4LfTtDEtBAJoZJRF2khGpJBsOHTTl9L0OH9KYKz9hn3rdpw
	eWGi1sewYSOwMkBqTLQA+kkN6owqDn9D1AiLfy2CJInIgLrR+cKFuEntyJiFePWT
	R/OCeQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc10dk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 11:53:27 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37fe90ee192so2528701a91.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782993207; x=1783598007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R4PQUlUFrH6cer1y0BcGOBwg2mPTIaOdshDz1KarkeA=;
        b=gW4+MpRUNMzeRWTqJcpTPkVdkApIR2jUO913eDGndkCMfU0kajthcxkXocb5dwCGQY
         OsDoP9I9xN3I41zaceo4F9KcNkqIQt+W93wbDaeCWz9L/923NntVwW+Yxr1OjvoEto7f
         VHpua+MH3+Rj8L0+QJRC3jB/VEOwLj8uNXL7mMHO9mr9xeDsuzm2YGe3xQS+AJ6xW2pD
         IvDJ6UwKSghpqZbVSEz4WN14icYHjDC+AcybxbfufhCB3ey+pLbfzM4LzALJHSGjr6ww
         D8En16bQaF8cNRb0VEWGHbkhuHo0T8rsGydhM5IdM3c+PaDQx7GfcfYjD+7pi9rT8WpU
         3ybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782993207; x=1783598007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4PQUlUFrH6cer1y0BcGOBwg2mPTIaOdshDz1KarkeA=;
        b=qCsiUPr97zH8zRMO84pjW6rF4VEUC+2GAVB+vjh6tFwYgnWF9anM0xhuy2n3WqHKwH
         N2+iVZDK8Wh1mfy73JBp6JWVI+k0mEvjHdYI5+/PeQ63rnPMc+Vr0ix6Pp5bGvXGQ4eJ
         KUVCiojWcg5Sxb4UGu+xW7W7+GEp8XsKNn0fQV6PIDQMszHH8xKlclDs1ltn421NersA
         U6O13Br/ck6B6O+9P37s1X3ilzjcqVAsaxiK6W2KvudbbjFvy7uRZAfHTIVbmzBgcXYX
         UTrfb6N7Lz6alfRpxuO39ByEQFyFPJ3JBkzBe7Uj/HXlafeIwjcP+7v3gy6RU6BQukZ5
         8ZHA==
X-Forwarded-Encrypted: i=1; AHgh+Rpj2OoVXsFvzchxu6R2o/omHv8f7rlegbfbfTfSwQTRJvXCU0H6B/+cecg/BZIbA8ibkpX0A/6PCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjNZMoYfEqg1On979M5vfzJZ5G+daZJKQ9Nd28DQNbIAhIgJnd
	fkeay8xzortIbQT7Lp2RUbh2KjJ/Mq3T1m4rAWJ639Uq+3ywelpAFWxElHh/+OZZfNNlBe0XAOU
	GaykI+Ha1ZkK8q5GdQtsEwfiEPc5eiY1qdR50ntu/6kwteioCWCSAAEkuJUhIBM5C7MELbQ==
X-Gm-Gg: AfdE7cn7erHxUDKeNcL5S8/xNOZeSUd0gS69Rho+iKaQX+R6bhixgxmdFlmHbjbfR2r
	rmDBpDUX68gAebQeGyn4YZnH2jrQI+32MNRp4oXIQ0qk/y/6WGlg/vODqoSv3lPUIQL9wyoSVjJ
	IMJdAGjloYwTDWebt/B4M7OQCTbQt9w31azg7LLHWA35zlt8tw3xW37rb2up3iBe6PRYmHWEz0N
	qZOjsm6BCM2F8crZo2k8h5LAqNEf0J24nykXy2+L/EKGyXFW8UpDn0WyISBtb8pxZky4HmsJ3Y5
	NMAw+uys6P27BRISrnjrQQ3dQuioU6n9SBzGoCC2zdaez6XN+4NBd4yLYrCkxYaDIqs/6i0RJib
	3rz1N5t2y0lfz83rgRK0U3cHofNQJzG1wFIjnp4O1OF8=
X-Received: by 2002:a17:90a:e706:b0:37f:c69d:ce69 with SMTP id 98e67ed59e1d1-380aa0f53e2mr5940321a91.10.1782993206551;
        Thu, 02 Jul 2026 04:53:26 -0700 (PDT)
X-Received: by 2002:a17:90a:e706:b0:37f:c69d:ce69 with SMTP id 98e67ed59e1d1-380aa0f53e2mr5940243a91.10.1782993205836;
        Thu, 02 Jul 2026 04:53:25 -0700 (PDT)
Received: from [192.168.0.4] ([49.204.106.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b816a42sm15615998eec.9.2026.07.02.04.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 04:53:24 -0700 (PDT)
Message-ID: <04b67f29-2afe-4c72-8c9b-bbde56f27a83@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 17:23:10 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] PM: runtime: Clear runtime_error on supplier after
 failed get_sync
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan
 <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Douglas Anderson
 <dianders@chromium.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev
References: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com>
 <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-1-6ddc317011c0@oss.qualcomm.com>
 <CAJZ5v0g6iRNUAKtDNKWa-_pshmnSCdStenNBJ91Xt=PSrhx=aQ@mail.gmail.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0g6iRNUAKtDNKWa-_pshmnSCdStenNBJ91Xt=PSrhx=aQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Uogv-BwxC9ZR9aXYlzvJ7rq4mdoh9hPT
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a465137 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZY8+d+ilh5AZ8AQMB2/tOA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=fOj4YSts-j8utWejEp0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfX9fz8KWonzoVq
 8iMIEcPMOwcDvDw/PH+vxqg9WeGbdZJPUOjcnUR48OJPh60BOMaRK+FUdii+mR5YAKjpun1qbpU
 7SqkuyszVJJ1Yvaz450IHNtnvJXuWSiRwk6TnOc4BoLPq4stWLUjHj1D1qqQoB2zF6S4nb86/Ae
 4IOSANKeEbf3gleJ+Aa//8oF5bkJX0hVFiCac3E/tsB5A52iUHcxKfMDesmN8oLszj1cddbxwUw
 b0CAmTH1VSRH+E05u0Y7OJolPqZEhGXUO+lmst0VO7FgoqWN/9guC21Ij7XAt6sB6+r5ySKnuLU
 AIEySYiRiMN/J3zb3PfVuE7RhM4RQnxMtdB9kqHIIXHUTKnz4lFA91z+vavOzMPNrjQ5J7B3d86
 6NMISX007n8EFW8h5wnrottegNtc6ylM1eWksm84KBhBEtoLr+pdXD/Oj4oS1Lq7zqSOS5soowq
 IqTVpyTtrOsFg/gSZug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfX1rqysHRXn4kt
 kBXXsyQR0WD0Sgc4+IseJ4gzCVhYtJ4dDxHAz5CcMKu3XsBqbah804HQoJcZSWE1lZME7RDRtQP
 f7ZUImDpxudXde0C4IqNx8HdiD4Oh2o=
X-Proofpoint-GUID: Uogv-BwxC9ZR9aXYlzvJ7rq4mdoh9hPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020123

Hi Rafael,

Thank you for review.

On 02-07-2026 17:07, Rafael J. Wysocki (Intel) wrote:
> On Thu, Jul 2, 2026 at 8:08 AM Praveen Talari
> <praveen.talari@oss.qualcomm.com> wrote:
>> When pm_runtime_get_sync() fails for a supplier device in
>> rpm_get_suppliers(), the supplier's power.runtime_error field is left
>> set. This causes any subsequent rpm_resume() call on that supplier to
>> immediately return -EINVAL at the top of the function without
>> attempting an actual resume, making the failure permanent until
>> runtime PM is explicitly re-enabled.
>>
>> Fix this by calling pm_runtime_set_suspended() on the supplier after
>> pm_runtime_put_noidle() in the error path. This clears runtime_error
>> and resets the runtime PM status to RPM_SUSPENDED, allowing the next
>> consumer resume attempt to retry the supplier resume normally.
>>
>> Change-Id: Id5067d09caca464f663fc95fe745d037e9c56664
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>>   drivers/base/power/runtime.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index 335288e8b5b3..9811d024d140 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -309,6 +309,7 @@ static int rpm_get_suppliers(struct device *dev)
>>                  /* Ignore suppliers with disabled runtime PM. */
>>                  if (retval < 0 && retval != -EACCES) {
>>                          pm_runtime_put_noidle(link->supplier);
>> +                       pm_runtime_set_suspended(link->supplier);
>>                          return retval;
>>                  }
>>                  refcount_inc(&link->rpm_active);
>>
>> --
> I don't think that this is the way to go here.
>
> Can you please say some more about the specific scenario in which this
> happens and explain why it is OK to effectively discard runtime PM
> errors occurring when suppliers are handled?

This was observed with a consumer device whose supplier's 
->runtime_resume callback returns an error (e.g., a transient failure 
such as a timeout or resource unavailability). When that happens, 
rpm_resume() sets power.runtime_error on the supplier and returns an 
error. pm_runtime_get_sync() propagates that error up to 
rpm_get_suppliers(), which then calls pm_runtime_put_noidle() and 
returns, aborting the consumer's resume.

The problem is that power.runtime_error remains set on the supplier. On 
the next attempt to resume the consumer, rpm_get_suppliers() calls 
pm_runtime_get_sync() on the supplier again, but rpm_resume() now 
returns -EINVAL immediately at the top-of-function runtime_error check — 
without even attempting the resume callback. The supplier is stuck 
permanently in the error state until someone explicitly calls 
pm_runtime_reinit() or re-enables runtime PM on it.

when rpm_get_suppliers() fails and we're already propagating the error 
to the consumer's resume path, we should not leave the supplier in a 
state that prevents all future retry attempts.

Would you suggest a different approach here? I want to understand what 
the preferred recovery path should be when a supplier's resume fails 
inside rpm_get_suppliers().

Thanks,

Praveen Talari

