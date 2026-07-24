Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95DD33A00C
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906739; cv=pass; b=mQ2SQ3v6war8XWFDd5OoHivVC3oR/oOajS9K2GcBMM3ZElC/6L09v6lzfTPunup/RMVqeLlIEw2/vvUxZYy74NLlrCG7uwxPJIzWRz6cV1llYiX9FFnSi/JGCos0jmb5nHuXJyk+tj6MVyEIv3a12j8EnQMbXf6N5sj3UeduLLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906739; c=relaxed/simple;
	bh=QIs9ebWB59VSkctkyRudXKVNnzfYEtVnWZoUq7k9g4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCGtWbe5P8ozg75wjAgoArOT046JeXCNd/Z/tM0V4c9ES2hgyHCeRvHta7cFZro78UqZ9csvlP1pLwugzfLvy2UKgb/gEaRQ5uLc9nB/9uWOekPJNK6lq1rQWV+S94qTUDjutNoZAPf6icH4La8XC1DaTeJsytPlQg+DBoBYQeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MAa0q0GA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PpL7uuJN; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MAa0q0GA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PpL7uuJN"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbD8L3487364
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KPCrpQ0VJGnkL8TeDiCE7B+2L9MbbS21BzEsGKWPP/I=; b=MAa0q0GAaRVPzYQf
	YGCgntqUuQsm3Txj5s0FjQeqY356BJS/s2mwbtwwlkNDO9UmVSeYArhsvi445ztB
	3FpAFO5jz66XNmL2q1h1ldc+7pIEl/yGOuYCWsSqU33JfuQxmnG2P1lUWEY6aPoL
	M1DXl7dkQ8rxsjIu2pzMZkhubPLUYVRIMzZdlvE23Ivkaj+szb+gQl0xxTT+SZL1
	t7xTYFhisO7RfSY4pMV1DCnc5zf3h8URctquQbwTC4+EHaYt2T6FMLCtKocQk0HM
	d5KvcoBKaTkR6FRYvfat7L9lM5WoVJ6sQpgW+AqUY6ZII1rjFaJGQxA+eyuJZflp
	SK/plA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa0ccm0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:25:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930f5da3467so85874785a.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784906736; cv=none;
        d=google.com; s=arc-20260327;
        b=cE+hwckBQaPFHnlj0OO4Fmpaol1Hf9bGFJadg6WFa26H/SZh2wqcfm4QzasvqhqI2g
         GellnVO8WNufwG1t3z18f1aQfPqmEV3WVmdmiobFyaZB0Ee6Innhz7WLFGKqdajiN3Cr
         kR75ebVzNTHtqS7vdrFcQ4cJ8uJc4X4Y47ZjfnDBc9Cxs7aS1xvGMDk8bZZp0hRv7Ael
         mbcXy535kXMaPw1iXsInyNt6OQP+tvf1IYGg1eRFJJa5IFyBYlLsTyoNAbTMukzyqtTU
         QdW3QC3WAvx2Yzx+PjIJRp5YgU84k7aA+hyqjIlwtbpjJwUJcguM4TxCmm1Hn/TPNRIK
         hYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KPCrpQ0VJGnkL8TeDiCE7B+2L9MbbS21BzEsGKWPP/I=;
        fh=O9QqjkyUnQZLcOoujQnk+++73Sx/3zIOLWdlDw5JGbg=;
        b=AnXF8ogJ0S0Lu9RRxjL9fzoiVECprmGk0JrLkdXAyRjqMS3+alUMr0ezVmYLFsNWKp
         kTUQoT8ljU4KTuFgX/qQz1UQ5SglNy8uwYuewbpM9bwT3o1P/tbx+9dEN9iEwMLieSlJ
         ZuwIWNR3ZcxGl6Aa8bn9/FFw4NYZ4H0n1aVFT9siEdfGi+nemNhd3E3rd33m4Q1MNtT0
         uMwo6ytJlXiumNSDBeNcSbx/56TSJEsGLSnO3xqjZJTA3lNdh2B7y9hWDSYGWOnDI0AS
         IhozO0BAz7BUgzsf9ZIr8PdNmjEiYMtR689G+ZRbnu0tuNS/2vLBEujMLRjAFYcGJMKO
         p/DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784906736; x=1785511536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KPCrpQ0VJGnkL8TeDiCE7B+2L9MbbS21BzEsGKWPP/I=;
        b=PpL7uuJNswVx4d/h0UffqnysgvV/jDcjvy80HYmTVcDa4ilgcHVWb1+SJ5EUuVi6Qt
         lzX82fY+8uJcUAbm7ph5qVgW/CaMI6gOtg0kACxc9zUZppXB2PUXJkw9ZXdEOKYpZaWu
         wvZmRqcmO6nl6BJ7RYArOTkqrvleK2KPa1h6A4gz22F3JwPE3zOJgaAxh+mTAx9mmlmD
         JqHWpmmxnVPRIs0pkP/dl0kQKnyqk/YQM0O9GV8mmCxHCD5CgZtAW9Ly4wFAGnRlCx+l
         Lam9QQ8AE8CvtQbM6UN88XmDumdU6TzGkFvxCJGUIno8/GwnPS/9gSp4akdEz49gs5Mj
         bb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906736; x=1785511536;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KPCrpQ0VJGnkL8TeDiCE7B+2L9MbbS21BzEsGKWPP/I=;
        b=P1RMBoPAqUPSVez8UXoiOgTFZ6j9qni1v1iWfXj9VjQ+dnXJVGPP+ach1retn5JXyi
         33pLO/cSH8f/vbdPqcHRVDz7LZcu2Fs+RzkjEj3s0f6EYC5PnZKG1Xsxexks3NDwedZM
         hNraxPvr6AM4R19Yy7y3JbQvT1gyTJCeXkjYLg6AMi72Z2RIsrO7ZF93Xv3+46HGj+sY
         YUJNdBcfIUFq57LUSBx1vHveD9NcBGvv+haWIISz6bWgyCgyft0LJYB7HrcdIMf3a0ZV
         bXqqr5wQDdAVuRZeYw4ZsHoVZ735O5wccA+IYVA8jQqsIeuqQ5T6cmT7fUv/n/lkqdPS
         dRvQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVKEh6xho9vXek7dTBLGSsUHeetS1MOeJC5JJWSV3Vzo1p5ULzuEs5LLpUUW9T/io2LoRj+jfK+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YymGOcr6nxNsv/MZbcrsodEbbEX1hBkuXEiWjBmP/Y73h959voB
	A8V0xtiyXcrs2LZJIACCkrP6rD9i7qzJDs8tpkbzHWlMqgA++kmmIZC9LCOu5w9+f+d7j37CqsL
	t0i4ZumJznTWlppUJ09UR8B/cEMtEQ8h2A/jDBFOWVIElbzaTT+VyEwlOurTvsQ2+T/BiTiM3aE
	8FMdCwCZR5cdv1N45C8oEBSZJ8oPDLyHjUJ6Ht84pPPdKq
