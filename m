Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671746;
	b=s51KS/o4nvYje7pKlBaUYkXq/7Qw+b1BlnmNAne9QIAtSasRN93Okhk0GtYZ7fkmlUG8
	 2T7wwpeCvJd0hRFtyqdHL5mJN87IaDLNQtj4y2Q8Hac6gzCL2WYjq3K5jFHjzn7nGy3Nx
	 VtQQvX5TOGAdwy+sEpqh99EWuxw3czgMKS5Cyr57C325joJQK2+YcVG5AP1b0JxfDbmL/
	 UoKaYje2jwUec6v3O/0HgD4Phv2gSTWecIyfM+pVy76B93Kna7ki3NfTKwpbWVCn1qZVW
	 tmL6wosIbYuuK+7y2LHTrJU3aypt4dOvaVUOC99am4HQtLe13ADaMjhwmAwY7Eemugw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671746;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=;
	b=xVpQ40wBx4d+3HAWdvjMsICOWhuCL7YXdbUABeDvG9gxpYv/1EHA4jd51H1HMBjypeEP
	 DPbCV6jK4CX0M3uulXvrWS6WePh6ObFYvQEj1oWMiFJaXsMqLSefvSOY7/AkK7JdtW8Yg
	 Unb4/FNLjKyUg9eum8yoxlRX1en6z9OZDKPMFEIPftYBOLtAR847yA3+oeeoMFEuNgR/C
	 YCTNfaNyvfcyQOS/AU56uKSV2v2VG9ZEZuB8Vkdkbd5bNtGOK0KY/5s8C0hBe9kEshew3
	 UdK/gQ4oiugvqfB3rVjSPz0qBm6mx2N6vGQby6vuqs/muvKAWFvzXyHjLc1bqfePDWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b7FjuHri;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C6zvZYVD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9438E606A319
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 12:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9438E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b7FjuHri;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C6zvZYVD
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M9xlCY2573576
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 12:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=; b=b7FjuHriWyJcQF6b
	oVxgz8d4XnoXFI7faQANh+GAqlf1hwx2KqrTuYLjyW5FpjEwS2L/kimmAc3pa4AB
	CT4m7ayULxWWZG3q3wZbrPIeLAHicmVkjguUeG7SFxAspd6FWvaKxbVB3HurC8OK
	fcUz/yF/RvrJD4lPFSo6JhfOzG2b4VNvQPZIQxfZkBQgvZJephazPUFFGQ73TqiJ
	R5iVVRCTGKIlJJQdCgbkZ6MEHpNZ0Go3fRbWPJuCci5ZvlhXGO52remI9hyptRID
	m9aiYahu2KCq3Fmjs91IJukRzfggloF1DzztroxWsu6nIhC08nEbKX1fDlEAVsCH
	olWzmg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ak6kh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 12:22:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ea63087d79so8532935ad.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792671744; x=1793276544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=;
        b=C6zvZYVDvsQzlkSCBnbfBSEinTQ5aqEOrZNT674hCUTK3Z05R+AH6DP0WTc4lrKLzq
         +pHyQwZQfA89UHm81BY5XebO+yKhsStKDNo/bb/r5ijlIw08rB48z7jdfSphizItJbq6
         f+H3UlJilQPQOOB4erv+ZTLSQCR5y3vZw7ipABz59FsDCLTHvPj8c+5v8jl/hTBVBbow
         Yy724azzBS6hhZ09zZa6IW0tE2c72VLgTx89YOy4SEyBu4Faoz692cMJMWFMC08uJdZt
         TP9FEUjo7ZFUeowAtZmVF3OFihn7b+/hpHpgojpxauF2sHALP64B2pKOLNPSZe+NLo7e
         +n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671744; x=1793276544;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=;
        b=uK6QCrEINfjImKv8Zh4Xfzpq7/NY/KPUvyhPq97yE/9O3nR9wNpYNtBApOwS5cFPh5
         /kbtPhw0sl6uhTCSdQEoO1cZmp+hfyiOoRkySm9byJYChY1/8O5yfeQLEz4y78Ue8zol
         ma/6Lls2vkr80yFTGcLDhZUVGgBu3+19c4JR4FmXlndcl4oTEYWecU6eRFStZy+MsYi+
         g/uQ9AxtmiiCedWMkISJk0LtTd7uqqB9ptbTVJShso/xf5uQYQprjKs+NcNpEslvZsQu
         XXIjC8+em0vMMJDMIBeEhXtq/Kiayu9aM30HEKgH/iEYCF0X+f9ij9OD9KmD+iaTRpyh
         XN3A==
X-Forwarded-Encrypted: i=1; AKwUvBz+hxv6TevGc7ANuO5Bl0GRLAJuUclfm2CDS7kZMl8WgYPbPK7q7JV68aoPEj0hnnXlSy6SJ18/QA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJJZq3WZgpYKLn8jrjklEKwH7TvkE1Qu+18Rhg38xukrwz7qsYf
	XVpae706w44WyPZroTRWMPBGRvYOhOUuTID8nsl+8F0gUMCXgzi5Ql2/rZ87poASrnB67FHaCOo
	PsbyN9Xsi/ZnpbE2jmLjQsGNs981wHTULiI2xSYqUiZ4YLiU1swBCXQzM4ESfqg==
