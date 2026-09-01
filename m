Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E343E0220
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277579; cv=pass; b=uM5sEoGBuCtEpaMjjugXCdI0I7f3qDXkMClwUbML8o0U53n22JphaRO+uuwwpJMuu6pT6FRNdQMylxypNoJNmUsARz+ECF4laseH+EPzcG5719YFAfrXnQzUpPVNMgJ9gzTykGMRkHeaMdfSZ703l5iC/PxE7zZPDXQ84ETDqQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277579; c=relaxed/simple;
	bh=bvjz9RXhe/Z+ZfaOA8mxJN7jP5/j+wC1mkikCF15B5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4eqxIw2EHX7DY77gR6ZlXh/aygT9ZJ75yP+yH8zZVJinoBu62HMdOpPY6ixI2VWqSvUUm+O0yPX4JLEPM19Lawj7b0QEmD+TJpjRfULmimxroBJz8rsKMJ6sxWcyWWNDLL3lg2NUYdYkgJoyytt3yjSE0u415443sKLaMRpWoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QdgIMwqe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c/xwsA4X; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QdgIMwqe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c/xwsA4X"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8dFR3913700
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 15:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SPr0GkIr+y44pxZZibhR/VHICVWXw4xIXLCVK5Fed5c=; b=QdgIMwqeylIzo8F9
	YCDovoAwRUT/5BZwQAbiO0c3d50Ttm3DNJPYmgxgGeWxNtNnCs25OmsQP35+sIUa
	Nw9w2I/fOCKO772sIgiPk/wJK/hNFnuzRGq9O6bGm3PH93CmPUcgOlNiRwG+aA1c
	S++3vqErDSEFJBdFBbU/Y8cNWBo6gLsePzCn39QhMrg0tTPkDM132SZ9V8KKsv+C
	mMGS/Dwaw8ROa3oQdbyDjd0AMfqnkLSqRTwTguHT/5Hic4QTzik6mfKp/rZosgKY
	n5u6b4SieyWmnf/jCOEDjGQpUO7Khbz9xWNHCHmFkq0ic0aIkv66qen4rMFqalk+
	pPNrxg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdsnu2f7d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 15:46:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so1593815a91.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 08:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788277576; cv=none;
        d=google.com; s=arc-20260327;
        b=MgjenUK3yWGQfNfZ4u2UyLFqkyVqW26DPIWb6+nHpWnIe8CAc8qYaUA0Vzk2sbcLqR
         zzQXkJdgOFFhcIIFCQv5e0UfcwjE9ZuO04lbwnOlB4nTyg4hDypU2yYEMQVTAOtEhuxd
         c+B3BBzIGZfuRmO17zPpaNDsNGu67fj86RFFReQ+88+26cxz8jIsgudX3NP5+f0M/0SR
         z1124HP4inyKFZ4ZSqhxIpk3vv2xHccMtkknfVGtbILkNWi/aK646bDIZbOC491depnI
         rvZZ85IWCyT2W1v9B3WkItMZth1zEFji21FcrIqqmfXLzTgWt0o259xrbMxPBTMZC+0g
         kNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SPr0GkIr+y44pxZZibhR/VHICVWXw4xIXLCVK5Fed5c=;
        fh=i1juShLMWwn71tKH0f/UtxNrLgH2o6MoSuU8qJVyS9Y=;
        b=Nlj1anM89LFjAcDnvt38ZvoMLjN9o3aEoeBv1sh+BQ0t1pNjMobAHXYD8F+TMi9ciS
         FmB4Qqm1gNzpM/erujINQg/o0u9lyVyEXT0sVvNXtJXjOShVz0/IRUDhilL7dOEBrP8g
         KMi4kJPXJEJQmjSRvwhUSrMn0qFDHOwaf1L13yQuPdqYdVGnCNdF06J3CTafTJkXkZkZ
         Gc+RJTRWA8th0enFpaYRiNOz7IvT9Yz6nuFu2u/3R7J5lpBQtVlA6U1MmAmZVObY0LNK
         QJo9+LR2I1s2VnEydK9LFKlA4BBAZnF9vCOFtcYkEYhHmBDsQ4rOHy7JeyzZJFcOnu17
         Q25w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788277576; x=1788882376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SPr0GkIr+y44pxZZibhR/VHICVWXw4xIXLCVK5Fed5c=;
        b=c/xwsA4XlLFd+k0qNTN0A2H6QOzDwd0j/xTbX207hJvsvQsRd57Ap813D+fTAzNtu9
         SdJHhoxTTjS/ziQqu3J77EZUfHi29SuqjHo9l/sv8YZCIKfR0dyrE/DGJCNdku2x+aYK
         PISBCptZhcPBCWwxI/CyPjrC11OQmFP6PCtMAGMDBT+doSOpcHox38vHl5rCfJgMJj9H
         dXydJ53sgOd+Gu4WYBf2sFzskxMdk6Dbp6Ah9PSf8ha7fNfRvtG2CR63nSp9uqjJrQre
         0XnxXX6noqWjZF772VXeEX9RYWm4usZl9wn7RrR4lXZxzWtNlb+3fivMYxW5FocJgM95
         +AHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277576; x=1788882376;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SPr0GkIr+y44pxZZibhR/VHICVWXw4xIXLCVK5Fed5c=;
        b=Wq2RnIGrJoi1TmUaGOeE9FbuhDT131Qm5gmPikJMoV4zIiCoSRVP3AaCErWJDkrXVy
         1AkKC9v6gR3+LJG5znVLQkjFoAGjzI+JhNgOP1/fA3Qw8fQ7NOPzC3lXsT7lLLtEXtlS
         WGuKqQOGb4zYVai/j/XKJvb0iWNUeqickKfGf1mQOXa/lIMDMSqrxeOwgiH8XbInRo+0
         7GMKESUSJ2WvbmRidmYCm0z9nHJt8eBWjjNeVTHOrrMlOxd8x2SAa41RsV5xFwedx2Dt
         TLI+XxUuZhonncfqbk768cLansgAENHY4byhYG2XQT/WX1CFuI5moQvE2TYnRN5si6qm
         BA4g==
