Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58049BD84
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062340; cv=pass; b=jkJM59ELID6u8p3oQr7VfpwRytsfwt7XRvGG4W5H4PmoSmS8TwsxBPK1E6mBzNbCkN9c1YFbyGLgwCqy661TeMFKtizCeaDVqtNXysCkterYB9m9Mu0TLk2NM5orHRz7sVzs2KUqkk+4MaVcQMm8RQrvs/qiGQxHxGWW666BmoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062340; c=relaxed/simple;
	bh=yPSLsauNWO+8YHpLu3P066P8SvE3P0pPuLQr766NovY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ni649TGMCeF4PitR1WEUgyuXDVc/EMYhHvRFnZwhcXBoOfnRAjPJntSG6D3/zLM6wyocH8+weVoMInEoLXOcYEfukCDDaWwAhOMcAbHw99z1nySC9M3Ipjbed2zZyfPA0TZvX93SO3k0m+Bi7WaVVeSUF8/kj8bmEyD6oZcqLjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xxeg+l4K; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xxeg+l4K"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so6274282a12.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 04:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792062337; cv=none;
        d=google.com; s=arc-20260327;
        b=NNRjx3sIiWzU5SaOUNUGnfZv2fvNRG72sp1xGO9DQxzg2UoBM7imT0R1appIryKx3t
         hcaG/xg+rfiOkA2Ktot674C43FbWTurW3jJpws7OEycVuqvEkrjRSRH53gdmK96wZfR4
         dr6I28CRXTa62g8dH7fUalulj/KHrAXNv1cjRlqAvlqJx3sIqnOylCNOGBQU82cbtiaj
         lL4OA8qOI9GbS/nFoyyQqBrxwlDB4+8irm9nM13RpF3p8XLJflqkyhe113H1rBPQjDju
         vWYwXuZ3h752H1WDoTRa167VCWC7dmxs9B+XyRCy2Px30EwWWrOT+JNLH3rMkjkz7pKj
         yqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rt6zLrcxhkT/9F91e1q6oOlpV0iVcuAdHVJ3g/kDDn0=;
        fh=E97MhSkILWrBqlMfqvKtl3zUhCKoepGMtr9pD/bm/C4=;
        b=ITbPpMGAI6lU3tey5AqUTzELD490ENHz1wWJkmQY1r8nUVtzLJD8VON01E6rV3T9cW
         IA/sSYI/e9AZYR+PuvYNIRWo1moV4qUfw/evQp9QJOPHzte2i1Uobt2zM1COlCw2cVns
         t7IeTqPr9VMOPJZmb46J42qwfd0VxnbrZvACEGS68WJzZNSUVRgjDS/aj6aHmDhau7Zj
         lXwARYRyB5Uwpnv1237NRZfcaihLH3bY3tlifF/hia9Q28qfYoVCkHpF27P2D1R84wLm
         oDh2Fh0Dtw6YMYTMJcytjn4oNauLeoS6wtorYCSsvpssfq6go+aSJ7h6C7cnYVx0tkXS
         i13A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792062337; x=1792667137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rt6zLrcxhkT/9F91e1q6oOlpV0iVcuAdHVJ3g/kDDn0=;
        b=Xxeg+l4KOR/hsGeSlEtXAcxY2ztBs/3XMF9Zf5ioIf4704ptJCJ9M0CbGOlx+WtEg4
         pjjTBpvuLzPEZ+R3zsErZQqDbyGffSeDsMIO2aNLa7I8i7WGf0EELZibZoIUGPTNz4Uz
         kAo8VazbOQXtmOoXZBr64vKG/t+mc2sgPOTHgeLEbmJhtfwjhU+cROP1zn0PU9xj+UFG
         /AFjLLEvuutKivJMy0178xoMDWnUkMjLPCJCKaQ6E/ZCTp9hkc7crEyha8UHVwlpnNQI
         kw51zaMdvwlYgcblAxEc4+3oZx52SyrTWG1H3tDDu198O6pbsRQggTJhoMI1ji0QdPGK
         qz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062337; x=1792667137;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rt6zLrcxhkT/9F91e1q6oOlpV0iVcuAdHVJ3g/kDDn0=;
        b=ybxbpIAKB/8c460w6RI9ggrbqncSxCTBpbQaAEQqIqZhWOwqW/U7saLCl2G/3l9Gq9
         Wy+jgNSZWNWZg5zlyOImQq+QI4scP7NEbsLKqB9e7p8PMzhBiL/KGEGkcE+Nikfrsv+P
         E2xj4GKhYXIkEmVOmsEEJk1nuDFDTnHMDhRLB8FdcuaJ0Gg3kSUrE9SW7cpNYFU45XaZ
         69XGfiMZfEDqhoxycJlTK1LQCJQ4uVpuxwoLML+ems72MrQKYoTPbjWDgg/ch8anM5ZM
         /6nsmlVDsRJDmkJin67CLn/V9kxbC/cfQ0hZNkzAM9J+x6Manz99/S/gCi/ocyCxpK9z
         rK8Q==
