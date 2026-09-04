Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA33D7D75
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508617; cv=pass; b=eD1xCLVNspDPaLRkfEn7eGi+Na3gcZOZ/ovfYHjuw6CNt+lQoh0TfSC51jQZlFbm+Zz/+52AzI1GPMubQxrVbLb3HHgqFVXew8b/HU2PefM1u+iPJQV7TgTADpdhzbxHaC5z0/cbn7Diw53dB2O7PHh0/4Kkk+PWsPPkbCLZp7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508617; c=relaxed/simple;
	bh=aRX+Nb7hSCvEAQ13DkJCkSxFgBFsa/ETVg/ALEwOfh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQ4zYKYPCYsTY0lTSMZIsjDvvagUMKrwYupqK8A3yBw92gSbylBTohjmioZCqNnIuc9FmDYTsFOw85FGJQSgIKmN9n9w4+0s38aDLpRvks4mEPxMJME8semiSREfHr0+ypYGfQOVCpTIl2WbfjGZR/JSj5xF2fTuFdyLy/0VDTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lyMe15eq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V8VFcJ+X; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lyMe15eq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V8VFcJ+X"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mlKr3112835
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 07:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AsK6CNkPzqL+25hJDO5/FxatvGOrEq2Iq+btxLgvqQY=; b=lyMe15eqUhFeLFRb
	ZvQ0jwRyMlDf4mFoetfSpQzEYtL0ch88a/gfxsbX2JtIdepnq+rkvGYgQAIF6v9e
	gmYcp/V4pNV7LwqvRF0oYLocep8S0xOkDji5fdOx9fOSaMk69L39GDys5WkISYZl
	pejqQmGAmG78zYbDoAFL1nQFAkJaG6RaDB5fBDzjeTM89qI3wnMwkzcQZO30t8h2
	bqbETwMMnF72JwJQEshfEVrj/KPRGa8Suz3/9z7Kji2cuAoL5x07XOL/lPFDQptt
	GVKoUAwfrHe8rAgW4FXRSLVBVcBcJS/cwbn8P3M4+hXKcnpUA9dV3BU0D306rwo5
	q/4KZw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp780rnu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:56:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1b8088203so1013752a12.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 00:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788508613; cv=none;
        d=google.com; s=arc-20260327;
        b=X9oHsrfGCdXp5X0azUduN5NyIRnVtL+qujsOj0FToDzywPL+tcGdm0AEkFN6qMghNG
         NuNQm8rc8Pzv+Fk8QtUEBI/rpbvQtjibuQoanDFX4Q2Muk/myz79iyrgmK34xje4dfPd
         FRAhphAgYvXAJ0qMvwstlru0fKL5/3lGEmXWW0LZ8qfOk3lBBKsHP2T/h1+i08KFUBtW
         P1PmDsman5FE6j0Os3isPrmbPdzL3NcU3aliO6nzOa/R2TfcSNQZzNwRpCRB6HBBiyr/
         sdeMB1aJrauBcBD0lmFHg9kK6Obl+O+zlslykTvEjEYCwnDqWOR0ZKAoQUDmy+20eT5M
         xbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AsK6CNkPzqL+25hJDO5/FxatvGOrEq2Iq+btxLgvqQY=;
        fh=LZm5ZdZgyA3B6ikzsY1SsAOdM9f+BO6HL5E6EeExUeI=;
        b=OnW9hvnauQR6d9nY6WYAdJbNXrNjZsPmNAdnhTAVcQASGTngZAcf0wq5LjLD/kYLOp
         nHEDKdCoRw588AQjBBbOG6YfHdqfziS54ZaVWNTtQXXZ/anMOTkngBYJL64epjhV9qMH
         N9xH8//D9H8i0nbQRUnrrgrYrzHPWwUkqyovrtqPx0lVReIZa9q0Dq+Z+FkBNqi4WAZJ
         Hvyuqszkj/cA5f2FZYBxVEtE0Kucel//dCUJQVIhLrsolKkfol4bnDzPWjX+mNxLWnXo
         DwTrl/hMeXOWH/kTeeWgWnA64UyzRp9/I153uMXgSpDvWSCDEEublzAT0f+keYkmLKTX
         uh6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788508613; x=1789113413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AsK6CNkPzqL+25hJDO5/FxatvGOrEq2Iq+btxLgvqQY=;
        b=V8VFcJ+XZMMQ3Cu6VlG/DL4uWfdUkiCraRi4vRtivjqpBNVVLeGXu/Y4mLNn4X8Jj2
         5jqeXQw2ZiUO7HXItjlLCKsVzGMTGIDe6jeWOccYLLD8CsgcgtoWe7zG9HMHLivoEhhr
         P4WXqOcisDB2q8G96iT8UcXiwjIVDr6uBGb3k2sZMzdhZcIho9z8RBqgXTbe8ANDkezR
         r5+u6uecdAqJRy4LYxd4kVYiqZmSOeyH8ABrvjOYTE1mUCupitekhmW4oByBs6MyvY8W
         HWGG+7uE46bT/8aAoTFfZyCFF6uiJxHzZUGYZhneCa7BeKGfW/+7OdPV+WzJxtQQ2qDx
         wiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788508613; x=1789113413;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AsK6CNkPzqL+25hJDO5/FxatvGOrEq2Iq+btxLgvqQY=;
        b=i2W4NCsMoenrYiCSVok43Yl7tgB7O9To19vcTUQfKkgxeVE2SrBZtmfhggfwzXmaKH
         pLJVxxUPRmS+b6ikAM9iVzA8ox9aVoHKsedPw8lB6qUrLzZcD7QsHOtAnOnyA0jj0AUh
         a48D43r+OiRZFCjFYaCmFrAVZX8Q8ALFPm9MO4CheJLm3D0+dT3HhwV+mxmL+6ykB5g4
         grf2gszNSZsvP+sgdaa287pdSX41zqgf+Sm/k9IXt/1BlW9K5NF30ebZxV6DK2Yc9X8c
         /DyNW+emPIZ3nd3bPnjpQRsjy36BZOx+FleaPQtfb+AwXVaawE3NWc7HLUiqvoReEnkE
         /dpA==