X-Forwarded-Encrypted: i=1; AKwUvBxezccWZfaItB1WqPLajTRvSamHSl8Vm+wkkUE3y+qvBPQtjIRRPok6Wqz2RpWCO2OpVsLrYwhSMA==@vger.kernel.org
X-Gm-Message-State: AFuF++lo+abSxFHHMdh6mubTRzQtOONCNlD/lOV88gkavYAeb4bhpMa1
	uk1dQPujs0wElxlxlXIl6a/bkRIS4+6fxCQV/JjDq5wQL7SceWhe7TbGRcmxdo6RWBGHjP2WtJz
	wkoXN6Ojqbf0x/43rxXpgT1fceKzvlUYNR6Cy7thk1QmQ2av6pl8M4fwNddJkMRB8i5Gt4S1IOM
	zPLjowLqp7hoTOMSsPx81VqcVYArBg8TcncwdU
X-Gm-Gg: AYBFou2lQPd47kpWNzkGlyPJ+2bjb0bxa6ouNccJvEfNEKvijSO6H9wVltfvo3/TFWB
	nP7FBc5CRkK+/5D2ako9dQd0LHMGAWoupKsiwNKotloiP3Dl+HRpaMBkfDsI0gjD2rGuoL3bsTF
	nWtnW0WWJXK5bbDeMVHoRpse1Uq1fkomz3RjYhkuYM2MxyFVjxU4YtLEpvlw==
X-Received: by 2002:a17:90b:17cd:b0:398:ba9e:75ff with SMTP id 98e67ed59e1d1-398ba9e7753mr29078677a91.21.1788277575973;
        Tue, 01 Sep 2026 08:46:15 -0700 (PDT)
X-Received: by 2002:a17:90b:17cd:b0:398:ba9e:75ff with SMTP id
 98e67ed59e1d1-398ba9e7753mr29078607a91.21.1788277575470; Tue, 01 Sep 2026
 08:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821075728.273004-1-gonglinkai@kylinos.cn>
