Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795445098;
	b=kMLSybephmW6wbilyfsxwyirN9xSS7gjV19RuOKwn6xZLXcFegN+6iKVHW17jaV8RNAh
	 GXtBvxjTIqYAqhvStxXbkDwBexUT+WgjbBOCsLn8vCi8vWsCLKeY+fOq3buXpMX0wzNVx
	 V48EAwgVnrCpESpVWWlKB3YnfpudCh779mN87AhyZmR7Ene1rCRaUMpm/DX6y7dY1zL8i
	 724tZdS1la1mtXZ0Y0kkeQaKDrl/ZAl3R+HFCUZ6eVtM/u2rGpjUf8jTZivwCKWvjeywR
	 ooblBdicxXbn/nhI3ty24m6/FAY9DxznfOMAXHTY3apvALFLSXrh4FPz0qpEbZV3FPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445098;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/d3C83PDhTdKS4Gzi1sKn6/sMS00aaFlTGMatqgMHxw=;
	b=Ha7v+mnN8Jqan4TW4agj6W6RiSOhB/eOkN6YjLeAcgjKfLfeTEdkiW+6MppzzMd8V3kF
	 ZsxHZyPxLR9WVm3Lh+WrK2llWR1fGcJse5Rs6x2YPUVlXMgYrTqaOBOyKgqFxkCipmHmy
	 NSM5Dlp+g/iWe7cFI6g5Hj6CFI+uD2enkd/yMhPMec81XcGPE7ZIZJtWLH34cIM592Xlx
	 3qtGF/e2o/wF9VjKKF0d03IlNigd99Jk7wIWi4ywkAPA/5Q7YOo9HQ2pFF/CbyJJPTfo7
	 yCgUdSe5dbhSp/csCBxllKgVleD4E3BRaQUP6Dqa343G6fLxZx+QKJQZMWv9BW5FpTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eaZOWP70;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IdaadmqP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C469606A31E
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C469606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eaZOWP70;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IdaadmqP
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDKvXm2086005
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/d3C83PDhTdKS4Gzi1sKn6/sMS00aaFlTGMatqgMHxw=; b=eaZOWP70t09Rj07+
	cPJieXBnlKsehB+GrJAydZDT4+PLIYK5pwuW2r5gNJH0Ojd7pEgMs9r1m7UJdBwM
	7zQKYMmWL5kxVdZlZToJgb7EbSrJo+bICo+4pzanjkiC32c6sBdLCP0QpHDvY6o7
	2N3LRchjol5Kcyj9VoiTImB5GCC9sG44+izkryoUavpx5ETRmQ8hsqXj0PFeoFPE
	VVs3eVVE4trvEH/2pNWN68ptXYzHit7ybHQ9WjKMfQry0Hl+hcfvNyem1wBUiSP8
	j+93DPws1QuTtVdpd1VoOT/++TZwI6m4sUIepZrJmTbemGkiwsq21zFG4MnOuAvU
	ZL8I+w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy01vac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 14:44:56 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b8cef34b43so3690019b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 06:44:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795445095; cv=none;
        d=google.com; s=arc-20260327;
        b=iXrckh4WY3iO1+lBSgRpOv7Cl7+n5FzqVOZORg7tklC99fw2cQEnlpKIwPgbqeKeS4
         YHMgZkQ7OPmr8fUDZnZYOln/FIP7/Ix5g8S1BaNYqvvr1IDFq8Gr8C4jsqrXF8L7SmeR
         SFab0BE5FOZ8j5HS28eOIDC+/NOWxAzfKK0V0QvSTpH5putjacIEh45gHO+p1FV2inp5
         cs62qp/+AGTHhKLrzVGLmsQ31gdcZL4BpBs3bSnPlHe2rD2nBtHKxmQZc6fsPerggHwe
         YNWgv36KiJQmHeJxuRiC9xQxd366b54UuVkwlg6/ONZyidkdgahYSIm85CZC8Zz5fGmU
         oOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/d3C83PDhTdKS4Gzi1sKn6/sMS00aaFlTGMatqgMHxw=;
        fh=XHb/sPTNUi6TUmaUm6GjpxcGwDSodkoWHWQAuM8m7W0=;
        b=I/rS/dQp34a11cZj/B1LUh8wZFFBp9p5O5SFvR1Vl57SKGARe0VjQpgBn6thA9lLD3
         gdtdd5xiRH17x/Z9lUe2jHK0EJlSiQqSPHDJ4dSbQk4pfdbaLOyUBrxBoc9upqcgWFZB
         CXsc3sGDxqf1ILcPloiK0A5pn96zUf6Q5vDt+Hr0LbUIbVgWii0Jp13OWyt3qj5Eq2tk
         2hlQvf0MHJdFaUbF3APnjgcUEP91aCvG9WgtYSHmvp5y6ic8T1xfpun8tj02aNhSQdd9
         sn43d74Q/+iijhI7bEaOIkmjT8d3ZF5EVzgBhbZsOllxN6a8eK1Nw0YYwyLANm5SA6aq
         1INA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795445095; x=1796049895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/d3C83PDhTdKS4Gzi1sKn6/sMS00aaFlTGMatqgMHxw=;
        b=IdaadmqPxlrWInEksHGTbMHQw+6cBlh1Ikp0dHsSCrliSqatwldTV7brzaR61dmqKg
         iTsH0WcKNbfqHa9/RMhyk5JAvXhN26AKkI2aCRXGSHTXTAXnQCAaKv4wwvY5zyZYQH9M
         3Av+Dlg6ItpjDuBdmcatiEj2bxGjQUqzCedAxmsC/PBPjBkB+JCg/Nt9MAlg37HYym2P
         6bz9XGYBnwEiPJ2b2lFsi/m1C3VcxkoLdxrgb3vAgBrfPEKfDDKMDdyUZaN9altdouBu
         IOeCGzmX0UIvlwVKLU2GVkdYOhfiDPj1tNsAiv7CoYOMzBgbM/LIg29fUU0Eh52aA64L
         NUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445095; x=1796049895;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/d3C83PDhTdKS4Gzi1sKn6/sMS00aaFlTGMatqgMHxw=;
        b=u5aIWZeVVWp93cCvgwYR6Qy9uqQ2pv450PfttuhVEH2AlOlEq9LrxRQYE2rHxzhAFH
         XZACVtdSbsy63vci7AVRzUqLAJSVuSvZFv8BW9zXYl8gF2MD4JlhKQ0FGstBQJ5i6rUF
         42aTE+JwuZmuB6+ZwaxAE8WR7Y6cg2CG4ohlMUbHsdklpUN4OsNyuzlfnj7Qy16X/e4k
         PDU8BeAFjubfaRyoynWeR5wovIEiHNF+MhZbYB6H1olDj52nUK3aj1JOEqhnJAAUQr/P
         DkJmkxNKQCPFm/uyFeVn9+P/CR3nUXSAi3wjJs8LJ95MAQi1KiN3BZxaAQDTiRlvVHU7
         DZ1w==