X-Forwarded-Encrypted: i=1; AKwUvBxm1aV4yatlVC82XcQNpx+HzHreQpY/TbfwLSDj4Z6DJ5yf7uLvr1QXA+UoVhOVYI/d6GoZYcWnWA==@vger.kernel.org
X-Gm-Message-State: AFuF++lYXF+yCYr7jtJUFBiUzpWCuQKWZhMyzszZBrGmehBabnRMFAiW
	FGDQZ1zRxwPEMB/aU4FN+LY13QmqQ0Ij8IxvyjmlmtNR/aK6JpZNfzeDIZPe/9IB/HR3b2SErJ6
	oFGIocMP0xcPmykzAibQw0EDhm2j5ok4kdrAk/KA1RWKnkggNS+N+aZDCm7HNmjbrhZ9/lmWOGJ
	9Dn+P2POQkje3pcTO9eIckG31Ou87Jkuc3P3ce
X-Gm-Gg: AYBFou06EmxGRr6y5oSqqU3pRgYz78xOcd19kwGHM1C8nyx8uJeJBn1lSZSwmOvVgMn
	86sDYu3H8A2Y/7DMKtcYrWKj65rHfNYwCXvotMcy8mmh/layBVSAYyFFe90fpZkTv0mS2zg6CVn
	BOEL3jC5CrMrEXNblCbXB4NMfQ8D9pkSgzjxpVAKZbcOhvaS0R86mcqn5qsQ==
X-Received: by 2002:a05:6a21:3989:b0:3d1:af47:5f80 with SMTP id adf61e73a8af0-3da39f77bd4mr6420729637.11.1788508612962;
        Fri, 04 Sep 2026 00:56:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:3989:b0:3d1:af47:5f80 with SMTP id
 adf61e73a8af0-3da39f77bd4mr6420552637.11.1788508611689; Fri, 04 Sep 2026
 00:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <CAPx+jO9fcvBsxe9yx9oK=0EXmpNwub5ba0a-TGk1WRFaRGsqpA@mail.gmail.com> <177884a8-902f-49be-8fcb-b2bec3ec7d6c@oss.qualcomm.com>
