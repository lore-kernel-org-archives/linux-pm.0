Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794582385;
	b=qCcX4YJBVxT5YGBnYfXw2q+arnG56ZTMf6Dvg7CHSIWkyms+wssgcMS4+rNOk+z7PrxZ
	 qx5FZOgvnuuL9n94Gr4hlyZLdslrnYZ+GGvDDG9vWAcMhJ/F5p49bSKeLHYbftZGJEWNu
	 X0cneWUMSifkWKkbOAnaTxFQY54ar3Xte0gs0+FohijGjxR0vc7y0ImMFdY0nZmr3dDET
	 VlSOaZZzwGLdmSyr2rkGQcRQUmQvSOSQjBX1NOTyK9rQoqgroRfjmGfXkw7dUBhchgBi+
	 /tTpTlv5x7qgJo3KaKubcm7s7KOyzB21NnWl7BA4QiLnMB1fy/gJQ6C2d9zztM676yQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582385;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ckhtKtBkcI8bOjOr1kP05oR2A3mdkH6IC9LeZz9W0+o=;
	b=HAv5NAJ2GE7b6psNx8+WB3T6vEZHDpuZeZhrAivJbpoeOiamx7bXyyCsWcdsa/aRItTJ
	 n6BK+NHMAe20AE30pXEOmF6d0AITged03EP1UPp2QsakVpcwVg91vgaAtZaR1i7celC6N
	 qSUOC0HaeFIq4wG12J+fCgwypdIpZFJjy7dKp3EYcTgH+of9xzEh7rlWsgMjm254sVjrJ
	 x61HFcaO05h2fzSld3gZ/geIv0BBonn9dqxHnoyJKj8gkkisCJKaija1RdtG6dD+xhRmf
	 3PHbAjP68Q0P8f9JQhZmLeRv95blwt2WPdO0mfFukb0jUT14i0EZgwSNlHfxHwbaySg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RarNiep5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="U4Lsip5/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF960A3820
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1BF960A3820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RarNiep5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U4Lsip5/
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCJTsi2796670
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ckhtKtBkcI8bOjOr1kP05oR2A3mdkH6IC9LeZz9W0+o=; b=RarNiep5MUR5lMIT
	8lLqXyMgEs/rw1xbOT+r72pPfKsp3/WHQ5MQYvnqnyLwREwoFc4KVK9mDHQZ0XN+
	WujmmrTE+fWXc4H0FCUAGuTg/85kD1I7q5/PlXJgsibe3iGvvSoVJaF/BuMboRF6
	Idiv2NaPr8qDQ7EuRGBK89XBDEEL5ThPvKmnDoGWtT3ahXi8+a4ZeGZCGBWgpZWQ
	q3kihX++ylhPieuo5j/aXh3v7HzcndGSyeCmL5DQzNzKgL4G4dhiuhTmfiJXDhyE
	Z1R5WD4Wi2HZhjAi/1bgpwhZynggkhN71UJ1cg59Ek+R4PvwCEQCpbs88fDIh8rf
	fbrnYQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvu6supq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:06:23 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-5640a2d9708so1311541b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 07:06:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794582383; cv=none;
        d=google.com; s=arc-20260327;
        b=J0/8jeqaI0yQ/DN9/RgQww9Ws9XiNeKmD91pgJHn0Z9ZOWW5W//v2FeTHGVQIQ2TmH
         Vfqf7+BYFFqBYfusfmWNjkmjbWKOw8xG5GJk2uWID8q1qpRLCEKUrzvng9+d6g1jPy1k
         klq0gvj+C2uRGrdC8KKvspIaMNqiDDHLdaP9wUmWUbulK+bB9OqdLUB0g2PYIO0sKJBs
         t1VfZLiZY0e9eKdoXnzvvyHZiIVLJAqDOSLYdq/iU0hZ96YczNNroBpDjRvQHD1L3IU/
         zIrpudrjr53GpikntHSK7nMM2w8haXAVwahxpfOaP45I0oH3+xr783DpXymnp4Sy2j/8
         JM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ckhtKtBkcI8bOjOr1kP05oR2A3mdkH6IC9LeZz9W0+o=;
        fh=KPcSHha8UEXNNTdpt/KG4y1MGqXKO0syph93jYUEAzs=;
        b=gyhtH54h0IqhjZ5V5uumgbxfb/Xt3d46jzR2mIvLBWuB7IkNrMR7b7TPZLqArjQVqL
         P7oRKWh1AhvNqEDp7WkQ8v/6yfrBQF1aGeg3W6uLQ2fq7Vk9L6qPHOsh8mhqnahv2y+Q
         SoC4+IgMX9YxSGH4BbnDxVFQxmjQhyaK6M+L/Mw2qMy+0LNjsdw8xJmTcd5qFWW1SrhR
         s3dsGvOc5eSwXyxuQ0lyQNIGuWZzJs17Pis4/4mg7GflCE+MPQT8pyd7O8SHnOq4wYHG
         VyXFTA0qkpDAk+KHmG+80WNFvbjwJunjdBbZsq+wwFPN1dHrXAZjb1X+VMA+m/LIUP8Q
         TT0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794582383; x=1795187183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ckhtKtBkcI8bOjOr1kP05oR2A3mdkH6IC9LeZz9W0+o=;
        b=U4Lsip5/z5x0DqpikPpoT8wp0+jt30H2/OwI6A1wDHFpXDSnJdr5OcV7nscoV1XK5P
         AjKXiP+ALVvGtADcrmqiVs4gERyP+kVM+5lj+tnphiDwSdtIH3x9CsMON1XBK7TxiclC
         r84MyQofR3/iNrssTxiBeelQLeZWWZgtb7kIJfTBXxExq+m3Pov3IVhzeqQg8IsSH6xQ
         LYTa0qhuciUp20EPUz29XVlfsojVxun+3v9WB99KXhHpod1I6LESBBhpQfLw/Pm6o7Ra
         Q/On/T60KGkehCu0hTjeO5zoxJjosTDoh9rVGNvj0BwYKV74InRcxE1LmKyz4Oe2poH8
         N+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582383; x=1795187183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckhtKtBkcI8bOjOr1kP05oR2A3mdkH6IC9LeZz9W0+o=;
        b=VvKzhgXWxYybg8IJHBGqPfJA86g+bzvdzqKpLjVpNpCQ7g3VaYeox3C6fNNjucXUH5
         xTW9hK2CRwRvHeWtfTOjM+d7mnW5G+yLbgv4cWXWFoOZWhv0/7c3YONBSuSIDZfCc8OO
         GCm+KtbxSh+nq706bULzN4N7V/113eZ/04ozKkPyjsv1glOGYxFZ1Ther8J5hFzVfiKC
         LH8JZXPEYSf4zzx5FqRziH2iQawvp9AlxrTyBMmvQsC6PAImUPFKyq3cydc60XONkDzs
         rYBttkEn5p7wV+c8l2yzXvjRdpq5M3W9edOwcpw4DU2xykOKqvK8e70T1Us7dgLQT7Sb
         5qmA==
