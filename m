Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795694671;
	b=upH318YnhLst0W7AOvSGDe0EHjegDxuLecA/Zu0LB1S761PV9XIA7XlHKb2QbjR5url8
	 v/jqRhHDlPj7etNR5B5cJeGye9xz6SVJ7KBeN60885GqUxdm4iR+yHT/g9RVxy7VCYMRq
	 26lPAGPLbU9KB9UHmppkamBVO5SlngQqc+tdGazZA/BkGoYCYoAYb2XnNc0a6qfiO0iWu
	 r55em2NH6R+tC17w9cku2HHkN7WnLJfs2I+M3rJ4Q3KW/4wwbP+eTAXxl0fyZFm5SKL1U
	 Cx4Uv3d/r2/4/zeBOikFB4dekTFBQTgMDVi6IonYGG0+1EcsllQJyAvhlvy/dWLx9vA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795694671;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jC5fbmrjeahgJSQY/yuWAzz2qq3dYpFpTS3cMwzVOs8=;
	b=hLrkkXbdCFuK4GI+OE94YMNbzJCz3jx7KlkYFWeJs0RIf5fzFt4lTrfsyCmggQOyG5gn
	 3dOjQt8C/hH5MB7Ua48YRvKFsrKwHM0K6uzCdFL8ww529synsKtYAxrWH3mSTgLBUSgJX
	 B3i0UMU8FYxyK5pmQWpgDeOOueIkJnWVO0Dz6dkayy9NpgOo4KiqQksX9eJU9p7lWWnzw
	 ipEHCs46/3v4MsBKarrGY5FHxDNENTRfi9iNS8MRoo36aeYjD0T4aij6dF6WTSHQ8lJaA
	 +ZJWzdaIK5B99PkksET54uJvG2zHUd3R7bJBNC2K+1blFW1rKWhPBOcQypUabO1e0ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nb75Bhnk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GaNd2MvI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B844606A332
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 12:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B844606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nb75Bhnk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GaNd2MvI
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVvhY633459
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 12:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jC5fbmrjeahgJSQY/yuWAzz2qq3dYpFpTS3cMwzVOs8=; b=Nb75BhnkD+24lshd
	TN3D1/aSnF7vHIpkHWwHrM1kKC6YkQu6oDHCxehUDM21hbKbjJyKXraJpSLvlXam
	gnP48d6B48IUH8DyGbf9NtPmsHJPfx1s+Xvo5g4i/6YSn7IKpv0RiuFj1u1B9HCJ
	nrsS14m61D4eNFRt/O9DQMyuIHBNkyiU42V3jRVb+6Xe3JU1uiB2RiZqWOkGZ5t3
	rUyoTCQJYk9dWVXIeVjI5rchYL8/hXkY9Ti0nM78XMS0H/uKHppIWpJQhPXEUnny
	GUDcDdJMJSAEmIBUWh+5vuzpXWLnzh/Y4mOkufX6bT7G9X80VxDZf+8DGg53esvd
	P3Nrtg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne0xs6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 12:04:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3adeba76cadso4716153a91.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 04:04:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795694668; cv=none;
        d=google.com; s=arc-20260327;
        b=PR/nDwN972X8/ED8ey4rh71THiV91s/vVk3rxoTeI7Q8eS3Ck/LTOUu/4PmfFisUGx
         6RePcZcbbQ/Nz0fB7Nr+smPiRrQxa2XXfI+X4jgqzJgJe9XhL4D8MBxWtidQ6/BIdVou
         evlfxfHA5zQ8dJrIzsSaR4zMPwcJRXwEqoIz04n4ez8cjD4rb+oSQWnDNvObPsCguFpD
         Jc1IcQShrYqkf5q2l4RK8/xg+kNUHpIUSe8ZWkZvYHwAg8Pkj93DjV57yzYpzyT4pf4d
         q0ZjzCra8UPxAXr5fpKR/Ek7Dk4rtLNSP5E1szRRsd5H9N2FyN4eUPvSMg4DrTazO/t+
         Aa2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jC5fbmrjeahgJSQY/yuWAzz2qq3dYpFpTS3cMwzVOs8=;
        fh=LGQHuCu/tOqpF1gUgaLxmMCuGJX4lTML/pHEbhxBVrg=;
        b=d/D0U1jKzJULU6zbuKm98vvm6q7dAu6eAN2FRgcfCntKow+gnuQ+tOC+JZdkehf7rN
         IXaCcpGpN8Z3oWla+bAmE5DNnldtSrdepSqMeWqDvGMrRDuUPQ1PvtBoi8Iz+ScarDv9
         kD/beu/H7CTF8gRXS4TTqXoVEEAiblx974xUqfUbe6VT7etGR2Clgmn4K9EJQolDckRD
         XYOacJlMVR605Yhv0eFvQSTSLFwP7wOZKy4YO2I7Mqt4HbFEfkBWVddZuSOUH7abbEUP
         1AQ8/objtNIBOF+sNQlRry3WZdQxLAqGq5DoOhOrp9sg0PO++94Rp9nChMDWvcicSZYS
         cE1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795694668; x=1796299468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jC5fbmrjeahgJSQY/yuWAzz2qq3dYpFpTS3cMwzVOs8=;
        b=GaNd2MvIaPG7AmQun4uTXBxkBy7LI3XHtmyJf35B+ZeG4OAxV+v9ESvUk9sTSkOWt2
         Ira1/WbIXEdvbOBd5LCw25+9DONxfO9Uq6aY64SuG73hVCvQa98fOqSUMoBV7nST9HP3
         TDwSsvgPcjvrlySj/YBKZvvIqwuINcR2RVgFt+ItJI3VJvSYh0qftrP4WkH3dgbyklOf
         srUl/1GpVJMbRJxxBf8lsDeYmC7l1JmuXbyUP43uHvZqazM4BDpifA3Hdt9UD3+j81Dd
         8pbAa6QFX8yXukXmFBvAQTbBZ9Bj4bY7+UsG1Go9GXJKFy1Pf5wB+HlQISIau3fIj/FZ
         MFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795694668; x=1796299468;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jC5fbmrjeahgJSQY/yuWAzz2qq3dYpFpTS3cMwzVOs8=;
        b=fdhRWxx6xskxFWkbeN9+rlthXXVlPuG/Gbnn1iNeTx/9rAZKE1jR4rV0T+8sjPfJCg
         jgHzOnS96iV5Gc+JSueOA1FBzQd9Nee0RfwISdH3Qkv6c+eJ+aluPrjg5kvHgZekqOdI
         xlqSfhXt5KPySxTvhBZHWdtVQhQDbhonTWKCoZ/4XsI8kteVrKvvU7vsDIYwFhX4Hxa4
         mzzub3YDAVwIpFtpYqTU1UnqyX/0XhGmyI7B6rI9/17RKwkQVloOwdapk9JfKzLVSF6z
         P/++xCWroCd1DRjz1X/pXtfmrr/7NBu3nMYzZjyshaIfRRZlcAr2VoeIT340yUgqEjCn
         /bZA==
