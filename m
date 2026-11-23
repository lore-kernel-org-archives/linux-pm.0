Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795450876;
	b=Em7J74YiLXFh4VgYqRtK4oaoS2vdThjDE9ZI8SGLUIp8neyVxA//aj9moPZ5Ivz84vcf
	 gFOe/DlMqHtVjQ4fWyMMSAkqbaGL9xxKDsShe4bZoWxafexWRkh/H/Ahurrm/V/AytQW5
	 dl11oBk0m2heGjiI6D3pQA1Sh71nDCaUb1WHIjQ78xEBJGvkOF/rXZ5XYQKPgpqUxFhE8
	 q3b2gfYwAjT8OttUROF66+FBZxwJ2JrdkiNEIDqhcJByvWs86VbVovS/4NPRZGpeux/CL
	 U+nAOI0ZwvILsxleHd1elyZGCVaTFlvBM51IQln4B98iAy6eDrV4EdgKVzSFp05IgQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450876;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pk67/hXS9CWh4vlTcztHypEGoxMFfpG8vfbm7E4XmBY=;
	b=EZBYC32vbcnFOi2y+YJzkiwAyXoZ/YRvLE6m4enf1hljg/CqKbyIoyVqABVRtQQk0gSE
	 0NMsEOEQP01UizW7FqLUpqt4Vw9LtFD224tgMdUeePw3PZoRc61qOSqTCpiBDDP6Q1NcM
	 e6Wn4ES7qluS3xHZQ8dkCirl55EQM6KuX6BMLfo0z+VoVatMKyYRSjYww/UgnuuMtj4FX
	 ZyJo/ZkUq1yLkO384Htp3E3jqiHIbPLdwG6fWl5f+MXG5fYkYrQzbA4jHTJkPj8wKW5bf
	 coEtgOhKlVi9F6ZfuKUww16hxjTLKlTFB2kWwpJSEj82f+Cxd0NGT5IsNYcjcPUDDOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SUNHin0O;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A1zHvwHu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E6606A321
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 16:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A0E6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SUNHin0O;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A1zHvwHu
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGGjR53025211
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 16:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pk67/hXS9CWh4vlTcztHypEGoxMFfpG8vfbm7E4XmBY=; b=SUNHin0OhRr3bhDm
	CtAfmREiUshcu9bxq7PMGoMcyYoE03SfrDgJ0hqiASjaqsLtV1Jk+mAWywtR4czA
	KjbVxkG3VQjfS/SIxkPyhKpqGcXWkcispE/n8DM5ZKQGHqtrIXBmOW4eEmoDPzOZ
	XSTgJF0cl55LL4iL2Pv3Szag3X3IrqvoWxzvfvISb1sxffxe0WFQtEkLHyPx2GMm
	wzD2BHy0v+CQ1NM1JPKZ8C72CY3+G2+Ht9/2yfD0EZrrX5Ty3HPOdbqGzPFrpqNH
	tpZ6hSMGUHFb7Z/MPEQ8es5Wj1roZsmWcqqbNE8LQvyY90Ahv96yLSjB0wIPxgTk
	eOGPBQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1pabj1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 16:21:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdaf2073b0cso1511364a12.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 08:21:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795450874; cv=none;
        d=google.com; s=arc-20260327;
        b=mt1eihIQM+Xc7yxrgFioqnYL2Je0gy+GClEAKJAWYkax9bCnoPY6Qil1QqPtxrj+2x
         Ila04ZA+1+sPcEW+RLjvWZjWgoWoukxp8GUUsn3o7tfYu5LYGLr2jmjD2gui3cY8dooC
         5HdzQZ1CK0vmxTO2mM5FOnScLKdMM68Nao/a7jcS/oP/babuVlde/eaCVp7AC40il/7k
         n+sliuvL0qgiqEB9FglrZqAXW8eHWfUiLWvS5slY0OP4psbvEhV0/m0k82bkYpO/857y
         qZjBOAS8AxFV0TQKLEKNWI1sJ8Cd/ZIJxuIcbgq5jL8d0mJrVCxGuapZTE7KcZSwl/YM
         xPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pk67/hXS9CWh4vlTcztHypEGoxMFfpG8vfbm7E4XmBY=;
        fh=D7c22MwNQdMKzF+wVqPC/j1b5v96bKI1ck1P7ndgNh0=;
        b=oTnWVKHZySt1WitHgVQNg2vzUmlg/cwPWiKjjPzabTK6t3G6TFR+RXUGhgfDDLIaTr
         PSZYk1JQ/4QID/amfGOmPuW9tHP36Kq1Kz2XtAi/Gh3i2sZS+Y3d69xm0YYPNXMdNPig
         7/WTQrCF37sUllLdAjqGN0569wF06mWgUPoHbC0MoNnMA70pkVcocULU29yXfPUKa3ku
         7SuLQgchUoG6R2mbSnCLZ8WbSu8SBlJOJha6yY8hWmXYAurwtNSIdpVNdmekY7R5D0Df
         n+jTtsCeb4lGe9SP7YiPen5+BrlUVAauSfZ4KjVSAf61iOED4AFbJc0QQr9I87HWF0rN
         wTZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795450874; x=1796055674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pk67/hXS9CWh4vlTcztHypEGoxMFfpG8vfbm7E4XmBY=;
        b=A1zHvwHu4ho0BioIlPVNcen6by5M+AaLJb76KigsDbRNdWIHWFf1TJjLjd4BliJq0S
         7up/DPRjMjD33DcY/1bM9BJUf0JLWttTbM1uTedLKAsz54rhcN6TaXj82mJaHzFmaE2b
         nxkaVmRjX/d1EH3tptP+qKqpOFHtnMTmwU+C8ZqLxJvxdvb/M9w367ypqDkdWYCHDU8v
         hHD+Cnw9Ivd1P70Q5PfKE37yc84AkTHjxvzUGQVnWUGrFZ/mPzSokB49FrF4EykYqK4v
         HrC3Pkri7BLiPerw9B2GksKphl3BF4/TOc0MhPf9ohLN9pKsyJZJPtTvPcFdXLKMdAhP
         UGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450874; x=1796055674;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pk67/hXS9CWh4vlTcztHypEGoxMFfpG8vfbm7E4XmBY=;
        b=WQ/JXmsz8HWXtaf9382mQ2VIe37lfoM/aEB15uamckt7O/gS4ir/uPRiLcNaZlOget
         GX9Q5Mgtyh2MtKLzhPBn/A5ieCOe6UQTNEB1itK58hM4PnnM7P6uBpqgbyoUKYBnNfex
         8J2FJpip7MS6CP+vAjmSFIlMjun8IJqzKp5ibTJBlR/SL5dzBhFQKgdsKVzHfrgok/GS
         wdZ0GyzNVQhT9jrih31Z3gERUZ8mEHj4so76wLfAILLklU6Qx5CQrOLsuEYJhz6cWIeZ
         kViOouInhWYqgf6Vgb1bytolhWiS/FVrUFILEbr7bcxmf03a7Hxn8JW4i2JLuJjdGHfH
         lAKQ==
