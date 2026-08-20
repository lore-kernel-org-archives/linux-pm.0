Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7A23DA5A6
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219815; cv=pass; b=TNYPJSnLwXxxfvSdMt5MCmQGxYSVebdUiiPsu15qsRmcKFnEzQkafej4o7cXDWkkKf9BVrsf2JLF8db4PcMPwwx4hfUaiAvUS0GdI/jOJJZmz0c//mvHuKdPqV73f5xkcURAPm5b2AzC64o+mZjR7uZSDYJljLitbQ/9BKvaF60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219815; c=relaxed/simple;
	bh=iRtlHShgvRENiFz/1DQGq7xGglK+lsSGgbhF9q8XOvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqT5swQyFqXXIbvrymQrQ886XL0k4cF7TbCukyvRDE8k3la1i9W/QCW1+RZYjVvDfFz5GUaktSTklxOh069lr+zArkjPAi/HLuljr0hqJHX4TBLNPrUg8vS5/HFAHbcFukKDGjB7BbdvaNpBiwKW9CjrTQH/8rIhiRmsxCcsOV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WR9DXaGs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZzVwDc9p; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WR9DXaGs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZzVwDc9p"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8jefo2529520
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 09:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GOB3vfe9M72AxiFEqL/rufgOK2tqAmA5k5ziqB7Jwgk=; b=WR9DXaGsl00Xj5kk
	d7wS6IRTRl2yXerTBzULxKBkyXjZSshYYCJRV14aSnmEr1HZksx1ZdiaJkT6xvXb
	7W+8V9suSqbVLBWH31b92fhxWqlwWGlm9UzR9csB87Kxaq8YfMGNS3HfoeLMf6oU
	3GELlc48wDWeVPwp7Tbm+a2+WVwu8UaGVSrvCcWZNIPJm/eMLRjefl1G4zFsLYxz
	xOV2zb2J4O71qiiCGVwGyn9PRQyxHr5kwFH1qLt0j/KA8YuxIDEtu/ME2PheBDWT
	Q3sh/5XOI6x/MKlS7TFy1xL/8Ww+i1jzZHr9eAbWAy7ihOqF2wDHUE3hSefMonrV
	HuI8cA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xbv88m1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 09:56:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfca8558d2so26773195ad.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 02:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787219811; cv=none;
        d=google.com; s=arc-20260327;
        b=lnWTJ9jXnQ9b/FEdbcTu5BdLO2ZNPfKkhKPZVcRS0U1/LFgFJt3GvdjUliKFokl2OQ
         JuO1GPxzeTgYBCbwa8d23fQlfzydBbi7NhiyhzD/82xcb3xsd6vyT3rPbqcvS7bH3FXt
         Tt5L7/QG+Ty41w0GGYdUlct1lNVn2+CzokxcjisPNzTd9i3/W2ZjmF4ohh8zui8Q+WrM
         N6OZPw59G2vLYau5T1IzgHAbIuWzJnPKhz77GJTX3uH/K2WpV9AfK4RdSdym7XrSce4Z
         ZbIsQ0rMvEorL7zsEZsm04oLYMiVuUoX0H1IDSrOX81EEfOPjyDr07JIogAuzejrJk5d
         /VAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GOB3vfe9M72AxiFEqL/rufgOK2tqAmA5k5ziqB7Jwgk=;
        fh=0QmGoc4C0xV6LARMHUWinNRHOez/rSPrDTkyaJ9ZoXQ=;
        b=NWmNtAlFzuChVII7Tw1jcghncEZpFBuScbpXJ69+5RtL8nL6BMRPOItxBcD3nNBbjo
         2UmyYwJGq0u2d+Hb7LVsKS3B+Pizw3KIdzdnvfnXR13fXjpzp37kZcWbS0++LeHfBF5a
         +/1N4R2EG6upxSdFsA+5bRlHlDcWNRgKGEjP0B++kaFlrFqXSLQ6op3VHsYmpy2OYRQ+
         aef5LuITU+VwtwzP6HM+oPnHxKe6fFpEsMUn6zH8Zp4dwS24DS+Xc1nGsLgh1BXXhD13
         xhCz93sBA/BRgRyXT3LNP+Fel+MhEy48oFgMDmzPZsKSnzeJyAx7HgccFCdpN+M+ZsLJ
         AxkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787219811; x=1787824611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GOB3vfe9M72AxiFEqL/rufgOK2tqAmA5k5ziqB7Jwgk=;
        b=ZzVwDc9p6KiLO3fSPfSkK8tOh5Mjjzp67bwPFNBvr+cQ23wgG2PK0RUaONu3CB6RrM
         xUFZCLt2rMRyuEshn5fXbEkjFOix5KytiQGuU+qQmowoNZC5qHqNPN1n/Olw6IWG0ptA
         gUtOb3Z/4vWs+iJqjGenD+XUkYXFp5VMTTbWgqx30Us5DTemREEAiSXowsKoUhBN2k7N
         AJQ2clpL1M9L/O8TaIaS2RidgjfTb30xjhHbSpdtUvuNvwUm/o+5NOLWIqAu4FGQy3lj
         +rjumMoZQaK9brkT/bALODoRT16saDu5bOd0s/ivqE5fMEm0csOalbyOwzl2X8OQ4aok
         xZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219811; x=1787824611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GOB3vfe9M72AxiFEqL/rufgOK2tqAmA5k5ziqB7Jwgk=;
        b=EeIAzIig0T8be23r19Eyztf28gCqxqUq5TDrckD4zGjvIws3gpoQsYxGx+Hcz6S3jy
         uCwVMfVF3lH6Wcb71vXpt8CmuCE464QeI4mB+4BpveSGyKNlI8lNJN6yqJBx17XXTJIG
         HALngsElnWeAUYMpU9grtTIrP2u24j0HUaWJ5QUZkiiVBsPTnNv/yQvH0EHqo1Joj69/
         M83Et4kCdcLSACjxdZanH26zjpPoe3o9l231NlS4qD2swkoI5l0W+LMJ4EJUl9u+V2r7
         +uxBMFO5aPCvl5QUszNbIiTxpluc3jxzImUbo7QwObXFXLKFJ+NT14I8bbHOyzbgV6La
         rLmg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7R70TMZLunEVlU31mk5/TvU4DJxzdtDKt1XgKpRe0FjczG8Lom2d29vZDi1PXY4sijDmoxmxt2A==@vger.kernel.org
