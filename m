Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4756A48F015
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992189; cv=none; b=BC3juTeEZOZOGX5+o7mATVlPbZd3LpKQX/2ySWcAh8Fc/45Xj12IA1PLNVb/BF9/MZ4IQxDJOzfcDvShY2/xagpkpYpG0iCrCsdqX4NOZcHd4slSvq3Bd+yv8usNrn6N/l1CRJ6XZOUjDEYrD+cwqpFEBORppvR8EinwFyPcpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992189; c=relaxed/simple;
	bh=KrMmaOz3/B6mLprGBDFofBWhY9m+yMGMGlz7ua+NZBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBtwxnhA+Nu63sNRO8JQ3fIj5uksLriPSB5wCM2gBClcJxnZUigMZilCxMmdedYp9FuRN5MCyeHuxJ7UYqvPRV1ogUotpuMrePgC4oVksGa3kZKDSGiBSDfQEi8TGaPGBCR2+eiwQBCB20pD0ArL0dTT09ccYsmIY+jXvnUNvak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W1kyHEfm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J/VhdcEC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W1kyHEfm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J/VhdcEC"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAds3l1217838
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dtVe7N4NXxJzsEz81o96S7Bz
	tivjUwZ+xFnS9CSgSEs=; b=W1kyHEfm1p8TTyAdLil5o7Zw5BTPRuxB59XGDSY0
	QIcJvksg3DGKEmoFs16i5gowBRIE49RujsEeVGRLoGqOMIU01VTTYeKmVfPux7n3
	+9IsvQBZd//GTpdNanmMrSbJW++kFQOlwZstLAi1YoSWhS56wa3WoRl3Jnj1iFlA
	gosL1u32lu+5KnrgdNaraHTmGL2MCTg9AA7TMzTU1O97s4I0XtUi2o6jAbBOE/PF
	boqHAiFbBmpS1/8IqLSTVjuWlss7Oe09HJ60oKTp+HxVW7DTpsIDUR1ttUtK7wpo
	nxNFPHtykvl7Vfl/nVRjMSfjGIx0yP4AHiWH35P+6+E8dA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu01194jn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 12:03:05 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c7c0d2b0aaso1398686e0c.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 05:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789992185; x=1790596985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dtVe7N4NXxJzsEz81o96S7BztivjUwZ+xFnS9CSgSEs=;
        b=J/VhdcECtPeLhKuWi6dLEbey6MW0+3Vxcm4DN+shmlfLkb88D+4SaYjGRA0ySguN76
         ncRUC1LoVVTwjWSfoKzEN9G3sUvu2bXRkxxZfJhwiHEP9Arrlp6WPXGIxnRDHjWZr8LK
         GezKUMolSZBOKbqUF7UTqI1G3pbbgtjkxjZx6OoJbu4cdRTZ5PZoG5C+IIZr7goveJhp
         GF0mUe37H1159VUWCvW/1N3yFTE8gc6M5brmuCTUlNHJtKRYa6orhJtheRwIHhg69vc6
         xk8INpSp5vA5544iGrcaQQ8XEdFoYyUziGHyOnZ1Naka6NnSmE7/AqTD0EE58+kS1t/g
         001w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789992185; x=1790596985;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dtVe7N4NXxJzsEz81o96S7BztivjUwZ+xFnS9CSgSEs=;
        b=Fv4laIaz9kCEt6roMxLNsLDXBcaKN4ikrxn1gqXAqf/AMK3p2fhvY0NUa9F+faZgh+
         EOS39Zv1EgspHxKLK1WNRl3Bg6gS28s0idnQjSTn7tqkwjwGZdsxk8rFOzt86nsp+Y4I
         yYdLs2mvHiWQtu7OvTYxl1He9AKv8A3ZX4+go8Dg8VohxzK0htIEvQQFMU0JPWiTUW8G
         1KRdgFJawPlCCplKQSlu0dmhnKYo5dh2MjRuaJnHhnBbM6++SCpiLVVTn9bCpfIrQ7YH
         XV4GB1x0YJfmJ9f10g4+E+VEqpl7E9EgnGmMtC04jerT+DPmyybg01b/l/3jsOmaVJPO
         Oivw==
X-Forwarded-Encrypted: i=1; AKwUvBxczg9kNTI5sESVBLKx/jFnbJ40Lt8OruX/jNRnjYkmfoIcWg+9oQ544CES+KrUy6UN6j2eLTBlSQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k5WWq2xCCIaH2DQIORScxO9pXC42MZpE5vBzd5tbOpFkmzT3kX
	ohQr4gtDeACpnMXX9sN4iG391Q0cydl3l5FLvpdwTw3Mdav23oGWLTKPpvMIAzObUy6rxVcMP7a
	0s1AQ8vtJIFVC7Xxg/nni/GEETqFqbr8iabLsl1GQOZhZLkKg0ITEu+DY/YKxwQ==
