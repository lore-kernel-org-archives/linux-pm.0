Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795620287;
	b=zyaP7WfaSSqVfYvl1abfDesOy3rgCNMMa5IDzRQSyx3hp0LaQVvY/OJUbx9u8N/kAsy9
	 O0dbYzzrR8NL8bOsHyfvYWOI+a2+BHcxFOm4yY+yXtln4GKYbnRmNyNCI6TehBnxCb2bA
	 /EEiUY/4TyfpL0vJUiWpiJ6vPAnbh9FzGK23INUcr2A+02ARo1f0egVvL9v8/GJ7DRKS0
	 R93CRl20Fe09F/W0MlOHZOufLPq31Ci97cWTamJ0/qDJAPg9KHACK5orRZL5Vg3j117MA
	 jkbBYgIxzhbOv9+VicZaKlsfL/9xCkUFYmTenXMI1SbTcMQ3WXNPMXe80c2smxmS6/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620287;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QIYZYd3o/tNv9e79fiRmovS4XRBJcwrqybTUeeJB7F4=;
	b=aBOYzh5avYAT2DFJXLuLt9cmfhDbP9kyr1D3PzyF2kfTsqzjvGyWrPWMOKEcHSJEwXxD
	 4nV/buVjF97s0zko2cR3InHupPvzEMbN1kbWG72ZI5gj10TfFdC0shu6tXZBy/Bjhmd9q
	 o7GP2xoIsfb4itBEqeDBonlhFMkNGflIIX+ESZ3FumViX+8Dca4JXB1rZ73exXiYX7+lB
	 Gu2TPJm+6OFh30Ya7Msw4tattw8H2s4kD6/uEmW/gYShMpwRkGAMYDL9qMaGgi9Um1F7u
	 z94F7sWfXuEpABG/cAmtoo2cCwPeo1CRxiM918o4LATgZ9IW696J9Fg9M5hEWPBoMoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MveGXrNU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Y+/coxbT";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A889606A333
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A889606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MveGXrNU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y+/coxbT
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APELpV93725601
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QIYZYd3o/tNv9e79fiRmovS4XRBJcwrqybTUeeJB7F4=; b=MveGXrNU9rvAmn6V
	xyXMLjH+LeWkmnYw5sO0/5LIzFGhJKO6bnj+DlEI27vePJbVd0hXi74Bktgvxg/7
	qTXu93gmDfo1mniLpECQMDNfQAraAs2gSciu6wtyvKkg5MYR5NR1xIuon3fFcysa
	vweMynCEphOviJ2FslE5q5pFdHKX8Vs7EQnRWvJuSHd11zkB/LMkPjB7+cJb0Jub
	X0GKLuGzzobTNolJ/29eZLg5253HUI1rBQHw6o8FEoIQO4X6XyRIjozhWIYI+OOA
	IDrSIbUznKwH2Byn5AsoGh7SuEsRWGvb4b832YXkS3/gvvFl3idyej/aVE7siMXh
	XdEvLA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61af09h0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:24:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2f08196b148so35034685ad.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 07:24:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795620285; cv=none;
        d=google.com; s=arc-20260327;
        b=qwaIU0VPQSTA66zNQskHmdR1B6BnnM0RTIhQpB9Sba8ecqCvx8Zzf5ySQ6jwSlFAil
         XZYFykp/GCgOB76P7V6Nq0aashzu3Spnw4LOfAFV8Ybg1e1vLD9IdSIz2dg3Eu0DfXuz
         ZnXrNSjJKkDxiILT9vHK05PMyGy/P1UulLwJhWTnIP7WK02/a+LaxBqoiu8+LbJ26cAY
         4JknV5/LaTUvqqz9VOxPQ/dNX8EImGtM+CpjZy3DLgY1C9T7bbLYIpLvGQGAn5HTUCPl
         fhi6tolS97Ex7Fo0gLp883VM/1tntRw4U/PwsngQVP5LZPFG1QcgyB6ef82s5eY/dfwM
         D1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QIYZYd3o/tNv9e79fiRmovS4XRBJcwrqybTUeeJB7F4=;
        fh=0pcTzn9N48zy3aUss0Kf1u0gGdGKOOUbuYOOQUQj/zE=;
        b=sqt8PBpWqj1TfKTAKbSI1JpTAkSJhGi4ErTZMFlnVk3maR7kMtHhsMBoOMx0tuO7/b
         PSrE5PhQVtUqr/bU9xy58I5qdBgzcDK2uAE5a47CpwV01m3gI4KVvkZKYsMJeEz8nNbO
         Vq3Lyf16/8pGehrN2hher8wDzW5xOpnidJeIRSMKBX2kOGC8D3mi+x97aratwhlIYinL
         X6GI3b0nQvMkHDyMUsS1khOB+Adgq9NiuqBR/cVYiqdgjaCmqy9WoQO2HdBj4PekJ6oP
         GdBsipmnMfBsQqgd+T97GFwSeLXXXcDcIdCcyPiW86GYxb+U5gwjhqFY06ZrKOV4kFiQ
         zbsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795620285; x=1796225085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QIYZYd3o/tNv9e79fiRmovS4XRBJcwrqybTUeeJB7F4=;
        b=Y+/coxbTTf86QvmULyqkEetF+xOyp04cBNyBoCd/s6pyn0P/6c4+21HeRW97n2/lSe
         qGLQjUw+F2Cr2ogsBf7IZLBmXXo5VVzyMBLrNB1u82Icgj30lzQQKcF1Rq1M+WJ91wrb
         ++W6HqYag5jYOwaVB19+DEtTKiMCErSJ2njb137OjxOVgF6bQunawDxWPU/zE6lQhZ+9
         66qT9K8pMWDGucNfaBMcaeQMFe7AwWHayu/bXZC8fYYrCCG90LATaBz7pBdqoLlyDRJ9
         W/NgM6YP3NOYqR/8lfVfhND8e+/pTfK8+wRIUlcfIjh0AH6radXSlpb07vYvxJnlnKhr
         PO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620285; x=1796225085;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIYZYd3o/tNv9e79fiRmovS4XRBJcwrqybTUeeJB7F4=;
        b=QqXIlwP02xoXfNtixezOPdcL/KpBAlo5LG84QowhrHgCgrQNWKJkiPDkoJR904GqT+
         HzkA3DeXUJGEJvwMbZBk+0DHpKxgLIxSMnBKf9oXOPABtyM6RTYqRVggqJA5vXuFBy92
         D3ye8OccGPxHdJGl7pIqODQtLv7jmKgh/4n1Cmqgf3pt1FtpVA3p9Yo4cbwMMoK3bvyC
         zGCMn11cPWUVltVxQm/UFxCaDiZqhiqfld8yw+vIFUn7bdl8zzbw2eEDshRL5kgW3x/D
         Y1r+DQd2o/QX80ckGN8TUerM+D85kYCNtGEqSkahKAJy2EZnO32sVdkHLNN1v8jXUTf1
         0zZg==