X-Forwarded-Encrypted: i=1; AL+hErFKH2Tr2vXEvHBeYlSKV7HN8LRqPatmhtFBfM6FFPNJOlAIAgKY/g/CzlncwakqkaRjWWWLKw+DIg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9VmFGXuBbtMWOChg6S9exWP3AC9+E9t9FNLIHKVxVDAEei/BOk
	14Cfp8W0dd4b5SqVCPr80RoVa5Gn96G1oVuL4Z+jHp4WX1wKBDmIRcKPbPrSOMPnBt8WuLTho8y
	UaUMbzoJ8DWuJdUxpAzpi+XN0SPrAikmDQUUxMZcUEF4Czh6GvVcL3NmweqCX12lWy5bwXKpULc
	nu+2Y4QLW8wCQBlmF43MgKqqeOesnveHM3F46u
X-Gm-Gg: AZFdTZco0SPjvF5n+EGzG1QLw4JaS/8zeSkllfboC6wFeQzvriHMFVo3rEDwvgBo6Nm
	ms2/LqPNTSaETKHhkcHrP/tivM1Sd7KgoDWxr1Wakq1fFBMhMTElffUmlNEmM91csP4lYFmJxkU
	zq2PZlUToM84ZpXOacQ/nWHsOiGRoKeOTGtT879fhF8MJdW9RU3XeolwfnuQ==
X-Received: by 2002:a17:90b:2f8f:b0:3b0:9bfa:72b1 with SMTP id 98e67ed59e1d1-3b41c942d13mr20572882a91.49.1795694667851;
        Thu, 26 Nov 2026 04:04:27 -0800 (PST)
X-Received: by 2002:a17:90b:2f8f:b0:3b0:9bfa:72b1 with SMTP id
 98e67ed59e1d1-3b41c942d13mr20572850a91.49.1795694667362; Thu, 26 Nov 2026
 04:04:27 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr> <20261123-meson-drm-create-hdmitx-phy-v4-6-3fb94f5534ca@aliel.fr>
In-Reply-To: <20261123-meson-drm-create-hdmitx-phy-v4-6-3fb94f5534ca@aliel.fr>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 13:04:16 +0100
X-Gm-Features: Aa3M54pnB9NhEO6Ylxt6lEzs1c2Wp_th_l5IvL7KXYy5McWsZMXy_VANhdE7X6Q
Message-ID: <CAPx+jO_K+sEwm4CCBUdYz0FzJuYNhKizy4VDpQ=Ystm1aPxbZg@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] pmdomain: amlogic: meson-ee-pwrc: power up
 memories for boot-enabled domains
