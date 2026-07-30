Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE14446065
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429270; cv=none; b=AebC02sOKNed0IgroynQ85Hxa+mWEybCVxF2DnF75UForFDnKGuAvrJSw01L+/azjpIwXRcwTBZwfMfPYS9zIXN8GoGFy26fEuE7i4bP840gRlkmsqrwlEqAdLuEGlEd85wmRho0y7b4CgGryMxHa3PY58B/H5gwa5bZezPYdcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429270; c=relaxed/simple;
	bh=gXRfC2VjDT+XZheOHTbKbVXeBbM9bMyYA1/mdxx+YNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Co1D7JzQDr2oOq0l51MdUEg1XSrvXvmNMwZRjim3t+PaxbVJw6CuvfaCVReWRncMyxJVByp6JNUZnFlHWIO/2+eCZJ+c7AEEDk2cFxR9ppUkBbn4HCTR9URs2vn/2deemBdgKehW2o80okB2aj/F6XiBVe/yXSpv73fQBC5r5q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OPWTosx7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hoXwg1RF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OPWTosx7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hoXwg1RF"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGWZE91302354
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 16:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XnjmdFxiHJbplHqHTRM7ARcmcbr5wAPPkXRM+q1ZZUI=; b=OPWTosx7xtooPdQV
	yHjJ9jqz2rPsoV/aQcdBbj2WYdVyYFc3+pR9Nj95skiup16r1SX477S/gIEdiIQy
	2OZEZ4XGs2PThTrpQbjBzqNmXguKyQeXssRrTg51tZX3w2mgPXK32H7Q8vSxU6Ok
	ifoB596Q+i+aNlqiXKsQsDi8o3DC//Vc2KJkYYa8Dod+TQo7jJ9yhBveMG7RG/Dx
	N+oJEj9oVl5z/Oj59WwKiHGgT2V2orrdjlxLrb6lnnfZRm5zgEVQFdJndVAgofKv
	aKW9LxFMjuoBN0DMBkUc08CI1upgaOBUUR/9PQ8EsLq3kb21g65hRauxd6QRRu89
	mOhP7g==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8k60pdb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 16:34:26 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-664c8e55e71so3929656d50.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785429265; x=1786034065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XnjmdFxiHJbplHqHTRM7ARcmcbr5wAPPkXRM+q1ZZUI=;
        b=hoXwg1RFG0f6ihOF8Nm6IKR5MVmyknRS1dlLi9BlqQxjoFyfA6MeoR2rtZxh+BC8wW
         r05xB+6lMcUgmdcZ5TjiIwqULlTgBlNfV7Td8AlSolFAatGxnLqTj3YyHsIxE89GVkrR
         aNiCRX7Op4qhr/UcCHrM1cJyqK4A6icFLOB+e2Icld99++Yxg+dGLPJBaVhMEBJ96QIQ
         d/Bkj8WSRj0dDaYX2uCAF9pFusvLKMbwi+u9/SniqC4AGpgJigbhEtoQJmmr5XIgNUNF
         h40DGkO1BWh//27k6pucvDZiVaPTU+NlUSpX2fyjFxvQOMzmJ2LE+R0MeSAwWxzuaWtH
         /HqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785429265; x=1786034065;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XnjmdFxiHJbplHqHTRM7ARcmcbr5wAPPkXRM+q1ZZUI=;
        b=h3hnYXbAfpPGp03H29MB3vOyLBIHruNVxUabZBuA/9F6JKQWLpJ8gV7ycJ47/yedb/
         YYzEEcPuRjN3NxzoeYOX5Xool3n3iiVtwsy4aps9HgM0Z/auglgUrn92oC19CfFYJiSH
         RiSUABi/iYDshmlYZbQU0pmSNXkzIVwqwpGCL6mBatug5EAoojfvJKWz4Uu+hCqeg4oi
         LgbwfGJGEfPDsf5yGpgs9I+6TJlmnPMAH4ktZJ80Cm+zSR5/qlKMj+8NM6gTLFu+Yzw3
         DyMkXNUp1vazkAb6ejmAy6nE70aBvxflU/tLEFCdLbXJHYO9joda9d0ZY8kq0+vOEKoN
         kL1A==
X-Forwarded-Encrypted: i=1; AHgh+RovuUPATr9KGUJ+SgAHGuZxJ0PS0N/PSFhfUiCfTyIOex1mlCNGnjKj7+soiye312gXjzhhgC/mnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHLJ5oRJHPyOLY6Gjw8qHEAJUMuiH+rBUN1Npb531CZKzaosU5
	jObNYmt2NEsgCnNXh8mby3tfXsGmeFPYXe2GbhRy10DWRw8S1lJSU7x2oc/nDqi6drjAGpohT/R
	bU+np7QueAuOf9KuPmZhPpdzSwIRBB+GyDbVvsML6RGR2LOIi3xb7HOdhsVraJQ==