X-Forwarded-Encrypted: i=1; AL+hErGesWh5US5veh8pDC0S+JFo15Rn68Emunvke/wN8VpQMES248h9ArQAwfYY3IKE0yjahJcssJTlOA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+qEIQ6ookzPfYNE+nRLsWZRzBp0OB2Qml5ZS3z9NmzAIyp9dwC
	eetlq84Z3VoiEvwwpQQn+PcAeaox0Qf/fezjmUVC9+af5PXll6PKj1nBAXC94DU+ZnhqtxqwYnL
	Zlun3ScPk8W51FDoNFaKVGsn+iprwwdmiC4bKpkik7UewekTqvy8m7MzA4KG/AuUnt2VJR9h1cj
	4Wpr98ZfjHptooWEnii6WxKswqc4J177yfhd/p
X-Gm-Gg: AZFdTZdvMQGb+iY5W5XKQ1ZNni9n3iRrQrXS5hShZYP8Y9dgs0AtKfzdRtLabVDD9vX
	lQQbH1DobhEd+a/TKIMDcMb+CBJIZrqLT7DMnUO6fyLqmGOiGNuQoeJl4Z07xCXXFB7r6Jp8W3M
	ofFkLDPPy5l9GpjSWKCB9gWLCRYyRL6CWa2OjiKWxqaQmGRdqw8ehLUkoMBw==
