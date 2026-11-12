Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794490669;
	b=UtctUGJK62X/G2+1inOMK5Zv0mxz3qpRFGTSuteIdzXX6TqLeqj72BgA+Xgearlb0gnx
	 pF0fiop8mVERyG7mU8e82pDIl/XpzxO/5liXkd24U1cxSGy03Z5cuDABxWtT9WxHyCVxB
	 56jK7w/8TBmMazeMbigRAbnlBPsDDuiLNahIqP057eA3YSoVY7O+2VGXd14iRMkyKBX3S
	 1/sxeok8VoBRqG1bMhCxetSEnaEHwFupwSdoYkISS7A7X9X52gnslndwT+I702eJCxbwB
	 PXW2FyPw49U2U0nvdrvvCru3WqYhfqysadDgsXm9W39vMeofeqoDE+rUUZ+ryiLYBcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490669;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xVcgSKEoiJgg+H1FyrIcVXoKCvo2YcTYdwMzq7YEsS8=;
	b=Gsa0d35r1DPnCwvOgXFTp6YrpjXvZTTQp4yr7rkmjnh8DYEjZY7kq73uZtl/rBy+e/9k
	 /ETAvqqMumwLrjwk9rMGwaFQSaRmiiZZeG+0Cbltl0He7hug/yHpYCuBMeNKuO67MEHjs
	 4pbP6tSygO06lAjIBPR78Z0xNTif/ty+dyTbvvgP9/kV1LeJjsepwqFqDMLYgYn2D0F9B
	 RR+OPvWfXCuxdLqKOu3KbVDYXyoRzc5SVDkk3kUTeGgWna8pdjBJt83DLaWNBLdN8xuV8
	 CelnNx/SMD15D+pQyN8AylBiOVNWH9/OhiDxC5oxjRYBlHc/VBMAKmlMYqH9LeYoWRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E7q2Vm5V;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y3x4dn8Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F91606A888
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 13:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F91606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E7q2Vm5V;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y3x4dn8Q
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9E0iG480138
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 13:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xVcgSKEoiJgg+H1FyrIcVXoKCvo2YcTYdwMzq7YEsS8=; b=E7q2Vm5VMYhyrtGf
	CFZs/Mgktw8daQ8HJgkgi1ceLDf7u/ZpiMhYlgLnj6fXMEd31O+B0aNzHtRSY7XW
	LrkrTogp0Q38BwCZmhA+889+IXMAaSsza0ne9qFuFGvBu0doQPsTAmk7WXlGAE5S
	2/lGW4DG5j6q/TU44bTw/iWUaJlPdY2Wt+m/F/vfYpOXBcA42Vjvl+E7UoJfZJpX
	3tBf0wxxHpNg7jwHPqIZMC7rNGarSNmmGowxZ/JeRHJ/JNvOiton9HIDbxybwxQZ
	RYsNH803LpC8MFpCWWMF5JkARN6u5Sco0vRXKgI9WlU/ZsBRnQ37mP85WC1TKNGO
	wPehzw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwan4rv0x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 13:37:47 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98a829c43f3so905713241.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 05:37:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794490667; cv=none;
        d=google.com; s=arc-20260327;
        b=fXUi/gJEFUOqQlcdH2U77fi1qm8HeLfRwe4nGczLA9WeblHrK/7V1tTmxPdS0dGdN9
         oZotcycTC7PBXVjVI8ZlMuFjHMvR76rtf+QpP032DlUcz5iKCczravhtnD5HMxdIjZrK
         144KypAzUeQFtDs+J5b9LVgb1zV6LHhi75wxMuH4DUJYxGyskWVl6aYYE4MdLw67XEVC
         huBg6N/mhLlmGNdFNPl+swRDVrTgVbsgKy3OHm8593mN9GAdLSdzMcLnVGMPd5gVg3fm
         XK29+PdyAcCbHDpUalGyRNphyVoErSS5UA2l6YnJJxmUhmDtZYlB4zvAQfubT7foJdnS
         6B1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xVcgSKEoiJgg+H1FyrIcVXoKCvo2YcTYdwMzq7YEsS8=;
        fh=GBoc3HOwzTn0Af+NEA0uAhji5/Ql+gy8vnhe/f/3LSs=;
        b=bdPpCzXHW9OBjS5sJNswjf67myB9697JWfDcWMo+PXR8GEynPXSFNMefnp6ZExMfh/
         MOv7byXsRlKBohtTsgAYuADW2HENrRqV8Kn43Qs655Pnno/2vKTrsidpSOxQo3EVzpM8
         Qt2/y7ACl+HV52rmt4H6S7qH40cL6/7lLZXlBJOiyvpEEWEUskhYhGwFD8LO/l+xGYou
         jTvD/EacnTyOBa2S0qB2dF4ua+1baRPmH5JTEwk+alrW/Pzk9uXxNw9qyYOa/rCwluRp
         qdA7ORdrObyM3rsXTKmQ9MZe1zT482DWt/KNM1zIRgTSobKPs+U7HoGJc0iyOwowfura
         DLLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794490667; x=1795095467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xVcgSKEoiJgg+H1FyrIcVXoKCvo2YcTYdwMzq7YEsS8=;
        b=Y3x4dn8Qflmv28qZrW5v1HJNOxNDv/hT8nBk19iJy1ow0swtZcnbedeH/skjttX4Pl
         AXp6XaHgP7dX+C+zpLn5/zKLHDYr9eiUWTdCFkrEVvKlzpsAGh8pru2WFpKVmCOUu0Wz
         BAE9R9rF2eJvRq46c7LAPNz9MSMPn15WZi5QwzxzFEk5J/M46f+SYrqPYReyTlbEsQdR
         6xP2h5O+hLpNDrOqw4DTd4cIDk4XHUFpCveY9/TMkF7+jkhkSMFEYjaSWXVdoLNfZXNn
         LK0/+oBk8/fgdgHQe0kUiGPkTKURxBdqQFQTC/M8q2iFT4wXFZvHTi1L4q1kpmLd1r3c
         ymRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490667; x=1795095467;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xVcgSKEoiJgg+H1FyrIcVXoKCvo2YcTYdwMzq7YEsS8=;
        b=zQ2zH1+q6Aa953fVTv1SL8Lb8U6T8J8G5nI9Tq62Onzh3eUhbBTWP90itywyCIh70c
         kVChgAdhagP7aXZh4LZim3etPFU2JBT0MN9DVMO45INKnqEyOCBaQpT47323UUwyh5wA
         wPP3d0afa2gIMNse7opYeNuSjxzj6jpIPfpmChzhvlt2D4qUUZKh3Ecx0qzuJTQNN89/
         4EmKILl7fPTL+DV5sRkPGZ3cQ+cpgb98FK8O2WBB9l0fPe0elLsT9VvXdTtq05X3yt8N
         cMlbskMfbyXwnxaZqf/nYidjwUJm9ItoVYXDpVEfNflQnQJ29f2X0D/KVjsPZIlSwUr6
         XJdg==
