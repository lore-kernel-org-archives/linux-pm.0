Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF13ACF14
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980933; cv=none; b=TLyE11HjVk+94ag2gikrTL8Wh7K7QxtDZuGZIftTaarlWE41yC+NNAqaxKyQ3Jnak0C9T47+Gqhhf3cJvIgljIQsiAN0t9olq/5UkUjvLt6EMj3+Q8g7eFEnWYnTjRp6YEYkJN85b+WR154M/cNzvNs/2xAcvkC7ACzywF+bPHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980933; c=relaxed/simple;
	bh=cSxddKp4I0UCxp9ZyNQQ3VHE0rhz14xxQPIoVAC1g6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8Px4QjFkfa/S0WqdMu6/AJh6Ze+n8gIE/e5cQAVcyor4EC+ml/M0MvwO2zV78MAI3hSJUf9NxXB0aqtsYCnUSbrSRfO4w+qkja7UCz4UT1nZhQgR/aro0BZh0zuRJPR9IesksNt2+F9aoQ++znl8m3x4jJU5Ve9cPwxooJUJdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hBp5+gY4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fw54+Adi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hBp5+gY4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fw54+Adi"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E7dC1K2873863
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cSxddKp4I0UCxp9ZyNQQ3VHE0rhz14xxQPIoVAC1g6U=; b=hBp5+gY4ZSoNEJW2
	Ns0QHOcdMVFplW4A5yixPzmbT83GllJrMMhv1XYzDfDPxMwsIMpqvctjetopl7rg
	VTsyuhyeft8a120DfR9qYSNEvKxkDacKZnbcF8XELZ/Saf37AIWp41Q5SOnu8pzc
	/YSWf1MFEUMKq5nYOq1XW9qzPzFm7QgvMMVKz/4T/CkVj8Rt1W4n2hNW2jL7MUz/
	sF3+lS3IKgi+UXdn+D8FOU3U8vBwtz4+yOulOxXJrjb8nY4XQMbB0psGZy2EvPRA
	QOXdqPUdJL/EJTjP+arhDXnt1kKX55EYegrnW2MUIabMyHFS+hdkJu2oJkaeCSHP
	IIXDAA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9yphjgw0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:28:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-533962f6bc9so9030971cf.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 05:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791980931; x=1792585731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cSxddKp4I0UCxp9ZyNQQ3VHE0rhz14xxQPIoVAC1g6U=;
        b=Fw54+Adi1wxevh83tZf4DRvRtpVN5i0qzKWLkqH7lT4KmEKT0QDGrfz5KpaagNmyGw
         MXanMuYgKqajUj/Re/eLFd6Mv7RGOugAUR5GwuOpQQt9sAO2YD9iVWTL5rNaN8r4XHF+
         3N0TdShkF/ruGQTlbJN3vZG6A1bgS3eRUB5HnHWTcThBe8wfCVYeyYovdojurzhRdzLT
         Sgg8I8OouTZv18bL4RnX2ymp5FCfcsH7vffcGU6Qq2BbgmKO/NnZqR0iNrNpZS62tuC9
         +F/eBDgZ2vZwthJNvyAmuc8AxSBDHNXmHUS3mef26AGJ5ZBBFvIgM+JBBDoaYFI1Oswl
         3mKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791980931; x=1792585731;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cSxddKp4I0UCxp9ZyNQQ3VHE0rhz14xxQPIoVAC1g6U=;
        b=kdJoeZsDIej7s46p8OWGWLqxJLkXZAacnpl3DwaIfuXrwgRcHLj+N53WRfEQgCXD9q
         tOz5QNYvcPRjk3yg7CtzKnYCHBnHgqzGsPdz2mPnqcEIfTLBgmA2I5GRKg1Hm7td8egF
         Sten8iWV2ycti6KlEXt0iDhvMt6oquC+q/NaJbngwpIlLRjYejWxKJO/LXFF1mjZViHI
         Qj8L0IfFlFnGCknHdN4Adxou0CRbImfl5iDP3Ds8NGs1J4P62LPLJIc95MKG2EmNAihv
         GkNlpndr/z3wMZ4v0oQM6wlKFpM/0s0i2crpKlBlDtNoy2cK3kx/aPXpYgralrdHb1cY
         iXJg==
