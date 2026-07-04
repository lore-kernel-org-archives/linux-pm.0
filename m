Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D63815E8
	for <linux-pm@vger.kernel.org>; Sat,  4 Jul 2026 05:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144267; cv=none; b=O11x065kbAdcLvY2XS3wKmY7sGa8xoEgn67mfoR6wZB4rRcslijOpUhC/UXZv4VsXEXXhTDpC5oC807Jnq6Rxq2ThXg/onzwWhNz5PiH/GY279vobxJ+OAS3ERctUbFIMjS3ayZK5V3aSi+onnKyb8F60oRBYnk2sG+Hu5DbxXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144267; c=relaxed/simple;
	bh=hrDTIMmfyR0bS4ItNIUcF/yfI+80W3HJbfHRHlQb56U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBsPAYhRbS97KhpIaHRAlG2dj1teYmlixMY88oJO92jERJVwZyVJKFud3dvu97Ke+iCBulRHnNRLjYXqgiAlB+BpUR2Gt1XxU/dIXqiSt/tADGxcptlLX3uFtCOE6G9N5lqGBHcBgHn2khp8pVqvFfkT+uKpY1SbBv9/HsLfezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KVj9nhfp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fqfw2bw1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KVj9nhfp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fqfw2bw1"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6642phtJ1811368
	for <linux-pm@vger.kernel.org>; Sat, 4 Jul 2026 05:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BPgsw4LHcZkkkqPUiF95WWE89s3NKtA9u8XaxB5FvJU=; b=KVj9nhfpZz/OR4Es
	g3MYKSHaopMTLEN3vkK/DHyyxVOSsg38ARKuvgG7TNmOo5vIsmbY+Jhx+MKJ4DkW
	BqEdnyR+OqQ69kNXJU16xVASNIzhaUY0ySMmQ+3iUlO3L9k4qCgoCbIbpIPcUb0m
	9pWlBlyAllFM5dVdAxTA6oF4EW8j5YzQQh9zg66rL2trn9Jq2FECFe4tSatPshuV
	2w8FTbeflcETUm60Pw+WigujBcVmfzKptw0tHkCAUzUtGsnUXylRllS/eUKQZ6Z0
	a46VgWZy7Dgix4jVASXYcPdURiH1uiaDw9mTfPCZ/XHQnEuqqNkF6q3sHd+6+s7X
	9LCe+Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvg9yq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 04 Jul 2026 05:51:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38108fb9d83so754323a91.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 22:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783144263; x=1783749063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BPgsw4LHcZkkkqPUiF95WWE89s3NKtA9u8XaxB5FvJU=;
        b=Fqfw2bw1tAUkFVgzzlQnb9pq07oqPvrPpFZPui4OHX/eDH36Uw7fIeTlYhytfOAYj4
         8ySZb0m6yuGjClKjFs6PQEIrXTF3CzLQQl/kqam+LZsHoe+AIP/AMnoivFwnuH0zlZsN
         smlFbTqzvLhaxfnKRW48qvGs8YSxxH27Ud1hSG1MCkuX8rhiBfQotPmfUfVxHQ+SQLS2
         zDo7GmnxeDk6OrJlJTf1qElo8lLQLZ1ZYCe2+ZuSFLEkAZH8ScFJKKcMYw3w9hNAhRf1
         lvIzSXM0WTbf4JI4Z4EVoj0rbIDhpFpwagve1Sa5GGJDdZBNYNfQAdZ2ooedvAeTW2Y+
         HjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144263; x=1783749063;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BPgsw4LHcZkkkqPUiF95WWE89s3NKtA9u8XaxB5FvJU=;
        b=FepnFyojPIwe2ii9O6TXk9v6m8aqjEGjyqIF4wD0QBmtG6eTxz1Yqi14W+eFp/RZ/f
         HO2lY6qNqZc7xdJQ8nheKJKh+KBmvNUdyaUxVQ+92WPd1I8+Bj9NLSYGHO1Bm184wuF1
         3M57MXWxueCxOqINCa6zD+rfJ2VYySXmSc7aHfBNWWSX653LvyWVH6t4SkiPQ/dAhoEo
         VNMianKR2SbPyNqnGHq38ypYu4s+gNcmsmVOFCjPIlcju7Qpa6+Tpgu7sZlN9ltTUTfw
         VpdNK8y86l5ifzr6kF48S4ggyuTEvkgU0xEkVgaaKGpkBaK+FdVMso7GOdr3pj7KK9Pd
         h4OA==
