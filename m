Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793209532;
	b=KyF+UUPNWcfHRZW8FzCKlDu2tURzVI+PRo4yoJaq2m2++KQNq8Lu92xNya7pZPAJ2NH2
	 7Hp6CgFDdIm6Uvgi8hI6DdT/5odRxOalSPQT1SWp/r885Xw/kQaPLhN6iJFMCsOXwMVhD
	 dFaHFZWyuRWcc8nseIufK/UoK3eNCElopPVSjzAgNVRlS9UZFVXT8lEmKhPZ5n7AcFOO4
	 j0SLvSb8WNbdbha/vdGWEWThHf8GfDY9HcwRgjku0NIGkGucR6siFB1Sv3NOtfral6pjn
	 9Gf+ZaIhZZEAY+9hbDJCdDeiSufc7lkkIffytgekgvBVe9+2jXier9mObhX+8+mJ/pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209532;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KF/Rc89LdTq3PibZB2FPeM3UBuCsxv4hiWwAReCHAJ0=;
	b=O90B0zZ77bNI/ytinxwAk1xqFcUXgt41rOfWNEuMQDbs2Y9P7Xbp1y1ibgTsjkIe2nrB
	 H5cz42DnoS2aJ3bxyud29eZX2IUrbEQDIXj7I6l0fdidkiofpVECJ1oMR/VGOekv4qS3m
	 7kf6Igo/U/3nMi6Cgxnhe0Mw40QK/9+f1S9TtUWnXX/KZDvgsIHnD9+HHQTSoojMIU5Pq
	 BatzMPz9a+A22qzY+bpQMBhdJ8IIWPtzxIIlfhrGUh4YDjpHrpXgCyitejErBjFhip5QS
	 JakmI/CuocImiivqssM6WPAs6aKoO3abCA4uClipDrlATYa1Abi6zJhzhufDZVGnIXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fzQAUgws;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=faxuhLVT;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E2606A31D
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 17:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 856E2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fzQAUgws;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=faxuhLVT
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFA0o1966267
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 17:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KF/Rc89LdTq
	3PibZB2FPeM3UBuCsxv4hiWwAReCHAJ0=; b=fzQAUgwsZXJhe6CvIVZRfjqsi29
	VSElBTbGsvZWRn2yOKofbTGJ1V/uRgv1Sz6dd3kDg95IaCjrCyTbPFJz7hHV87et
	gBL043Mmcpw9IHiGFH85WzM9fMhpdkFRDms2inV/ndT62dfQ6vvf1RdD2o593gUA
	dSUBdIWe07OFVV63TUl24gtLhk6nUXOLtUp8Owm8Dk+hCQpUoTSqHNzXFyfmyJ5v
	D9jxpTtjKUTxpiITjq+BlYWb/ekSMDhr3YQPBWOaoRNCy212vgc0FpkJ5SvrQ9rA
	P5o8dMdycX4R1gGh0d1ArvJqWGo3AZ7eECWbia2Jv9+X3U+Z7C2zCqoev2w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkhtjh7hy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 17:45:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f20addba1so210559085a.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 10:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793209530; x=1793814330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KF/Rc89LdTq3PibZB2FPeM3UBuCsxv4hiWwAReCHAJ0=;
        b=faxuhLVTaFebAWTwPNDmE6WcmuQAEKCJ3ngGsNGmOqWbkK819yUQR0njHTDltWNN2/
         DNcCgqcdMIHGh7cf+rB8fjWYdPFaQI30+0m+aLUgx4WR7xnFnvAt//RZv8/UvLj0/5eW
         46mqLI+MDunefO1D3po5hZrkfQo3BrJmWjSdzUzN8rqDzx1r4cLEXowo8reOSMDLnDQk
         BgefcTEKYd7ikULrsdXXQ8AIq+1OkbFGcYg4riZzF0uo+ismaCjRqh7jqkuv7sED73RS
         GWrK6vxy3vl9WesAaJkymmvYxY6NgHXWsynRJSp9R/EieB1okpbhOg97iA9IsOpxadwg
         XfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793209530; x=1793814330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KF/Rc89LdTq3PibZB2FPeM3UBuCsxv4hiWwAReCHAJ0=;
        b=m83tJfJB+GPLR+DJFOWyu8arjgna1mSHGKJ2TS4g7PUHoZNUijwYNW+4h90ESQX2t8
         kBIaf5Wnbb2sWRuaZxcq/nKKNQs3uRPEpqR0FBwUocjFe7nz/ocqflxY3hruISx0sIDx
         Wfz1OAmq+d9gwSO4+YN7NB69KdK/NMLrEqM3GK4x1MPF3WIWvT8c+R/AUfZIsjrBudOC
         Dk0wYn4rIjxoadipzwRokpzfSJjGlcJjKimjA15mTy2NEnU3Gdd1cmb6Q26HEcoOG5pr
         mVjfajE3kEIgrqoZimdrKRmpU2hqlKuJw4s3yFApf2UaiNA+nC/tEwSZhvNnpnNc22tK
         83dg==
