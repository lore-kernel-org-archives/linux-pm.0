Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794815247;
	b=kPc8GxY3w7oG99wdVC13Jza9hDyvlacEfFclioLcK0mFwHUXIRYS6ogjrsTOGft0VqeW
	 3LottyHr7D6rPdFXFoSoOI1ZzUXqolZ3bsyDuj6FUKJLc8ImAFkjDpjOLiv0dtkIl3NoB
	 lRbkgIF8cKB7SNF16ZYVox6AAbetOP/cnTvNrVt+WVy0SMasHuFHOekZpHamFQfJxlnvk
	 QSg4KVuYLCm7/6zRauFS75N/Iw6a6FAvurm0anAUGpX5+EZUhqtKP6r1PWws+p4K+dbbk
	 3ImEDCLv3Aoptm+b7aOjOaq/Jj80MxoI74ECxc9kawGz37kfhvqGqWByPq0pqYSZdbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815247;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-ZohoMailClient;
	bh=OUTfZXv8x7eL7MqFjv0jmWWqCW17mS56gXHeKOmtpac=;
	b=P5eQhJ3Zq8PEPUsw+TpWt08Yz8HFQpwwTno2vMo+4BdSCxi7ZzCxDIlq5YM39XJ4Vaax
	 +WYZ9xxnYRCXIdZfFSJwUOrmn6D5I7AushQWlikpVVPHvvUk2zvQVCrTpT+2x+RGWH3B4
	 Z3oLk4+juXM2fXXfVbM4QXb1/N9D9FNszaTXY5A2yf1Dyr92PgZsXYWA2jxHsP620iYvQ
	 9WtYZK9IktwWCIXDUElnc8gQ/9sKwN69XLVGXwrWy/p59VdOdYWNoPGxx1Op5TSVudnD5
	 y9swM2BpeUu2P924UGdOcXo2RKoKmQf8oKlt3dmFvty+7/cM5H+x8V5E+8fhGCrycyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=icenowy.me;
	spf=pass smtp.mailfrom=icenowy.me;
	dkim=pass header.d=icenowy.me header.i=@icenowy.me header.a=rsa-sha256 header.s=zmail2 header.b=mIvoRN0S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E42F606A31C;
	Mon, 16 Nov 2026 07:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E42F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=@icenowy.me header.a=rsa-sha256 header.s=zmail2 header.b=mIvoRN0S
ARC-Seal: i=1; a=rsa-sha256; t=1794815227; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b3dX3z7c8GFLUI5FjH8mIhgOyYSA51JeUkEOFuLCLF133Gle+fjvbB+ac6keHKZeDlHSaofM0sf3vs23/gppDwsE317B4UO6N9cAEvvzp+M3wvnthvpt68p7YiFGLpALccy9LE8keCwW+sidDGtBO9WCel7jztJ2dAfBiGYH7Aw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794815227; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OUTfZXv8x7eL7MqFjv0jmWWqCW17mS56gXHeKOmtpac=; 
	b=dcA/+LPEvCvS2urZRT7Gh5ZEPbzq2EduvUULHDPVgosMueAZ/Xym4Kn6zQYxYcHeMm3DQ5H4zyO4Y0JRNSaXUGtJyl341MU39l1kxug0F1iN18H/coynhi0QmTGE8CBvTsgepj3H4dgN11YXTBXAnfYz4fQLrFJoeZdQv0ykZ84=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: a=rsa-sha256; b=mIvoRN0ST5AP8MT6qVavjzJyxAQ7SFGcjKnUup5BQLCsGI7ny6wSsMQLnrb9M8PwFElqyVUHsR/JaHuE2YPNvHp/n1IWkesy//TYSYp6FtgmVYBHF0hLYzraTTswWdBQIOYoSEK0ArLmw0s1YmwtChkhnf2AoQi3Iu9dEOySWJgsJxFCagsm2m5WIx6Sg4iMtEMpvA/G1YL5kc7OcAVl72hw3d2+so0zGpKapw15ZG2DgYXRboefObfWqg4jkGsqqftoOSIhBbujYFmKHuKLBIu84y6kfd90D93MUtJ3cb4MEWUfHrUXN+mIgAuEICkxsgsjMoHL2PjHWwgmT0TF6g==; c=relaxed/relaxed; s=zmail2; d=icenowy.me; v=1; bh=OUTfZXv8x7eL7MqFjv0jmWWqCW17mS56gXHeKOmtpac=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794815225743796.5951054994644;
	Sun, 15 Nov 2026 23:47:05 -0800 (PST)
Message-ID: <b7d7ac2eee0e64aa7c267def5c2a8a022c7da425.camel@icenowy.me>
Subject: Re: [PATCH] pmdomain: core: connect consumer with supplier via
 device link
From: Icenowy Zheng <uwu@icenowy.me>
To: Yixun Lan <dlan@kernel.org>, Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>,  Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Date: Mon, 16 Nov 2026 15:46:59 +0800
In-Reply-To: <20261116072442-GKA100890@kernel.org>
References: <20261112-01-pm-device-link-v1-1-8932e0862378@kernel.org>
	 <CAPx+jO-37Km71oSW+zOO7BBWLj86SNCn=U=EGmBXdC5SfX4nbA@mail.gmail.com>
	 <20261116072442-GKA100890@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2026-11-16=E4=B8=80=E7=9A=84 07:24 +0000=EF=BC=8CYixun Lan=E5=86=
=99=E9=81=93=EF=BC=9A
> Hi Ulf,
>=20
> On 12:33 Sat 14 Nov=C2=A0=C2=A0=C2=A0=C2=A0 , Ulf Hansson wrote:
> > On Thu, Nov 12, 2026 at 8:45=E2=80=AFAM Yixun Lan <dlan@kernel.org> wro=
te:
> > >=20
> > > Connect downstream Power Domain consumer with the supplier
> > > through
> > > the device link API, So when the pmdomain driver is unloaded or
> > > unbinded,
> > > the consumer can be automatically notified and purged gracefully.
> > >=20
> > > Signed-off-by: Yixun Lan <dlan@kernel.org>
> >=20
> > Can you check if the below commit that sits on my fixes branch
> > solves
> > this problem for you?
> >=20
> No, I've cherry-picked below commit and it does not solve my issue,
> =C2=A0it's a different problem.
>=20
> Problem here is the pm consumer side isn't aware pm driver is
> removed.=20
>=20

I do think it's just better to prevent PM drivers from being removed.

Thanks,
Icenowy

>=20
> > e279833a5362 pmdomain: core: Wait for device link removals before
> > dropping genpd->dev
> >=20
> > Kind regards
> > Uffe
> >=20
