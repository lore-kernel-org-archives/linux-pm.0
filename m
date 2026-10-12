Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728974A5EAA
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821926; cv=none; b=NQpjTfeg+vvOTrhW7jIToa4P1I3H1DSFXKxiW/XTMog/TnSUa5QNb9Mw2/e1uXQDPMr09crFK0Vv/5Z0OX75OZ84yJvD7dggmLLiMqqjZRRjCYxX9EY2tyGrtqR+LkzhWznqhLrsC4+co1IyroAG6SnF3y09cz2aUxKYxRpIlRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821926; c=relaxed/simple;
	bh=+NE18ke9KzvmlYSfERdehf4J8Dx7DueTMJd/A6Wr2XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gp8GT1OiYGgvxiAaSoCiYUn+hOISQvhI6cFZnc6ab4TLP27/0+7/b9sjeNPV2zDO2pc+dSGJZRRDT2bE2VTPhraiwBJdRsugKb6oYVb5YoyNp0O4ptTG8wQfgwii/wOU/nMYgCbLPCTkdfeY/odtYE4jN8j8q9c2uRUWXkzyTRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j0q1H8XT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WV0xTHbe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j0q1H8XT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WV0xTHbe"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFf5r52420110
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 16:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	992xLarjq0QrSCEXrsGRsdLKg44G3vu6aNh6DeczHcU=; b=j0q1H8XTFZxYi7A3
	9QyW3jRyF9odnWX4YAZEMXN37+l4twuaxFgwwPMXZIZvWBx1LQGTreTjzgYmeyM+
	5SZGxjqaYohCV1CeCbAFmvD6A4ZzrsLr6ZBC5HtplmxZwg0JlZ6Z06atZIn2mH1I
	GHZTR/8/WRBt7JqlQjM7Z4VZrVyPeh2Pl/vh7XmpQxaQGZfMWjeKbgy27brOtECP
	EjAkkNs0+Cc02+YTZqrhbxMIAUZES596SYbQFdHmshZAAB4Xv9h8LjM4RRbGa/a4
	NNlUf/ngkZDnI0Z4FeKtX255tLN4DXSZ1m4bJJSjZ1N68GvVKQHZjqaueMFd1fUR
	+Myg1A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8qtkk5h0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 16:18:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92eebb130dcso28586185a.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791821924; x=1792426724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=992xLarjq0QrSCEXrsGRsdLKg44G3vu6aNh6DeczHcU=;
        b=WV0xTHbeA4gj4WQ9C2NlIFxJlz+J/Va9v1HnKo68BypaB4IKyKrtY+wr2v6ykSiOkA
         ClpgwDE5ZTpEUL12w7JXngGxbjqBjMT+EzFJABN107SBWk4bIcPCkUv4pioucfxXL90D
         PpCTecxHuS9tR0O6xsZ6WkW3a26eBEg4xYL7e43JQbwC+NSV7rH73oCXbZ873sKo8xm9
         lTh1pE+JNwD+OnjhAy0VucLEcLxI3dnCUeZNzQ3iUgZ0nnKJ808JSVy8DwP2uGiCyfPe
         0TJuOKPD+JYT3L/Itg6t4diTdqnu0BPypjS9ZUqIhP5jExkTCXjwzONcLBYznDPJVYQF
         hkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791821924; x=1792426724;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=992xLarjq0QrSCEXrsGRsdLKg44G3vu6aNh6DeczHcU=;
        b=yWEg3Vt2NKyyXRbXHINWj/Cu/hgnsfeIxUDFqygp7huI5c2db5/nF4gKUhhs6XThoN
         2UDr6mJTqrgzOm6X2cAxwzYu7aQ3//b3DgOcEFSbYdzxFZUeVlDUrqx2HiTd7g25/+3S
         oREu/A1fUUV35U3ugoS15+WrXkLYwm258tzH9FWSSfBCXzisTtGd8bB+NypXXFXsaZI/
         XQ8toxDkH5ftUOlsKLFVytWd/s5JJrcHEKLi7oe3+YM9sUXdUAj9SDQFDqnumaYlLyDZ
         LfAICoaQDUVwJSY2HPNEZB0K4ETZ4CZnAkUcXjnXiApKeOtyRKitRbEXarQfV23XXI1V
         Tgfg==
X-Forwarded-Encrypted: i=1; AKwUvBwDfNAgUSAiFLUo5e70jgIfgHHBod/W01++X1h4qVXyWHWrJKnbQJbKG0Ag/q7L71LunUvKbRUxAQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYITB76XBw5wDnabiyC1pXumPlobretm7KWtDYTBXAlLYmoD8AMW
	xjI+sGp/VfS9NuP/0rG7qI4Kb9yzoTZ55kUNNTUBRj+cazxBrJeE9ukz6UZKwASwjKCjN9N7IYZ
	2q6UVXExWZKeB4wqJPnXLU+dd3HwH2QlqPwoZpr+MV/hLvtvRNgTof9CCWWtiPw==