X-Forwarded-Encrypted: i=1; AKwUvBx/wCTnrGaC4Vpj1i9cXsIKWN7rz3SlZZiCCNlNv4lgPErHfuOF8qGVG0xGG+axaBHvzkBF6NfQeg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLvZ4WLr/zGZom96ixJ8bReLTZ1I79tbm/GvJjeyBoV+PlrgSX+
	NRfKWVFemltdFwcnrAK+NvSgkG7iOKsG4bqdBwXLn1lT0eT9tMBrGufVhWwvItTsDdMjxq1OB/9
	iOjlIZyPX20x/S/ECHAP/FrFS5MjRhz0=
X-Gm-Gg: AYBFou3Q5b3njqCDIFXGyqiAX6EoHIBTSv6886KhI4hvCIIvAsJBKKf7fNp/uy7hxaw
	A2GUDBXE06R4wAaKzjHrPBzEmDNsk0M0sgmqb66OPLWEYaVpuzsvmH46+nnWhBcuaoTd9KjRoeY
	j2lJGw2OUFwnCeDivTWVlGGlXSUtT7hzBtYvlu7IGr8Co0zYckKb0GKseKQCy02WfJb2GDOAeC8
	7oG4+H/EdAYv++NGxNEQPNT7qARaBpXQl+YCBCh39sD7nS5bh2G0vo6uhWr5REEWqR5+rOWIjlF
	rlm6uVyIKtxu8A3Qq1fbEOKOM0mvvxYxjB6b7N5lAOpkrVMoiyLJk42CWIWGZa4040FjDXPpx3l
	EVQKjFFghU6Tfy7labqHmiPSS227mPTyOg8f4UBwt50ZB0BuCgUSbp/+p/vdzpo9BZtuOznRiEp
	A=
X-Received: by 2002:a05:6402:52d8:b0:6a7:ea54:38f with SMTP id
 4fb4d7f45d1cf-6b17c272132mr13118289a12.32.1792062337050; Thu, 15 Oct 2026
 04:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009165710.1320233-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMRc=MdcWS0c9E0V3cJj9B9WMAe0vSs9e2s2EauRH5zFkOng+w@mail.gmail.com>
In-Reply-To: <CAMRc=MdcWS0c9E0V3cJj9B9WMAe0vSs9e2s2EauRH5zFkOng+w@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 15 Oct 2026 12:05:10 +0100
X-Gm-Features: AclHuK9XNtyctc4-zz7ILqGJPTJfzfoX5rtUFZXlnBV5qOrrlt95vuLzAJaAEjs
Message-ID: <CA+V-a8uVxwP+AFbRYb-weN+EHQ5rFxo7gXPus4muSrMri1QAAA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add ADC power sequencing support for RZ/V2H(P) and
 RZ/V2N SoCs
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

On Thu, Oct 15, 2026 at 10:43=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
>
> On Fri, 9 Oct 2026 18:57:05 +0200, Prabhakar <prabhakar.csengg@gmail.com>=
 said:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Hi all,
> >
> > This patch series adds support for ADC power sequencing on the RZ/V2H(P=
)
> > and RZ/V2N SoCs. It introduces per-SoC probe functions for the
> > renesas-pwrrdy power sequencer driver and ensures that the necessary
> > Kconfig options are selected for these SoCs.
> >
> > Note, the ADC driver and binding patches have been posted separately.
> >
> > Merge strategy:
> > option #1:
> >  - Once the pwrseq-renesas-pwrrdy driver is merged in only then
> >    the sysc driver can be merged via renesas tree.
> > option #2:
> >  - Merge all the patches via renesas tree.
> >
>
> IIUC there are no build-time dependencies, so the pwrseq and soc parts ca=
n be
> queued separately?
>
Yes there are no build-time dependencies, and since renesas-soc is
closed for v7.4, the pwrseq patches can go via your tree.

Cheers,
Prabhakar
