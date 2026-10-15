Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EED4D7D3A
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061332; cv=pass; b=fJl9SE1dyYC61s1SLCSwejCVemNDDiAlWld8zCEay3BE0+xBFuqyvQF12nBsZjmpMQH+bPbl0xgo+WlS4GoDBqtDXyaHHhxkAH6jnt7ZZEArS4EiUFhePuIKfXsBGN/MOQ5EVbWtJe+KnFcGVC9GXZMfawn+COYF9ED9WQHGHvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061332; c=relaxed/simple;
	bh=FmmRZ608D4C2zUwqRQSrC5bNE6F6es2uQjBujj5jDeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEgdloMRMHZOhHB/iiL/0L6fBA16gIjxokY2VmXvPH1fg9FrM2xWlk91FnkhjqCuWVFGStojHEMitw4jraaJ0zVd8GyvlNUiC9D6cqwzWrbJnT2tkfb3i1nSUVjOUcR/wO2Eodl/QSlannqFaHoKnNRfeLPJdy39Ie/ogdOLuII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGHY4KRj; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGHY4KRj"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b0584ad71so3065201f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 03:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792061328; cv=none;
        d=google.com; s=arc-20260327;
        b=ENZb8glRodWtSGasTAAHaBSZUTydS3Kz1gy+B3G6xNmgkqOOZ/WtoHzv20syBqYp8a
         mo9kvNcsZTFtv+gWzmiOMoDSV6fc2oBgQ7AOTX02bFR1iGmcU/AtsQ96q8dM3kh550yH
         qu1C/NnipKktHfsgA9Ehu3dxCsUfp8/9zyZqPlcI0QhvLLfoPyCwAulUv2inzlV1QWaN
         8cwsBSrqbpMHTsMjApQ1gtFs3mf1DlpyT+sr5CJ5qxY1uNof5S/zKo2FDjTB1zvw5QXD
         eitV8bwuRLTMDxvOYDkB2QBxOoZE0oeRZY1lxWaWVGQJi0pwIR5HfInCsq0WH7APBekH
         P8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p8Bpe0WzfKNt750+YudJl1Zs2RvA8+Qnb6B1KoIdGiE=;
        fh=qVO1pH25RWi7kNBVUF6b7GRL2UK/xGxsB0+htjzmOco=;
        b=syIwl6kUVRcRxAvZ4ptxX4F87I1uPJWClhPgtoTuVLnFcSWP4qpsuwNj25HdQ1FpY0
         tmfWREPcw71eDQ6au3X/FFa1eSyHiqcHPPWKRlOVZbroGSVLxwp1I+Kl2jCVI+hNGrNB
         Ri0fwI/h1etrvDlEOHYlUexrh6dgsVFJDApr2nWrk8lLxc5q+OQ+pVexYwNWMvDovV/i
         wGW6uLWt0AL5L0tNnkO4SZws6uhq1mgxzeX8LpErQ9ELEXOFcf46lRo4ccdnkiANf+3K
         muDFr5HbSJM13XUuDotOJoHEh5sql/q0Shv/r0lhUhk5PQ2/1XRSKyD2T3SrpdqHZ9yF
         0wQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792061328; x=1792666128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p8Bpe0WzfKNt750+YudJl1Zs2RvA8+Qnb6B1KoIdGiE=;
        b=HGHY4KRjFFixMp8LxPY4W3sl6Fm2iSsRXws7p5amThHrS1bIMSDbzUcJsNhVHSSSkc
         vpnNNCGYFQbntsLd1GE47O4adACIyeRq2DalBo3fGycYeghLHa3mtfdd3qsuyz0nFAaW
         2vPK87O6CwFiW3efiCeV6a4apP+vsoIe2IbsQ3D4FTIf4NUUQkZa4kuwJVQddzSUlDJJ
         lCRMqyX1xuV5bJQl5pSFtMD2GbL0inp/SlPPmbq08jAJmjCbMIayUjGZWeDrjGeLiU3q
         uMMyguf1Ewiy3k94edtnPsZrMx+7Th1M635N8HKSf1SJkhMr4Tc3ntl5kNofpTjMnxil
         9UNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061328; x=1792666128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p8Bpe0WzfKNt750+YudJl1Zs2RvA8+Qnb6B1KoIdGiE=;
        b=xgh8ybekoXcfoBD+aAc0nIL3zPyu09TvB4bT/AUx8foKqpvoi+aeQE39ZdoZQFiXHk
         ShEuWGA1nvHVl2qCXXaoX+Bn6QKXRDEttjMNmoWtsIjVXZLHjO32UAKUkGX/JrcghTEG
         jvqr/ox+5jmxzCvvXYv1TGgBC/LnbywVQxeqa4cSOl9+LUFB1iyGBaF/mCyczXWsB9nl
         1H2EoDeU2P2k8LqbdQ2SLl3tu7mxmkJb0IK/hywY4HbWoS7SNCV5JT/lLSk4urpKa854
         YcXwtoRldrZskhQ84CqZU9rjd0qbIu9rCPzf6SSD0nT4aGh9V2vRMTMXiz1F42mfwSRO
         bUtg==
