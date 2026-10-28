Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211047;
	b=uAlKs21lvwDdHp1gZEvsY/ys2LxSxkLKf+MVgMvQNtEiezDaoSBNGBBVehR8l13W738F
	 TcHp/gsdUfh1tHXiwk1lROmNOg7dgAA2ycnMPhRSXZwOMCwnXXHvqWsfb8mJIgUnzhvzL
	 LT/aw1L/zyEUqoign8GkT9VYA2p53vSJeW4v4Jz6sLAiSDOM5usbmNTgm0PUNpqVluh7V
	 gXKDwoldJivQDfZO4DZgdsj8+VEvRa9GKrnSqt0dliMEuq5G4gttgxzJgT/pD+5TWyQkn
	 7ZgJPk7hCkzEuIOvpZ66Mbx7n+MSfAqiYSEQIt5EMI1cY2BzRzeGMlJZH5/xCWrkBTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211047;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6u3zqcJQ01sSMu+qm6L7bE2aybaQhlU8iBaL9JFnZjM=;
	b=rph8AUW/rXMjtW/p5DWfSphDKxdZNGBnAgnCJ9WAbhoJRObZ8n+6uBwJ1zKVpvDB/Mmd
	 DpReRBYdC+/q9j4hn0v8baIy0WtHqa1eJBGfDBcRH3mpsDdOSlpRmZ+ZEnLiVDuP7pa8Z
	 ZFrF2IKmMX9nuw4ZNAFpAyqQVdLLY5r6ZiH6sg4kJT2+9R2aLZjTRF1a1nJ9soLHNKm6C
	 NeMsnTfekp8NFCpOBGN7ENGe44zO04ukGTsxphK4VHEwcDhCHXZa3aKKMQFoBCPZ+wgBv
	 gzO1U97Q03ugvCbaKjga5uTXG5ENFzxlLqEXHYP0hmzPV4MADvq61lejnVL8nELN5ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ArxIu4Pw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NyILZ4yb;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B460A6F4E
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 18:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D51B460A6F4E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ArxIu4Pw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NyILZ4yb
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SHaSvt1474511
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 18:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6u3zqcJQ01s
	SMu+qm6L7bE2aybaQhlU8iBaL9JFnZjM=; b=ArxIu4PwtAhxXYrlBnwxbsMSKn9
	Sa9Yu3eWK/NuQ/ZMmyh2bEcFsDg5zgE14xK3YIx/VdViTFPR3PupnD7+J0OoH33e
	piHVmnpn/wgAh27ZLAZOHD2qz3bymru9azMuhO7PU4r9+DZUoxeiMsSlk694qaUC
	QSDaY7qi4Gi7w5Xr24b0cZNDdJOSINYnZTEaLUgSv0aSS229Q7K2rCwC4TzP+btd
	46fuPGkeqY2H+Sw+r/pD55YlUR7rReFFEdb0XldyUsZkAJUGxWzpY0jDP3yphaP7
	TkI3fsZxELPFB05xHviqgvdAVD2dK6kwOYnb/Bd0TJtI8ay8Jv1RJVshkkg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkp84e9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 18:10:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f559420f3so111598385a.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 11:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793211045; x=1793815845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6u3zqcJQ01sSMu+qm6L7bE2aybaQhlU8iBaL9JFnZjM=;
        b=NyILZ4ybfIWMNXTIxPdmD98k45qlob8L3xmgmoH/y8/bsrzCr4DKiuBKHr0yjtlRYy
         N5UzUTuJeyDhEaP64mTsOyDy3pozCrcFvU15WqH48tOK+3rc8zatPzOqHULHCqVP25JO
         h6PKnNMEnBHUsAlJutFu1k+7chgkPb53HOwNsQl18v6Gdp5DDD73Aswgg5nE4+dCZs65
         0gXopaUm27EGIiwNNFerGiJPn9ZT+C0HXBETmPxewupaNCUut8q4ohOeG7awLpyi8TjZ
         4UQf/v3j0bSeX+tTIMilHex2Zyud4cZLYUAi8TYq/13G4rT8d2lRPGE5WlxaPAYzysXA
         5eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211045; x=1793815845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6u3zqcJQ01sSMu+qm6L7bE2aybaQhlU8iBaL9JFnZjM=;
        b=POc0LHsPXGzbzmCeJkUdw7sd0Nr6lDG7n5JJ1n5AM9iOw0wirVS3iitibUsId0dZSn
         qO2nop4cKXgh8VXq+BWyKtC5GLIvJGNG1LKi45uO7psCiS58VrdbbWch9fJD62dfWHjD
         kffly3G1jUy3/7NmCwskliO8tqxWj7Y09iQI85ZM2ziQdWIWbaS8H5CPadFN2X/1c+YT
         ez/g1zIH7UfV9Y/yzE5odBLXUURSIFTfgDbDjFFMpp7mlPZ/FoUsR3q2CZVwIvVNEfu7
         3+lvgbuD6NXX3jC7JV8ah0TVVFevM06l/XMg3qYwoBLwHMfed/5Fr2r96wqpbskWpK8X
         lEEQ==
