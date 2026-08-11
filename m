Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DBC430CD5
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443042; cv=none; b=Xa1xBN3rLccdw9X/Q7gzwC1ydJd10F+hs22e9eVCIaeHs0uW2eO4kRLHdB9uMZOd6MHhf6U31bE+5tIhVrGcXG/cBy7SMTxeQfGKHPl833zFn3+hi6tuJoiNaYB+d9JSkr0TmI0Rq+/v4R4dxjquoONsEqG7Z7WDBAqXg7LM3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443042; c=relaxed/simple;
	bh=fgXs0ECcNvgGaeJcwkLzQCD1n22yUPG5FRti3ek/DTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWqZfATDnMgnW46qxjNDbX8nCK2366TrUhElVIWOKK3i0XDIUJq6eFNdEOy/ipDZ7D19W0BApb3Vt+0hJ7ZWLu2u+Hw7tX9q/ClCW7YOzv3rHxURO68iNtZ2lZii0LS3VLBtFILwcFtJOGa0mJO9zhT7GpQ+ef51sTmWF/D99bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CcY7HrCq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QvH6JZ/6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CcY7HrCq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QvH6JZ/6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B6wIri3047710
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7QdukdYst6AdgiExdWVsNfBj
	ptF+nLJuNmughEUGSs4=; b=CcY7HrCqV+t/PV72ChNr7uGjZIvc9mVnyJbUByF/
	cD3YK/9a81JSJz0MqEBlyWj2PNNH9iwDWOHgKl9AUKgLvnkp4UlDH1NAeRzXgsJA
	/SIRNPnxqeQwqFiULRtcsZ5UzGBK2b3zj/JX8WpxttDX6fbG82faqRd9sd0XaKKd
	bnv2jlgnSEBImVOqpyVsj/lsFSrhlUHA3tyOHXGjMl5G+2XiN+iKT2DCt/FP31mZ
	ivgkLzrToti54cKiA6e0XyTyViM6zp12JABtnTvNcU58jD2zViM9JBzUMMST+/k/
	N8My1AuuFQgtL5UqAVukh62xwuCDIQao9zosO2YZ2BThDg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk23nnu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:10:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52cd0374265so54714611cf.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786443026; x=1787047826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7QdukdYst6AdgiExdWVsNfBjptF+nLJuNmughEUGSs4=;
        b=QvH6JZ/6FGA4CNXN5EvdM497vlsmbngpcXN/JjkCOo6V8YTeyeM+Eu1ytlq/5D89y9
         MiMFnjJbM58EtFf/Vdr2lYqCkkPwveARU9cK9ZNoi2zpbLVMt9B0q9gFLn9/74Mrmt4y
         3Kf2wLNVwTKJ2CRR2KQKwe6UZqO0xr6v0cRBVWjEgSRBIRJ+tkpVw0lDRAygTPkxcqHl
         JUChWpFpj3genYys3bdBaXU7f2jI04HdDpI1uNi83iarqRXjymakgxHXqNDLhI2EPorG
         WNU2FDF6PIS8B3jeTrz4qW2/ozCZOkxjYV5n455oHwcrQmO70sV2cKndOSpu8VpKJrJy
         CeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786443026; x=1787047826;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7QdukdYst6AdgiExdWVsNfBjptF+nLJuNmughEUGSs4=;
        b=X+ems1qls7jwPL2kHtxScb+gYoBxImhPigD+/Oew0Y4US/9Vw3O2I7a9myZaXp/Drk
         8YOoK2EszrxP9ZDV7DtF3hPegx651gpl1DqzFBSKGpmtXxIOok2wvG+hxpAJnry79KXG
         MrDnr//gNJcDkaNIlJaR9P3DZ4FMRfJrkhHeUzdA5yEjGUW/J6X4kDtcFlz1AllX5jwt
         ac3ozru9a4evABD5C5SeIWvntvDYF2TBKNVWgGtsIR1QtMtwdHr62926uTz6SV4MqTtl
         RFkjJdK8s+m6ADK8iVVjNkTfJuXsBchj0ZkSirj+47d97oV4JUg2Tq+PixrP0p4eH+Jd
         OTlA==
X-Forwarded-Encrypted: i=1; AHgh+RoMvGN9FUQ5ugV4Qr0j9uIVV26jAmmZGQ1ZDBkaH4XtvzO2XqfF4rEkPD0gWcqb8v7wT9/wNnJznw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXWBg5f9EH1vBeAQqHaGmMHJ3Ep27OXA5fybsH84P4GLIooRp
	9fjTWW1/LGNZAP2/R6HWCIYepbhC8o5SPdjXsNwOo8rjEOnz/SlWqtMCDHRHiApEr8wcXUEdYiy
	n66GFsdc1nLTobkmTO8CPYtcfHuuWQyZGVyj0m2RkPgtAXAMycARA5alTI0yf7g==