X-Forwarded-Encrypted: i=1; AL+hErFL525tj04FfEBlGbHRqct9lParQOhCp7KYZyNHakRBMcPA3GqN3IEQi4WIBPZleGy8ZpU91dlyEA==@vger.kernel.org
X-Gm-Message-State: APuU4Z90oqV+aS5KZRzqpXqGmsPE05SLlCathsFO7POkCYjTthMp7+GG
	Im+z8FTjyyOT1XxAjAWv14FLh02e+wCzBUx6h++q5UERhoc9n3LIuLwD/UUrG/LsLdM4GouLDsM
	2H6sNzWWfCjffaHrialnBQ1ElI54mRjmn2UogGFnUJHMkHeU5uSwwN6uoCbIcvHFNTuPNPqWzn/
	v4yMjL5ahkadrkB1pljMQypMbntDB07fGiZYqx
X-Gm-Gg: AZFdTZfReelh1nnFWs5ZfutRGI4QZ7R7woF+cvX+oXfWS79UUfnTurGrkY3K6fRSzHh
	Z+qJ/JGSH7cUHqcYkqmA+X/T33Q/uweJZeldFGgT3MXQnLhPmayQgw8U8vWwCTli1yNW9fpUDlZ
	juLxH6fgz82nUBb7aMyy6iVu8ABOyYnUeLxBH+tEUL7gEYKKXPhLTPEdXaCGVEK+45Oid3zoFb/
	Q+3bpFq8U54LJc2
X-Received: by 2002:a17:90b:3b49:b0:3ac:b048:fa13 with SMTP id 98e67ed59e1d1-3b41c9beaefmr11525927a91.67.1795450874040;
        Mon, 23 Nov 2026 08:21:14 -0800 (PST)
