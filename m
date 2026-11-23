Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795459347;
	b=RDQdTv7Bk7yd467CZwPFcjmedm1bEqHkKi7aerXCWigLH8oNMCWniqskti3VMVBLmg/d
	 JQyu4OhZra7iIFvZw28flp2UruE4PpW8k9osRSPj2iBS51VWBWhi0HRMHFHrGB3VtDXaM
	 eN6H/GnPlu/7kHt+JmlyhAkXJA2JsvE6kCCuz7hiYx4z3NFY9Vn9S8L2xEveaoKy7zBtF
	 8k/Zwd4voDMv4DqJG17MVRKgSniZfETKIYZqxrUCb0RNQmeGnutivxkICMMAPFs3z4vLS
	 52KTu+ixGwy1+6l8WILOjTGig7nwAbT4AA/haQQ3uROFx8C+JwljXgXG45p/UXMZQtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459347;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=L2Y93dKIpsxu8PAQQHZSdaxuk248sFchZIYLxYLCnhI=;
	b=26IBs4r+nPiRv92x8SDNm/5N4t+YYDY9NMIr4SYOQQ8iW37sygvZE886+WET8ffF6Zqv
	 lDPYv7TShMCLd5clz2MzNEuxNn73Fh/RXPBRv4NePKYaaErS153D5mknTpDZip9xYo/JI
	 t6oCSMN/ZUuSLyHqmi776xJAPrsHlBdPzYWrcQiwJGWfRLzKeO3BUxwmGVO3E9zX/94LK
	 oH0w0/jkrMXlx3/F4aBAkmBG3NWOTOOuJ/mMMG4hHQ7EQ1A+H2uYRmk+EpIqel3e9bIPq
	 CXLzQQexnlcba7hbfVqPkc989sJQmO7rU14jbIciHwy4AkpunWjcuIBC2wqOWaR1u1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QiJ3W1z8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Et6422oq;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E8B606A339
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 18:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51E8B606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QiJ3W1z8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Et6422oq
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGH3vd1093811
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 18:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L2Y93dKIpsxu8PAQQHZSdaxuk248sFchZIYLxYLCnhI=; b=QiJ3W1z8ipaC9yb8
	z+jPkEFJl4FmS5tqfd3vTQH6B3QSy29PgKQRCRHd3WAeHcLDi5MSMBuwO+CvFEOW
	35HUh3WXLHHKz1lKqXVZBGTbHkvhnTFV/R2OV7wSVKegsGThWRRmT1QV8UNF1jxo
	Maq/haq3HHMtwjcUNEJL8aFwe3xEjjueD44rfOmI6gwkP7zOX9PIcn08hLhWixls
	DGPb+Lk2yRu4vrBwnBpCFy8P1FZ4mqZ4uNsZA6aJe9XWwarO7rdpgbuYM1TZyzsq
	JhgMQvm+MCafXx85m8OJT24e0OMD4q+ia2x2PHs1mvfpZcLvxeanC6tAsko85HDj
	2ibgnA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ma0suty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 18:42:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9495f7e03b9so29392985a.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795459346; x=1796064146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2Y93dKIpsxu8PAQQHZSdaxuk248sFchZIYLxYLCnhI=;
        b=Et6422oq8Ece88AGKwqHCIDH9qsSn1FOQpoIE+wQhbUeikPSQa1HvQlbyeMjs/Cz/l
         xp+9hwlVBQP9YhgeKV5KSnoA3KVEZq0PNuP3cJFeqAnwbsKhdZm5h6sBCIsbIWydPvHC
         ry2JZNNtwHfuYRGuQuS9jAoHe5RO2oX1oxYZJa4EsafHb5VyA4Ly3C6l+Jq7pviFcEXb
         6opB6XlXZOhKqMaKiffCQtKg3i7ZZ/AgSRfUeln5TUWpgg2htNf2lx24pyh7REwpUhmP
         SCL1m/eea/urqKCpmN4321MjicrE8h1duDz0BSp0fK8zQjAMbULpuaVaEpNnSBf/ibTQ
         GSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795459346; x=1796064146;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L2Y93dKIpsxu8PAQQHZSdaxuk248sFchZIYLxYLCnhI=;
        b=0pATKM2NdYCzLiTuxPdmi6gJbGjwoUtxlPlgifNJv/tUQswKduKuUMWmrD/a60ClEt
         z96a1a+RdG2K2fqwxQ1uF502hnol5I7oQEkI4lp1cEZvZIzGcRXtBGbhJTu8+QuAuJFV
         FaTMFJFUlcUH+7Exh2oKQkQyXm6RBVVI1N9pcdDLEdNs6pWpFQzZqtlsQryWorrPQfEG
         +ZxaE/k5N54NG64iO0RUtJ2zkhGMGkZiokNgydCGLa6uQhDjJN54ECyCCd+ezQZ/VWxj
         Q0tPnYP6zN5tYNDGfv1aGao6tswYR6pQReoDULKNAS3LUnMEYSbS8JxggMW5VbLOHC6w
         hLpw==
X-Forwarded-Encrypted: i=1; AL+hErGxE7GqCsT47WmaSU2Wf1RfgiDlRl4/92fV58BrJapqEhK2FkoFK9GIrZuYrsDrTanaFGogdvX72w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/RwXfi9tqBcCDbAOubPNYPNhl5W+0ZLPbXoLPhRFPrv3bcaauP
	K0zjsfphOTk2dYn9VEeK7VM21w0q5vzi2UcQRMcRGRmQCzLPlziF07awYNuDT25wL+5tBhKFpoU
	uIw31aZSPMQOv+p0TVH+UcMNSdEJrhSFG7r5xWOgmY6zMXhoCWlhtzifIK6/Jkg==
