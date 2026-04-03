Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63153B3895
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233719; cv=pass; b=lc32Gvn1hBnA2tcOBN/ZkSJL6NuWnY8E+K5zsUl8NvdOuvGeGX6uR+/brKb8BheSSuonpm/VsTFPzrEXpMCgw5OchO4h/9uhRkrJkAUn4EB3l2Cu8Cv4Z8hbKGDcUFJ7CTHY+aTJVlDPlrUD4Dr6//LvpbVMRc1LDswCjeX1hHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233719; c=relaxed/simple;
	bh=QU5nQFj9zTMuLvpMp7ysPwBJAS+h8cyhyd8jT8E2Q64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXBI6LBzXIZ8VOcVHLOUh4tAB6x4vVxhkuhJB1dpXadjuyKuLIaLAK+dvAK46snoj9aBnp3ZGifysMWNNxN5YYJA3j6RxBesaMNARuMleSh+Qae50Q9jjU/Wo6ADGMibAgspwE23OMpQ9I2f2+SWUF8KGuvuoN2eP/U19dJ4mtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ExYWp4nG; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ExYWp4nG"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b941762394aso269682966b.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 09:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775233710; cv=none;
        d=google.com; s=arc-20240605;
        b=YwALT9CWikVoTKoRZwM+GGsCT82e6rOl6xNHc2vUxQXR6ylPuaEWERZhAbEscZhcDu
         QmWMFQGVq8fjNsZmXcay+DiieKSVhoa+Z3HPO7+WiekIpHW4ud8IRWqduGPnQVxOcEk9
         TckXfaQm1oNIw+5xJwmOQ+XChAaxSYPkMfS3R5100/dNm4PlvIQB+J1M/L99UVsx0Sup
         5bZz38vCNiGUGckpD969ooEfXIIBWVPN+fJgQUly/GriPnTMWty3J9YPs7af8/r4HH4k
         IynSPOe7SPtZ0XjHoSxkkoY7v5hxTZNY2PFu2iN9zP9P0msWFTRcHDqQeb9++dM6aI5B
         F7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QU5nQFj9zTMuLvpMp7ysPwBJAS+h8cyhyd8jT8E2Q64=;
        fh=BBUtZiNyJFwjzTdyro6yYCxRXHz1YX7WYekzNv6CI80=;
        b=XCIu+f/vvUWjNjRUo5PmIpb/+ck5LrRq7pWEswnjtzk9BTw3zemfPmuVHo07odvIVV
         6o3bBkv+kiPWfwaxHkd7co9jT3frk4BHG0inhB84wHyuHham2yxypohJCPvu6nlpaW9f
         yBvZYCpc66MdXi3CX0xeAc3m5RC33+GK0zmps2OGc0aCI++3YBJPoX8REKieDnC+dgc7
         xwVd+MnNHJm6W8nSWRlLfJRWzwsER3VUldqve3MkSebJC120s7mGfeIbg77GuUdUUivF
         9iWERnFNuHGsAXdptnOeeWFyqunLjcfJ9vaZxYhvPNHCHJCPdHsex6ARCR8pn1V7BpUU
         3VKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775233710; x=1775838510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QU5nQFj9zTMuLvpMp7ysPwBJAS+h8cyhyd8jT8E2Q64=;
        b=ExYWp4nGM9cQ3l9TK67XwcYGcZLHX9WAISx5F3IlSLTucjgqBu+VFC9zmxXKjJsEsY
         ycWT02+ujpvuc0mz5Amxcu3fuItNSABe4dwnXTsLP5oRDute2hhYrEEe6smDU/QCZ34G
         5rCDXFaUD3DG1ROyBREOpXtya9UkL7Gu0hxQx7ylTg9uLvMWDCBURZFcHsf4kH/HrQUa
         TjnFLD1sDtHixWtho3WeWWAWV2FrOnUgj8AmWz40gyjkBU4Sd44BrgNq0VqdqPMMzbvE
         XYhfHrxUTLeEqObdbjHXUeMOnSBKoztbGb/VAFG+IQ1vVYDr7h3tdjN+tTY/g8ps63gh
         nqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775233710; x=1775838510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QU5nQFj9zTMuLvpMp7ysPwBJAS+h8cyhyd8jT8E2Q64=;
        b=hx3S61iTFNyD70K54C9ovloRhabuiL5ky70JwZUovtfhWAzgZ8eThB5JhBPLT67oyT
         MjNDY4QHNrT9xXzVJo2bwfTp5qcB9rCcN6iTPytY1BfyAjg4xvUUrx2dS++K8dSjXkNY
         qYsjYqpYrWlQTThiv99dEb2ljCmVy26/K4X7qQIM4kLNxjatplQfHuRMAKRk32TsdIOO
         DbxOlndfCpo1UZ/Q4g22xe14T+WNqYahRsOL9SET2wBNUhU96igdyytXaXKr7pLNDFrs
         sEXE+117K7ciAQuypXsEpbX5d4loOJUPe0tcYOMGVL5VdKWl5LFxRohV8clcUx4HKDOM
         ligw==