X-Received: by 2002:a17:903:4b07:b0:2ef:de9a:e59 with SMTP id d9443c01a7336-2f03f1a1767mr166368845ad.23.1795620284597;
        Wed, 25 Nov 2026 07:24:44 -0800 (PST)
X-Received: by 2002:a17:903:4b07:b0:2ef:de9a:e59 with SMTP id
 d9443c01a7336-2f03f1a1767mr166368535ad.23.1795620283988; Wed, 25 Nov 2026
 07:24:43 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-04-k3-pm-support-v5-0-42394acdf3e3@kernel.org>
In-Reply-To: <20261118-04-k3-pm-support-v5-0-42394acdf3e3@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 16:24:32 +0100
X-Gm-Features: Aa3M54olEAoYIpHYojNK94sf0JF_SRHhMMcIhjtuJGmTJ5tnlyfF1zWJRLUcNAA
Message-ID: <CAPx+jO-TqhmF=vwSveSQk0ayUKf9M9fSDBYygTx3uTdQ5QHSHw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] PM: spacemit: Add power domain support
To: Yixun Lan <dlan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Icenowy Zheng <uwu@icenowy.me>,
        Iker Pedrosa <ikerpedrosam@gmail.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfX3V6anjdGhuCq
 xdTz5J/fZC/SRYtumy85vc7QmX10GhESKXdsiH2NoIoMGrryLf0Ca3w6hAscQLlGnbr9mXnEeg3
 muEQ3mk7XIX/KzFPuyHvO/QN+ENBtMU=
X-Authority-Analysis: v=2.4 cv=PdhqFShd c=1 sm=1 tr=0 ts=6b06fdbd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8
 a=CDiEhUVfAZlwq9Ebo7kA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: LDu29nkW2p5Tcvpf6qFJvL33ZZj7rm6K
X-Proofpoint-ORIG-GUID: LDu29nkW2p5Tcvpf6qFJvL33ZZj7rm6K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfXydxBOivKeynb
 AA7QwCmrS1grQVmC40a2y5rkhbTyhi/0j7afRwBM2AFWiZ1tLItFVuKVw8T2I5WoAs3OpLecRY2
 NAZ0qRCi3E6NeUV96w7w6lBuOi5ks67ALWUWgDSYEEsN03Wsdkt/wQ7Kle0yPGKb7reKXvk8znd
 HuzmX8Y5anncJUZ+kHRGZhYXzv2AUi05Slcs9qT200cvS0vkUeY9HJAZCxAI9vyu/SeozzGVAqD
 +mea6P1Ka9XIZMESBOh6V7uL11YOU1F7Kb/561UsDwGjmddU8GybirhaTWueEKEPfZpsxf2Zvaa
 OlwECLxaioHKr8O+txNRun+jwRMf/GV5SC5jAxgdmqowwLwXFZLrEbL0uye16I+FMIksL/c5pzE
 FAxrcoaxnzacH/74zmnTOC41NoOxbUG9zWxm/N0tPjcX62fewJWQ2BOv89oweea4536Oos5GWIC
 phG9BRKxiPcOEi2wuKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250061