X-Gm-Gg: AZFdTZd4Lya3j0yhO1BP6rHDTitDKXLVCLpWZNNAeZVV4X+XoHNbele+GttLu25R2IW
	qa4KOkitUy9sdy8gLfty1Qnyfi2pGZ29q+JncByUVQQ6p4+tR1w6rXiXOtWlxSxbY7MraD5QCnE
	LqvXwzaXozxpgaGkS4lbg+VKdMPKxMqvEYnbIeZum+tdbo30OSRTMbh60ui1nvXfRugbHpSRLxT
	LOOdmkwsactQksHfQWwtYPov7oLh77j8NqKc3PEvxnD1Vc8Yacej+MwjcWzj0IFJitM2PxM9/cf
	VyHUxOTmiqdg+O7NceaAwBKk9IXRSAGoCE1XtcMHtRjQbqWKTEAhDp50v//C3+niT9C3pm63upM
	Bv203ET+vZ8BaRrtZRZN9rqDwpkjv9QY04rOeql3EiVIfVX0J8+/XztPVtkzu3YalxVmnvrA=
X-Received: by 2002:a05:620a:a78d:b0:945:c5b3:6356 with SMTP id af79cd13be357-949ba8aecbfmr2043697685a.2.1795459345408;
        Mon, 23 Nov 2026 10:42:25 -0800 (PST)
X-Received: by 2002:a05:620a:a78d:b0:945:c5b3:6356 with SMTP id af79cd13be357-949ba8aecbfmr2043694685a.2.1795459344926;
        Mon, 23 Nov 2026 10:42:24 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b00117dsm434564566b.80.2026.11.23.10.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 10:42:24 -0800 (PST)
Message-ID: <b11d2e6b-8802-4450-8eb1-7984034d5c4e@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 19:42:22 +0100
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
Subject: Re: [PATCH v2] interconnect: qcom: bcm-voter: Clear the ALC vote left
 by the bootloader
To: Michael Auer <mick@yoxcu.de>, Georgi Djakov <djakov@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Ard Biesheuvel
 <ardb@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261120122152.198114-1-mick@yoxcu.de>
 <6e30e65c-3fa7-409c-90da-2740f7bf0a24@yoxcu.de>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6e30e65c-3fa7-409c-90da-2740f7bf0a24@yoxcu.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rag9gVni_DbUwMbSa5SDVw0MwIcdhE9x
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3NCBTYWx0ZWRfXyL6EhNF7AqrD
 9ulJXkOyUiKNHJg0vFswGIgxcyAwuc77ftQh/cDXcHgSiw6uikoC6Hvn2eMsAfVCtc6lexfLxyi
 X0F72XFf1vEcoh6a4vXQSI6w+thF/g8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3NCBTYWx0ZWRfX28OLlh79ffLf
 87YqoLWL16CftCItj8XleH4hjOVQIicHqSvf1V4agzoUI/nNiG/bIKHtYdqLjCC2sY1RQSfiPlw
 U5nd9QJCPFzL54Ul7tTBePePpgxOJl0v9pYrmLVIOA2qSoxl4R3h/nOssldUix73bPXvECOrq2t
 PYuumUJeoTqGwUTFZR0jrH6+y/YAJqSYoAMpIm/Ly3NoAmw3YhTPs/hBV8YrcClpXJQmpH1fpWZ
 H+QIUBsXv1TkOGhgLcjPjAr/HQ27s5klxNUPmUu6NjYIO6ipYrl1mplBNKf3eOOCNDjyNQh1XWF
 It3PmXabrrRYmdso//dwtBiSy3aLYUNZVpcgVoqtGFi5a6o2E4hTpsd85D7S4CObYeeH/arSeL3
 Bor8kEeyvimHlpukUjqKNwalzVmStgpSRba5xrVnit1emPmxANbuX/KZp82PhuV1zYci7Yzr5gD
 Rp9Mg+KQhNW6JzousSQ==
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6b048912 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=BCpp76bnSYiX9KVaSk0A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: rag9gVni_DbUwMbSa5SDVw0MwIcdhE9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230074

On 11/20/26 10:41 PM, Michael Auer wrote:
> Hi,
> 
> A sashiko review of this patch found that the wake and sleep writes
> never reach the hardware. rpmh only caches them, the (0, 0) wake write
> replaces the (12, 0) wake value from the active-only write, and
> rpmh_flush() skips entries with equal sleep and wake values.
> 
> That matches the OnePlus 6: the rpmh cache has ALC at sleep 0 and
> wake 0, and the APPS DRV vote read back after a night with 139
> suspends is still 0x20030000, so (12, 0). What I tested is the
> active-only (12, 0) vote alone, held through suspend, and with it the
> SoC reaches CX collapse.

I was hoping you would test my suggestion before sending it out..

> Konrad, did you mean ALC to drop to (0, 0) in sleep? Then the wake
> write has to go, so that rpmh_flush() programs both sets. I can test
> that. If the active vote is enough, I would drop the wake and sleep
> writes in v3, so the code does what was tested.

My agent suggests that changing this to use rpmh_write_batch() as
these aren't cached and should achieve the desired outcome, please
explore that

Konrad