X-Gm-Message-State: AFuF++nsa00RB3WuKRw2ugvBW/Ip2L86fcg6GNwT7z41tIO49uJePuJX
	Pr0yA8XxSrHC0DFNh9a+nYzZ769txHKKcZeo1reFNhMsd+0RTOktaPIapkHcEhN4CAUY3QVXj4D
	mowuwn8FmS9Lb5WWVSLpKr/zu+zf2XeSfwbfSz7MUKGj3awzUM69aseTP7Qpb+cvaRUsvcRPlJB
	vsyJQyPxdiL2yc+7GkkYFeWGn3rVD3LiFdY6Ta
X-Gm-Gg: AR+sD10LW/laQFolYZFe8e/XHF7Ad/qnWP3Db9f5rHxxPQ7xcVmknXDlKcLqlrkUMFT
	SGbwrMd/ZA3BT90vgAxxkCrrfX/MqKDAtwJQYJBUcTNSa9g1mE3B5bnfrmWfnmPsuSPpeN4y+0j
	dbawEB9bULhFg+/XcWjSoKq95KwIaxBsWpOEffIlxIpmC5uVaHo95G2rqzlw==
X-Received: by 2002:a17:903:28c:b0:2cc:aa36:c04c with SMTP id d9443c01a7336-2d5fd5b087fmr208298885ad.1.1787219811442;
        Thu, 20 Aug 2026 02:56:51 -0700 (PDT)