X-Forwarded-Encrypted: i=1; AL+hErEryDSfU12ebQuqOpUjNIduQrjRMYBkUP0qKlsasfXbJ1HVPBo1NRqRdNzaqisJA3+QaGtmuLf1qw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+EOy/Wqt3Epi/OlWq1c7GpbgSlGx4iUxKI3A5+lVL/T8rMWqi9
	acveGF8HWSMr3qQwylzcicEdbsG1yhFbwNVhNGwU79riRPWoPckw76MMreEXWWOEqELiuwtoP5c
	A9ixjhNeaq6+10jrk7jToLkuykK49vbXbxbjBJg0Kj2t2xyh0iHuZWT8JcPTVG9kCavh4MtYFAz
	pbo27x/q4aCNY8EyufJdoXfKR/TfeUZS21b666
X-Gm-Gg: AYBFou2PZvMC+LdDq/w2N5evpog3ockzJ6TUO3lszPLhhaYi94Gcle5Z+Kovgog9fyC
	y04aulPYfJa2eERhrdTsiQ46s9W+Ds6V6diIEp+BOC9XE2ij4+MlD7PSYa8aevANWsuuCupcTQj
	bwz9Ptfg3TFKF+LpT1EhB2PR6zgcIQGYoiP3AmRCLeKLnnIfb2u/aRuvfPDo3ud5ig7Fsf56PcX
	i6a7uudBrjWPtdSDzFR4QuizqlXTGw411yl/tYK7JJZ/OGw9z5RiPYGD3BIyhvylgEq5ksEVPuW
X-Received: by 2002:a05:6808:bc9:b0:53a:6769:c365 with SMTP id 5614622812f47-56e6328866cmr2333720b6e.12.1794582382779;
        Fri, 13 Nov 2026 07:06:22 -0800 (PST)
X-Received: by 2002:a05:6808:bc9:b0:53a:6769:c365 with SMTP id
 5614622812f47-56e6328866cmr2333678b6e.12.1794582382297; Fri, 13 Nov 2026
 07:06:22 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <b47282f1514a9012ac51d0915afb83782c3c0050.1794417398.git.len.brown@intel.com>
 <CAFEp6-0yj-+7uYnj5PCvaP39ruQ=xduBbQgJc7MyakuPLJhmvw@mail.gmail.com>
 <CAJvTdKnnqZJrZ6bgaxsyy6QttGwgh5RL=De9ggV3KhMPDau_BQ@mail.gmail.com>
 <CAFEp6-2sLZkNQqDg7seE0ipZbuve_TZMjgNHV4ubW0Qs80Pyhg@mail.gmail.com> <CAJvTdKmGp6t44CP-smrjbm3aoXeTWvyUUM1Uv1w8UxEo3OSPJw@mail.gmail.com>