X-Received: by 2002:a17:90b:3b49:b0:3ac:b048:fa13 with SMTP id
 98e67ed59e1d1-3b41c9beaefmr11525901a91.67.1795450873365; Mon, 23 Nov 2026
 08:21:13 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179259111932.19580.13027750156272888992@gmail.com>
In-Reply-To: <179259111932.19580.13027750156272888992@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 17:21:01 +0100
X-Gm-Features: Aa3M54p5hRWYEEHgjaTJlT9_Lb0ZXa0hS2O8Lw6qo7tyI0uEXYOUPeVJEQxKehY
Message-ID: <CAPx+jO8xT3thJqDfTGNDdEe_EZ7fL5HHP-gjy3uZJtvemmNeyg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: clear states after freeing them
To: Anfernee Cao <anferneemelokc5@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: LmUqILAoE8FlwnJZsV2N4-VcsPGM-3Dl
X-Authority-Analysis: v=2.4 cv=K+O3jCWI c=1 sm=1 tr=0 ts=6b0467fa cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=gKRGjSYNajUN44eR1FMA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2NSBTYWx0ZWRfX+rH6iB4GW1v+
 DnYiWq8K42XMSDZVdGN3cKImCX2XftE3do0PsWBXzpJq4vZ1m1aBZVMJZFaZzrXgEOFx6YawJWI
 RRMArAOV2nru4lRZ7Wcfpuq3R9WacsI=
X-Proofpoint-ORIG-GUID: LmUqILAoE8FlwnJZsV2N4-VcsPGM-3Dl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2NSBTYWx0ZWRfX2anke+QZtvx7
 2Be7Bglnr3XqiPiflTdqeKk4vt2/YMfPuEuxdrmHCjgGGGOX5LbmGp3sKs5joGrdAHM4Y9INan4
 S0QVN2YPY8vbtdn0FNRKMBzSEJ1g9PydgH99NgGpEKRlbeRLZf+j9KwPenUEbHe9kEk/YbIt/Xq
 frDPydbDOTm88EsGeAn6UUMRku9K9jUZa12/OJldBahHkitE2V66ybTgoqZyJeXKEzbDgQnjG0a
 cMY8RAVYjnjkMJW63hXFqSWL/mS/Cy0fg84UdDZpB0ts3+d9YSuUxAg9ONo7erJsn2WFdJ3Vv4U
 lTcxwBPDYfvXGWJIIPDWxfoRblpuXrUhFfWdw08KbCXzJZ5CP1kHuOCzyFZJH31jZRPEA6SxVD1
 XhTzscyrd4qvblTG8WzghVe8IGGzSoIX7qO12VodQajDMBkrsBZvl8TpRUd72ASV5Mf4sret8ec
 MiyFni3YO4Drt8xXbxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230065

On Wed, Oct 21, 2026 at 3:58=E2=80=AFPM Anfernee Cao <anferneemelokc5@gmail=
.com> wrote:
>
> genpd_free_data() frees the genpd power states through the ->free_states(=
)
> callback, but leaves genpd->states and genpd->state_count pointing at the
> freed memory.
>
> Providers that allocate the states themselves hand them over to genpd by
> setting ->free_states().  When they fail after genpd has taken over, they
> still run their own free helper, as psci_pd_init() and the RISC-V SBI idl=
e
> driver do:
>
>     remove_pd:
>             pm_genpd_remove(pd);  /* frees states via ->free_states() */
>     ...
>             dt_idle_pd_free(pd);  /* frees them again */
>
> The second call dereferences the freed states array and frees it again,
> causing a use-after-free and a double free.
>
> Clear genpd->states and genpd->state_count once the states have been
> freed, so that a later free helper becomes a no-op.
>
> This issue was found by manual code inspection.
>
> Fixes: 9d976d6721df ("cpuidle: Factor-out power domain related code from =
PSCI domain driver")
> Cc: stable@vger.kernel.org # v5.18+
> Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 052ec478dfcc..12db69f53aee 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2353,8 +2353,11 @@ static void genpd_free_data(struct generic_pm_doma=
in *genpd)
>                 ida_free(&genpd_ida, genpd->device_id);
>         if (genpd_is_cpu_domain(genpd))
>                 free_cpumask_var(genpd->cpus);
> -       if (genpd->free_states)
> +       if (genpd->free_states) {
>                 genpd->free_states(genpd->states, genpd->state_count);
> +               genpd->states =3D NULL;
> +               genpd->state_count =3D 0;
> +       }
>         kfree(genpd->gd);
>  }
>
> --
> 2.54.0.windows.1
>