X-Forwarded-Encrypted: i=1; AL+hErFeL6ZbHOSuhtLGYu87Cqfl6m0t+DhLjB1z5CpQPaWMN6zIlAv0vFna2Za+Qy8VcjUWfgO9HPL7CQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+2hshE0JG+BCA3T0WOzuHyFunZw5UGQBilXQUlHmc2mPK6hDzi
	YnTuWUIIAcOr30x6TL5Q/lkhQmiFy92z6KgvzE0x+s3ycNxpZpnntr/XXHMX/SePahBUZK/G/gQ
	5ywOrURUIoSHZwIM5yUJ2dd0g5QQh14xWg52HJJ+7x9apd+md9OHGBxRDWSCUOXc2a2z39F4qxt
	r/EkW30kb7MSjazKhHPWhnQHAy9dWhmDfdw00l
X-Gm-Gg: AZFdTZfVTrOU9oij5v+DiswneS+84Ted8kY8qOGf//w5oWRSVRhnilrwQvvQezsCAic
	qfMdi+oP9OqSpdZxeK7IMQVxiQnxpK3OdKVlYN+s8ORUnIw3LWcuYD4E4YeAnklSSrJCRWqt4tj
	Vj/6KrHrsY5ueZ1SYVpj/8fjHmcra6eW2eCMEYM0U6yPaj0Xxa/eFT9C0UrFKzchEnVZP0Ws7p/
	oKJ0rVA2JspnRtm
X-Received: by 2002:a05:6a00:18a0:b0:899:268e:c848 with SMTP id d2e1a72fcca58-8c87cc450e4mr9837960b3a.48.1795445095403;
        Mon, 23 Nov 2026 06:44:55 -0800 (PST)
X-Received: by 2002:a05:6a00:18a0:b0:899:268e:c848 with SMTP id
 d2e1a72fcca58-8c87cc450e4mr9837944b3a.48.1795445094856; Mon, 23 Nov 2026
 06:44:54 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-s2idle_state-v2-0-ad604182e7e7@oss.qualcomm.com>
 <20261113-s2idle_state-v2-1-ad604182e7e7@oss.qualcomm.com>
 <20261116-icy-free-lionfish-c3eed8@quoll> <d3060950-04ea-4f9b-b160-0e068946e623@oss.qualcomm.com>
 <20261123-humble-native-ibex-7d2f72@quoll>
