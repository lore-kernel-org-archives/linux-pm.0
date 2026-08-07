Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA21E473C9E
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104678; cv=none; b=LFKgrqR35JCXfmjOdrwwCqKXBuxhEVErQsW2jFAEVrlajc+7e3ObNq0GKP+PhGpgmaeizv/w00sR1lWTXVinQ/WnuCooZvnqo+ZH54zXrlxnUyiQK7HUiuYLl+gRTUItflDcuBBceJEa0JrCqV7zDtcpctNNetM+8hDz3j++UxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104678; c=relaxed/simple;
	bh=CYWwPcIDbgZJ89d3/zXRkb7tZq9j3PBAauv2vSVKr+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipYUbwlKR/2+cEEI58H5fiNoparrl5gp20YVhpTaBmCFzfOm+B+u/F6FdWKcx129Y1q4Z6D1gL2VydgbkTBIsxPyMRv5mJUwbnmGvaa+fLLq3gDAYGwDr2YHu0lw/D15hDMBhrg5lrsQBxOZzyecJdEfghqSVDZ1UFP/LLJS5JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fcdIfSMu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pe9Yf9WC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fcdIfSMu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pe9Yf9WC"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67785L0d3477083
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 12:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zjdnzx+QsVtgM2X6y1LWePg9rWQkquFUfDwdlQM/D0k=; b=fcdIfSMuj3HLJvrR
	FVFOIUGxLVpO3A1PWuCnkR3uTVoeQDD/YnUUd17H9FNeggns0tluDyvT1asx9JrH
	f8AEeVCEVlNSoGMahDbYKSHDa55cxKM5yc2LplKk4A04+mVj3/XLRA4bYUNm8PoJ
	uJXzwOw3XaBaqpcoXGqLCQtlAIBHJ/LLehKXYkGpF4dDLcWowGphWBkhXUwJPr7t
	QCF7T7fWn2dBQOqdrfZTAEmoTPrDBPIU2eMIcEMGRoEkyPKfeXTylw2AJdH2odfN
	ZuRf0wUKftiQrppaYOWNWLE/ZtAPbkXUAP6vMD5l4RHrND5PW3N+OYsamJS64YxP
	qzwL4w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hbtgg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 12:11:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c083f1818so35237901cf.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 05:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786104660; x=1786709460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zjdnzx+QsVtgM2X6y1LWePg9rWQkquFUfDwdlQM/D0k=;
        b=Pe9Yf9WC5ONJFKgn93bOUrYzplSXapmIUxgFtLFvOW7ne1ETU8Pyt5XDUcSBbEk5PK
         jIK0T1qQmNLTW2u4aTSDLmI3FGtTlPdRNP2oYcQN5nOS6T85BLNlF45x5aBdLUZIalHc
         dKhgd5SgL1SwQ515nZJPDlMyOggEcO/0+zyjYgzwxqW/Y6+C+9pC6ggUX/9jh6tcd2Mm
         HFyRFSzda0tDUH67/p4wV86kQZsUBemwUx3S+ZzbVgZHo6vTOWSc+fu/7QOg5npv9Qtm
         HGjXSJeNcz5ijClnEyjZO1Z2qjEn1yTwM+Z7ZlrrcB9eJH9GMK9IY/6QIiRDGMAkqA7C
         sa3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786104660; x=1786709460;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zjdnzx+QsVtgM2X6y1LWePg9rWQkquFUfDwdlQM/D0k=;
        b=Q40KMXOFapLw2BgDH3FLUFcj1E9aIOf4GAwatxzigtY4k51W0hyw2Os1FGDBwb9PR5
         sFTneJ33bv3qSUSR+iPxGHIWd32fN9vGtdaC0VOd0fCic5E27yvUkIyHLVzxHgPJYjzB
         Ap9wMtHbdo1TLol2ArbpXJS/wvdnLBXJqKmpRRkXZuunhrQwofAH7RP0Z2xFTZ7Otn08
         xkA/3rIowXJJGzf/LcoCqMC9PN863kyxeeVBoSs5MID5oCUbyLxXAR6HP3D/7918JDG/
         5oYvLt8+9r57MKw98znNGOIvOsxYLbZYz+BqpjWRd0n2JKsqsVnH6yvqSEvUZhr0qI6o
         Bx6A==
X-Forwarded-Encrypted: i=1; AHgh+Rojw2FuqgjiPQK/f21uvJZK2lBZo6poeQRRZosk5+1CyIj6jAWZ/Chyws/wCzKiG7f7ozRYhPCECA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5+xmyJlfD2W16+IIX17JiN6GgkgUEM0OjYkM6dXOoQ62fUFh7
	JM+ZfnGCe+2M2NagXMOrNWoD+c7Hj0npV9ykPztvm97x+6CswrHUughexLqohd3MegjUheQi4KC
	lGVjF3VghjU3LSed11KnFPfl6ly6oIkLXIFhOEFW3/mMjFRqMz5hKMTw47AI0Lg==