X-Forwarded-Encrypted: i=1; AKwUvBxiYjGNcmcJJMIfV7YT46Z8mYjHP+U5fiNcXsQe3n07qShUmNn0eZ/benDO2E6xa2HGjA4QVL2HHQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKaebTHOwJfDH7jp1/JIa1oBmGx4NaQpw54sVfSQ+uDM+gTOO1K
	hdgCuPzgtvd88dDCWNu3bnuVLfaOzlHhe3vOv0zw2R2SjVdwY8+22gHiXtTlRFBogsrQIw5/r5m
	YCF0XaeqaQzo93fhjKNqI4sucqXit/9+DXGcO5E82pTYxU8Wc/ygBz0ThD9EQsg==
X-Gm-Gg: AYBFou2/eAMVMqGXbb2DC5lai4bf3sP8LVJB35+C8P4jCHZFVHrxPBs75kGaJy4ev6f
	kVezIsalv4WBtWlXom2aixNW8AjbRZiJo4pKRWvsrfD6k7RNxN+jYKy43afphEx7O7YqNtUI1OW
	d2Xckl/iq9Q1TsJQRHi25ltS9XkZmUgRKctuRxhWEvNV0WzNrQhv7kYC9yDVSsvSWR/+sK3yvjG
	g2EoqZaxSD6Y7rpMfH2yRiI7vFbSBnTP84fURaYz2Wou6C5JHJXUp5gOFUy1RHZXAxa0Or5jbzG
	N0WoEdW+BMoodR9/eXw++PEerQZ74EQcBRKBajzQn+Q4dqdtJByRyqMh8wgAWIF9NqZYXUtd/YM
	z892rx+oanrdNIiOEmQ1bMXdg84gIT19sUiHZwT0qyn3qI1jJl5zUt2DFqPh4IgFwi5L71W2nLg
	==
X-Received: by 2002:a05:620a:2681:b0:93e:d364:c9fc with SMTP id af79cd13be357-9440896dc2fmr489027685a.5.1793209529570;
        Wed, 28 Oct 2026 10:45:29 -0700 (PDT)
X-Received: by 2002:a05:620a:2681:b0:93e:d364:c9fc with SMTP id af79cd13be357-9440896dc2fmr489021085a.5.1793209528623;
        Wed, 28 Oct 2026 10:45:28 -0700 (PDT)
Received: from lin-0772.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d295csm6842485e9.7.2026.10.28.10.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:45:27 -0700 (PDT)
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: atanas.filipov@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, Bryan O'Donoghue <bod@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sm8250: add camcc interconnect cells
Date: Wed, 28 Oct 2026 19:45:23 +0200
Message-Id: <20261028174523.3514860-1-atanas.filipov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a01d8d86-740e-4a25-96a4-d4dfd664af5e@oss.qualcomm.com>
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com> <20261016170701.1504338-4-atanas.filipov@oss.qualcomm.com> <usade5zkrncpry4ufbdtaahoa2zyd5hx7tjgfvzfte2aqbkgs7@t3mej4maj6za> <3e5b7781-20ef-4e84-bb62-29a081c26d8f@oss.qualcomm.com> <x5x4av76vm3swozvwe46uq5vz2ys7bvo4bducpp7flnmhykg65@pvr3znxyktje> <a01d8d86-740e-4a25-96a4-d4dfd664af5e@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3MCBTYWx0ZWRfX1BF1wUuRKVBV
 nEuqu8mtRBRbSwbIa7zc8wcdOu/MNfkOw8ExrFPmBdYpB0zOxFzttW9gY2ZP4NeyCvB5/1eTR6c
 UfCuqv43riavaIDyMyDNWVbUzPmTmXCs1L1A72sGdxViXdXfAANCj4mZVJWxNYr7kZMpEhyH2lV
 t2Js+CIdu9niZOUC0Q7FteINZ20rZDH2vX0dmuqsbqlS1fbDBPw+1iUrIUg/PVGNIqCFkyttTWn
 o/Gi0rEzCJuaQHHXaEx7nmqZaVFZpemIwEz1V1HOdUhrTA9rpUVscRHXzLdLWldPHW7kEoyVnfZ
 Fn/rdWjguODzjeFk1hXT9fNSSyJxyVC0eVcFWhn2obuyDFytDLZvCUijzKVGol9jVhRTr2JVZg7
 gY1Yz9r2vMgnVY/TQ7x9XnJFbKdKJ9JW2/zBDtr0iMOxhwKG2KPI1K+UGrOcYkpaUV4HZy1qWH8
 mZIHhdm/5v98Sa8857w==
