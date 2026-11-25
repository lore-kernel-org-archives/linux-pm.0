Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795604913;
	b=zmqxOQFBgs8veZHRocJCBprh2a+1iAqtuKhg2eEKc6pEkNhoqOvnci+LhNzH4fWgdTQE
	 nIsYYNImCU9JGj1/mSzcIH0sgof2+9s4FOVZV+pD71t6/bYALZ8dAaFMsc3857sv9dkVT
	 ZCMzYX4SNsk8V1nfdJX9Iooz8aePjgmO6bNoTr3z+2oVGUQEHRFzCcJeOinEwdRYFk1bN
	 dfID12/m2X0iFQsx+k2B3lAfNF8SuFE/Sz6haco0A5DH3z5397h2ywV6EseSy+KDrvPOJ
	 8HHnw27C6nEN+AnlJOCD2uBLvx6qDR0BoxGZsX9r8RiXEpQVVZFdun+RDKdXCsGdmRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604913;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=m7zUToUS1+7RVlBq8lg0DAY2VTgGDQHEGVuEzMquWAQ=;
	b=IUXfYLanSnb1LuDtxKFOwRjHLuNeLD0joBrD5Ye1HykLqlkgZ3HlWbXWexcsCkp/6MkU
	 Akydu/L3FEVoUog+FCRJVl5muY0ggWE4EOjL63vPHp/ULGLOS3TUyUepRnefxVAJFOhC5
	 055IHrhOuAUOM7m/9d0zSIDU9Ve1tWmieLKM+DgWbs93TcsWTI8NLCrqfUOVYZUUeN2xP
	 ycpNRlK8pkjeHJHD7DDZcM/7nGFKRwJjhflDWAAJtgEspneKm+DKBcKy7fw/9Z2q+n7K4
	 1V4n2G3Mfddef24gCI2p0bygsc9C9mUYrXzGi/YoZfiQuHaQsihxRFiuW4uvMPwRdEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nc9uQR+j;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JooTsSeq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2260A2601
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53A2260A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nc9uQR+j;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JooTsSeq
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mTeG4034159
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m7zUToUS1+7RVlBq8lg0DAY2VTgGDQHEGVuEzMquWAQ=; b=nc9uQR+jLwGYfJ+v
	wCrebLA8CUnPykqKns+CQ2yrRQX7mBdPXHCMWPqrppNP4EEqU2xz/ZDxv4GlaaV4
	diSFgLYngeA848CL7VUmP79lf0CGvoFe7HMV9ryXoUlJgFCDYVA+vY5YqMNHvOzp
	AP64yguW96k89HPWqInNVzFmbAczwLCAuNLpnN+AtB/co6g5xKucvRnn7YHP17Tt
	nsxQo16Kb9HnPlxBxSSD/axvQB25PQ9cB8UzYqupv/HjZ1aliLqhuH91v4Qctbk2
	zFH/QuxXH5D6PfcOI6atlTGFW72NTj/SQ4NkYR6bvlOtcKnV3kbeDY4jlT8UZFVN
	H9JRJA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mqbjf0m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:08:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b3fd219d07so4543656a91.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:08:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795604911; cv=none;
        d=google.com; s=arc-20260327;
        b=rII01smHUHwMzoqqWKNWlskOEaO2rBlxLpW6uj7cDUAMjiiWinVTPh6wh6ZrVCxJqG
         r6tnHJ1stOdoDB0AgGzvhkHHatAqx3w6nXhvI4L5ob2JlBf6vJa9bckE/IiLzc+sNkG/
         /YJqEH9HJXB1uSdRF8KRA8uYvnJcXiTjDL/JjLUn1iBSPyWcps6FOj2IOWRgLpVTBmCz
         lsIKgUKLcLR8Sphc7R4tFbUbTitdj+THWwqHXHNI81e83QXXqK7z+SgGxMm/oOd4BYOf
         83E7hO8huOUYpE3OoiPxkljovV1vLCkgntMxR3iDEatiYjPDK1ggm6M8bvbTV7R6IkLa
         rnCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m7zUToUS1+7RVlBq8lg0DAY2VTgGDQHEGVuEzMquWAQ=;
        fh=Fh9yowDMkdlbo+Y2dmA8V5xTnRF/CInSUBhiFpYD5So=;
        b=cRwCC0j7ALrT8YisMNb9m2oyBmCQGQjVPk77o3iKsZvExh8hdBnHfVSnrZ6IYJpXQS
         +BV1mQMrDvTfiBll9VImsjTruAr/x3p6kX0eyM4gL2Nfb2vt43ACmb8/YpOY+321F7PI
         SOIrCFFPsTfdQxXwgmidXOZKALOccyVeaa1QmpnJ0dJ6Fikg7BljXqlOyTKKKZpzqqUT
         2s/aqqQOyfDzycH3e+T5GZ7eVurze9kOircK2hdS2eRHo4DLt1m4FOK9K/8GqwfxFB6U
         kyeAdH5anr2NF1UDonPHIr8LijW8JxkUWnHWhN9CNFxCnSrBwDeu49FKoorcG54LZszI
         fOKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795604911; x=1796209711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m7zUToUS1+7RVlBq8lg0DAY2VTgGDQHEGVuEzMquWAQ=;
        b=JooTsSeq2RR1X9kQ7o0BsZFsA8NkAkFKzubTfUrfxs0AoHK0J6gRp/ranL0IYd4DTh
         qTFPTwolI/JQcnvGSgmo+MEX93AyyL2/zTlaOKAMWqGXXu/OU/+e+Nml21uA+/7i/TW3
         AdMpSpQ6HS+75nLtv4n1XMi0n4knpbPsOUxLp7zi+/cFhxR+qTBbpB5FWeoW/wz+mo1E
         L/TIjfPa4lOEIjrqRusrw/DGKvaaCaUSlWcHhH60n6vEOlahEwY4nM7VlyNTUMmgjtSb
         bJhUa4rVDCDmrO92JSSelxDCxWetV8Y/S+s0qvhkkRctw9hA8CuSIPoGQoLr5wa4JDyS
         nBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604911; x=1796209711;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m7zUToUS1+7RVlBq8lg0DAY2VTgGDQHEGVuEzMquWAQ=;
        b=DWQyFu8rP3FWE1xfaDNX89wvlqBlCAmwTv8s6mDyRH4fi+EZsTxLceHYMDiJTaUiHt
         IbtqLsw+0S7fFRTF0V+hGOq0V2xgdwdyYY0F2v91B4KxzbIM7o6qawR+RZyLFAeSOOXM
         roIoESbRyzDGe91F/jumfkdkjuACOZhsMFqa19Y2/+W8XcpSLOsXkdPJmIEmU157Gu+M
         kwave2oKgDGrkalrG6bXon3FK36e2B9HmDynAdlhevOjdfeRkCmW0HBGZbzAbAQvAo9J
         38QkYrbxkl+wQGo0CV/1OT04IagP9fg5qFhJiUvGLm6VfaLaDYneBUkoele5l6NL+otS
         y10g==