To: linux-kernel-dev@aliel.fr
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Ulf Hansson <ulfh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b08204d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=zH7TnIvAWWhA1n-d4cAA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0NiBTYWx0ZWRfX3iAhDe7SWwwv
 BcWSUDCXvPDPDFHjgFBN1iC+pvEPifDCMbZRCpDl+5o4ut0EMSTp//UMhRFFhp6DNO00TqNg9OD
 H++ULbdRRor/SVeur9Uzr6HERUSJ6jmORpOR4LHye0CfQrRPIajVrmz4qSHFoDfAI7iraOGSt0t
 ejoyApc38vKGdC2A8fjynvr1/mUMZTw0Aw+0+1NTFjX0/tlsbqcGicmJtKJEkTtvywaeNAgNwXo
 2NwWRyK4uETfSg3YP7dYnwdTeltu4HREGnOGCk4mK4cydfm67eB/+qQHK25SMHL67pojwwnFITM
 lMVzS+GpXpjLo8HHGCHI8J0KQihz4JHjqI4ZSQUrSgy7IaY3lkfyBOaG7sek0XCWAcpCSDqiyy1
 17DNnyMEUFWMUoGHSg/qI/megO49r0DjWcs+bbybdhiQkKHBK01Pof7qne4Yz2gv51y/a16F+Zs
 TN5ERpPoFyG3SYKICsg==
X-Proofpoint-GUID: 6ccTCVmOgK4NoUizAAYNJAWr8Elchtle
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0NiBTYWx0ZWRfX6gxggaEogZbn
 MhAWkSDZyI32f3Kw1gq1fEGzk5iZioYNBEyQchWlI8zywRpURKEbdG1MnogIASBXOqYhigASCGc
 SH4YH1j3TSxyzo0ihc2rMBhGrI5NbCs=
X-Proofpoint-ORIG-GUID: 6ccTCVmOgK4NoUizAAYNJAWr8Elchtle
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260046

On Mon, Nov 23, 2026 at 8:38=E2=80=AFPM Ronald Claveau via B4 Relay
<devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
>
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>
> When a power domain is found already powered on at probe time (typically
> the VPU domain left enabled by the bootloader), the driver registers the
> genpd in the ON state with GENPD_FLAG_ALWAYS_ON and never calls
> meson_ee_pwrc_on(). As a result, the memory power-down bits of the domain
> are not touched.
>
> pwrc_ee_is_powered_off() only checks the top-level sleep bit, so a
> bootloader that enabled the VPU without waking every memory block
> leaves those memories powered down, and nothing in the genpd framework
> will wake them since pm_runtime_resume_and_get() is a no-op for an
> always-on domain.
>
> This is a preparatory change: a following patch drops the explicit
> HHI_MEM_PD_REG0 write from the meson_dw_hdmi driver, which relies on the
> power domain to power the HDMITX memory.

A question, is the target to drop the GENPD_FLAG_ALWAYS_ON bit for
these PM domains, once the consumer drivers have received proper
support for runtime PM?

In any case, this looks good to me! Do you want me to apply this via
my pmdomain tree?

Kind regards
Uffe

>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>  drivers/pmdomain/amlogic/meson-ee-pwrc.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/=
amlogic/meson-ee-pwrc.c
> index 338f70d77bf0..b3ae5cd7bea8 100644
> --- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> @@ -392,11 +392,21 @@ static int meson_ee_pwrc_off(struct generic_pm_doma=
in *domain)
>         return 0;
>  }
>
> +static void meson_ee_pwrc_mem_power_up(struct meson_ee_pwrc_domain *dom)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < dom->desc.mem_pd_count; i++)
> +               regmap_update_bits(dom->pwrc->regmap_hhi,
> +                                  dom->desc.mem_pd[i].reg,
> +                                  dom->desc.mem_pd[i].mask, 0);
> +}
> +
>  static int meson_ee_pwrc_on(struct generic_pm_domain *domain)
>  {
>         struct meson_ee_pwrc_domain *pwrc_domain =3D
>                 container_of(domain, struct meson_ee_pwrc_domain, base);
> -       int i, ret;
> +       int ret;
>
>         if (pwrc_domain->desc.top_pd)
>                 regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
> @@ -404,10 +414,7 @@ static int meson_ee_pwrc_on(struct generic_pm_domain=
 *domain)
>                                    pwrc_domain->desc.top_pd->sleep_mask, =
0);
>         udelay(20);
>
> -       for (i =3D 0 ; i < pwrc_domain->desc.mem_pd_count ; ++i)
> -               regmap_update_bits(pwrc_domain->pwrc->regmap_hhi,
> -                                  pwrc_domain->desc.mem_pd[i].reg,
> -                                  pwrc_domain->desc.mem_pd[i].mask, 0);
> +       meson_ee_pwrc_mem_power_up(pwrc_domain);
>
>         udelay(20);
>
> @@ -478,6 +485,8 @@ static int meson_ee_pwrc_init_domain(struct platform_=
device *pdev,
>           * prepare/enable counters won't be in sync.
>           */
>         if (dom->num_clks && dom->desc.is_powered_off && !dom->desc.is_po=
wered_off(dom)) {
> +               meson_ee_pwrc_mem_power_up(dom);
> +
>                 ret =3D clk_bulk_prepare_enable(dom->num_clks, dom->clks)=
;
>                 if (ret)
>                         return ret;
>
> --
> 2.56.1
>
>
