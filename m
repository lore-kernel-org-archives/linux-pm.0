Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0F441D21F
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165548; cv=pass; b=cxLj1cNDmzTjPdTjQffK8h57eygi66BPL5X65zzWZ4SEFQNiCGhKIzMSYXtuUbuc7ULQ5SB0ApyDqB7p4FkUP8BjdS65fjW8ngrWXuosad1ueU/wLKXtEITiciP65NoG3zLgR2mDkbzZmIqi/+l5QUquvlWxLeLYDAkrGTHypnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165548; c=relaxed/simple;
	bh=otl8liIb8W8IWl9VhhkrAOQ4oieAS8mQOQ3oJNhRrPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdug9XsEIDkFKd4kSZlqHFXX+pSlWxdAh8Z3FZ5j0+2p4ccHKlxXqPQtDvvRNsbA6C4brnXVeSFksqiTdzahg190V1eRJ2Kp6sn1eYa1+N2d30sxX+GzU5+qe7Bdgn9ABEZSzYaUe8O9hhiCG1g8PnV0eHK1SjPI7csKcjaUAak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ng/mumkP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hk6gL75e; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ng/mumkP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hk6gL75e"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbdEW1831903
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 12:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n7V7ql5bnTlujjDYznFGFQp5Hg4A7cbqQcUtRXp+0cs=; b=Ng/mumkPNmTwMVxr
	KDEczxhCcBHu0SPYMHfl1XD6OpmyhbbSAaOBYgcj6DOTpqB7516LIONMW0BCMtND
	bfMX/E+RVovSWDdTQWLyVly0kdNGMw+gmhbBPciZR4kwOUocTudjSTCSky2j+Ncr
	Ga0b1T0/EG+/R/pXlLbohmeeG5XpJP6+Jbr512R5cYWQIvmGjL0sRTWCHSo4ZvPj
	OMQw7v4/xvkFqXUjKT3NNXH4fCE8hopPX9d07OnpGCH46NXnPjaxrp24SdZsC9PB
	MeXMs4uixQx+UInUDebGVMVAxE9SraG9ganD+4VqjHlADW4nLoJ0MfnXrBu1JiXL
	/SHvFw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guyma3tty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 12:12:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39de1f85cb2so828509a91.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 05:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790165545; cv=none;
        d=google.com; s=arc-20260327;
        b=MGo6Kvd3EnCt9pjGMVhNqobH0BhCeuxpRmKMYjxMNGn+BXrXcj1SiFpzzd2atWm64A
         4bkUcb4DdBxu/leQh0wMU3hV1biNdMvWpiVq6VGU0R5EZ9lwiuNghM8doKwQJXr/8KMY
         WYjxaK+KBcHw/HZwK2B6V8VpcwnBaH9NXPmRsI1K/6V126Wwk7h1UR2ET39KmD8w5mEO
         tI1E31PMnkkIZVOQQCegEoio4olh2xHuFmhgAkweiqpeasIHpKd4dOuG00nee5suYvR/
         2EQdy7brdGt+tRs1zpl86hep7/H/7ZMzCexgkAUPuYMPchmmQv5HzSLVE9pCGsgCM5rJ
         HUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n7V7ql5bnTlujjDYznFGFQp5Hg4A7cbqQcUtRXp+0cs=;
        fh=ay/AUTmfbUCJKe+p6zlpEvzRZBBqi+5dXGyAJ/+GcLI=;
        b=lqsgFluwSdSNASB5YaJHTiNmtYYAafZoKtEbT9TYX3IQ0vB5USM8ijH64auj7yA8kL
         K8SQ6Gr7qGYQN2WBsGl9hn/SNMhQawByJadU8nRWzcVkLQsigUS1CCjFePG17W4dYk5P
         rXybozIcISg0qniZiFrNntlsGW9PD9SJKh1MIzNdvxslWvZk9N3iMHFfiGSLorx7mG+J
         A23EF0/Je2NN/NyTlvVkSARLEv4ZU83UyEnDbgz3Jps1Z/+NZLsEI8xIn5RRkCZYispJ
         j5/nm88iAWGkZgBRPQEZ/SphrffM/7HVkLdvD+of4H7bIqm4xcgHLtMhZo0C9njBqA3q
         3ayA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790165545; x=1790770345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n7V7ql5bnTlujjDYznFGFQp5Hg4A7cbqQcUtRXp+0cs=;
        b=Hk6gL75eW4amJ6F7s64TXMB284uLQsBDpVIfcdNywSg87ikbo++y3ILvm++50OQav7
         cwNCmZH+gB1YMk2felj5gBNJw2eBwROa4m7JEusZ1oxlMGw83Kgs+OdCpKBePsgUL0eu
         6z7MD7iki0lFoKjxIzvCD0d+kHssVcYP3g/Joy0uoJPh8hQqIoWnNAD1i0QwlbrRtnz6
         xXfJxOpHltPBPTWEurJ+7zOFyL24RBsDpdBvrtE4idwQMFD6o/Ddf7gFeXsIWoUDaobh
         FQRlEe3F2lGnMsU1FzcmBNhZhB65D6b37hXJV//A3yhdu6O20d9ex4UlARRiCyC1WzKe
         jP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790165545; x=1790770345;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7V7ql5bnTlujjDYznFGFQp5Hg4A7cbqQcUtRXp+0cs=;
        b=QGW+IoelXQUenOEvSQE0qMwXh9LhM0zG/WRix3S9ETLsvcqp7AuIDtue8BMLtzvZcr
         Vq7pl4uSEYqSIU6yEH2SrP9JJyGCnBS/AhauqySikT0O403ctN5APCzoffgZyJxmPbk8
         amYM5q9+TIRom2AO11d8pPHdqwIWIDDWBktQsvhgLJmta2rLfq1sg+T/VF4ex6zRnoOy
         h1CDv5cPxRiy2m1BsdHCksRQeGFKN44W5nyQxN0ROFyS3xIvE81EhqlfVI5R9Wm0OFwD
         EhWU1slHOueDexaI1TC9VSIDnzhNiwlaSpZclSXHmHV7JrQ5Acp1Bo260b7Uj21SMIKj
         Rq+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwQ6n5GHpccLgF+ZIVasmK4OfPjIRIAqKorXwxT3skc/tXwtRlpSsrjb1a1XbxvmXtCYZKwEMbDUw==@vger.kernel.org
