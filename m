Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6653C4557;
	Sun, 20 Sep 2026 05:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881498; cv=none; b=jSSF3CKlbEF6il3zmkK3G8nW/PutNboKxI0FGJ3aK3b+1/pCqyQJnBOx+z5UxpebHyP0+7ndskgl+DJPWdd+KtX+N7OaH4PU0x2jk45JnlrdAb0tE2F5w5Jva/dL467LFG8s/ujekR3lK1JHZulEj+OsOtyjirexTuP8yZ/5vHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881498; c=relaxed/simple;
	bh=1AdTZrjEG5rVm64Wy23q6UY0iEhLPLMZtuoUctrq8do=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Arjy8NRMXM3VplukQ7lcpV7HBl+6fQ/A5YuYHFrEjdVDyLxM6nN1H1BS4zE7nvNgUsfIhCldXRa3lUj5MA7THU5h3h2BGlefh4e/f3ZhsHsHplbA8HPuc/Rh2MxVlNZftNAS4SEpua8Tjx8/9zpBDqOztoOqODJ87/uSlEWwiik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.103.44])
	by APP-03 (Coremail) with SMTP id rQCowADX4D6HbK9qQxUuCA--.44669S2;
	Sun, 20 Sep 2026 13:17:59 +0800 (CST)
Message-ID: <58c888729f24169a9f487bf8c4240a6d45ee6fe5.camel@iscas.ac.cn>
Subject: Re: [PATCH 2/3] pmdomain: spacemit: Add power domain driver
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Yixun Lan <dlan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Date: Sun, 20 Sep 2026 13:17:58 +0800
In-Reply-To: <20260919231333-GKB322102@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
	 <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
	 <a4359efeee2220903a05a2383a651ec8ec7284b7.camel@icenowy.me>
	 <20260918230107-GKC297024@kernel.org>
	 <33b33b2b79763d410bc2e5b4ef46c305aaf6f7c8.camel@icenowy.me>
	 <20260919095936-GKA322102@kernel.org>
	 <8301abce221e33d827053c54a64aed05f3227f7f.camel@icenowy.me>
	 <20260919231333-GKB322102@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:rQCowADX4D6HbK9qQxUuCA--.44669S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWDKFWfAF13ZF18tw48tFb_yoW5tF4kpF
	WUGa1UKa1kJr1ayr1Ut3WUXa4UK3y8Jr4UWrn8J348XrZ0vr1rKr1xtr98uF97Xr18Gw12
	qr1DtryfW3W8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07betCcUUUUU=
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/

=E5=9C=A8 2026-09-19=E5=85=AD=E7=9A=84 23:13 +0000=EF=BC=8CYixun Lan=E5=86=
=99=E9=81=93=EF=BC=9A
> Hi Icenowy,
>=20
> On 21:56 Sat 19 Sep=C2=A0=C2=A0=C2=A0=C2=A0 , Icenowy Zheng wrote:
> > =E5=9C=A8 2026-09-19=E5=85=AD=E7=9A=84 09:59 +0000=EF=BC=8CYixun Lan=E5=
=86=99=E9=81=93=EF=BC=9A
> > > Hi Icenowy,
> > >=20
> > > On 14:57 Sat 19 Sep=C2=A0=C2=A0=C2=A0=C2=A0 , Icenowy Zheng wrote:
> > > > =E5=9C=A8 2026-09-18=E4=BA=94=E7=9A=84 23:01 +0000=EF=BC=8CYixun La=
n=E5=86=99=E9=81=93=EF=BC=9A
> > > > > Hi Icenowy,=20
> > > > >=20
> > > > > On 17:00 Fri 18 Sep=C2=A0=C2=A0=C2=A0=C2=A0 , Icenowy Zheng wrote=
:
> > > > > > =E5=9C=A8 2026-09-18=E4=BA=94=E7=9A=84 02:40 +0000=EF=BC=8CYixu=
n Lan=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > =C2=A0 SpacemiT's PMU (Power Management Unit) consist of
> > > > > > > several
> > > > > > > power
> > > > > > > domains
> > > > > > > which can be managed independently, depending on
> > > > > > > different
> > > > > > > application
> > > > > > > scenario, each domain can be powered on/off for saving
> > > > > > > power.
> > > > > > >=20
> > > > > > > =C2=A0 The driver is implemented based on Linux Generic PM
> > > > > > > Domain
> > > > > > > framework.
> > > > > > > From a hardware perspective, either of two distinct
> > > > > > > power-on
> > > > > > > sequences
> > > > > > > are supported, in software mode (SW mode), the driver is
> > > > > > > responsible
> > > > > > > for
> > > > > > > controlling the states of bits such as sleep1, sleep2,
> > > > > > > isolation
> > > > > > > and
> > > > > > > pwr_state, while in hardware mode (HW mode), the PMU
> > > > > > > hardware
> > > > > > > will
> > > > > > > complete
> > > > > > > the sequence automatically without requiring software
> > > > > > > intervention.
> > > > > >=20
> > > > > > I think there also exists solutions for K3 that uses RPMI
> > > > > > power
> > > > > > domains, and let their ESOS firmware to access the
> > > > > > hardware.
> > > > > >=20
> > > > > Yes, I'm aware of that
> > > > >=20
> > > > > > What's the relationship of this implementation with the
> > > > > > ESOS
> > > > > > implementation? Should the ESOS part be disabled to use
> > > > > > this
> > > > > > implementation?
> > > > > >=20
> > > > > I should say, it's a mutually exclusive solution, so yes, the
> > > > > ESOS
> > > > > part
> > > > > should be disabled in order to use this version
> > > > >=20
> > > > > The motivation of this patch is trying to support drm/display
> > > > > driver's
> > > > > PM requirement, while avoid going with vendor's complicated
> > > > > RPMI
> > > > > solution
> > > > > which isn't mainline ready
> > > >=20
> > > > Is this a long-term solution, or a temporary one?
> > > >=20
> > > For upstream, I'd say we probably will stick to this solution for
> > > long time, won't say it 'forever', see comment below..
> > >=20
> > > > If it's a temporary conflicting one, I don't think it's worth
> > > > picking
> > > > at all.
> > > >=20
> > > Well, checked current Linux kernel status, there is no RPMI PM
> > > solution=20
> > > implemented although there is documentation in riscv-rpmi spec[1]
> >=20
> > I have seen pending patch for it with multiple revisions [1], the
> > dt
> > binding is even already ACKed by Conor, so I think it's not a big
> > problem here.
> >=20
> That's exactly what I said - it's not mature, not saying it's pending
> patch for review, but for whole solution that involve Linux driver,
> opensbi and underlying fimware (ESOS) - which not upstream-ed..

Except for the MPXY part (which seems to be already mainlined), OpenSBI
is only a RPMI consumer.

ESOS is vendor-specific thing and its version from the vendor already
contains the RPMI implementation.

The Linux driver also appears earlier and received more review than
this driver.

For not reinventing the wheel, it would be better to work on the RPMI
PM driver.

Thanks,
Icenowy

>=20
> To make it clear, I'm not going to pursue the RPMI solution, but if
> someone insist and willing to spend the effort, please feel free to
> push

