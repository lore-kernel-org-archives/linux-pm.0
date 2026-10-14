Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C993E2769
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995590; cv=none; b=NMfzpoCE10q0nAXP2RO+HcPOIqF++m7mxUJnL1+R0NExlZzxIrCDs0lU2B52p+sh0tTZ8Bps3QE2nTFLbxYbICAgWNdmWxLMydUbQw7jC+tXtydN35fBFy37a8ENegLKVzPj2OlpFj3qlTzrzd2hwk2Sx9ARYcVCoI2ufi5stO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995590; c=relaxed/simple;
	bh=2SmqRSM29LOzHM3A6GRo5sG3zBqbZbnVlToBp75cpZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLVpPUxXi08v2J7RwOZg9ns7cu4YJd9chlEzKjYmsNcOks1FqqZbR1FIZuuEMVN4H/zVZojwGjB8IhvT7yA1RPJzBQVoPTTLFIu27+kriMSGetid430X830YDxgLtLbm8+sEtaFXSYyrFO7k+IbudtbW0SF7r3HxSgIf3wtikH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SqiTDsgd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jJCttwxt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SqiTDsgd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jJCttwxt"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EFMihC1682636
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 16:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Y1mP7tjz0hdlvUiRGJ/PYzkP
	s06b0Qc31Vf6gKT+zak=; b=SqiTDsgdAMLlg/VmmNIgi64kqSNttKz2JFT/JQps
	iKksROTi5LtbCb1iExe4VZisxmOjTXSc5qY3t8AzLdITJfAWlerr7dcHOC7eEINz
	sF+ScAitxzJlBP1QjlE2/AkCuvXB791xdhi+ZRCGaDPfUEb7Kkl1JGTDQViaSbhL
	So+U+1rVlO/FkoV7beVyz6HNoB7BDuEj9LpMcYxEHGkxAglspqlQLp5RUzQG4kJx
	IODHbTrUuKVWZkivtMbvTOvjkYg7XBYPRwNU1zIP5BB4YdPKfJIYFIC5ujXoj5Fk
	f8sCBjpJ1c9AiSNNLdA2u3LwWLF6/0xYFgX5cT4uxHl88g==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacb00963-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 16:33:08 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98bcae867a1so213227241.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791995584; x=1792600384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y1mP7tjz0hdlvUiRGJ/PYzkPs06b0Qc31Vf6gKT+zak=;
        b=jJCttwxtRda6uGs15dxXqUyZk5bXk3YdXN2KyByf7q+rVANKzbacDYDTGKEmEI8S3W
         MmLDLZOXEAB9PsTrFYT0ehSEF9+vyx+ePDIkvhU/eNe0RHmbqmFW4jNLG3T+Ryr+988/
         LlJRvDyVUqoYfkGeI+49SZasvLuVmNnfNqZJ6voM2ygIiuUY+nfmPBlBYoJTaUR7iQAB
         M26x0xDWgw+Kgtv+uB2+oQhu31fcg1azsM0qRRmQKoqyzoPkZt9BDUoofW+v643H4g2+
         DRObS6KRRmV08uoKzrhe4NU5ChUUWDAz80ACs/BET6QTFztGQr0QFM/Qh2trjIDDPlbx
         f1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791995584; x=1792600384;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y1mP7tjz0hdlvUiRGJ/PYzkPs06b0Qc31Vf6gKT+zak=;
        b=Rfd7hXT13JzAgdep/7LouUr203cToEA1JwE+ZBDBOPPgr8EBsSPaO5RLbjeTl8LMJ4
         FenTW75sdvneMOcbTlFlqCo8AC0XTcGo/D0egruNcjtw0zXABknQ+/kFIOgaJ9ZRT0/x
         R80S5ZyHFkTMS0RrFV1GaJb+ZM3rCtw72Zjn+Sxfoe86Iz2JyzPNhOH/gpFO3eZ1FO5G
         G8i5EN6p9YFF15aq4c7ES5b+PXXJFOATr5Sa2nrQiGV3cLyOzOeBslWdHIUVjRTiLR6x
         gwGfZub9wbb0khD8lh8bkIX4ieDzR6uQY1b0oG/GkntpyCJJZftWJDnsNGzGgmtPBhTN
         t+nA==
X-Forwarded-Encrypted: i=1; AKwUvBxSUE7Bemzfsc+HMBqeFbqCuaKetrQV72yoIYTlZfH2xCUgDr+Lh/JwHLs+II2MKGTj0AP0xuVNoQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLYioG4dFvMtoMf93byIAnimWjltXQU/xq7UROuifNcvJQNUXmk
	tXpfhfuuppYzWs/r6ss86eq9BJCZx6uSM7pIIvEDdQHw+fKW+RK4zfCp9+OjOEVOYBRRS0/m5u0
	9shb+wEj6aCIAuqYDEzcvfhh0Qc+gLfUreFkv3Qd5pVkbMbjmHmLaiSOM9bejOw==