X-Proofpoint-GUID: ipCgjMDoDb1PbuXgHLvJ8B4ugWXeaQ7u
X-Proofpoint-ORIG-GUID: ipCgjMDoDb1PbuXgHLvJ8B4ugWXeaQ7u
X-Authority-Analysis: v=2.4 cv=LdipeTfi c=1 sm=1 tr=0 ts=6ae234ba cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=CBOP4jDC0s-gxYZSdkEA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3MCBTYWx0ZWRfXzZSZ23giyNgi
 cFnNUbRIU0UiaacjmPGoIHmVAy5QvHojIUi4rsQSRFdJNmLlf0UbIyRfQ3uC8YYrrCL0+OaIHDU
 bvAyZnl39wPJeVa8mmRjuDe+oMixFI0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280070

On 10/20/2026 3:49 PM, Atanas Filipov wrote:
> On 10/20/2026 12:45 PM, Dmitry Baryshkov wrote:
>> 3. Add minimal VFE nodes and let camss use those. Converge towards the
>> split VFE (IFE) device tree.
>
> Agreed, I will take that up separately. To get it right the first
> time, could you clarify what "minimal" covers:

After going through the options discussed so far, I think the VFE
child nodes you suggested are the right approach for the per-VFE
votes. Below is a concrete proposal. It is separate from this series,
which stays limited to the icc-clk conversion as you asked.

Why a VFE node is needed, not only convenient:

 - The VFEs need independent votes for three things: their own clock
   rate, the MMCX level that rate requires, and their own bandwidth.
   OPP is per device, so this needs one device per VFE.
 - VFE and VFE Lite have different rate tables (on SM8250 vfe0/vfe1
   350-720 MHz, vfe_lite0/vfe_lite1 400/480 MHz). A single
   frequency-keyed OPP table in the CAMSS node cannot describe both.
 - Today nothing scales MMCX with the VFE rates: camcc only applies
   its fixed required-opps, and CAMSS sets no performance state.

Proposed minimal node, one per VFE, as a child of the camss node:

	camss: camss@ac6a000 {
		...
		vfe0: vfe-0 {
			compatible = "qcom,sm8250-vfe";
			clocks = <&camcc CAM_CC_IFE_0_CLK>;
			clock-names = "core";
			power-domains = <&camcc IFE_0_GDSC>,
					<&rpmhpd RPMHPD_MMCX>;
			power-domain-names = "ife", "mmcx";
			interconnects = <&mmss_noc MASTER_CAMNOC_HF 0
					 &mc_virt SLAVE_EBI_CH0 0>,
					<&camcc MASTER_CAMCC_CAMNOC_AXI
					 &camcc SLAVE_CAMCC_CAMNOC_AXI>;
			interconnect-names = "hf", "camnoc_axi";
			operating-points-v2 = <&vfe_opp_table>;
		};
		...
	};

 - Only what is needed for the votes moves: the core clock, the
   power domains, the OPP table with required-opps, and the
   interconnect paths. reg, interrupts and the remaining clocks stay
   in the camss node for now.
 - VFE and VFE Lite get separate compatibles and separate OPP tables;
   VFE nodes of the same kind share one table.
 - CAMSS populates the children and uses each child device for
   dev_pm_opp_set_rate() and its ICC path. The OPP core then sets the
   clock and the MMCX level, genpd takes the highest level across the
   VFEs and the other MMCX consumers, and the interconnect core
   aggregates the bandwidth with the other camera consumers.
 - Without the child nodes CAMSS keeps its current behaviour, so older
   DTs keep working.

Child nodes keep the camss node as the single entry point and keep
the change small for existing DTs. reg and interrupts are not needed
for the votes, so I would leave them in the camss node; moving them
would only make the child nodes look complete without changing what
the driver can do.

Does this match what you had in mind?

--
Best regards,
Atanas