In-Reply-To: <20261123-humble-native-ibex-7d2f72@quoll>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 15:44:43 +0100
X-Gm-Features: Aa3M54pEpZ40tQjszZMv2Cjc9ZKJszGaoEabHp-a4xi-MEaol4PsN--f8rv57Hc
Message-ID: <CAPx+jO-e337v234_wF5QKDf5YJaEZE1-+_Mo5=Y9BfwuG+29_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: domain-idle-state: Add system-state
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Maulik Shah <maulik.shah@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1OCBTYWx0ZWRfX9yWG32Cc0KVS
 tfAFJC8HmNzQJrlgVmL6SyW20k+1ZJ0tyYXUFRw78QiklhBBxSgOb1jf+O16lS6wjeb6Qz0TdTM
 fdF5M6SrEv03c/uCnZGVADpucwhsJB3bDFcdRd7J1QQD2G0QXdZ+/7JuojpltunDXkDkMTNORpO
 YXsY1MvkBnNd/w/HPcsLvUWgA6isNvo76LCJsg1lPc/rrpi8bvKlpMhkhNF89wWLbC30KXR/aRr
 zL2ORWEO/6OyWQD2iJbF56nGEW1haOgEBS3T1Tpv7e361dGQ+6dB38AC2fNiUBStJpbIFstyms4
 QmHo3r/GlQ5HWH0eJwuq+Ki0ImzdS0KWt/JwbeZwITpwJdvjgzytTjk6+4BVeV8duewXW2C0MLC
 8G9W6m3uuZDyLiVAM8PWiZv3m5TxmrbDSx/vgmqcduX7SWjqSCyTrBsWmrtraz6b7TQo07APtEr
 Rxf+AjJKaisauTFjHjA==
X-Proofpoint-ORIG-GUID: H3i4O2aJwGToYz_txovLKyxRC6l2EaW6
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b045168 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=I1gXTs31tpYBTtf-1f4A:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: H3i4O2aJwGToYz_txovLKyxRC6l2EaW6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1OCBTYWx0ZWRfX6Q+eXtePg6F9
 AQ5ECXGofdmyTutUb28OxP1DpCB4An+iEWTKVdkzClrHVvakiulGi+Tdx/Az4R76MXQYeLUSBiG
 dTYSjAoYoN1Nom12b5U8zeRgpOFg0W8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230058

On Mon, Nov 23, 2026 at 9:20=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Nov 17, 2026 at 10:34:52AM +0530, Maulik Shah wrote:
> >
> >
> > On 16-11-2026 17:28, Krzysztof Kozlowski wrote:
> > > On Fri, Nov 13, 2026 at 10:25:25AM +0530, Maulik Shah wrote:
> > >> Some domain idle states require system-wide coordination and are not
> > >> applicable while the platform is up and running.
> > > You repeated the property description. Say something more. Why they a=
re
> > > not applicable when platform is running? So if not running, when are
> > > they applicable? Why?
> >
> > On certain platforms CPU subsystem deepest idle state requires co-ordin=
ation with SAIL subsystem
> > such that both must be powered down in coordinated sequence. During wak=
eup SAIL subsystem must
> > be powered up before CPU can resume. The wakeup can take a second or mo=
re.
> >
> > Selecting this state during opportunistic CPU idle can therefore cause =
substantial wakeup delays and
> > repeatedly interrupt SAIL operation whenever the CPUs become idle.
>
> The idle state latency times define that. No need for a new property.

Unfortunately they don't. The extended coordination that is needed in
the FW to reach these states has nothing to do with latency.

We simply can't reach these states unless the entire system becomes
suspended. From the PSCI point of view this can be compared with the
PSCI SYSTEM SUSPEND call, that we use for suspend-to-ram.

If a "system state" would be voted for from cpuidle in runtime and
when using PSCI OSI mode, the FW would always return an error code. In
PSCI PC mode, the FW would typically downgrade the vote and pick a
shallower state.

In regards to ACPI, this can be compared with the S-states.

Please have a look at the discussion [1] I had with Sudeep around this
to get more details.

That said, I will work with Maulik to clarify this. Seems like we
could improve the commit message and the description of the property a
bit more.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20261005-s2idle_state-v1-2-3c402c66f388@oss.qua=
lcomm.com/