X-Gm-Message-State: AFuF++lTD72XxxgqIX1EvwhF+26bAiwE3ogjYQMfsnkOcPyAxpHg2yED
	MjHpgeslNRrV26A/8Pt4SEU7aQ2oChv2AIYmA7isA8s5zugizQXwsAK7CsmuDNrlK1CrBi9O9Qq
	+2eF3ATDh1dGKMUTrNp70AbD4ExzG+OEG5Wh1r7dAUCQxCR1n+zj2yzdI0GkhgOKrb+qsJ+sfGY
	kPGLhN5avS0AJnmU7UItqX6H2K+PwJCqrewLTH
X-Gm-Gg: AYBFou3Hi+/505yFMqeM/TH9lRBxkZ8rXNGCZNYkpPQERBzXywEo22Jgs0LiA19Gz5u
	8tgmeBvQhWydemLre/r+xnd7EVySUEZn3SkL2lgPqzCU6u9jdvxKddNo/MBSX/i1WSfJsTz5j0a
	FZzIzNVG++dcis3QhaxaPJuS2eM90GZabNIksRqoJOyH9k5eqbTQNd5oY2hYJNbisBguwb
X-Received: by 2002:a17:90b:3f0e:b0:39e:59a0:46b5 with SMTP id 98e67ed59e1d1-3a07e5606a5mr2042101a91.24.1790165545106;
        Wed, 23 Sep 2026 05:12:25 -0700 (PDT)
X-Received: by 2002:a17:90b:3f0e:b0:39e:59a0:46b5 with SMTP id
 98e67ed59e1d1-3a07e5606a5mr2042073a91.24.1790165544489; Wed, 23 Sep 2026
 05:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921134432.50338-1-ayman.chaudhry.kc@renesas.com>
 <20260921134432.50338-4-ayman.chaudhry.kc@renesas.com> <CAMuHMdVkh_qpJKqD7N=njG+35gS+rE7cFfWQ-kS3aRoTByxH_Q@mail.gmail.com>
 <CAMuHMdXmJWu5DD5sQ0epWX8FnWc7zt0CTvJ5_jpjj-Hnvgg_cw@mail.gmail.com>