In-Reply-To: <177884a8-902f-49be-8fcb-b2bec3ec7d6c@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 09:56:39 +0200
X-Gm-Features: AcwNN1UllrxbRYClFejSTOv1mPezdKyC-qM3m7DiYE7HdwsmgFFrqN7aqxA-MZ8
Message-ID: <CAPx+jO8bXn2F3cWz87Ozjrh00E+a_UWBrHeUViTEkTL87JHW9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] soc: qcom: geni: Derive SE clock configuration
 from OPP table on SA8255P
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA3MiBTYWx0ZWRfX2Fx8DCc1qXMW
 SnLSJFv4h/Q647/K1ke6uHPirRLdrAhZDu5r74wOVW3HwKUPBmaqu4q4yLwRfLl79IF9z8wIM8h
 ATf5aKVJ5h/RRrLIZGj9sQTp76Z5f6s=
X-Proofpoint-ORIG-GUID: QupFNeIDtmwwIbeGNXmL4LFMO-K-gYJ5
X-Authority-Analysis: v=2.4 cv=ab5RWxot c=1 sm=1 tr=0 ts=6a9a79c5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=D1j1bUi7ZpnfGdUu11IA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: QupFNeIDtmwwIbeGNXmL4LFMO-K-gYJ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA3MiBTYWx0ZWRfX6OTVGINKTGp0
 BMidnNCS/0MAIvrj/TMb/lfgfVYm3Dy0UhrIVbejcKrAon8GXfmp6iPP1jIeyrfplVwwoOO3XtO
 xQJE4fLbn92CiN2c1GT4TM8HEflkccr+aWE0GdWLC7FE9qcAneg5ncVqXLa6tudY61mWli2LLZt
 txgt0YVX6WlB2SD9NPPLOY2AXJrSTRKpepthdqjqAqrME4BrhNc6XkHIDpqpqM1ph7M8ayEcPYu
 XRqyTKX2UtbUJk/JHMesCWHoA8pAycbSQlRPOz/cNcJLo4HPLtrVUzHUBDYLSMCrQH0uVIlRj+s
 QhiRY8Jt/Whk1My2jK6Bsj3CZJc8HYcCuIyayRnBRdm0Imo/dq9CQ4JWAcyxusk+UGBCYHfveVs
 +GLoK8Itcz0OqWA/Rp+DkxabIHb2dC5h8dH5gHitp8/OAgVfJo7itZn+bdzIP6N+w3b7rqhPsE9
 ktVg7dn/BhNDyvy695Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040072

On Tue, Sep 1, 2026 at 6:48=E2=80=AFPM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> Hi Ulf,
>
> On 01-09-2026 20:22, Ulf Hansson wrote:
> > On Thu, Aug 27, 2026 at 7:59=E2=80=AFPM Praveen Talari
> > <praveen.talari@oss.qualcomm.com> wrote:
> >> On firmware-managed platforms such as SA8255P, there is no Linux clock
> >> handler available to determine the appropriate SE source clock, source
> >> clock index, and divider values for a requested protocol frequency.
> >> However, these parameters are required when programming GSI TREs, wher=
e
> >> the hardware expects an explicit clock source selection and divider
> >> configuration for the serial engine.
> >>
> >> In contrast, platforms using Linux-managed clocks derive these
> >> parameters through geni_se_clk_freq_match() using the source clock
> >> information stored in clk_perf_tbl. Since the firmware-managed path
> >> lacks equivalent clock information, protocol drivers cannot reuse the
> >> existing frequency matching logic and instead rely on a direct mapping
> >> between protocol-requested frequencies and performance levels. This
> >> creates a separate clock configuration flow and prevents
> >> firmware-managed platforms from deriving the actual SE clock parameter=
s
> >> required for GSI TRE programming.
> > Hmm, this sounds like moving backwards when it comes to keeping
> > drivers as portable as possible.
> >
> > I understand geni_se_clk_freq_match() has been around for a while, but
> > fortunately its use seems limited to only a few qcom specific drivers.
> >
> > Rather than continue down this path, would it not be possible to find
> > a more generic solution for "geni_se_clk_freq_match()"? Can we replace
> > it with a common clock/OPP API? In this way, we would not need to
> > sprinkle drivers with calls to platform specific  code.
> I agree that protocol drivers should not need to know whether GENI resour=
ces
> are managed through the clock framework or a firmware-provided
> performance domain.
>
> The intent of this series is actually to move in that direction rather th=
an
> introduce a separate flow. Today firmware-managed platforms cannot use
> geni_se_clk_freq_match() because clk_perf_tbl is only populated when a
> Linux clock
> is present. This series derives the same clock-performance
> information(clk_perf_tbl) from the OPP
> table and populates clk_perf_tbl during geni_se_domain_attach(),
> allowing both
> resource-management models to reuse the existing
> geni_se_clk_freq_match() infrastructure.