X-Gm-Gg: AYBFou2yYRyQOvsqfL9CbyiLRZSxSxMeOLfmFRPr6XKYC9AGb3vX9wAZ0kx2Fzbn/sC
	4CaES1iG4vABDQDFuze7k4TPeYTphg0/SDj+odrJ5Pj+uAqWYASQtSMSFQx16n67jlQlfBSt8er
	BbOjn5PFJuegwPH9ELSioqWl+JHEy8ETuBC1yU7cOygBg4aKQOMhhN1Sca6hU15+iWwBD6HIyRx
	UbrDLHSBePJZAdRqRsjnH2eDBOgffEYT5bwztN1BNBP0wfc8wgF6B6GpdgzI+3Y+S8jutj/X5z3
	DCBKuPBB1fYRRCYMfSPl3jqiccInCrUPLXj+/QQXL+D63okWvb9/cOROHEULkqsh/rKdJY9xTbg
	07VyGCwnIO5U4vGbU1PoFlcKbtLLt84QkCA==
X-Received: by 2002:a17:902:e844:b0:2e9:514b:7a73 with SMTP id d9443c01a7336-2ea43fa9f19mr45591685ad.48.1792671743989;
        Thu, 22 Oct 2026 05:22:23 -0700 (PDT)
X-Received: by 2002:a17:902:e844:b0:2e9:514b:7a73 with SMTP id d9443c01a7336-2ea43fa9f19mr45591515ad.48.1792671743527;
        Thu, 22 Oct 2026 05:22:23 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b412756sm23642595ad.24.2026.10.22.05.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 05:22:22 -0700 (PDT)
Message-ID: <5dfd7245-c2c0-4468-95ed-6bb8a385da98@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 17:52:15 +0530
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
Subject: Re: [PATCH v3 1/8] soc: qcom: geni-se: Populate clk_perf_tbl with SE
 source clock frequencies from perf OPP table
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-1-5da1096243c9@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-1-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pgKgAmuFHodr6xrUdPZ_YVRah-OP-dVc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfX45pKA+AbPRyR
 A47dZbmNrv4aEhDL2oj9UTX41fY88SC7QmZaEt1SCYOgNIYGDj+/+3RWshaA9sNhj+fZossbDaG
 eZ57czbLwURT8bNeWxPU0P3tXJn83IU=
X-Proofpoint-ORIG-GUID: pgKgAmuFHodr6xrUdPZ_YVRah-OP-dVc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfX/Z7hzdCRgpTT
 vIbCEGQSkQKCVPPIje5CP8kpUmeNUCklnSEc20aZxWLJnAR9TWnosDhE3UjP0hqfU+qDEP1qVP0
 NJamhgdYIKNhq/gKPj1vSdsinOZgCAl0MhUoBZDk7C7PHOK2B4AOZPZ+ZGh1XWl2yQmRqxtgm6y
 ea7NoVvPJ7aKUN/P8SjMeH/FLEqEaIEH2xBDPqMXjScx8n8/OMh3rV4CyW9zmCtg47Qa5jwLpRp
 Y4O+o5O6wpC7Dci46EJugBRr+t4O4eSvH36KgMpFGF2qgo7OF5hOTtrBz8X/soDCtKmCPyCp9bW
 dWsX85c8TxPa25BTnuNFE16V2Y3JojVU0/+XFhptgVUBuDQyXxhylKnRfvh58nST34SeGxAPCbx
 cr8yQ/Eto414k+IyEa0AQU5N3y3rkPu1Eo5NLy87oJLgV7b7OImHBSK499+w6oVHloDuQDn5mg0
 Vq97MZ/DHOqgEnIEAsQ==
X-Authority-Analysis: v=2.4 cv=dOszC+Zb c=1 sm=1 tr=0 ts=6ada0000 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ddSnBWzqd8mu_d83chYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220049



On 10/15/2026 6:28 PM, Praveen Talari wrote:
> Currently, on the SA8255P platform, protocol drivers attached via
> geni_se_domain_attach() treat each OPP on the perf domain as directly
> corresponding to a protocol value such as a baudrate or requested
> frequency, and simply request that OPP via
> geni_se_set_perf_level()/geni_se_set_perf_opp(). This does not allow
> computing a source clock and divider combination for a protocol
> requested frequency, unlike the Linux clock managed path which derives
> this from se->clk_perf_tbl via geni_se_clk_freq_match(), and then
> applies the matched source clock frequency with dev_pm_opp_set_rate().
> 
> Change this by treating the OPP table exposed on the perf domain
> device as representing the actual SE HW supported source clock
> frequencies, the same role clk_perf_tbl plays for the Linux clock
> managed path. Populate se->clk_perf_tbl and se->num_clk_levels by
> iterating over this OPP table in geni_se_domain_attach(), so that
> protocol drivers on the firmware managed (SA8255P) path can also use
> geni_se_clk_freq_match() to pick the closest supported source clock
> frequency and calculate the required divider, and apply it with
> dev_pm_opp_set_rate() the same way as it is done for the Linux clock
> managed path, instead of relying on a direct frequency/baudrate-to-
> perf-level mapping.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