X-Gm-Gg: AR+sD105z4HW05dYFygTpHmjxc4c7f+UYIHhaZcuZKDIER5DF1Tj3//6Jwo94soO6yM
	O6ByCCzZsXqPovFb0A3MrYv7haGAo9CX5GBu4/mnRyK2NiGlTvc8kgFSDA65eUefNJfXV+vbt9S
	1d+UUTSM5gpooUOksMVtCGuiNTj1kSR50EziJkUwn7D+1vEtv3WmjA3tL+L4uy/r0diQgrjv02L
	M2GdoutxgHXNfN+nXwXPMxWGHsvJYiZo7IcMkvKTdmrcUSuwOkyANMOhvqoUQ79yArnSmHiIcAN
	Gd+WIBlRG2pJ6NiFq3PK+864rz+AkdWK3Om6CyzvrAeAsC9p4sg/rrzDTLc4PqEUARZyMMXlv8c
	vsGtexlI43I9x72MzUazK4Cl/4icNVmXTm7C0Q70E4h75fv3elEbXs2qnmjcUQiuP6IoaARIPC7
	MUSJSBnbw+6TW3CQ==
X-Received: by 2002:a05:622a:178f:b0:51c:1006:a024 with SMTP id d75a77b69052e-52d586c8d5amr15905261cf.43.1786443025743;
        Tue, 11 Aug 2026 03:10:25 -0700 (PDT)
X-Received: by 2002:a05:622a:178f:b0:51c:1006:a024 with SMTP id d75a77b69052e-52d586c8d5amr15904781cf.43.1786443025281;
        Tue, 11 Aug 2026 03:10:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b44872e696sm194374e87.68.2026.08.11.03.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 03:10:23 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:10:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] clk: qcom: ipq9650: Use icc-clk for enabling NoC
 related clocks
Message-ID: <ekugszfavtnbsprtjyid6htrjqg4iziss4hknniuvistiwy3l2@rjbmoaau5zh5>
References: <20260519-ipq9650_icc-v1-0-4d3554c94257@oss.qualcomm.com>
 <20260519-ipq9650_icc-v1-2-4d3554c94257@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-ipq9650_icc-v1-2-4d3554c94257@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA4MyBTYWx0ZWRfXweEasG0/5Upc
 eZo6POlqBeDpry3vIftncqd0oodS46gl34cmyWnVlrZLzVV12xzqqLGoFxTradJXilUxE+GEbNJ
 UfPu289LN383m/nb9s+oB4lym+ZRLI0=
X-Proofpoint-GUID: 8VuK9ohTi4QU9WJ-v4UuMfrZA5i16huI
X-Proofpoint-ORIG-GUID: 8VuK9ohTi4QU9WJ-v4UuMfrZA5i16huI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA4MyBTYWx0ZWRfXxzzkIEGue+gt
 VHYxu+/t1uoxcq9EiUg4caG4bA7nnyEVFJJVTtJE5IeN8bz0seqt9fPRUtsto7Jp6MWYLITczJo
 3zHlkPgNcRU+gj2MmBVtNGKadilmG1C2limXqiHakOomxVy+v4fqo3zupdGOBNFHGhm8PY8524b
 MnAsaEuKWBGtGE0fadT1scMNMNiwMvEQoKXWETN8a1s9jle23JfqvPHc3YhNTnIz1BbIzKbJfXy
 0HN+UBSd7KAJxntBIvojlFszIfK7FlCHvk0DMrhHzs0Zrqay4RRoepcGxuIKE1UXUa6KUIcYp/c
 0cXptc0bu7m6RsqpbOiHsdhC7gBuVx6ExqgRb1anZlZb7nOJhdcEF7ctGFk+W7W0zJKkl8UGOLm
 VF8Puew1mJ5GVmkeFR3Glbc1Bg+cGQS7X53bbcIuT0koPoOtdfe0ZTBo0j1z5TTtVUCQGsE1B0L
 1xHrJMKQLTKMzSkKjSw==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=6a7af512 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=5alyi5PEbrS2V74xuKgA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110083

On Tue, May 19, 2026 at 02:17:06PM +0530, Kathiravan Thirumoorthy wrote:
> Register NoC clocks for PCIe and USB interconnect paths using the
> icc-clk framework. Without this, the clocks required to create
> interconnect paths and access peripherals connected to these NoCs are
> not properly managed.
> 
> Also add icc_sync_state to ensure clock states are synchronized after all
> consumers have probed.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/gcc-ipq9650.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