X-Gm-Gg: AR+sD126APSkSm4iTvnN/6lBpJDirQiYhdp6Q0n/FYgLffE83qoLu/01SUWTrJf+ogR
	878eL2SD7KlberXW0zdM9U4yf/L8Q89COfDtSQ1e2O9pf3AORvRX39xonDtn49wimdFTEnG2iDU
	5RLBc0ERv0tGKUs9E6tdbCAkq6MYQFEFxZSwGghPuzALl9p55L2agejBOLlw==
X-Received: by 2002:a05:620a:3909:b0:930:ea41:771e with SMTP id af79cd13be357-93103852b6fmr821824585a.31.1784906735909;
        Fri, 24 Jul 2026 08:25:35 -0700 (PDT)
X-Received: by 2002:a05:620a:3909:b0:930:ea41:771e with SMTP id
 af79cd13be357-93103852b6fmr821818185a.31.1784906735245; Fri, 24 Jul 2026
 08:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708234614.499613-1-midgy971@gmail.com>
In-Reply-To: <20260708234614.499613-1-midgy971@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:25:23 +0200
X-Gm-Features: AUfX_mwrYV4f6v5r_1WLYjP_DJ5j8CdxwNSs9NXFS9k9uGsEaGAAKztNtVNILsQ
Message-ID: <CAPx+jO8vL4Ne14r+bR3De7riiNVRJK8Djm=b+jTsOscUynHwAA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: rockchip: Add a regulator to the RK3568 NPU
 power domain