In-Reply-To: <20260821075728.273004-1-gonglinkai@kylinos.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 17:46:04 +0200
X-Gm-Features: AcwNN1VX_i35MYWk1BRKRMPd_ejniyU3wi6Q06RCOJsNKrSWKss17q7PohQ4c-Y
Message-ID: <CAPx+jO8kfpBTYw7TCM=+2ebN_i_adYM5dUVPf2NRR8QBFKdXkQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: dt_idle_genpd: kfree() the original name allocation
To: Linkai Gong <gonglinkai@kylinos.cn>
Cc: Ulf Hansson <ulfh@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@rivosinc.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0MCBTYWx0ZWRfX+0Xa5ZweEzwn
 bR/IBsWT3uKZIXf6diuI1W7UWwgl/8w9gLtFCzbv0VcmDC/gfhI+JmCtQpLt3b0mI/QNbMxJP5g
 1lp3z/oULNvrjqxrgnSfPM3f30Jbl0ExbFHPDRkc3N28xeB5lYqW52nOpADcWHeGoAze9/uEfP/
 Y/9itcTK0srMxcsxwitP88yR/p6vvZbqRGXa2P+0o3v2t/i6pvBZG3GqpQ+86ykO0oPFbqmKRNE
 PZXKAqGuCXtYfSSthnUs6p/9/Fglt3en/EaOCcC2p3gccE03Xv06oRkpw3qsl9ZXBtZ2xW96Usz
 OkC2aHQzZyaA6jZh4Ga8jBp6T6Lo6a/LoAT/3++ZC9z0M2GydPlSE/yKFxWisaf+La8q9nz7Llz
 fLIjBjJL8UaI4/6ACoFMdeyQTRoUpqUFzVH41mmHIyjMAeEFbpMwBDv+ydYkprx4+Zd+3h3oxDR
 vEZ2gd6B9E1nPFtb2lA==
X-Authority-Analysis: v=2.4 cv=L6ItheT8 c=1 sm=1 tr=0 ts=6a96f348 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=JdndqbUKdSgka_8NYHQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0MCBTYWx0ZWRfX0mX40z/tUAlX
 bTgRr2SCpgWF8/zesCordKLT4Dwg0cTwFqc3X4ZtLBhyVdsPe35C+6UJUDcpIfsWuUzMuf6W/8L
 5qhyUehTVJ2XglN9mpsDoHhXwtXbKbE=
X-Proofpoint-ORIG-GUID: 3PSj3MeiPq62kxFP9iAx-7nFVeGezlcv
X-Proofpoint-GUID: 3PSj3MeiPq62kxFP9iAx-7nFVeGezlcv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010140

On Fri, Aug 21, 2026 at 9:57=E2=80=AFAM Linkai Gong <gonglinkai@kylinos.cn>=
 wrote:
>
> dt_idle_pd_alloc() kasprintf()s the full node path, then points
> pd->name at kbasename() of that string. dt_idle_pd_free() kfree()s
> pd->name, which is no longer the start of the allocation.
>
> Copy the basename instead.
>
> Fixes: 9d976d6721df ("cpuidle: Factor-out power domain related code from =
PSCI domain driver")
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/cpuidle/dt_idle_genpd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/dt_idle_genpd.c b/drivers/cpuidle/dt_idle_ge=
npd.c
> index d292975cc468..ed41a90eeeb7 100644
> --- a/drivers/cpuidle/dt_idle_genpd.c
> +++ b/drivers/cpuidle/dt_idle_genpd.c
> @@ -99,7 +99,7 @@ struct generic_pm_domain *dt_idle_pd_alloc(struct devic=
e_node *np,
>         if (!pd)
>                 goto out;
>
> -       pd->name =3D kasprintf(GFP_KERNEL, "%pOF", np);
> +       pd->name =3D kstrdup(kbasename(of_node_full_name(np)), GFP_KERNEL=
);
>         if (!pd->name)
>                 goto free_pd;
>
> @@ -112,7 +112,6 @@ struct generic_pm_domain *dt_idle_pd_alloc(struct dev=
ice_node *np,
>                 goto free_name;
>
>         pd->free_states =3D pd_free_states;
> -       pd->name =3D kbasename(pd->name);
>         pd->states =3D states;
>         pd->state_count =3D state_count;
>
> --
> 2.25.1
>