X-Forwarded-Encrypted: i=1; AKwUvBztt/KMlrKPqYfBWJKlti78S+ulQWUy5nfO0I3BtjaVbjG9MndmD20zwa1h9VR4ZPdlgovnF1XPQA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKpb6H9WKrb+vXyQ0yXnV2yAsPfG5oG/v+qtJ7P0xQ0it9ZAdaT
	mrMO4Vd1rQtBsqDkjBxuGf/n5IP5Uy7QLIYuAcR/dw2KO2c2m8Dg3zSn4LmKnyO3tcbUyOj7o7Z
	7OcAQ7lFXJTRa6tctUp39SpN8HpHa5sfqxAP+Vc2F9UTseFR6szoxaPNgdYXu1A==
X-Gm-Gg: AYBFou3TxK0PeeWVURRYZ0kYoZ6zr1z43/CLklPuoMscjvEWZllfTIGB60DIMZuUDWO
	zvZvHqa78WnDI7twXHMGm36wSK42XZP30lWYw5pYYEoNNHpW6w7Gxt0a/YneYxz1Wo5qpTkNWVE
	R2HohO16vncf0/qBnntdh9TcRZWFRYTOK8cTvoUoLCzjMkOOZbJrzRzh12PaeNIdtMTXqITZbzl
	ac/kCnfSYqcS08KlBIL+2EhpiMivDNGhBDu55jQvwLqL/tarHgVJKmbOGWtOuuZ5YnFKCDXh9wC
	TIHiB1XP2yZcM2TUYid0PSKVOZ8t+jp5xnl1UjhCzTq57bSXtHX0cM2ChOn6I8PnP0iwQarDsoH
	DYNued6sZYNB7rT8bSWHSj83KC7J3eZ/vHUjBkjOXqVazlgUoi05wroCn0dyLSWFwY4Biiu47mw
	==
X-Received: by 2002:a05:620a:6493:b0:93f:2ff0:87ef with SMTP id af79cd13be357-94408a728bamr431339385a.15.1793211044835;
        Wed, 28 Oct 2026 11:10:44 -0700 (PDT)
X-Received: by 2002:a05:620a:6493:b0:93f:2ff0:87ef with SMTP id af79cd13be357-94408a728bamr431333885a.15.1793211044276;
        Wed, 28 Oct 2026 11:10:44 -0700 (PDT)