X-Gm-Gg: AYBFou09w0XB2e4bNRF9ZV+0kxMgxF5xEnYNjigvp2bUbBsvpVQyWYbV518P2jwX5MH
	wveUdaQ3VXM80E8NVbYzFMMy2Auu6oqiBkDTZuieD55QZp0HKec8Gn/cAj2l+8KYwaBx2pintIz
	hgow60h00qWoVjQmLGY/hcp/+iPuehngoCbm3i7PtlF2CpIBJlxG0Pl9ZbI4UJBMyAWqrkXfcXf
	NGcbfyunvEg8I3E1KcnXdFSRE5bl/bgz/O73x+ZU9Rt8uxMZwRE9/dN2O+SWMo9ZqLt58udXY4v
	ICzmOq3GFBHxdzefvIOGzLXk/EI/iYK14r37Q+I7DrgW9YXH781dTwU9FgC4nlUlIDRhvLKGZp0
	ek+JGqU8mMZHqeA==
X-Received: by 2002:a05:6122:6b8a:10b0:5c9:c60a:e9b0 with SMTP id 71dfb90a1353d-5c9c60af4e3mr1306963e0c.22.1789992185272;
        Mon, 21 Sep 2026 05:03:05 -0700 (PDT)
X-Received: by 2002:a05:6122:6b8a:10b0:5c9:c60a:e9b0 with SMTP id 71dfb90a1353d-5c9c60af4e3mr1306917e0c.22.1789992184755;
        Mon, 21 Sep 2026 05:03:04 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872456ee4esm21504766f8f.21.2026.09.21.05.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:03:03 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:03:01 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 01/11] clk: qcom: ipq5018: add 24MHz rate for USB UTMI
 clock
Message-ID: <rcmwsup6di3nmi2qwnayspzmxxqaidsplx5hlezpyxuu45ykbq@arnpm3epmu6d>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
 <20260921-ipq_clk_changes-v1-1-d242e3d49648@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-ipq_clk_changes-v1-1-d242e3d49648@oss.qualcomm.com>
X-Proofpoint-GUID: e7QEIgBHEeHfrHXeCAve4MRDPCrhMX2M
X-Authority-Analysis: v=2.4 cv=dPczC+Zb c=1 sm=1 tr=0 ts=6ab11cf9 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JaUoqYncsU2g2DIqJJIA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfX0ArfnQPBZqGV
 0JRQIXb/DSeJZHh/qTHo4NHfHu/3HpvikraShjp6gms3p8x18fl9Hzj4yZ1p4Xz/12S7J6JjUET
 rOE5BLLrdZRVHzmtLnNVhPbHHXWv1jZkdPMqCfP3atEOCbw+Ri47QLeKQbdUA2oFelePtYwTP3P
 0OZZ81OncO1j8fE/CoCCcgvT5ltA7+Eje6VutG5pfDOm4K+ggucweDezhXOBbZxV3b4CP3z4jwJ
 VQnXHyLzzbkXuNt3ouJjSt0ATkilwU2j+kAX05IzUNEUgmixBZoLZvvj/zIqAP+bmlIltrBwXcb
 qKys7qe+yRZ5Gt7CdsJY73iq9RETvwVc7BA1W4ylRBoSR514xMvcB3GOn7hZws0cr9JfF1LqmN+
 XFJgIhv/j27fxv3PqEmw/fSwAEcy4W4wvA67/WcEQa6W56qZf6jDXQK99PXgmgFbrsLsr06tmru
 XnLK4PIHGStHWOaLYDA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfX58iQzbQ5xlyO
 QIdgcm2NB3JPQKRCGbzQAJkx2E9jluqEawqXFCqPqOOt/HzPI2SN2XbUkxvCxRE812nUkoxbWY3
 sIaCNx9BZJvV29S/s+SKorbTVct1xfI=
X-Proofpoint-ORIG-GUID: e7QEIgBHEeHfrHXeCAve4MRDPCrhMX2M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210174

On 26-09-21 11:49:34, Kathiravan Thirumoorthy wrote:
> The USB UTMI reference clock must operate at 24 MHz, as recommended
> by the hardware team, for reliable USB operation.
> 
> Validation showed that USB 3.2 hub enumeration with USB 2.0 devices
> fails when the UTMI reference clock is not configured to the required
> 24 MHz rate. Configuring the UTMI reference clock to 24 MHz to resolve
> the enumeration failure and ensure successful device detection.
> 
> Cc: stable@vger.kernel.org
> Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