X-Forwarded-Encrypted: i=1; AHgh+RqDadnDVH731SIVyfnbxsgWIQJ0YSMid2/Z0LQjfC57v9N/nLn7BzwA/6s+SqIES9Kyk9cUTNGbmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxN0YWelXMYF9o9fBmgtAo7rEhfFE03gVaMiPwgELJT13hfWhVe
	4fefcvMH4FHgB8n4mMe3nSLRQ1xLKW35j7ruUvDthZKqIUOgOgjk70m6gKzxqTleQVY62K6VzfL
	TYFwoO1ocmAzbT9Wk5RdWyypu16DT17yn8HTSQkokHgWk3qAWsycCf3XniqGicg==
X-Gm-Gg: AfdE7cmF0u6pPVozk/8USBIFF0ZGJEBCg59HQNJfITrSNw6xH10P6s1Q5O4Mh2mMhjF
	eOM1e+JbU8cDZceVQdAPaWoIffUrUnNuCKI9xkwq1/mBxPefJ4BYzlctavNnEuUsd6zqafLz+bx
	PLvfoX8PKFbig1ymRMclD/eOKF2tWf/5OAkl/LaKVNg+XFFlua+YPmpdcA1xP3hl8nWfnF59BSG
	s3GNQL4QQNCmE80v8gJcKtFiANQMvNVHFPQcTWhDZD+40VwNFV1xTnUBNGYCmEbvBxQDNaMfmxq
	k8/CYePpNFWq7ypzV9k/WJbAFLgpUi0m2Dp0g+Ruvo518L8mG3NkBB0uQahhMXqx7SpJ0bI98n7
	KRG0L76pEqYgXObYyvh7lKBBcBYMJEzJqi/j/LQqTlZ0=
X-Received: by 2002:a17:90b:510e:b0:37f:133a:3e09 with SMTP id 98e67ed59e1d1-382803b483amr2336968a91.3.1783144263610;
        Fri, 03 Jul 2026 22:51:03 -0700 (PDT)
X-Received: by 2002:a17:90b:510e:b0:37f:133a:3e09 with SMTP id 98e67ed59e1d1-382803b483amr2336920a91.3.1783144262906;
        Fri, 03 Jul 2026 22:51:02 -0700 (PDT)
Received: from [192.168.0.3] ([49.204.111.196])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f31e7a2a8sm12120126eec.25.2026.07.03.22.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 22:51:02 -0700 (PDT)
Message-ID: <ecbaece7-764c-4e0e-b490-55d538f8aa29@oss.qualcomm.com>
Date: Sat, 4 Jul 2026 11:20:54 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PM: runtime: Only set runtime_error on suspend
 callback failures
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
References: <20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-0-578b78a0cf46@oss.qualcomm.com>
 <20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-1-578b78a0cf46@oss.qualcomm.com>
 <CAJZ5v0haSHfupyfnVGX_v4K0wYrjn-83NiDPPfC22x=zwi8igg@mail.gmail.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0haSHfupyfnVGX_v4K0wYrjn-83NiDPPfC22x=zwi8igg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a489f48 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=7DW+zsgf7PPjz/i6iZMG3g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=cavnWwEOFYD_SYEfP9UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: PaKHyqaHhWuW0HtjwnAGXibsC4luldPg