Received: from lin-0772.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa82516a45sm9801595e9.15.2026.10.28.11.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:10:42 -0700 (PDT)
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: atanas.filipov@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: qcom,camcc-sm8250: add interconnect provider
Date: Wed, 28 Oct 2026 20:10:40 +0200
Message-Id: <20261028181040.3515955-1-atanas.filipov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7ca815b3-4712-42e4-996d-4a1e53cad492@oss.qualcomm.com>
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com> <20261016170701.1504338-2-atanas.filipov@oss.qualcomm.com> <20261020-bloodhound-of-remarkable-debate-11afe3@quoll> <7ca815b3-4712-42e4-996d-4a1e53cad492@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae23aa5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=SLSU3p2cmSaEdqdVgzYA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Kb02nLyv9IsqYo5_NsA1OE6ld_Ca-MEG
X-Proofpoint-GUID: Kb02nLyv9IsqYo5_NsA1OE6ld_Ca-MEG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3MiBTYWx0ZWRfX9j6UkLJX8S8W
 OnX+dvOjjYj8VUh7YPUHnSWh64fkuMrHj6OkucEDlVwHgZxf1N+JyHtzETZmuJcsgNIhtTphOrW
 Ic1zdpusyfA3AQVII6HzsKrQdcZtcCw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3MiBTYWx0ZWRfX1kfRP7SWgmNY
 uIZR9bK5NKAq2kIXArmGjpZTSkpBML/OMvrhRsHa+yKqZfdPslKem03nQQxHJy0rDtldfvOHZRM
 3DDihMtUkjMsVd/ytZ5AmcQWHNNJwwTJ8BiOHcme3UFfRptSTjiV/w1dGFxKxyvZu7wbbCNNqzK
 kr4P23Nzr+wGP8vj3RSb30jGpeKjRcjncQiFe1dG4vFLfA7g17u3t96i5dw+Rl6yesdmfe5E85l
 B+pZs9Wlfsem7viOLEc9IGGSac+qE3y/l4FJZoecKjT6q5iq1013h7K1hhCFX0zc9rjGApwzbTh
 cK/vTdr3VvX9OW09hgsPqI6LrZBS/WHpINr6vJAqgsnZSSnLsuvAC90tK6+wWNDaTv9cz3N5lOl
 YF410xopj4si0W9ZrxpstVa+h/v5zfQeTMzTmNHxyUDFEBpAAo0m+/pr/bnmL1YndYH0an2BIsG
 IqOiuNE0gO1g10wnlHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280072

On 10/20/2026 3:44 PM, Atanas Filipov wrote:
> On Tue, Oct 20, 2026 at 09:12:03AM +0200, Krzysztof Kozlowski wrote:
>> If you only need to solve "last writer" problem, why not fixing the
>> clock framework to accept the votes? Otherwise this should have
>> description why it is an interconnect.

A follow-up on the second part, since the problem turned out to be
more than the last writer.

The last-writer problem between the CAMSS VFEs is now handled in CAMSS
itself, in the direction you and Bryan suggested: each VFE sets a
clk_set_rate_range() floor, and on power off drops it and sets the
lowest rate explicitly, so the clock no longer stays high:

https://lore.kernel.org/all/20261028132403.3505037-1-atanas.filipov@oss.qualcomm.com/

What clock votes cannot express is why I think the camera NoC is an
interconnect:

 - The camera NoC is a bus with several independent masters: the VFE
   write ports, JPEG and OPE. They share it on the way to the MMSS NoC,
   and the camnoc AXI clock sets its throughput.
 - The consumers know their bandwidth, not the NoC rate that serves it.
   Converting one to the other depends on the NoC width, which is a
   property of the bus, not of each consumer.
 - Masters running at the same time load the NoC by the sum of their
   traffic. Clock rate requests can only be aggregated by maximum; a
   sum of rates has no meaning, a sum of bandwidth does.
 - The rest of the camera DMA path, from the MMSS NoC to DDR, is
   already described with interconnects, and CAMSS votes bandwidth on
   it. The camera NoC is its first hop.

The interconnect core already sums the average bandwidth of all
requests. icc-clk currently derives the rate from the aggregated peak
only, so it does not use that sum yet; that is a limitation of the
icc-clk translation, not of describing the camera NoC as an
interconnect. It can be addressed in icc-clk by taking the average
into account together with the bus width.

Is this a valid reason to describe the camera NoC as an interconnect?

--
Best regards,
Atanas
