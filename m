Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870F7314D1F;
	Mon, 21 Sep 2026 03:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962011; cv=pass; b=YXskanthFv0Negp7Z2S9yEKul9VTW8oyZwH8l9jprjlCFVnoq0n5rMS9q1RURIbbnXJGLKewTeB8gr8Sium+1HtIZNkuMS3KC89kV1mTvEs9YPh1Bs2KlU14JydnrbXV79CzrXXRLHZ6w+uOHklkavfqWkLnfjUxqSGEOuMA5Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962011; c=relaxed/simple;
	bh=4w6Ld7u1Q8BK4R3B8dFoO9XD4j47BYZ7ETJ2PULMJOo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XIr3RjR/BRDmX8ohPTQYi88U/nanVMvRhMZGYO5W6OhUW7lEsxCXY18DDGWuAtE7ACd2rlpKstcS4i5azs5xJy8gnfFV0Iqmxj0TpvAl/8yTSj47C23f0fIuDK9swXQRAojQsPZAtjFv1oi7hWGQmsopSG5VNGTafij92cZL0uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=HLTiSKnR; arc=pass smtp.client-ip=165.173.182.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="HLTiSKnR"
ARC-Seal: i=1; a=rsa-sha256; t=1789961995; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X5pwW2IjnPHpzmr5K7OAGIATf4tr1RmrHZShCHmkRnFB80eb0og99S3ptID2GyBSbzyK50lRChsuR19Or95NULFeQDe9NQCur4D69JIHRsBhvk2b6Glao7gcFhr5uKFS/KvyKbAGadw/NpVtvvwYgp035iHibnjJuh4p0CJAH9I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789961995; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4w6Ld7u1Q8BK4R3B8dFoO9XD4j47BYZ7ETJ2PULMJOo=; 
	b=jrPzwenixC18SQEbj/hawwd2Ab/GR2YJ4aN9WSpVlxJl6MQSEi1UIu935TXYXnnofGOQQxzq+AhuKZbm2O7rWZ6sYeH9VUrZ90j49X2NhFngYAIfOKslUIWQwc0Q8QzWTyWWoUUubdWr8RDX0dFrx2u/AGEc8EvsnP2TLeX4YLM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789961995;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=4w6Ld7u1Q8BK4R3B8dFoO9XD4j47BYZ7ETJ2PULMJOo=;
	b=HLTiSKnRBxDG+DPoUe3cXgKegVFcNOD0rXriszZDzV1/F8Q+FYh0Lq2R2pUHcb9Y
	9HRcudk/GGPCRYxoArQ6deKisimm35MVSCMzGl8zVIa8o1Up0Gj0sNp2eqBpj8Ezxni
	rxpwU46CgPRFJekJUgUrLvG8MJWm6gw1sNLPv51gORVjhjVfocygjLSwS5towg0HB3/
	9qC9vaRbzWwaAFps2Kk2dNQUhskGeiCFFG5yzdHrSE2mI+RtR6S2PZEmv/dO26UU3ao
	OATfGI2Xfc/CboFvOf3pwIRJ2yDLcnU6Vl7ukFXtXfPoldSOlngD64qK1vak5j+s/89
	MzIRisP3Jw==
Received: by smtp.zohomail.com with SMTPS id 1789961993543581.7356580542081;
	Sun, 20 Sep 2026 20:39:53 -0700 (PDT)
Message-ID: <8ac3815961bebc5065ecabbbaed3e9920d5cbba7.camel@icenowy.me>
Subject: Re: [PATCH 2/3] pmdomain: spacemit: Add power domain driver
From: Icenowy Zheng <uwu@icenowy.me>
To: Yixun Lan <dlan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Date: Mon, 21 Sep 2026 11:39:47 +0800
In-Reply-To: <20260921033540-GKG297024@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
	 <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
	 <56e5f32102c67575ded8af9e81a06dc9f1dcf0ee.camel@icenowy.me>
	 <20260921033540-GKG297024@kernel.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2026-09-21=E4=B8=80=E7=9A=84 03:35 +0000=EF=BC=8CYixun Lan=E5=86=
=99=E9=81=93=EF=BC=9A
> Hi Icenowy,
>=20
> On 20:56 Sun 20 Sep=C2=A0=C2=A0=C2=A0=C2=A0 , Icenowy Zheng wrote:
> > =E5=9C=A8 2026-09-18=E4=BA=94=E7=9A=84 02:40 +0000=EF=BC=8CYixun Lan=E5=
=86=99=E9=81=93=EF=BC=9A
> > > =C2=A0 SpacemiT's PMU (Power Management Unit) consist of several powe=
r
> > > domains
> > > which can be managed independently, depending on different
> > > application
> > > scenario, each domain can be powered on/off for saving power.
> > >=20
> > > =C2=A0 The driver is implemented based on Linux Generic PM Domain
> > > framework.
> > > From a hardware perspective, either of two distinct power-on
> > > sequences
> > > are supported, in software mode (SW mode), the driver is
> > > responsible
> > > for
> > > controlling the states of bits such as sleep1, sleep2, isolation
> > > and
> > > pwr_state, while in hardware mode (HW mode), the PMU hardware
> > > will
> > > complete
> > > the sequence automatically without requiring software
> > > intervention.
> >=20
> > This driver is tested to be able to power up the GPU on SpacemiT
> > K3,
> > however the following warning appears in the kernel log:
> >=20
> > ```
> > genpd_provider audio: Fail to power-off domain: 2
> > ```
> >=20
> This is kind of an expected issue, due to hardware design, the audio
> power switch is coupled with rcpu core, which means power off it will
> also shut down the rcpu, so the power switch currently is configured
> as always on from software perspective, it's unable to power-off even
> in Linux or rcpu once system up.

Should the GENPD_FLAG_ALWAYS_ON flag be applied onto this power domain
if it's not meant to be shut down?

Thanks,
Icenowy

>=20
> I will drop audio power domain control in next version
>=20
> > (BTW I built it as a module to prevent whole kernel being rebuilt)
> >=20
> that's fine
