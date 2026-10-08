Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCE244B693
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2026 21:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493433; cv=pass; b=HXw8a9QZh+0+jiLTVrperrlq7jIOldJNw/Xio7m+bw2raz2737boD+BM08UEqFqVuOozDCglNT7gDoKw+yBy8rxox/63YbTycmEGdZ8uwYUGQUUYSQqV1pWX24fKxEORMVs7UatOkrD6oAQN7oruI4uo411li0ReAyVhYYNxMoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493433; c=relaxed/simple;
	bh=vl6P2d7bzS5ltJJCjjguAr4o4FboZty4KMxvPMf44as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikomK0MYjcKUm0i8Jx3T71b3VurCEGn9xQjNATC7a7eoFJunE8Vj/D5TrBePixQcvj3OKRXIDqVVcPHoTEnZEBn4ZGGftFlFyjncBCdzSwDxvnQ7qFr1G9BnzALVA5Oytu/4Ghy2hTJO08QQW9111LuM/eSSqJ8/v6Io8jWpvqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXb/7leP; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXb/7leP"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67687f279b3so3478706d50.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 14:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791493425; cv=none;
        d=google.com; s=arc-20260327;
        b=HXy1O48qHHULK0W3kwHAS8WwI6vakWEsZlSSbOaVolsx0dR/CHykoB1LyGxhqtkynl
         p5zwQQPshnQnoIRk3b8luH+1pwk+VgCwJJIz7docWBMxNjj2nLBmTnoJmEgn/8g3Xiwu
         AMYdC1O7hSCmek6LJYK+qPBvnNytnRQe7Bx+CmCFcQPzB7t06iHH8IviLym0lTkoFC5i
         8gJ3zrypCE1uADUdteSkcAOmr3L+7CuwDrFV6Zm3WBPstqK2BeLLgodAyXQvntF7jiMu
         D6+fstDRshlglA3qhMaUnFMzuQItm6jn1yrXq4+V5YRuFs9QPI3FRVZzv4W8vg7KYHOU
         QqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vl6P2d7bzS5ltJJCjjguAr4o4FboZty4KMxvPMf44as=;
        fh=pwWwqHionWFyMA4TfWrv5h4AOfLMRF8hZeXMjxrGmok=;
        b=pPTi4NrrjLTSJMhiHLf6KQPdR9XYdBY+GkImSPXxxi6az98/QCvgAmH/PKXE9DWkdD
         pf2wZlXVBRGyUd9kvay+ZMrW/1K+M3wfJJ0upfz2LRJCkZQumxzAEGyrdLb7cZ2TnZLp
         xWsBghSTJaluWsd90N3Nq1JRiTdpqWi4txAJTd1l9uitClfRfqRDb9durGBTsP/0+g7w
         1UITkP1I+mNiAmt2KMeLq/zifYGBX2Rxd5+RV2gBcDmfEv/xMIOW3U5uOXQigYy6K8Se
         mauuUL0DjirzI+XgCt3kIoCyZBKcltrs3pLLkZ4lZ6C5Qsfq3WUfsgtuBtD3F87w0Bia
         Q/Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791493425; x=1792098225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vl6P2d7bzS5ltJJCjjguAr4o4FboZty4KMxvPMf44as=;
        b=UXb/7leP6TGNYUifCSK0ZJavuFWdrwXthwZiI6/dWlDhkOz4RHlfPFOujRweRjd/ks
         OiWVTAmZK3nO0GggLSZfwN8B2gWdsKQnsSA10Ke8dGWQcFCYicp3IP29KG+cTVlhft1w
         MqB6+615PiU0qCOGJw3Q6YbiFMFan84RlyjV7Yza1ad85M2NkQJjvLH25YMwb4W7MkWm
         YhFIrndChRBySsVyrWboOrEPjUSAZ5+X4aSujD0WUKIkNPX7+GH6Z6rbyigdR49T1uSW
         qp6t7DKOC3r4nvc8GB5W9LGamVawPCFTigLsreM+nINugjPbXlzsMQ41BFDXrMOH6PHD
         SCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493425; x=1792098225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vl6P2d7bzS5ltJJCjjguAr4o4FboZty4KMxvPMf44as=;
        b=du0tij8R+uV95X5e+kRY4zHQxjOnQD+SErNXaHMYJwgMECKajktHHPm06Yi/z8I/cs
         xOY9fHB/+NXrktYvx6Wj15v6g80zRiHSf5O2af0mxt4H8SLnuH/4F/5dWHv2Hgr7gdA8
         xX5NTUej2Jd1Yj4r8nxtYdtDyNtz59jW+OxPvQhrmGMjOQ1rJ943qm6O8chqTZzrdG6y
         DMePoS0NUCc4rf/jo3U74Ej2QldGjcYhH5UOXsTdGaTs/d+RsOslIgGVr/4gCPkZ2KRt
         63/qI/3UD/FMUs96ysEDlJyRvURZSNZpfj56aRXqtzFuduwaVvKJ7aiBHyVAjM0nQYOO
         YhzA==