X-Gm-Gg: AR+sD1277uGCMfiAh3zAQI4lgJu0LwVYhx2/3MG3cTpT5Eu1e5C3S5vDYMeSXEgsv1k
	64Onp6Qk6iAq1JYzFtmw9IveC5IgkrCdgCA6Xb+h07AjvTlQsWPxYE9E44LAjm+IK3UHLCpXZuF
	zRLIk/3+Y4fE8rkiqmvtaKdZmUDxZRwXNBl+8BmnIGwV4VIMxm67/I6FXS13r3JPGXOsLuJ9bF6
	qo3r4tYajUopd26nG9aQMCEyUEsbi7wdtfgkoHDrvOdaNGlf27D4DnkuZQj/TGVdgYNi/0RfLZD
	/5mpZgt8K+nLrxqeLXwq6jYS/wACLLrl2HPvbfF4MgDZkJOss2m/RVMQV06eZ7VNVnUUFd08LWR
	3/Z1FhZpuswHOWIrOcurbhkqxzVb40jJ9yVtBQQpBxsN9XrB7z0AxxcfkP2VnT/tbvw==
X-Received: by 2002:a05:690e:d4b:b0:668:8986:83a4 with SMTP id 956f58d0204a3-6692f83a99bmr1913814d50.98.1785429265545;
        Thu, 30 Jul 2026 09:34:25 -0700 (PDT)
X-Received: by 2002:a05:690e:d4b:b0:668:8986:83a4 with SMTP id 956f58d0204a3-6692f83a99bmr1913793d50.98.1785429265109;
        Thu, 30 Jul 2026 09:34:25 -0700 (PDT)
Received: from ?IPV6:2a01:cde0:108:24ed:2206:62e9:bbc4:c360? ([2a01:cde0:108:24ed:2206:62e9:bbc4:c360])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6692c9315ddsm1608848d50.16.2026.07.30.09.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:34:24 -0700 (PDT)
Message-ID: <9d14fbef-43db-4463-b7d7-e5daee1368e6@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:34:19 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] arm64: dts: qcom: kodiak: Enable CDSP & Modem
 cooling
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
References: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
 <20260727-b4-qmi-tmd-v6-5-973cd3a226af@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260727-b4-qmi-tmd-v6-5-973cd3a226af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YD2WjKBk0Gtxzpf7udtaxVQiXeiPNyPh
X-Proofpoint-ORIG-GUID: YD2WjKBk0Gtxzpf7udtaxVQiXeiPNyPh
X-Authority-Analysis: v=2.4 cv=Wqgb99fv c=1 sm=1 tr=0 ts=6a6b7d12 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=oKFihCAVH3oSEhwhxOsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyNCBTYWx0ZWRfXzZgi8GhZFJfK
 6NgpDBHAxYRsAHkKt0LpsgP5UuQF4mnMhMjxiZejSKlV6gev+ZDMEf5KhDPI3gC7ynmX/XhaFQ9
 0ZN1Gua6nMfzM+twyvxbjeux4XRVT8VKxpysU1SCC+6q2liRM8CNcO8h4ZcXtilEwQZndpxaxEG
 cdjIC4lDFt2lmxsAZnCFzfrW0jOEQ7kAtgj03OzkHSaq5crqaPLxAPnobLykl+vQGxjRIe3z+p7
 UnE+llj6pY6C0FtdIUO88KLmDXXGFtdL1Uu/YhXCGb+NHkMOLuatSFr9rj16X/gY/nT40/ru8KV
 1sAe8jt08DHFDWn70JN6wOSzEB6sQHsJZwvpboIIENEBF0SVhmsBJfVt1fA44Fl7YKwqeaIocs/
 NxybDpjNBDkVAdgcm+i1Q+W1p4Zsqqgf8G7MDla+emkpS/z1kAcyLq9eEgTc3DhsBVUWxPwbCTe
 ZZkb7vq1M3QMOokd/cw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyNCBTYWx0ZWRfX9ikCfVyFWkaO
 QY2i3YepNdcDSrSE0ejcv2c59fddq/hq8jsTLN3wHT1JOMUT/khVkencw7mNzC+h5yYkxPNWbv8
 xLU1HK5tfX/QNpLeLLxX6IZFFjCxPVw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300124

On 7/27/26 16:22, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP/Modem does not throttle its speed automatically
> when it reaches high temperatures in kodiak.
> 
> Set up CDSP cooling by throttling the cdsp when it reaches 100°C and
> for modem when it reaches to 95°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Since the remoteproc_mpss node doesn't exist on non modem boards, the
> cooling-maps that reference it cause DT compilation errors. To fix that
> remove inherited mdmss cooling-map nodes.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