In-Reply-To: <CAJvTdKmGp6t44CP-smrjbm3aoXeTWvyUUM1Uv1w8UxEo3OSPJw@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:06:09 +0100
X-Gm-Features: AclHuK9bkZ5reHD91VpKpV7QwREy_Gm5RBl2twDjBGl-eypJtj0BwlEjdoR1eWg
Message-ID: <CAFEp6-3QnYgAwBbscorkXt=rROpt+iNv8R1=t-GdyDpHVL0q0Q@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: pci_generic: Fix erroneous system suspend abort
To: Len Brown <lenb@kernel.org>
Cc: rafael@kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, mhi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2MCBTYWx0ZWRfXwUV07fbLFAIq
 ruCM58D9obdu0z/lWiLmtPjs0B0da1pAvUY7DNabaBj+Psa7h2075k/OEEYXYoyAzvUIJe4CH+p
 5N4g+cHxtV4SV+OFE15XbmQTOBi/W+nTAOrYSFP2RHN/NmpyrC4Ge0BfuOvWvTuX97MtHs237Vk
 bxOMLC5SZZpSHT9ilrocmDsBmGWtWtP0FyBzjxTmZIFKSSqikwjEqfzDfKIdo144owJv6yz/bz5
 Zs9dk7wpfr2MrCJQKNFkR+3iZa5tu645hhizq1YOnsQi5o6wOpyO9HC9RFRlMv1r0bibAB3GWAf
 iQqBBR8h+kPO8Q60kzavDsyi3zU5isy7TdMNqRj70t0qp/JH1epSf06ZZH5H7A9eb5/4KstvXiG
 7lPWfuxY6MANiZVsvsWY6otW1wlsw1UOIKOcWCspxpljI9Bl39r4vO6xLioTDHRTzt62LR+ScjG
 Fn7xjWSQJ9peCjTiUKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2MCBTYWx0ZWRfXy4iXOOvycjRy
 UMp+g9GlvSDE6ntxi6+J3c3vKJazjqzk03YN/ytQ57QnwEqw/qClubFNdq9YrKH/CceNf2wqZlb
 5K0gkFver1+ayxxDilPSp4RHTWyg7GY=
X-Proofpoint-GUID: QmEVn6AdbanddntIudicQbxElML8KR0Y
X-Proofpoint-ORIG-GUID: QmEVn6AdbanddntIudicQbxElML8KR0Y
X-Authority-Analysis: v=2.4 cv=JfcpPkKV c=1 sm=1 tr=0 ts=6af72770 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=qTCYnKY_sxFd4FCAs5QA:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130060

On Fri, Nov 13, 2026 at 3:09=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> > > This 1-line fix should be applied NOW, without waiting for internal
> > > mhi internal or development.
> >
> > Fair enough, but would only ignoring error on -EBUSY would work for
> > you? as this is clearly something which is not relevant for system
> > wide suspend cases.
>
> Although I've seen only -EBUSY, I would turn that around...
> Are there ANY mhi suspend cases that merit aborting system wide suspend?
> If there are, then check for those and explicitly abort system suspension=
.
> (experience shows that these scenarios are quite rare, and it would
> be remarkable if there were such a condition here)

Taking a second look, it seems that we're not propagating the error
from MHI core in mhi_pci_runtime_suspend() and simply return always
-EBUSY instead, making it the only error that is reported anyway.

So your patch is fine as it stands as an immediate fix (along with the
comment). We can then work on a proper long-term solution separately.

>
> > Also would it be possible to add a small inline comment saying we
> > purposely ignore this because of buggy mhi suspend handling.
>
> I agree.  I'll add a comment to clarify.
>
> > With your patch what happens on the system resume path? is the MHI
> > device recovered?
>
> This laptop is generally quite a good suspend-resume regression test bed.
> It does actually have a wireless modem, but AFAIK, the device itself
> is always unused.
>
> $ lspci -nnk | grep -B 2 -A 3 -i mhi
> 08:00.0 Unassigned class [ff00]: Quectel Wireless Solutions Co., Ltd.
> Device [1eac:1007]
> Subsystem: Quectel Wireless Solutions Co., Ltd. Device [1eac:100c]
> Kernel driver in use: mhi-pci-generic
> Kernel modules: mhi_pci_generic
>
> I have over 28,000 suspend resume results on its local drive, dating
> back to Linux-7.2.
> The most recent 3,000 cycles included this one line patch and showed no i=
ssues.
> There were 9 suspend failures on a run of 2,500 suspend cycles run Nov
> 8 - Nov 9.

It would be worth including this result/info in the commit message.

> I've attached the mhi messages, as they'd wrap if I pasted them here.
>
> Twice we see this:
> mhi-pci-generic 0000:08:00.0: Unbalanced pm_runtime_enable!
>
> perhaps a hint?

Thanks, I will look at this.

Regards,
Loic