X-Forwarded-Encrypted: i=1; AKwUvBzQ3c7d+tbCemv1FcOw6sO/+QkQHteQ0TefDdSmtmFnquEu7eQmvbTs1lPzUARwsutXJSDWEhUHHw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKGlgq4Vj9UHt1CCsJ4xFaWY530wtJQEMwEtIHq0CSG/lYxro6R
	rZvMioG3AJxqtXRMTKE3HHwlMqHeK1cFxJX24ClACCxKmLan1KQUm0AGDKBdONxldy3qsmJhmvw
	BkZnEXKmEas9z5zZQZS+6cJAZIoNI5tM=
X-Gm-Gg: AYBFou22OTkJfTTjz+XZW94ybxro5dNOOaxHU9HJmbgetzwTq4VffS8M8AyA1UD5+qZ
	uI/zN9sSwgT7vrjHW2K+W8zbjfJi2EtaPbp+ht+9R7T+NFJpZmJPFmr8QB5grJ4kuzWyKjLdIff
	0RFRI3gTFIfJHpQSXBUqra5mkxmwoB47pYMPoRH7ngHPT3kmCu9ezxcpEzDx4GIi46BRJ4iWwuR
	aTh4XZcwISCzBcki1ubqIt7zpU7Trc1dHcLUOintHviGut5IbofYq2i+rvMBPAA6IA+FtxHRX3C
	tKhO4OyfAafKubbYEiXkEHVF9Sahuu7Sr9dSWyZTmB8GNyeuTBGIbFxVYtI7SnI6xnWRUeoFez8
	PDum3znOsyzfx3GzuuZC4KJBtDBZSJySTjWVzMbtrJUxX9deukWMD
X-Received: by 2002:a05:690e:11cd:b0:674:1e05:9b81 with SMTP id
 956f58d0204a3-6793628e483mr25302d50.91.1791493425421; Thu, 08 Oct 2026
 14:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008124106.665014-1-Jason@zx2c4.com> <willemdebruijn.kernel.cf8fec88827c@gmail.com>
 <CAHmME9r+O=3i4JP94P0-gFwghfWtD=vLa1g3KB-LvW+xFbJWHA@mail.gmail.com>
In-Reply-To: <CAHmME9r+O=3i4JP94P0-gFwghfWtD=vLa1g3KB-LvW+xFbJWHA@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 8 Oct 2026 17:03:06 -0400
X-Gm-Features: AclHuK_qKmc6ZKE8_x2MdYae4trfNS2WogXUatNfjY-lv9_2jJsmiBMEjOiQbLM
Message-ID: <CAF=yD-LO0u5z8SU_Aktu0-0aeM-1UknYsGc+rCpD3y9bpwxtwg@mail.gmail.com>
Subject: Re: [PATCH net] udp_tunnel: drop packets when hibernating
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 3:58=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com>=
 wrote:
>
> Hi Willem,
>
> On Thu, Oct 8, 2026 at 8:37=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> > Jason A. Donenfeld wrote:
> > > The kernel's various networking applications keep churning away after
> > > userspace is frozen during hibernation, even as a memory snapshot is
> > > being made. This can lead many network applications to an inconsisten=
t
> > > state, replaying packets and cryptographic state changes. For example=
,
> > > on wireguard, there's the possibility of this sequence:
> > >
> > > 1) hibernating begins
> > > 2) handshake state cleared
> > > 3) keypairs cleared
> > > 4) new handshake round trip completes
> > > 5) machine memory is snapshotted
> > > 6) packet is sent using new keypair
> > > 7) machine is restored to state (5)
> > > 8) packet is sent using new keypair
> > >
> > > The idea is to prevent (6) from happening, especially if (6) and (8)
> > > contain different data, but the same key and nonce. Presumably the sa=
me
> > > issue applies to other users of udp_tunnel too.
> > >
> > > Fix this by just dropping sending and receiving packets during the
> > > hibernation sequence.
> >
> > A few high level questions:
> >
> > If the issue is reuse of key + nonce during send, why include receive
> > side functions? Specifically tunnel (encap_rcv) functions.
>
> Because I suppose (4) probably shouldn't be possible after (1). I
> explicitly clear the result of (4) in a PM notifier. It seems wrong
> for that to then be violated after. Similarly, userspace doesn't get
> packets after that point either.

Since this is an issue specific with security protocols and reuse of
their state across freeze and restore, is that the more suitable
location for this check? Drop transmit of packets with that risk
(unique for that connection nonce) only, if freezing.

> > Is this a problem specific to UDP tunnels?
>
> The stateless nature makes it more poignant there.

udp_queue_rcv_one_skb is the UDP hot path. Since it touches all
packets, the last resort for adding checks that are relevant too only
a small subset of packets.