X-Gm-Message-State: AFq9FYKofDna3Ztp6/tl7CI2BkBp0w+3cUC4rzvpUyyj+V2Qq0S30DCS
	7TABREiwPslbmFpX/A+QqHeyQcmen8fkygLVD0YZ/TYdcBJTyvHJxpZk0Rosls+9YilRgrl1Eu1
	EF2FDBF/8sQCWkJ4eYXDYnt9XJFtdIRD3OLA7YLQ=
X-Gm-Gg: AYBFou1gwzfKERhooFmeiYJH6WGk3Mqkvko8ftR81+mGWAPIy4AV7xwVIYfoFJ3ybhO
	ZEs1AkBp5cc1Gdqp9pzGnFAP0f09xV0qvRzzZedoPpt7oJNK3KOl0OapZx6TsmOfxrhQIVh1KE3
	M0jEk9cNPPVdoF55b5lFT8G4G4simbf1k+2w9wIYIradg/sUxEMf4Vd/ca56RiRk2Ubm2Nvn2GH
	pXdhQEUaxZpC+dvMNqjpOvj1o9Jtd95ZNcpZ5HLDwcHqwu4D6ukxMaMH8v8Yyx8d9wOBfHFqdfQ
	6B0gmIIz/tlRePtiOSMl22ryth+e6fMLyI9NKwzAfZ5zK2yIJPqUWhW4Tf1wxVukaGwesqPMX1p
	BdYeW7MgNyqYOpVhG3MRptbjJ3K4GdEVgWdxFB0LzD/FtEpqnbiFZioLjHTyYWDOxyZbhMIXXWM
	QVtc/nyj1G
X-Received: by 2002:a05:6000:4305:b0:48d:f2a3:3a4 with SMTP id
 ffacd0b85a97d-48df2a3048amr4041591f8f.16.1792061328335; Thu, 15 Oct 2026
 03:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009165710.1320233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261009165710.1320233-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMRc=Met2DuvMz4fZjSn4as56uaKaN4K3Nt_ub=4BjaLQe5nmw@mail.gmail.com>
In-Reply-To: <CAMRc=Met2DuvMz4fZjSn4as56uaKaN4K3Nt_ub=4BjaLQe5nmw@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 15 Oct 2026 11:48:21 +0100
X-Gm-Features: AclHuK9GL7dcegAHXj9a4i5LIQhbxiG32N7YkVxCBuH5SJV_-Wy1REjdRCS5iRg
Message-ID: <CA+V-a8toBu8SkOft-LHxgR0OEy0pz8sMGMze3GCG5z6n-YuZgQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] soc: renesas: Kconfig: Select POWER_SEQUENCING_RENESAS_PWRRDY
 for RZ/V2H and RZ/V2N
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

Thank you for the review.

On Thu, Oct 15, 2026 at 10:45=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
>
> On Fri, 9 Oct 2026 18:57:10 +0200, Prabhakar <prabhakar.csengg@gmail.com>=
 said:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The RZ/V2H and RZ/V2N SYSC drivers register auxiliary devices for
> > power sequencing, which require the pwrseq-renesas-pwrrdy driver to bin=
d
> > to them.
> >
> > Select POWER_SEQUENCING and POWER_SEQUENCING_RENESAS_PWRRDY from the
> > RZ/V2H and RZ/V2N SYSC configurations so the power sequencer driver is
> > built whenever SYSC support for these SoCs is enabled.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2:
> > - No change
> > ---
> >  drivers/soc/renesas/Kconfig | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> > index b7abca4559df..32cd0d9c8758 100644
> > --- a/drivers/soc/renesas/Kconfig
> > +++ b/drivers/soc/renesas/Kconfig
> > @@ -517,9 +517,13 @@ config SYS_R9A09G047
> >  config SYS_R9A09G056
> >       bool "Renesas System controller support for R9A09G056 (RZ/V2N)" i=
f COMPILE_TEST
> >       select SYSC_RZ
> > +     select POWER_SEQUENCING
>
> That's implied by the symbol below though?
>
POWER_SEQUENCING_RENESAS_PWRRDY will only be visible when
POWER_SEQUENCING is enabled. If dropped, randconfig might generate the
following warning:

$ make menuconfig

WARNING: unmet direct dependencies detected for POWER_SEQUENCING_RENESAS_PW=
RRDY
  Depends on [n]: POWER_SEQUENCING [=3Dn] && (SYSC_RZ [=3Dy] || COMPILE_TES=
T [=3Dy])
  Selected by [y]:
  - SYS_R9A09G056 [=3Dy] && SOC_RENESAS [=3Dy]

Cheers,
Prabhakar

> Bart
>
> > +     select POWER_SEQUENCING_RENESAS_PWRRDY
> >
> >  config SYS_R9A09G057
> >       bool "Renesas System controller support for R9A09G057 (RZ/V2H)" i=
f COMPILE_TEST
> >       select SYSC_RZ
> > +     select POWER_SEQUENCING
> > +     select POWER_SEQUENCING_RENESAS_PWRRDY
> >
> >  endif # SOC_RENESAS
> > --
> > 2.55.0
> >
> >