X-Forwarded-Encrypted: i=1; AKwUvBxHfl/4KWf5KeeodKyNcn1OuJJT33TdOsXYgrewGIc8hDc9UxbiGJdhw7BJGNZSPKjJrhigwFTkzQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIYZ6bB2/e9iXGlT0YRcdUe/9Q/gWPFVNJT82ojRQJj7zfphd9G
	IiAB8mF/vThq/qiOl3roMFMnOCwxVkLVbImPRBTcU6o6ptA7Ge0QU4lRj5kkLtD/bF59lfN/jQS
	wcBfHSx4/7KwTWLJtVk4NgQ/XL+My0n2Nmy4haHhiJBBNDNOUjy1XznsMUJ7Eag==
X-Gm-Gg: AYBFou3eHlaspqnjGQwnDXGkXoO51ZN3hq1MpvXqtw7aD3CKYOhJoEyr2bO1K5MrnpY
	JvpUxNj+RNy8xWOJi87FXMj811DZwOxjmVqRwB8t9BmfmgmzXQV+u7ucyThJ6xmSToQRHOyM7QP
	QPHtWvNN2utba2CHE8I6//TZijpekzkncOeWqnHuGCYpWYXPk5RJcqRnr9dlvD5U8gBRjbhrj7Y
	rQ5pwz4s/+IsvH04jpYRH0WOFakDI3MDHsHfmaFl1m+MLu1r2pZlxA0+nyW38WUFjkVJfHdSj8R
	cC/ubEP7vxDpCJTWEqfmduSgVM51ysgMR2vyi76zT/3x7PDbfGSSLh4+sOeAro5kVnHhElGO9Ru
	2U/8hH62rrZyQXkiCPGaonQ==
X-Received: by 2002:a05:620a:4613:b0:939:c7d1:7471 with SMTP id af79cd13be357-93ebd228f1cmr2881092885a.4.1791980930294;
        Wed, 14 Oct 2026 05:28:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4613:b0:939:c7d1:7471 with SMTP id af79cd13be357-93ebd228f1cmr2881084285a.4.1791980929180;
        Wed, 14 Oct 2026 05:28:49 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9767227sm694052766b.11.2026.10.14.05.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 05:28:48 -0700 (PDT)
Message-ID: <d77bac91-1018-49f4-8128-27a69f754aaf@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 14:28:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] arm64: dts: qcom: shikra: enable WCN SW_CTRL
 wakeup
To: Linghui Wu <linghui.wu@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
 <20261014121910.1509541-4-linghui.wu@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261014121910.1509541-4-linghui.wu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ia8SuklTATb0pKP3_u2y2TPhKuPTHYWc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0OSBTYWx0ZWRfXzUDNVTMigaSr
 HNDh0FrrR+Qn3KilIVI/Nmn9gVllw/3ASTKmhmLHGjp2Wy+UVI/CC7IfcZqVzT+BoMxmtgXmvXo
 XJpespO85vgYqptARPKILSGvfAbRKoo=
X-Proofpoint-ORIG-GUID: Ia8SuklTATb0pKP3_u2y2TPhKuPTHYWc
X-Authority-Analysis: v=2.4 cv=Uv72pOwB c=1 sm=1 tr=0 ts=6acf7583 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=swowMNEn3sr08J82c5oA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0OSBTYWx0ZWRfXy8OhaEtJ+5UP
 MQnBtqpKwdDlyyGzUN56xCIS+e7Nkq2D5T6/PU9u3EIOVz0EJHu9pwKs5sPpuRLO65pnEmomEnS
 QBWVyjia626C5eYoX45siOhP6q55sq7t+lrZm2u3zBYC7Dq2MpelqYld1jYmZJRTWQiQQdwQqOB
 HJHEHz9q8GE/BV4alVhjDSXSOym/0grwLaO5qjRPW+HwwwXKATLE+Kl6eFnxMhR5Lj9BPTT1V8L
 IRAorONJzkVADymX24+ai35E6rTlu7WzEMZk4MaR2qrXnH40YKTgJl6WJbn5OBqY7K2PyQD5nE6
 heSK0hdrJwLzlCVCsHJtl6huwkQJFqDDMuEwICbR8OjG+AoXsak/Oh2biz5AILu+6IXcYfh6sr+
 QbQGfOSQMaQnTpEvgAtVmb13t3HBsUP+g2GZ6B3sLsGhejS60gdq9RIV8ZPTxlVMjmuYjpnxtaC
 7AV53F2e7pmY6RPQ1Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140049

On 10/14/26 2:19 PM, Linghui Wu wrote:
> Configure the WCN power sequencer SW_CTRL signal as a named wake IRQ and
> mark it as a wakeup source. The CQM SOM DTSI is shared by the CQM and CQS
> EVKs, while the IQS EVK uses the IQS SOM DTSI.

You already have a reference to that pin. You can do something like
gpiod_to_irq()

Konrad
