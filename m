Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.47.186.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707999;
	b=JnYQCDUfWra9IsBWKlpUxoCEOhO/H/rmJunugz6GgcK987w6wQOSoQrR8YihR2AG3Ti9
	 z8cozLM87ANMVCUa9juU5Muqgn4vePNCUKVOv61ajbzjHBf3a4/4QaTejeYsRLt4PiFz+
	 IO9wKeh3zT+yvzwRP6k7xqJkpVIuOkG7UINrWUzCxJwB8l19CWGZuTGxqwfgkMPFGr7K9
	 ty8souMvuHayHRLtoypYbyDndBxjEExbJ2CxsZ3LscnBJNkx0eV3xJGxVe2+O988l7D99
	 ZTBB45pyw5JYycu7Uysz8WOUfYKs6oHjr8P1BxGBFuN4n2Er82hi9OcqepBR2KOPJ5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707999;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=aNk1CIxhOLAytGei6bBD68KqohNxTSwFnPHNn3X83Eg=;
	b=W9VPjYPFd4x/wIQQJw8ImezThKUeeAQdRfr2U2AIiMP7BEhXz7HP3X+j493ZzDE6p9rb
	 JpUmjHC7YLGzdqbyXtKbrWf7beIMv7ksMgZvEJcLr1oDafL8hu74uEgULsrJLtfUmjm6a
	 QZSWKYrCYpiQgFpxT8Sgew2oZAtao1MniS97PnRrdltZ9J5KJ0KtuYAIqFWRb/Aaipktt
	 m4TYPPVCmip1EVucVO1j1XRTFb9hDkFLI1Ur57QaPUQTAJcNlPSCW//pdKZEa3ttvK8qA
	 VFJxJ0A31mC0dcxUcildGt0QG/jfCvzPxbHrCifzZhKsaJt/l6ieCAVGJS99xI2/eag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=krgm.moe;
	spf=pass smtp.mailfrom=krgm.moe;
	arc=none smtp.remote-ip=103.47.186.116
Received: from krgm.moe (krgm.moe [103.47.186.116])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38282606A31C;
	Thu, 26 Nov 2026 15:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38282606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=krgm.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krgm.moe
Received: from yuno-laptop.localnet (unknown [103.47.186.116])
	by krgm.moe (Postfix) with ESMTPSA id F171582E;
	Thu, 26 Nov 2026 21:16:35 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 2/2] interconnect: qcom: Add Netrani RPMh interconnect support
Date: Thu, 26 Nov 2026 23:46:29 +0800
Message-ID: <OK0H2hoOTniUo1R7Fcnn2Q@krgm.moe>
In-Reply-To: <7384bab0-5196-4286-a9bc-52166ed31068@kernel.org>
References:
 <20261125-netrani-interconnect-v2-v2-0-4eab92854137@krgm.moe>
 <20261125-netrani-interconnect-v2-v2-2-4eab92854137@krgm.moe>
 <7384bab0-5196-4286-a9bc-52166ed31068@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

=E5=9C=A8 2026=E5=B9=B411=E6=9C=8826=E6=97=A5=E6=98=9F=E6=9C=9F=E5=9B=9B =
=E4=B8=AD=E5=9B=BD=E6=A0=87=E5=87=86=E6=97=B6=E9=97=B4 22:49:08=EF=BC=8CKrz=
ysztof Kozlowski =E5=86=99=E9=81=93=EF=BC=9A
> On 25/11/2026 16:10, SignKirigami wrote:
> > Add a driver for the twelve Netrani RPMh interconnect providers
> > described by the previous binding patch. The provider tables define
> > the bus topology and BCM mappings used to send aggregate bandwidth
> > votes through the applications RSC.
> >=20
> > Signed-off-by: SignKirigami <prcups@krgm.moe>
> > ---
> >=20
> >  arch/arm64/configs/defconfig        |    1 +
> >  drivers/interconnect/qcom/Kconfig   |   13 +
> >  drivers/interconnect/qcom/Makefile  |    2 +
> >  drivers/interconnect/qcom/netrani.c | 1723
> >  +++++++++++++++++++++++++++++++++++ 4 files changed, 1739 insertions(+)
> >=20
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 6ec8d3a69..ff46c6915 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -1875,6 +1875,7 @@ CONFIG_INTERCONNECT_QCOM_KAANAPALI=3Dy
> >=20
> >  CONFIG_INTERCONNECT_QCOM_MSM8916=3Dm
> >  CONFIG_INTERCONNECT_QCOM_MSM8953=3Dy
> >  CONFIG_INTERCONNECT_QCOM_MSM8996=3Dy
> >=20
> > +CONFIG_INTERCONNECT_QCOM_NETRANI=3Dy
>=20
> This should not be here, drop completely. You based your work on some
> older kernel. Take upstream as reference, not downstream commits.
>=20
> Best regards,
> Krzysztof
I have sent v3 revision to fix this: [1]. For base, I will be more careful =
next=20
time. Should I resend this patch?

Best regards,
SignKirigami

[1]: https://lore.kernel.org/linux-arm-msm/20261125-netrani-interconnect-v2=
=2Dv3-0-1136e2cc6e3e@krgm.moe/