To: MidG971 <midgy971@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Chaoyi Chen <chaoyi.chen@rock-chips.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: dc2EhbBG-A1iIthNdL-Q768BX6JEyXkR
X-Proofpoint-GUID: dc2EhbBG-A1iIthNdL-Q768BX6JEyXkR
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a6383f1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=s8YR1HE3AAAA:8
 a=ghsCoqtGgTSC4U4bjT4A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzOCBTYWx0ZWRfX8G51u28VVoHH
 +bIi78zPr8divoj2cZ8l6dd+3AjoVavbyUn0Pvvgg28Ai8efWC8TrwAVRxhcXBES23o+1iNl4SI
 ECMjg1d2LafaQZwf5HBkZyD9cVuQYDBSlzAYpbApHwIZaKNkXjuGVdmKnP7Kl4h0855osn3jB3Z
 IPMeqhwvF1dmvA0k+Qm2aAvwWuqc8cgvf9hK1NgWEekEEE9BVt56WutbC5hF1qmZ16uWpzWPNSf
 mKSBZAHE5uhYG4DkBQkYwTMZUlURkKJfGYZnq3oiIB3bxo6X0JgoVJeE6bk9xbbjHDumjcWiIIk
 hJYXQd4bQvCcK5ScpCfkfpST5w1RVpGO698BCEf8DdFRgXE0IjG3DM7fZygPANQEGfO8L6sutlb
 4OlIdz3Dg6IpJQHfLydjaPmiDgWXQC+fwriJZPj6b84D+zWL0/Bhbc9s509pm5XCsrrIaTGBx3Q
 m+tGzNoxKmFDcL1uk3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzOCBTYWx0ZWRfX5Fv7mfTB8CJv
 ufYLtOj02r688aWDrn1b2x/3LJp+rezc6kz60/63J0XQSL7BeCJ9tK2R2r/WZ02vRf+5VdTdoI1
 hSn8tuJPhTmo7J5hW/GyiEbkxeTwXf4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240138

On Thu, Jul 9, 2026 at 1:43=E2=80=AFAM MidG971 <midgy971@gmail.com> wrote:
>
> From: Midgy BALON <midgy971@gmail.com>
>
> The RK3568 NPU rail (vdd_npu) needs to be enabled before the domain is
> powered on and disabled after it is powered off. Give DOMAIN_RK3568 a
> regulator parameter (like DOMAIN_RK3588 already has) so the NPU domain
> can set need_regulator, letting genpd manage the rail wired up as the
> domain's domain-supply instead of marking it always-on in DT.
>
> Suggested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Signed-off-by: Midgy BALON <midgy971@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> This patch was part of the RFC NPU series [1]; Ulf Hansson and Heiko
> St=C3=BCbner reviewed it there and confirmed it can be applied independen=
tly of
> the rest of the (still-RFC) rocket driver and DT patches, so it is repost=
ed
> standalone. The NPU domain's domain-supply DT wiring follows in a separat=
e
> patch, so this change alone is a no-op at runtime.
>
> Changes since the RFC posting:
> - Move DOMAIN_M_R below the other DOMAIN_M_* macros so they stay
>   alphabetically sorted (Heiko St=C3=BCbner).
>
> [1] https://lore.kernel.org/linux-rockchip/20260613070116.438906-1-midgy9=
71@gmail.com/
>
>  drivers/pmdomain/rockchip/pm-domains.c | 36 ++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 490bbb1d1d8e8..ba66ae7194289 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -204,6 +204,20 @@ struct rockchip_pmu {
>         .active_wakeup =3D wakeup,                        \
>  }
>
> +#define DOMAIN_M_R(_name, pwr, status, req, idle, ack, wakeup, regulator=
)      \
> +{                                                      \
> +       .name =3D _name,                          \
> +       .pwr_w_mask =3D (pwr) << 16,                      \
> +       .pwr_mask =3D (pwr),                              \
> +       .status_mask =3D (status),                        \
> +       .req_w_mask =3D (req) << 16,                      \
> +       .req_mask =3D (req),                              \
> +       .idle_mask =3D (idle),                            \
> +       .ack_mask =3D (ack),                              \
> +       .active_wakeup =3D wakeup,                        \
> +       .need_regulator =3D regulator,                    \
> +}
> +
>  #define DOMAIN_RK3036(_name, req, ack, idle, wakeup)           \
>  {                                                      \
>         .name =3D _name,                          \
> @@ -241,8 +255,8 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)             \
>         DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup,=
 false)