X-Proofpoint-GUID: PaKHyqaHhWuW0HtjwnAGXibsC4luldPg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDA1MyBTYWx0ZWRfXwZ3p5HBMyf9H
 CIyYVe1oy3xomQzMUNRlZ4HXbbXgL8o+EacE8EytCL7BzK97+gjovtQyFuEjuvwPnHVeNHgy/YM
 oeFrHzpssewqoerZZF1au5SWfujvbe1lME6FHTRdRdkfEL5E9r1G1xuu1vZGjwnFADW+mk0aPho
 htHRkl9nVt2bjpF4XsW4BG/L+zhrQMOq4C8Mx1MYFEGZk1CQ2V6A2Y7SCoqUhUn9hgDifMKz7gg
 oGfj5n7Uwt8n1Q2qEBVTu9cE/9C4kdqd8WG9QHzDa6apYl1FMaM6IYq4T78MI2ezo1FjsD3G8wW
 n2wP8/F3N2ZjRiRYg4LC57X0YdrLRANA1yGAfcL+dJ32rWv3aCEtqmdLR0oz9Hccz48MggZg755
 qWhZ+U9s3NoSS5he/NnW1I9LImZKpo0RkBDouSClG5dLvvg2Z9xR8nGfli+WbByPiAhXMFxCJZs
 PJpzsdB2+xNVjuvJ9jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDA1MyBTYWx0ZWRfX6vhsiaxeyiyc
 l8mwiV5OZZzyLBD17q1BIznHapSPCQrSgO3KvEkfAHMnwJ5PoSK8V+6iWkKsBGA54WI9s/A9h3P
 lwMpcIoSjTZFn6kR8GLOU2XoeDavhBM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040053

Hi Rafael,

On 04-07-2026 01:53, Rafael J. Wysocki (Intel) wrote:
> On Fri, Jul 3, 2026 at 5:05 PM Praveen Talari
> <praveen.talari@oss.qualcomm.com> wrote:
>> When a runtime resume callback returns an error, rpm_callback() sets
>> power.runtime_error on the device.  This causes all subsequent calls to
>> rpm_resume() to return -EINVAL immediately at the top of the function
>> without invoking the callback again, making the failure permanent until
>> runtime PM is explicitly re-initialized.
>>
>> Unlike suspend failures, resume failures should be retryable.  If a
>> device's resume callback fails transiently, there is no reason to
>> permanently block future resume attempts on that device and all of its
>> consumers.
>>
>> Fix this by conditioning the power.runtime_error assignment in
>> rpm_callback() on the device being in the RPM_SUSPENDING state.  At the
>> point rpm_callback() runs, __update_runtime_status() has already set the
>> device status to either RPM_SUSPENDING or RPM_RESUMING, so the two paths
>> are reliably distinguishable.  Suspend callback failures continue to set
>> power.runtime_error as before.  Resume callback failures return the error
>> to the caller but leave power.runtime_error clear, allowing the next
>> resume attempt to invoke the callback normally.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>>   drivers/base/power/runtime.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index 335288e8b5b3..70d933bcd295 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -469,7 +469,13 @@ static int rpm_callback(int (*cb)(struct device *), struct device *dev)
>>          if (retval == -EACCES)
>>                  retval = -EAGAIN;
>>
>> -       if (retval != -EAGAIN && retval != -EBUSY)
>> +       /*
>> +        * Only stick the error on suspend failures.  Resume failures are not
>> +        * treated as permanent so that the next resume attempt will run the
>> +        * callback again rather than short-circuiting on runtime_error.
>> +        */
>> +       if (retval != -EAGAIN && retval != -EBUSY &&
>> +           dev->power.runtime_status == RPM_SUSPENDING)
>>                  dev->power.runtime_error = retval;
> Why don't you move this check to rpm_suspend()?
Yes, we can do that.
I hope the changes below address your concerns. Please let me know if 
there is anything else that needs to be adjusted.

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 335288e8b5b3..fab38bc98113 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -469,9 +469,6 @@ static int rpm_callback(int (*cb)(struct device *), 
struct device *dev)
         if (retval == -EACCES)
                 retval = -EAGAIN;

-       if (retval != -EAGAIN && retval != -EBUSY)
-               dev->power.runtime_error = retval;
-
         return retval;
  }

@@ -751,6 +748,9 @@ static int rpm_suspend(struct device *dev, int rpmflags)
         dev->power.deferred_resume = false;
         wake_up_all(&dev->power.wait_queue);

+       if (retval != -EAGAIN && retval != -EBUSY)
+               dev->power.runtime_error = retval;

+


Thanks,

Praveen Talari