X-Forwarded-Encrypted: i=1; AL+hErGendGypR14+tXlfjUv/pv8drY83Az8N8JPXGilt2fbxprpZM10bPfWudnuwCkRzcepN/5PDhxY+Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9dJnA1S/yjdFl4YzSNJALw6eAVoxCPnnxpDaG40/nv7CFo0wjm
	VIVLzwvfC8PiN/nZzvOqGojVtvdV9kkVNS4sOwR1l1Rj0wLvs9yHdI+TW5vlusqV0ID41soJpGY
	XwQlfO0CjoEDjnspINTsaKYRiqPllttrdPyKICry7IouMDWBUfS0nZJ0v6nvYgwPYTpt7MKizYP
	ncTVaZuw1PktpERDMjtsiEl5Kuca5QmSkfxbBL
X-Gm-Gg: AZFdTZfDo/Brqekxl1o0jGTMzRaNnSSyikGnOuj3x9M9MTPDpfhKPbBHT8bqFS1w1YE
	MI2+rPQHgIwxG+UywMxlFcH5xpRUJyruXdUJaRyM5DI868KY0sohaaHNAyR4ibzGidBe1aakGsh
	oTtMOP0yNnXzTqIKrHOL20a4ncDMweBXS0HQtUm1a+viIAawIRO2PtPk97bA==
X-Received: by 2002:a17:90a:c10e:b0:3a8:13d6:f740 with SMTP id 98e67ed59e1d1-3b41c911c91mr17608609a91.22.1795604910726;
        Wed, 25 Nov 2026 03:08:30 -0800 (PST)
X-Received: by 2002:a17:90a:c10e:b0:3a8:13d6:f740 with SMTP id
 98e67ed59e1d1-3b41c911c91mr17608576a91.22.1795604910256; Wed, 25 Nov 2026
 03:08:30 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795029012.git.geert+renesas@glider.be> <16bd6b25711f0e5a4a8ff7484ad3acba83a2a2fb.1795029012.git.geert+renesas@glider.be>