>
> -#define DOMAIN_RK3568(name, pwr, req, wakeup)          \
> -       DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
> +#define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)               \
> +       DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
>
>  #define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, r=
eq, idle, g_mask, wakeup)      \
>         DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status=
, r_offset, req, idle, idle, g_mask, wakeup)
> @@ -1274,15 +1288,15 @@ static const struct rockchip_domain_info rk3562_p=
m_domains[] =3D {
>  };
>
>  static const struct rockchip_domain_info rk3568_pm_domains[] =3D {
> -       [RK3568_PD_NPU]         =3D DOMAIN_RK3568("npu",  BIT(1), BIT(2),=
  false),
> -       [RK3568_PD_GPU]         =3D DOMAIN_RK3568("gpu",  BIT(0), BIT(1),=
  false),
> -       [RK3568_PD_VI]          =3D DOMAIN_RK3568("vi",   BIT(6), BIT(3),=
  false),
> -       [RK3568_PD_VO]          =3D DOMAIN_RK3568("vo",   BIT(7), BIT(4),=
  false),
> -       [RK3568_PD_RGA]         =3D DOMAIN_RK3568("rga",  BIT(5), BIT(5),=
  false),
> -       [RK3568_PD_VPU]         =3D DOMAIN_RK3568("vpu",  BIT(2), BIT(6),=
  false),
> -       [RK3568_PD_RKVDEC]      =3D DOMAIN_RK3568("vdec", BIT(4), BIT(8),=
  false),
> -       [RK3568_PD_RKVENC]      =3D DOMAIN_RK3568("venc", BIT(3), BIT(7),=
  false),
> -       [RK3568_PD_PIPE]        =3D DOMAIN_RK3568("pipe", BIT(8), BIT(11)=
, false),
> +       [RK3568_PD_NPU]         =3D DOMAIN_RK3568("npu",  BIT(1), BIT(2),=
  false, true),
> +       [RK3568_PD_GPU]         =3D DOMAIN_RK3568("gpu",  BIT(0), BIT(1),=
  false, false),
> +       [RK3568_PD_VI]          =3D DOMAIN_RK3568("vi",   BIT(6), BIT(3),=
  false, false),
> +       [RK3568_PD_VO]          =3D DOMAIN_RK3568("vo",   BIT(7), BIT(4),=
  false, false),
> +       [RK3568_PD_RGA]         =3D DOMAIN_RK3568("rga",  BIT(5), BIT(5),=
  false, false),
> +       [RK3568_PD_VPU]         =3D DOMAIN_RK3568("vpu",  BIT(2), BIT(6),=
  false, false),
> +       [RK3568_PD_RKVDEC]      =3D DOMAIN_RK3568("vdec", BIT(4), BIT(8),=
  false, false),
> +       [RK3568_PD_RKVENC]      =3D DOMAIN_RK3568("venc", BIT(3), BIT(7),=
  false, false),
> +       [RK3568_PD_PIPE]        =3D DOMAIN_RK3568("pipe", BIT(8), BIT(11)=
, false, false),
>  };
>
>  static const struct rockchip_domain_info rk3576_pm_domains[] =3D {
> --
> 2.39.5
>