In-Reply-To: <CAMuHMdXmJWu5DD5sQ0epWX8FnWc7zt0CTvJ5_jpjj-Hnvgg_cw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 14:12:11 +0200
X-Gm-Features: AcwNN1U1n7SQ18uSpUqLgK21GdYB7lBiWF4g5o3P6GVe9OMu93MP2iK1mK9PKiE
Message-ID: <CAPx+jO99DnXLzarD_rWgr43e6vzWCJjYWaVFh_hhr6rtivXxFg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] pmdomain: renesas: rcar-sys: Add r8a774a3 support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: phR_Ff-sSUCr77A7xsetJ180pOjZGDYj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfX8m1RneO/Jmug
 Cs0q7IJOp6nmlsQYvf1IWGEnHSfHCGsYRu+ryW693y/CRHbOnNILJb8aGhp+Vi9nMw993DsgU67
 PPMJyG5iTQtm/W6BP3nSKJd0eBJgib4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfXzvNnOL8pRN2T
 nNG8CmjHjsjgl21uYuZ2WKeq2o357S5vYB5zT1XpKZtaGdzps/89ACj8b/uxX363xMkpvTTSo3t
 WG4/uXXXTlGMOwF3X5TbGM+stYC5Bagnfg5v6ruqwLw0a1rR9+OSHYKbNyOXzmD4jlsBUqJKtUT
 8HIe3oCwvtLzNh+hoPwuXrsfPcb8QbEIXyrv8+SN7iDYNW8aAxSCU/1c7NM6iFa9hQx3Auzy36v
 RAqpX4B3xMXwXRzlCUfifAyuRlTqJlStgbac3m0NNdbR7jrjkFtqmP6PQOEiHfGkvJwAkwE8Nru
 eRFBIkwrcc6ZavZ1ncD/z5XIwALPyPBr1632/rHnbwo0L6r6BiDKsyolLQKmGNvxu8eE+Wm4uyQ
 P8NAp9GJxFbZDZ5FENw2r9gqoHv38FieINP3BV1B3jX3BUkukpOLd2jhU3E6yPxqWUissqYcSjI
 PTBYpvs6DU6b33UriQA==
X-Authority-Analysis: v=2.4 cv=N828hG9B c=1 sm=1 tr=0 ts=6ab3c229 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=tBb2bbeoAAAA:8 a=yC-0_ovQAAAA:8
 a=gynxR62fjgbsPHoWIaoA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=Oj-tNtZlA1e06AYgeCfH:22
X-Proofpoint-GUID: phR_Ff-sSUCr77A7xsetJ180pOjZGDYj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230048

On Wed, Sep 23, 2026 at 1:45=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Ulf,
>
> On Wed, 23 Sept 2026 at 12:33, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
> > On Mon, 21 Sept 2026 at 15:45, Ayman Chaudhry
> > <ayman.chaudhry.kc@renesas.com> wrote:
> > > Add support for Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC power areas
> > > to the R-Car SYSC driver. The RZ/G2M v3.0 SYSC is similar to the RZ/G=
2M
> > > v1.3 SYSC, however it lacks the A2VC0 power area.
> > >
> > > Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > v1->v2:
> > > - Added space before closing brace for `ca57-cpu1` area
> > > - Updated include path to SYSC dt-bindings
> > > - Added Reviewed-by tag
> >
> > As this has a hard dependency on "[PATCH v2 2/9] dt-bindings: power:
> > Add r8a774a3 SYSC power domain definitions", I will provide a shared
> > branch with the dependency to Ulf.
>
> Alternatively, I can just collect all pmdomain patches in this series
> in renesas-pmdomain for v7.4, and send a PR for that, similar to what
> I do for clk and pinctrl.  Up to you...

Usually I pick the corresponding power domain DT bindings and share
them via an immutable branch called "dt". I would prefer if we could
keep doing it like that to avoid confusion and special cases.

Note that I already have a couple of patches queued for the renesas
power domain driver this cycle and whether this series conflicts, I
don't know.

That said, I am planning to pick patch1, patch2 (both shared at the dt
branch) and patch3. Would that be a problem for you this time?

Kind regards
Uffe




>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