X-Forwarded-Encrypted: i=1; AL+hErFmieVmLf0pWiBZ7OOg0LQYiF9eCf2unVQhblsyFgRc16JaZCPoEQ9PGjmnZEjVaCRU9oyY0MBzvg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8QINfmnX7cgT0muSAuG6zB6wjSDBL9X/XOnsA2St7kiP3YWRQY
	JYoN2pQeWoQ5zm+xj+/txhsHqcOu8zhqeJpQUBHbXgrlEuAkwNDAAZozOQJh8+MrU7+0mBIw9Rp
	o7yYrc3TDTmVhsgxkDg+cnZ/NVNBpce4xakhtO/21ErLFhcVv5iO7mKPwdIuNkZWVHRT+Fcs03C
	brbGQwFcmwjBivOgHit4NVSbS3JAmEirMQ+F/h
X-Gm-Gg: AYBFou1us4gvdh3+0Ft9yMKzkgK2jDGsAl+rnhanpfLVFojRcncYJzqGaVYgd2fXcNn
	sHTPhE+0UNPzs+Lk/1MUyaA7abrhtQ55epXaT5GLgg2BEWbOu56kRPjoogcHtdzsRCXb11j7V4v
	+Eo17V/WT9WkWuQqgkbfpw9sCNm36VSw0y4oYlaDbYOpCOiMoFFOgiAHgSsw==
X-Received: by 2002:a05:6102:3911:b0:7c3:6466:3155 with SMTP id ada2fe7eead31-7d5061cb5bbmr1984726137.33.1794490666685;
        Thu, 12 Nov 2026 05:37:46 -0800 (PST)
X-Received: by 2002:a05:6102:3911:b0:7c3:6466:3155 with SMTP id
 ada2fe7eead31-7d5061cb5bbmr1984719137.33.1794490666279; Thu, 12 Nov 2026
 05:37:46 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013-genpd-boot-performance-floor-v1-0-a765dc83e6d7@oss.qualcomm.com>
 <20261013-genpd-boot-performance-floor-v1-3-a765dc83e6d7@oss.qualcomm.com>
In-Reply-To: <20261013-genpd-boot-performance-floor-v1-3-a765dc83e6d7@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 14:37:34 +0100
X-Gm-Features: AclHuK_D3_dNomlWbL20p3tVMOhfrYVgRQMwsyI6NGH-uAbOYwZihTFEQR8CH4E
Message-ID: <CAPx+jO8buJH7eBFdzd146F=aUJifSDiksM2FV37fCjK7kOb8AQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] pmdomain: qcom: rpmhpd: Let genpd enforce the boot
 performance floor
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: _f0-hu2c0vA60rbXX0cEjh4PVesm5zen
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX0YJCWAte3Dvj
 rGwCWFIsh7hnzI8rz1QFbtfvLiJlZGlES6OPYQCpJRryQpdfJ4SStWTNpM5HoST1xneNKTpAhh8
 Leamp1YxMQadWdYrMu4lUews/ohRLs8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX9X09SvMcqIUG
 0v5X3whyAcI3SGX94QZZhMvd5w1w2IN7IykRnVW9SZXE6jXxFgGnq6FGABrY7aMZ4EO671ppdpZ
 Py6jKP77oSNYj0wcAdGBWRpXVnk0Kvdt5/UgyS0Fz8bC/HNoADOuVwbNdXvQXVVTTm0ufSC9HK6
 aNHSyaLo7pvW/jBecKO/5VgOQBli0R8TDHbCNqGUXEx43g9IhUsts/1eS9ntMMnouHmaw3zwDZU
 +Lrk6KSFyrxjp/P88JdZgHrLtG509rSR9bVKa5mvJCb4efQWjbGrWvUgaJBEm505CqYoyl+CNvh
 7YFE/8bK70FXRtEsJTkW5rs3Tamri30mIxAj86Ua4s6Hqu/O6EDjmCkvJiOUt4XlZs5a3wAiIFY
 XAe18UyVMK9E/Bv6JijAdFZ2v7dqtlObXVRKwWoK720YWaTyFpgHh2jaQn0Z6ipWPR39jcyfpO3
 LqONQSH/dxtEorymk8w==