X-Received: by 2002:a17:903:28c:b0:2cc:aa36:c04c with SMTP id
 d9443c01a7336-2d5fd5b087fmr208298025ad.1.1787219810878; Thu, 20 Aug 2026
 02:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819151457.256959-1-ulf.hansson@oss.qualcomm.com>
 <20260819151457.256959-3-ulf.hansson@oss.qualcomm.com> <yuowf7hfnhcizjgxglfypsqbf7oavh3jywbls5mdbuyc5rglmn@ejp2tahonk6r>
In-Reply-To: <yuowf7hfnhcizjgxglfypsqbf7oavh3jywbls5mdbuyc5rglmn@ejp2tahonk6r>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 11:56:40 +0200
X-Gm-Features: AcwNN1XwxKgaQ4nlmVlWsFlz-TFCrFjNsKCp3_ASPsoM9q7iXmpsxnM_c1Jkpjg
Message-ID: <CAPx+jO8MXQwDh2Bvws4ngO=9LeE3YvFkiv=KDgYupWxS6VePjw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] pmdomain: core: Add a genpd config to support
 unknown initial status
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=6a86cf64 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=FEbHA5cY-midHvKCsEIA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3MyBTYWx0ZWRfX/+Ge8IfTpFlB
 KAmotK+Tzaccmz2dJuonBlfk1528PZrGwf7hfTgQ4j7WmkzcJty7rpX9nTJPeDWbPBdwPwe1NE5
 s0uh8UFSKPQra5Ks/dSZ65rU/ePihREe3Q0QBjW2jfVKJfs5r7rrDz7Q3Zo4mDw8q1Wr9DFCd8u
 GsmAs93k0GpiIj02bUTJY1gFY2WGnZgLGlMIBW116l23JNOVuR7pE+XAdJkYTj7h7ScdQ7luEK4
 NiJZOCYvjWZhrMqDrI9plKi7nwZ/yj5Uqd3tMx8IqL2UoejaTAVvjgZSPAab0v833pDiVPahjQB
 lRacUyvxtDnC2sdAnRZd2ktaEXAZvav4f7nQhZWfW2pYboASHgTwc2eJ4wDEHpzNrlvQt2GJl/x
 UhGeZp8Hf5dMMUEJqceTcRQzOyhE4K2TIsXTBsxs+dPBIoWKUc3dCndic506taFR7pN2NTebdgS
 VYag1CN3NwhB5pOe96A==
X-Proofpoint-GUID: J0J90IFbX3_MfKuTYL8taO1e8f0zr83o
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3MyBTYWx0ZWRfX8SzQ/N00QAIU
 vt4BOcH+cSdeUjr928tr9TQg5NvyegJ+gU5k+Aqpj6RnSkPR/SXU4l4qXGqzzKmTpL/RCEcFNx/
 SEzpW1hx5oMEXWq4A1EFrbAHv8t7Y/M=
X-Proofpoint-ORIG-GUID: J0J90IFbX3_MfKuTYL8taO1e8f0zr83o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200073

