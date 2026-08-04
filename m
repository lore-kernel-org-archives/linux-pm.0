Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9C46EC8B
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867140; cv=none; b=d/XunnDJSl1n//6V7hAbvCOTTEx80zMi7/ASHsGZhLI7r+Og/0NZA0mSu+j62Ijbjkvi0xdr4s4DoUkrxwsy3rMwW0yUr7aCl6Z8hiOUYKjb0ZRjbN9x/+CsL+jYZgsSTC1QBYqqgE9mkGmnJEwvQrj5TjQkekpgbWF5HhBBV8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867140; c=relaxed/simple;
	bh=AhED4tqTrGP4lTLdsnRoUZrZzBvGyQOjHem5uxoluE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euWRTbh6qqXSAKzTRM45w8rqivwrKfN359qtTtY6XmUdwTYoVv6yK2e4MQb9vy4y33nagRfznh1TrAvhe84tnBrr615TYEgqrDLXmrw38Hju67wcXSZHHVErYxA+d3/pUuf/KPiwmz9T62/7kFip4mUCiuadanQ3gxkm8Y55umc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPKdfl2K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dc28tqxI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPKdfl2K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dc28tqxI"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674H0Ibp580152
	for <linux-pm@vger.kernel.org>; Tue, 4 Aug 2026 18:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ASyHTNEVNi5r18fBCeervNjdQdHm+MvkAMt4iPH0kVo=; b=hPKdfl2Kzb0PMnWL
	wyJfm/ZTqLS6zb6najKVX6yGOjgKyPcdo45pD3b1SeTjF5K5u3BG1jC8DifV/4Da
	vXJCDtyAcaIsrw8hx7JLXQrn/Oz2cS+5thCdWTkAaDOoGKfJPvduQJa7MucvDJGU
	vVhODXcHwRSASU5Dhac4mkYQkO7udgkE2f26FEsmYRLxvS3jZhrr/V/RP2E3knnG
	2ECZpJm54y3AL3a2v1L3+Xl5Tt6wZeqpQrpDppned1mHKk+l4h+UsIFDk6ft3v5w
	kO6FS4900XVSwB977dTh5UWS1XnzeM39wVB4C6uuIul9GMlJSlKF/O+FktxZvKq7
	nho9FA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum3q8b8b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 18:12:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38827cee19eso115425a91.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785867130; x=1786471930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ASyHTNEVNi5r18fBCeervNjdQdHm+MvkAMt4iPH0kVo=;
        b=dc28tqxIDqzCkVIhhqkH+2ebwNTNrT3rjAqFOoeUpRO5+xRM1UJpKEkt5bKOQSLmbh
         byeSeSHxRBt6ktg4xXm0LzTSte5ccYUdrTBATz9mYxlM+HKl5Bmw85/rrXh8hvUK/KJZ
         nTp0Vp5pvAOh6OdgoaEh6uhUa0mvGIePFkas0gCzTuegTBURlgle5+Tqh1pAOCc4BTni
         qWj/NF5/pYDojRKPWn7Q2WR0j1ubjKWntPO3C//+UeNAxQaS0RJm1snV1AbdYca526TA
         UIi/WcpIH9AUpVhydYPuEbs2ZizwtRIs8liICsO24aG40QS5tHRMDw/Szg+yP+/Lzpe2
         93NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785867130; x=1786471930;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ASyHTNEVNi5r18fBCeervNjdQdHm+MvkAMt4iPH0kVo=;
        b=BBGv+vLfaAERFehRsZ3tbsyUYBYYGSx7i9bh4GSBwsnWhC8PKW42EGRfXDnIW5yWvO
         9UIY4rG9bpd46AHhruS5tLCzHvKt+6C2qfQahLqpbMYJxBEEUSAWsad27ognOWcsa9Qn
         ZY5r+fSWXyrD7ZM+qGKMEcIaCdbbRlM5mH4ah5npjXotG03ioOa0beZHG5Exw34x7Wu6
         +eGHJxtclQ2HoD10VScXYo88whND57bQc+4GlHgaRUiPRI5DH4U7c9UpiZhgVQZjDZlT
         xU3NJuDfI4I1kMbGbgJeugbaPIhdpH0Q5JVVxk4E0f7/krIjCtcsczXKvhWv66QkdKK/
         oaug==
X-Forwarded-Encrypted: i=1; AHgh+RqUvdyGhp69j4ZTYhfhnmgKZvBHJFlS5gvhrv19bIUczZh8+tTfAaryorBA9509fcCT9N4psQqW6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrPw87gvuprNnBfuKOk4RQiQybV+FaA493fiQED8HrC9hmFTw
	bznNRS8pBufPLkjShsrsefIG71Ui8HCdxO9NVRw/EBhp512mI2orC9LAbGNSJ09TImJwcComodb
	Kbi9zRBn2uYlGFOaKqCGmCJuTyUOSG53li4IHH3Fd3LZagxSZ6Ousyg1kGB/9IuCW6OV6Hw==