X-Proofpoint-ORIG-GUID: _f0-hu2c0vA60rbXX0cEjh4PVesm5zen
X-Authority-Analysis: v=2.4 cv=Gd+CDgXL c=1 sm=1 tr=0 ts=6af5c12b cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=jAT_WBN3s0Bi42_mw-kA:9
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120054

On Tue, Oct 13, 2026 at 2:49=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.c=
om> wrote:
>
> RPMh power domains are registered as powered off without knowing their
> initial hardware state. Until the provider's sync_state() callback runs,
> rpmhpd_aggregate_corner() replaces requests with the highest supported
> corner, leaving genpd unaware of this boot performance constraint.
>
> Set GENPD_FLAG_POWER_UNKNOWN and provide the highest mapped performance
> level as boot_performance_state. Reject an empty mapping before indexing
> its last entry. Let genpd enforce the floor and retain consumer-enabled
> domains while boot protection is active, instead of clamping corners
> inside the provider.
>
> Retain state_synced for the hardware-specific sleep-vote policy. Include
> the supplied corner in sleep votes for active-only domains until the
> provider's sync_state() callback releases that protection. This also
> applies when translating an enabled peer's vote. Keep the existing sync
> callback to reconcile votes for domains left software-OFF by genpd.

Hmm, perhaps we should start by just enabling GENPD_FLAG_POWER_UNKNOWN
- and making that as a preparation patch, placed first in the series?
Would that not be a more cautious approach, taking it step by step?

Kind regards
Uffe

>
> Assisted-by: LLM
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhp=
d.c
> index fa8fed5bd3e5..1488f31bcdda 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -40,7 +40,7 @@
>   * @res_name:          Resource name used for cmd-db lookup
>   * @addr:              Resource address as looped up using resource name=
 from
>   *                     cmd-db
> - * @state_synced:      Indicator that sync_state has been invoked for th=
e rpmhpd resource
> + * @state_synced:      Whether boot protection of sleep votes has been r=
eleased
>   */
>  struct rpmhpd {
>         struct device   *dev;
> @@ -982,7 +982,7 @@ static void to_active_sleep(struct rpmhpd *pd, unsign=
ed int corner,
>  {
>         *active =3D corner;
>
> -       if (pd->active_only)
> +       if (pd->active_only && pd->state_synced)
>                 *sleep =3D 0;
>         else
>                 *sleep =3D *active;
> @@ -1006,13 +1006,7 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *=
pd, unsigned int corner)
>         unsigned int peer_active_corner =3D 0, peer_sleep_corner =3D 0;
>         unsigned int peer_enabled_corner;
>
> -       if (pd->state_synced) {
> -               to_active_sleep(pd, corner, &this_active_corner, &this_sl=
eep_corner);
> -       } else {
> -               /* Clamp to highest corner if sync_state hasn't happened =
*/
> -               this_active_corner =3D pd->level_count - 1;
> -               this_sleep_corner =3D pd->level_count - 1;
> -       }
> +       to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corn=
er);
>
>         if (peer && peer->enabled) {
>                 peer_enabled_corner =3D max(peer->corner, peer->enable_co=
rner);
> @@ -1210,10 +1204,15 @@ static int rpmhpd_probe(struct platform_device *p=
dev)
>                 ret =3D rpmhpd_update_level_mapping(rpmhpds[i]);
>                 if (ret)
>                         return ret;
> +               if (!rpmhpds[i]->level_count)
> +                       return -EINVAL;
>
>                 rpmhpds[i]->pd.power_off =3D rpmhpd_power_off;
>                 rpmhpds[i]->pd.power_on =3D rpmhpd_power_on;
>                 rpmhpds[i]->pd.set_performance_state =3D rpmhpd_set_perfo=
rmance_state;
> +               rpmhpds[i]->pd.flags |=3D GENPD_FLAG_POWER_UNKNOWN;
> +               rpmhpds[i]->pd.boot_performance_state =3D
> +                       rpmhpds[i]->level[rpmhpds[i]->level_count - 1];
>                 pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
>
>                 data->domains[i] =3D &rpmhpds[i]->pd;
>
> --
> 2.54.0
>