On Wed, Aug 19, 2026 at 7:40=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.c=
om> wrote:
>
> On 26-08-19 17:14:52, Ulf Hansson wrote:
> > From: Ulf Hansson <ulfh@kernel.org>
> >
> > It's not always possible for a genpd provider to know the initial statu=
s
> > for its corresponding PM domain(s). To register the PM domain in a safe
> > state, the genpd provider driver may therefore have to initialize the
> > genpd's status to be powered off, as a way to prevent the PM domain fro=
m
> > being used when it actually could be powered off.
> >
> > In these cases we may end up to power on a PM domain through the genpd
> > subsystem, while from the HW point of view it may already be powered on=
.
> > Under these circumstances, it may also be required to keep the PM domai=
n
> > powered on until all the consumer devices have been probed. In other wo=
rds,
> > until the ->sync_state() callback for the genpd provider in question ha=
ve
> > been called.
> >
> > To support this behaviour for a genpd provider, let's introduce a new g=
enpd
> > configuration, GENPD_FLAG_OFF_STAY_ON.
> >
> > Reported-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> > Link: https://lore.kernel.org/all/20260811-domain_off_ss3-v1-0-6a0a0fc0=
23f5@oss.qualcomm.com/
> > Signed-off-by: Ulf Hansson <ulfh@kernel.org>
> > ---
> >  drivers/pmdomain/core.c   | 6 +++++-
> >  include/linux/pm_domain.h | 9 +++++++++
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 7345c06f1d55..be4fff2f4664 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -189,6 +189,7 @@ static const struct genpd_lock_ops genpd_raw_spin_o=
ps =3D {
> >  #define genpd_is_dev_name_fw(genpd)  (genpd->flags & GENPD_FLAG_DEV_NA=
ME_FW)
> >  #define genpd_is_no_sync_state(genpd)        (genpd->flags & GENPD_FLA=
G_NO_SYNC_STATE)
> >  #define genpd_is_no_stay_on(genpd)   (genpd->flags & GENPD_FLAG_NO_STA=
Y_ON)
> > +#define genpd_is_off_stay_on(genpd)  (genpd->flags & GENPD_FLAG_OFF_ST=
AY_ON)
>
> Maybe genpd_is_state_unknown ?
>
> >
> >  static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
> >               const struct generic_pm_domain *genpd)
> > @@ -2445,7 +2446,10 @@ static void genpd_lock_init(struct generic_pm_do=
main *genpd)
> >  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> >  static void genpd_set_stay_on(struct generic_pm_domain *genpd, bool is=
_off)
> >  {
> > -     genpd->stay_on =3D !genpd_is_no_stay_on(genpd) && !is_off;
> > +     if (genpd_is_off_stay_on(genpd))
> > +             genpd->stay_on =3D is_off;
> > +     else
> > +             genpd->stay_on =3D !genpd_is_no_stay_on(genpd) && !is_off=
;
> >  }
> >  #else
> >  static void genpd_set_stay_on(struct generic_pm_domain *genpd, bool is=
_off)
> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > index f925614aebdb..9929347e1d7f 100644
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -121,6 +121,14 @@ struct dev_pm_domain_list {
> >   *                           powered-off until the ->sync_state() call=
back is
> >   *                           invoked. This flag informs genpd to allow=
 a
> >   *                           power-off without waiting for ->sync_stat=
e().
> > + *
> > + * GENPD_FLAG_OFF_STAY_ON:   Use this flag to inform genpd that its in=
itial
> > + *                           status for the PM domain is set to powere=
d off,
> > + *                           which may not correctly reflect the state=
 of the
> > + *                           HW, as it's unknown. If the PM domain bec=
omes
> > + *                           powered on during boot, genpd will preven=
t it
> > + *                           from being powered off until the ->sync_s=
tate
> > + *                           callback is invoked for it.
>
> Maybe GENPD_FLAG_STATE_UNKNOWN ?

Hmm, I understand your idea to clarify this and it sounds reasonable to me.

However, "STATE" sounds a bit vague, what do you think of
"GENPD_FLAG_POWER_UNKNOWN"?

>
> Or probably it would be better to just add a new state to the gpd_status
> enum, like GENPD_STATE_UNKNOWN.

Well, the problem with that is how it should be treated by genpd
internals, when there are child/parent domains. Having an in-between
status sounds unnecessarily complicated to me, at least for the
purpose of $subject patch.

>
> >   */
> >  #define GENPD_FLAG_PM_CLK     (1U << 0)
> >  #define GENPD_FLAG_IRQ_SAFE   (1U << 1)
> > @@ -133,6 +141,7 @@ struct dev_pm_domain_list {
> >  #define GENPD_FLAG_DEV_NAME_FW        (1U << 8)
> >  #define GENPD_FLAG_NO_SYNC_STATE (1U << 9)
> >  #define GENPD_FLAG_NO_STAY_ON         (1U << 10)
> > +#define GENPD_FLAG_OFF_STAY_ON        (1U << 11)
> >
> >  enum gpd_status {
> >       GENPD_STATE_ON =3D 0,     /* PM domain is on */
> > --
> > 2.43.0
> >

Kind regards
Uffe