X-Gm-Gg: AR+sD113biOWRmia/dXymUTDIl67wBk/hRAqFxY/8QbzmTgxoSohHHSVmN96TlIk5nt
	1C+ef7GL2zclKRmUkERTUEBOcC5loZRLoYKRxybT2VNCnxYxLXLTAXaFZa2/javiLVK+p8uwe+a
	WpnNNHXP2pCQJC3kfN4e583OjuMXSY0mZgl2A8/hfuTYs0upb71XJaCCQTbrfGWLNt89ctsZgkj
	0Zy+vm9ctfQk+HB2CyGrZGNAaozTzu/t7sVaMnwbfY1BstiwaghIHz3lGFwGOxACiQSwQ4TJAU8
	/tGphP+vym8NFQABukVKrTrGsLhLu99BVF8Sp//ch+7LlnHSZ2prfWYfiyG61LCCjOm5hZzlz73
	SpOsRSXpzvpL/I4tPBARrD2IJ23HThgZtw7gs9KidhVuHAg==
X-Received: by 2002:a05:622a:5a0c:b0:51b:f36d:1ae4 with SMTP id d75a77b69052e-52ce61fcb59mr247580241cf.43.1786104660332;
        Fri, 07 Aug 2026 05:11:00 -0700 (PDT)
X-Received: by 2002:a05:622a:5a0c:b0:51b:f36d:1ae4 with SMTP id d75a77b69052e-52ce61fcb59mr247579351cf.43.1786104659899;
        Fri, 07 Aug 2026 05:10:59 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995ea27b29sm41957535e9.11.2026.08.07.05.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 05:10:59 -0700 (PDT)
Message-ID: <14ea9fce-2bb1-469c-b751-32f7a2e28f48@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 14:10:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] lvts_thermal: Make reset optional for MT8196
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        rafael@kernel.org
Cc: daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        laura.nao@collabora.com, fshao@chromium.org, wenst@chromium.org,
        jiapeng.chong@linux.alibaba.com, frank-w@public-files.de,
        bchihi@baylibre.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20260721105230.101906-1-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260721105230.101906-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: o6dvG-hmtjqJRMLjIRF8lqe_vmJwKd4l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5NCBTYWx0ZWRfX1KTWmWVBT3Wr
 8ZrEsjivfi5faKQXRffclwahJEMohyFq+zZPdrQHkNxJiBpKdtAFmkD3WoHjERvYhbGTVK1JajE
 yDC6LKq9Yll990SPB6k9rhpKbTPlTCE2uIcAmubcoCBPB3rCddbXyj89WirdVIF3lZpMSXVkwfW
 Wamdxf8l5LwSDSVzCXGwiI86qCy1LIEPcZe5QOe6jYjes71Ha0zyGdc720fM49OB3mgZidlCCMN
 lBQbEWpGNrGnY8DilsSLC+rsRMB/iGXfh60oKY7drCat5dcGXKl3ZnbBUyiHTeONBerUuzTLL0E
 msmer8I6S0Gi697+DLEwJ7kWjTm8rMC17ASWuct0SjXobLyhcUbds7SUYNpykZjzyUu0rtIt80I
 6Mku/jxwn28rXqcgCGgYhY0wiiRpSnsDvZA2Do7huNSAy7Lqbrn+yzo5DglO07HIC5YN9fBqIb8
 tQ6s4w/wuThu/U4zDmA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5NCBTYWx0ZWRfX/XCKvGBZt05a
 FY6JcqtYwPTN/TVt9s5fyX0e3FZTz8l7wY+1/HttQRHHgYBpbapWt2L3OafkyOdc/tpbxo9Gyrv
 Vm50bU5rknqX6/qrrPzUyJAH1HPHbLQ=
X-Proofpoint-ORIG-GUID: o6dvG-hmtjqJRMLjIRF8lqe_vmJwKd4l
X-Authority-Analysis: v=2.4 cv=MbpcfZ/f c=1 sm=1 tr=0 ts=6a75cb5b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=rXlwX46IFeUSpfNkUDcA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070094

On 7/21/26 12:52, AngeloGioacchino Del Regno wrote:
> Changes in v2:
>   - Added change in bindings to allow resets to be optional on MT8196
>   - Made the code change simpler and without paranoid nonsense checks
> 
> AngeloGioacchino Del Regno (2):
>    dt-bindings: thermal: mediatek: Make resets optional for MT8196
>    thermal/drivers/mediatek/lvts_thermal: Make reset optional for MT8196
> 
>   .../bindings/thermal/mediatek,lvts-thermal.yaml   | 13 ++++++++++++-
>   drivers/thermal/mediatek/lvts_thermal.c           | 15 ++++++++++++++-
>   2 files changed, 26 insertions(+), 2 deletions(-)
> 

Applied, thanks