In-Reply-To: <16bd6b25711f0e5a4a8ff7484ad3acba83a2a2fb.1795029012.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 12:08:17 +0100
X-Gm-Features: Aa3M54pwdhQzxCyuIzV30L5QTtG5r_OlDFzkU_dedYyzSv3GvUcS-vx6Qv1tWoA
Message-ID: <CAPx+jO9F6MkwODVi10HkGNYCTJHG_0vc8Bc3FMs4go2q9+=_JA@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] pmdomain: Make genpd_get_from_provider() return -EPROBE_DEFER
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Paul Elder <paul.elder+renesas@ideasonboard.com>,
        =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NCBTYWx0ZWRfXy1kggSKvfxdk
 h+Zo5uKXRoiBmx/2wZfQiaKvPrtqtPC4dHY6cJLiYZx4CRE1BGv8EdRTa9h77JMA4qry8aW/FFZ
 WDuNwtEsmplURwFjL0Kuv2eJil/1mb0=
X-Authority-Analysis: v=2.4 cv=Bb9NQbt2 c=1 sm=1 tr=0 ts=6b06c1af cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=LDBv8-xUAAAA:8 a=wQiWHD2DouBedGx1vnwA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=DZeXCJrVpAJBw65Qk4Ds:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NCBTYWx0ZWRfX8zIuYrzqnD+0
 Dlf77DFxUCrcFpNsRfsQaMNQmTl5f7gdItRcLoXYVJ7eLfyZHfORCj+H+kYizuUfn4bRMVJKUpZ
 ncJHtC92tlAleKL7CsW0j+qfrq6WRMfot07xlThlmnwTDeBODgYevHUHjm4/JVyazcrDSo94sTS
 gj4exC5mhCzj+xk5vBhv3sOmK92aNA/9KOICnX6OIC888+2QKoznK2GYMNBR+a1d+7ThCuWR6jp
 YUrmBF4vUCutUwQGJtkxFe5SsZBo8i1jtQZVz36Xg0IbyDAmyiKlPB5IzlmENWG8E2qzgHL6jFY
 GnlwGbOqMxWLbVWsH/mWxcxTGiWkMk8Gyq1hhaekSwaKHtsClzW35PHh+2Vo1njOQJ2rlF068dS
 6b34Ry3iF5SkhhL+pTdflNcv5fV6V243COoXF3gZUzlaHApcjoCKuZz3IXgGJ3wOLircGf1Hu6Y
 q0oR5NYqeVh47hmFVAA==
X-Proofpoint-ORIG-GUID: VuAP4nAY-uxg_uwrRvn5qrmpjkeu4BRH
X-Proofpoint-GUID: VuAP4nAY-uxg_uwrRvn5qrmpjkeu4BRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250044

On Wed, Nov 18, 2026 at 8:46=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Unlike provider-based look-up functions in other subsystems[1],
> genpd_get_from_provider() returns -ENOENT instead of -EPROBE_DEFER when
> the provider is not found, thus not supporting probe deferral.
> Currently this is worked around in of_genpd_add_subdomain() by remapping
> -ENOENT[2]; other callsites don't care about the actual error code.

of_genpd_add_subdomain() isn't the only caller of
genpd_get_from_provider(), hence this would change other behaviours
too.

In particular of_genpd_add_child_ids() could suddenly start returning
-EPROBE_DEFER, which seems reasonable to me. My point is, please
extend the commit message so this gets clarified.

Otherwise, the code looks good to me.

Kind regards
Uffe

>
> Fix this for all current and future callers by returning -EPROBE_DEFER
> instead, and drop the no longer needed remapping code.
>
> [1] of_clk_get_hw_from_clkspec(), __fwnode_reset_control_get()),
> [2] Commit 18027d6f392ee8d8 ("PM: domains: Make of_genpd_add_subdomain()
>     return -EPROBE_DEFER").
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> v5:
>   - Add Tested-by,
>   - Clarify that all other callsites should be fine.
>
> v4:
>   - New.
> ---
>  drivers/pmdomain/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index ee8075e90852e738..c242807f62579e5b 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3021,7 +3021,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>  static struct generic_pm_domain *genpd_get_from_provider(
>                                         const struct of_phandle_args *gen=
pdspec)
>  {
> -       struct generic_pm_domain *genpd =3D ERR_PTR(-ENOENT);
> +       struct generic_pm_domain *genpd =3D ERR_PTR(-EPROBE_DEFER);
>         struct of_genpd_provider *provider;
>
>         if (!genpdspec)
> @@ -3276,7 +3276,7 @@ int of_genpd_add_subdomain(const struct of_phandle_=
args *parent_spec,
>  out:
>         mutex_unlock(&gpd_list_lock);
>
> -       return ret =3D=3D -ENOENT ? -EPROBE_DEFER : ret;
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
>
> --
> 2.43.0
>