On Thu, Nov 19, 2026 at 12:13=E2=80=AFAM Yixun Lan <dlan@kernel.org> wrote:
>
> In this series, we try to add a Power Domain driver support for SpacemiT
> K1/K3 SoCs, the driver implement the power-switch functionaly which suppo=
rt
> power on/off, and it's based on Linux Generic PM Domain framework and
> similiar to vendor K1's implementation, but unlike the K3's vendor
> version which is more complicated.
>
>   The DT documentation for Power Domain already exist in below file,
> and APMU already has #power-domain-cells property.
> Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
>
>   The previous DTS patch is obsolete, so I dropped it. For devices requir=
ed
> PM feature, it need to add a "power-domains" property, and should send in
> a separate patch.
>
>   In order to test this series, a prerequisite CCU patches are needed,
> which can be found here [1].
>
> Hi Ulf,
>  Would you be ok to take this version? only minor change updated.
> I think the sudden removal of pmdomain supplier is kind of an
> independent common issue (exist in other platfroms too), I do not
> want to addresse it in this series, see a possible solution in separate
> patch here [2], or Icenowy's preference in comment[3], or whatever
> way to take. Just let me know what you think..

I made a comment on that as well, but I am fine with this as is.
Please make a fix for the unbind/remove problem on top.

The v5 series applied for next, thanks!

Kind
Uffe


>
> Link: https://lore.kernel.org/spacemit/20261008-04-k3-clk-pm-aux-v1-0-837=
2d7307694@kernel.org/ [1]
> Link: https://lore.kernel.org/spacemit/20261112-01-pm-device-link-v1-1-89=
32e0862378@kernel.org/ [2]
> Link: https://lore.kernel.org/spacemit/b7d7ac2eee0e64aa7c267def5c2a8a022c=
7da425.camel@icenowy.me [3]
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
> Changes in v5:
> - drop pm_index
> - fix dev_err() to return error code
> - Link to v4: https://patch.msgid.link/20261112-04-k3-pm-support-v4-0-de3=
931aa5153@kernel.org
>
> Changes in v4:
> - adjust Kconfig help message
> - drop unused include header
> - propagate regmap_read_x() error code
> - simplify spacemit_pm_is_off_state()
> - Link to v3: https://patch.msgid.link/20261108-04-k3-pm-support-v3-0-b9d=
c0857039b@kernel.org
>
> Changes in v3:
> - collect tags
> - rename spacemit_pm_is_off_state()
> - implement a remove() function
> - use proper type in struct spacemit_pm_domain_param
> - refactor struct spacemit_pmu
> - Link to v2: https://patch.msgid.link/20261008-04-k3-pm-support-v2-0-6f7=
78a53dd2d@kernel.org
>
> Changes in v2:
> - convert to auxilary driver
> - no need dt-binding doc, drop it
> - drop dts patch
> - support to build as module
> - set always on for K3 audio pm
> - no global variable for struct spacemit_pmu
> - no force to do power-off in spacemit_pd_power_on()
> - check return value of pm_genpd_init()
> - adjust license header format
> - Link to v1: https://patch.msgid.link/20260918-04-k3-pm-support-v1-0-0ac=
d2b36b96f@kernel.org
>
> ---
> Yixun Lan (2):
>       dt-bindings: power: spacemit: Add power domain controller IDs
>       pmdomain: spacemit: Add power domain driver
>
>  drivers/pmdomain/Kconfig                        |   1 +
>  drivers/pmdomain/Makefile                       |   1 +
>  drivers/pmdomain/spacemit/Kconfig               |  21 ++
>  drivers/pmdomain/spacemit/Makefile              |   1 +
>  drivers/pmdomain/spacemit/spacemit-pm-domains.c | 422 ++++++++++++++++++=
++++++
>  include/dt-bindings/power/spacemit,k1-power.h   |  14 +
>  include/dt-bindings/power/spacemit,k3-power.h   |  12 +
>  7 files changed, 472 insertions(+)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20260909-04-k3-pm-support-0bef40e87fd7
>
> Best regards,
> --
> Yixun Lan <dlan@kernel.org>
>