Right, the goal makes sense, but I am not sure the proposed solution
is the way to get there.

We really want to avoid having generic drivers like (spi, uart, i2c,
etc) calling platform specific functions. This isn't just me, it's the
general way for how we do things for drivers. Of course, we have
exceptions, but I think you get my point.

In this case, why isn't it possible to use the clock and OPP
framework? Is there anything missing to make this work?

>
> Likewise, geni_se_set_rate() hides whether the underlying implementation
> uses
> dev_pm_opp_set_rate() on a perf-domain device or a regular clock-backed
> device,
> so protocol drivers no longer need platform-specific callbacks. The goal
> is to
> converge both paths behind common GENI helpers rather than maintain separ=
ate
> clock-selection mechanisms.

The OPP layer already has some capabilities for managing clocks. Can't
we use devm_pm_opp_set_config() to prepare an OPP table with the
relevant clk data for the devices, as a way to abstract things?

> >
> >> To address this limitation, the performance-domain OPP table is treate=
d
> >> as the representation of SE-supported source clock frequencies. During
> >> geni_se_domain_attach(), the OPP entries are used to populate
> >> clk_perf_tbl and related clock performance data, allowing
> >> firmware-managed platforms to leverage the same clock frequency matchi=
ng
> >> infrastructure used by Linux-managed platforms.
> >>
> >> With this change, protocol drivers can use geni_se_clk_freq_match() to
> >> select the closest supported source clock frequency for a requested
> >> protocol rate, derive the corresponding source clock index and divider
> >> values required for GSI TRE programming, and apply the matched clock
> >> through the OPP framework. This removes the dependency on direct
> >> protocol-frequency-to-performance-level mappings and provides a common
> >> clock selection and configuration mechanism across both firmware-manag=
ed
> >> and Linux-managed GENI deployments.
> > Rather than adding yet another platform specific method, would it be
> > possible to extend the generic OPP library with the pieces that are
> > missing to make this work in a generic way?
> I agree with the goal of using generic infrastructure. However,
> geni_se_clk_freq_match()
> derives GENI-specific parameters such as the source clock, clock index,
> and divider values
> required for GSI TRE programming, which are not represented by the
> generic OPP interface today.
>
> This series does not introduce a new clock selection path; it reuses the
> existing
> geni_se_clk_freq_match() flow on firmware-managed platforms by populating
> clk_perf_tbl from OPP data.

So geni_se_clk_freq_match() is used by two consumer drivers today,
drivers/spi/spi-geni-qcom.c and drivers/tty/serial/qcom_geni_serial.c.

Beyond the $subject series, there will be even more consumer drivers
that call these platform specific functions. As I said above, I don't
think this is moving things in the right direction.

If this can't be solved with generic frameworks (clocks and OPP),
please clarify why so we can figure out a better way forward.

[...]

Kind regards
Uffe