X-Gm-Gg: AYBFou0og1LjhEUEGjz9qZK7/ZjSB675iBiY2mwVi60tMKQYgYEkArtN7NWkiRTa4ft
	ORvES7iGxV/G1lYiKMbsEi+Lwp7asCDa0Zhz7tRLeurfBT4C6WFSQWVaPFxXnAgAwu8710jum4K
	XrqOV+FQzD0lr0ZW9vs7GhSrRcpQ0TkKmcqqlaZ5UR5dppLuHENJJXiuosOAQWQHj2FCvuh4NOw
	r7Bglbp0WaaJ51j/hB4Xbrxu8+roqtuOIXtkqT2O15LfUu9efvGgeinRomJgPyfhusiDSPNSHrd
	b0tXBVePxLX19b7bpbcier0aJKs7+cTMgXB/ttoak7w+4VPUpzrF4i5qepYy+CfvXT6goomHQG/
	3ex37C81nopoGnsEVsoepCjJ8PQFxWdWkbNaU+rmosee6OXAOdlfCtnrMYTLrGa8o1gebBitdyV
	+GKWFaQ9E/dLZY
X-Received: by 2002:a05:6122:20a3:b0:5c9:c60e:3a44 with SMTP id 71dfb90a1353d-5e91f5795e7mr4855532e0c.22.1791995584454;
        Wed, 14 Oct 2026 09:33:04 -0700 (PDT)
X-Received: by 2002:a05:6122:20a3:b0:5c9:c60e:3a44 with SMTP id 71dfb90a1353d-5e91f5795e7mr4855515e0c.22.1791995583701;
        Wed, 14 Oct 2026 09:33:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be33d93e00sm758352e87.66.2026.10.14.09.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 09:33:00 -0700 (PDT)
Date: Wed, 14 Oct 2026 19:32:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 03/16] OPP: Retry failed default single-clock
 transitions
Message-ID: <njgant4vjdowkfe4milfhpeknosxxyalcfuf5p25c2t2sn6ffp@esokxr6ridc4>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
 <20261014-topic-qc_clk_dvfs-v1-3-3041b788e9f7@oss.qualcomm.com>
 <xkiu74kv2biofdix25gimmxxzqfqyocsq3wvdriqj7zscpynv4@us3hib36vops>
 <3d8158f1-8c26-4866-a318-abaad47f75ac@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d8158f1-8c26-4866-a318-abaad47f75ac@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=VKpIDNPX c=1 sm=1 tr=0 ts=6acfaec4 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=q1GH_QlswVeDWWcc61IA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NSBTYWx0ZWRfX8MAzt2abI046
 f6ycvPzASexmmS8N5B0TwXwHz6xNiuwy2I0DRj3k0h3/qD0YTz2HTkLKsfp5CXSTAXj5k7RS79G
 URYWHpAhYB/8HsQv3M931xZm730/AhI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NSBTYWx0ZWRfXy2fEl18Iv0uz
 FRz4m3wrD5GvWl1yOFzG+f1GUi87UU0XAVS5ClKilNPwatVXRM113qKNzjJuOoGLC4z9tUeRsKJ
 /jGzxSxazbw6y6UixksnDHhGsVM6fSnyL29CWHQndXjSwlBO4XQe+2OnowUCs/TasyD+ttAUVad
 /oPqrMwyw3pXmeJwUFTXTaNOgjF5eMnCslXuAJB4u2d/oUncK2M5oy4WwwV5kfQpsgoTYxXpg0D
 zy+5E0KE3gQZwHvQJdrOX0lW0gstkEmuSzphYaiJopOc1kawS52MW1dNtWf7yPp7NZZLVVjto5Y
 cjzZNX1e0+8Xi5GpvXTPOWUUW87d9Z7xcQfu8kp07WOrdTSuYJ8FUznFAUZpype+Uteceiq9HBb
 qY5vctbha028q00AN1pUAsbHStaT9H/QWYOa8IxzSE+HUH/uUiEjbFsdrTFCZUZhJxUAkmgoAvG
 +11Ke1HERcoLPlFsNag==
X-Proofpoint-ORIG-GUID: UBFw1ZQXE2QpGngphpuVHtJaqbIpvJHH
X-Proofpoint-GUID: UBFw1ZQXE2QpGngphpuVHtJaqbIpvJHH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140065

On Wed, Oct 14, 2026 at 06:14:43PM +0200, Konrad Dybcio wrote:
> On 10/14/26 3:35 PM, Dmitry Baryshkov wrote:
> > On Wed, Oct 14, 2026 at 02:19:03PM +0200, Konrad Dybcio wrote:
> >> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>
> >> A failed OPP transition need not leave the clock at the last successful
> >> OPP's frequency. If hardware changed before the error, the default
> >> single-clock path can subsequently skip a necessary retry because its
> > 
> > What is a necessary retry? Shouldn't it be: try, rollback if it fails?
> 
> The failure scenario is:
> 
> opp-table {
> 	opp-400000000 {
> 		// low
> 	};
> 
> 	opp-1000000000 {
> 		// high
> 	};
> }';
> 
> 1. The device is running at Low. OPP caches 400 MHz and the Low OPP.
> 2. A driver requests High.
> - OPP raises the voltage to 0.95 V.
> - clk_set_rate(..., 1 GHz) changes the clock, but returns an error

I thought that your previous patches actively target this. I.e. if there
is an error, CCF should retract the changes for as much as it can
(assuming that there is no extra error on the reverting of the clocks).

> - Assume clk_get_rate() can report the resulting 1 GHz rate.
> 3. The transition returns an error, so current_opp still points to Low.
> 4. The caller tries to recover by requesting Low again.
> 
> Perhaps I should have included that in the commit message.

I think, if something changes the state, but returns an error, it's more
or less... an error. Or a bug.

> 
> Konrad

-- 
With best wishes
Dmitry