X-Gm-Gg: AYBFou3RNModP83tIuZ2TN92w6hUzaOA1meTRz4TuAGTtSQLGsDjzExbxxgANWLNcP3
	xziTlgstVKy5+VzKr6tv2U3CCX5NqJcKtLLw0+NxpdOAfu1LHtJVyQyiw6lgLiG269etkMkIDtY
	V6nZMoFb61vA+uFF5CTJnoIqpwxCp+BxTxYRWYZ0V5guIHZKZcVs9ikX3vFxQz0Pp1HG8oJBGbE
	u8AZCRmupSiiKw3yOuefsVxleUiKxZ8hYLh9UEvxmbKx6zb9sX8Sju/1YSsAKJLBk72TkiV+WnO
	GHSaVNaJz7yaVry143+Y/vaFeVkgeMmr14Y1iAZF6jl5qgxo00fnIaCPBRaSgmdgeL0NMxvYqwh
	WB1xpg4WMCt1seV8Wr4vwmg==
X-Received: by 2002:a05:620a:6506:b0:936:2f59:dfe4 with SMTP id af79cd13be357-93ebcd2b830mr1732268885a.0.1791821923635;
        Mon, 12 Oct 2026 09:18:43 -0700 (PDT)
X-Received: by 2002:a05:620a:6506:b0:936:2f59:dfe4 with SMTP id af79cd13be357-93ebcd2b830mr1732263185a.0.1791821923034;
        Mon, 12 Oct 2026 09:18:43 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3bbc9sm482104166b.20.2026.10.12.09.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 09:18:42 -0700 (PDT)
Message-ID: <0ee83fd8-dcc2-4666-a864-de52fdef1c7f@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 18:18:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: sdm660: Enable keep_alive and
 sync_state
To: fabricioakio@gmail.com, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261009-sdm660-icc-sync-state-v1-1-77b8d2501cb2@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261009-sdm660-icc-sync-state-v1-1-77b8d2501cb2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NCBTYWx0ZWRfX290O0bkCtE0W
 bBhY6sfxRjAQUDqcsEpuXDXHa4wew1L/EyHzXkl/O+7JiWCGawiEzmHxocSGvc/qGK3jtPic1tU
 /OeTkZkt/RVQ9XMuHltxKm9Rh/NcKSCWC3U22UU7qbDJm3+b9NeJJ68+sUMZBM7QP5Y3z5aqIMg
 9H4ncdzQfFuxT+LgSLsz9bU2dZTFUlywkdsj+9XHs/3cYQqgwFT5yi3ScDNWxz0riGQ6yHMDh10
 fAgEkC/oRQmCQwGB/4yrSSo0L/C9/4myunS090QI2BHrYx4wFcqNtPPyviUg++2IbeFSNJ+tBSm
 4RsUHW9D9vQfgkjKR+NvVt4HxWGMrkYkzjj51d0BnxyJwm7G/FCA949x8A9SaKPYfHBVl4TElk8
 iFfj0icBegDmAfLiAGtd3BEEHxQAK0h/08/z8QNDBTzZBTrWrQBCcxST4u6AGb4Kj+tt74+uALI
 BnUBvpOlyc1+jB5bZ4g==
X-Authority-Analysis: v=2.4 cv=c8U+0h9l c=1 sm=1 tr=0 ts=6acd0864 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=USPW2_gFu0Xurz3Eb4AA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NCBTYWx0ZWRfX5Hl9whMaUIyc
 2leFPPliCxw0jLCLn01MWL7wNlFR1UZMQpCLI3q6eJyyV3LOqmNM5EkrYdTM6799w59F9xYq4/F
 uzK6ZaaowbQtM45LEjHBGs0DPXnUz/c=
X-Proofpoint-ORIG-GUID: 1bBEIcef4ebYDovkxtGUQ2bmux85reF8
X-Proofpoint-GUID: 1bBEIcef4ebYDovkxtGUQ2bmux85reF8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120064

On 10/9/26 10:45 PM, Fabricio Akio via B4 Relay wrote:
> From: Fabricio Akio <fabricioakio@gmail.com>
> 
> The interconnect core starts every node at INT_MAX and only lowers it in
> icc_sync_state(), which this driver never hooks up. Every bus therefore
> stays at its maximum rate, in the active and the sleep set.
> 
> Hook up icc_sync_state(). Releasing those votes also drops buses that no
> driver votes for, so enable keep_alive on the providers with a bus clock,
> as QCM2290 does: it keeps a minimum active-set vote and leaves the sleep
> set free.
> 
> On a Motorola Moto X4 (SDM630) with the screen off, this takes the
> battery current from 117 mA to 68 mA.
> 
> Fixes: f80a1d414328 ("interconnect: qcom: Add SDM660 interconnect provider driver")
> Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
> ---

None should be necessary on 660, except on bus_0 / RPM_CNOC_PERIPH_CLK,
which is not associated with any interconnect master on this platform
(so it will actually get disabled through clock cleanup!)

Konrad