X-Gm-Gg: AR+sD11ShXMVfV8GB2ucSAuF3rzVVhgxONB0hMc3+FYWhMhhTFWbDRojr1GjYB7Fjzq
	QREwesBKdaeskd/xI7LkjY//0nF65fVVhmKr3RnqwYav3vjwT+39jACpAz123p5AuiVnacSbUuq
	XI7QGF0KpF+CvOI2vKzZfRi0cGdRuEuVD0WspADrSiFHd3/39/UAl0B7/AJTiDaB/tR6tNgCziB
	xjZdCu1DHZu6q5G2ZtkezmNF16QAOoOctjfH8qUqvcGB8FYbWqgf+g+X7KAjbvB72JWrMxwUUld
	ktGYHIYXnNms7wHKec1TK6I48GQGy3pYgtweqfgtOK9c1m7lHZXM4ha4vUSnMSl4viajn9IwYiM
	ylFp3v0TN5lXHEMuxBDktf4jSmpMplg1Zxg==
X-Received: by 2002:a17:90b:4983:b0:37f:9ce3:ca95 with SMTP id 98e67ed59e1d1-3903c6e051amr654640a91.30.1785867130271;
        Tue, 04 Aug 2026 11:12:10 -0700 (PDT)
X-Received: by 2002:a17:90b:4983:b0:37f:9ce3:ca95 with SMTP id 98e67ed59e1d1-3903c6e051amr654595a91.30.1785867129813;
        Tue, 04 Aug 2026 11:12:09 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.234.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca2e8ae2sm5560935c88.0.2026.08.04.11.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 11:12:09 -0700 (PDT)
Message-ID: <0d5dd29e-ced0-4c3f-a507-ebcd52f919da@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 23:42:01 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 06/14] i3c: master: Fix potential UAF in
 i3c_device_uevent()
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-7-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260804133810.184905-7-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0NyBTYWx0ZWRfX0LuvH4rU+2ab
 EP9z1wOanZ4YDQw0YfUR1Jx8UYYW2mhDiMJitq1UeJRybSJTlNuAIl24nW60sCHd3Gduy7EFUr8
 qBxn3SdpV7sNnB0Seri8ZD8z5Kj4+2ptwurnkkd8UIKz5oeK6pVqji6AYvG16tk9/UoBtVTvxLU
 FzbfpwhIZ2UQtA6G66dqPXR/chsTogwL1msKd2mgjLlE2s26qpk5ZUh5CzdV9A4RAOkq96BXGHs
 2znOISY8xE0uzWiBNmMZ2qaxLyu+oZkbf8X1YHMcnY9sdZm7GUAMH7O2lSIHrmoi5RqjvUekz+O
 51Fw99hLaWCgzmAwhglbTNwt5LSWlrEp5DOuU2MEb3AEqtkRZGRF0+R579G5d3yBar3D45D4gNJ
 iYhoQ2siETbzFBy9ruV377ojwWPjzyE4gbyGS9Ven9E6DhKZc0B98nCLKEomVKaBzr7qxwoTuWd
 1SmIoHtEiz0oWokiz7g==
X-Proofpoint-GUID: D4ncQqB64XsAcLfZM7mBXPJtze-9kAjw
X-Authority-Analysis: v=2.4 cv=LsiiDHdc c=1 sm=1 tr=0 ts=6a722b80 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=/lQgZcjXNA7ZrIsIl4Cfeg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=ohCnSGWktmBL-HYrFGoA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: D4ncQqB64XsAcLfZM7mBXPJtze-9kAjw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0NyBTYWx0ZWRfX77S89LY/Cgt4
 JCMQ4xcQLuAx9epPLda7JmBTNJVeCT9gzIMccB4Fewis8TCZikvdb/7fCU0f12NfMztDmNZ2g0w
 4In8uxhg2UNjF0TVuoZbSEal6Iu1UMA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040147



On 8/4/2026 7:08 PM, Adrian Hunter wrote:
> i3c_device_uevent() dereferences i3cdev->desc without holding the bus
> normal-use lock.  Since the descriptor pointer can be replaced
> concurrently, including when a uevent is generated from sysfs, this can
> result in dereferencing a stale descriptor and lead to a use-after-free.
> 
> Use i3c_device_get_info() instead, which protects access to the
> descriptor with the normal-use lock.
> 
> Commit 6cf7b65f7029 ("i3c: Use i3cdev->desc->info instead of calling
> i3c_device_get_info() to avoid deadlock") replaced the accessor with a
> direct descriptor dereference because i3c_device_get_info() would
> recursively acquire bus->lock during device registration.
> 
> This change depends on "i3c: master: Fix recursive locking during device
> registration", which moves device registration out from under bus->lock
> and removes the possibility of that deadlock.  Without that change,
> restoring the i3c_device_get_info() call would reintroduce the deadlock.
> 
> Fixes: 6cf7b65f7029 ("i3c: Use i3cdev->desc->info instead of calling i3c_device_get_info() to avoid deadlock")
> Cc: stable@vger.kernel.org # requires "i3c: master: Fix recursive locking during device registration"
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
> 
> Changes in V3:
> 
> 	New patch
> 
> 
>   drivers/i3c/master.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c

Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