X-Forwarded-Encrypted: i=1; AJvYcCVpOJFjfg27SeziW/v410PBfVOd4PZHa7EdBteFA8Qbs9/UrAvsYIHCtgEQ70Gj9QDCfRO+uLugRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUo8qufLw9UyHbcANILX72Vrh0JdMRRqCi1Cxpg2jovvh7S6hT
	gtdUd62/d4lmBeYkbZ63PZOgt1sKsWc8vpq48QM9mRoOpNcLAXrDYbApG/sR6CR1wkauhKhuOcS
	prmoqZR0xfplRjvM/Zo/4mXf6BRfZCtzqgJDcdPr0
X-Gm-Gg: AeBDietdSHU90sJ4ep7sfKJWwTz3gH0IxYpeuFQPRoW13pFXb4dDWthRUZLfGLXU6iO
	rI50eYcaI/Nhg1/SClGE2lRSUQi2WKhAiGPWcjXsQcYT3/c5yK2tSohTWIEA3vUB2aIOYKrKE5P
	C7SEP7XKhtTh4DYizsTynjs5o+aUhqJlqlnjYonJ75smesxotPGPaAcG8HOuh518+Gf+hZzqUDi
	lzku+7TaxSsZefLAQliOJaqIbIhauRWvEqcNmYm7PvvWV2wexKirjmzExTzWr/CevIj7i/5J9gF
	YW603X4bJcdMJop5n9aeUdRidvhFbBIHeaBGa6Hl9Hid1TGU6xUn
X-Received: by 2002:a17:907:984:b0:b98:4f24:a6d with SMTP id
 a640c23a62f3a-b9c672d41acmr191528966b.11.1775233709065; Fri, 03 Apr 2026
 09:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153413.2469218-1-wusamuel@google.com> <2026040136-ocelot-simply-8981@gregkh>
 <CAG2KctokEVVuhrs6tYuMjFF4ALR=tX80iZHrt4bhVvEKyoHzRQ@mail.gmail.com>
 <2026040236-kiln-carat-bb6d@gregkh> <CAG2Kctpr7vBm_=Xz4H5FHYAfFxg=bDt35j6B4EprfUGio=Ftew@mail.gmail.com>
 <2026040357-undefined-gave-c98e@gregkh>
In-Reply-To: <2026040357-undefined-gave-c98e@gregkh>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 3 Apr 2026 09:28:16 -0700
X-Gm-Features: AQROBzBqCMHYMQgCewV6iBEDIM5gfYH7CX8XlpEk6-JJdgIOB-Bl687I7GX7WKY
Message-ID: <CAG2KctqOLeYm_NFUjGdXQcBo1KhSZpXFQxQdM-DQBV4Mn0ahTw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Support BPF traversal of wakeup sources
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 3:04=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 02, 2026 at 12:37:12PM -0700, Samuel Wu wrote:
> > On Wed, Apr 1, 2026 at 9:06=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Apr 01, 2026 at 12:07:12PM -0700, Samuel Wu wrote:
> > > > On Wed, Apr 1, 2026 at 2:15=E2=80=AFAM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, Mar 31, 2026 at 08:34:09AM -0700, Samuel Wu wrote:

[ ... ]

> > The data is fundamental for debugging and improving power at scale.
> > The original discussion and patch [1] provide more context of the
> > intent. To summarize the history, debugfs was unstable and insecure,
> > leading to the current sysfs implementation. However, sysfs has the
> > constraint of one attribute per node, requiring 10 sysfs accesses per
> > wakeup source.
>
> Ok, as the sysfs api doesn't work your use case anymore, why do we need
> to keep it around at all?
>
> > That said, I completely agree that reading 1500+ sysfs files at once
> > is unreasonable. Perhaps the sysfs approach was manageable at the time
> > of [1], but moving forward we need a more scalable solution. This is
> > the main motivator and makes BPF the sane approach, as it improves
> > traversal in nearly every aspect (e.g. cycles, memory, simplicity,
> > scalability).
>
> I'm all for making this more scalable and work for your systems now, but
> consider if you could drop the sysfs api entirely, would you want this
> to be a different type of api entirely instead of having to plug through
> these using ebpf?

Almost all use cases want all this data at once, so AFAICT BPF offers
the best performance for that. But of course, open to discussion if
there is an alternative API that matches BPF's performance for this
use case.

I'm not opposed to dropping the sysfs approach, and I attempted to do
so in the v1 patch [1]. I'm not sure who else currently uses those
sysfs nodes, but a config flag should remove friction and could be a
stepping stone toward deprecation/removal.

[1]: https://lore.kernel.org/all/20260320160055.4114055-3-wusamuel@google.c=
om/

Thanks!
-- Sam
