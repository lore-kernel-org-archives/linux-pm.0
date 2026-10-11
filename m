Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2062324B22
	for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2026 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791736113; cv=none; b=rth17nOo+TDC3m4mNm9yqDyqhsCcU1mbuU9QzP7TgKXMyXztWjtzuZutI7oFf8R7zOiO8cnigeRgCQKtrE5GPheW8JGZ9p3im7TFF61DxgjdK4HRBkAzldlW7c1PlXsU9VHBk5PddirqufnPpmvUi9CZM1ZiNv/To6sLfh3+95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791736113; c=relaxed/simple;
	bh=gFt47LSAsQO+9dW+yOZPgrQ8Va/c7AWtExmCZjKK+GI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bFFb1UA+a0gRYFvOO0Ka2MhsQOEaEVNCGum21HSgzO5YxNVm16WH3e1NVpieaTyH6kq+BFl5x9gr47SgoscN/lthIZJZzrXol4+LqnaPH4qwfdV4kzF30v5mq7jMkFCXEseVJGdw8cIqymfvwyLUsbzsBdQvgbxCIfN2NwWXlDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gox6cT+p; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gox6cT+p"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-677bf06de21so725207d50.3
        for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2026 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791736111; x=1792340911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gFt47LSAsQO+9dW+yOZPgrQ8Va/c7AWtExmCZjKK+GI=;
        b=Gox6cT+pbC4miYBOPFdFk5wPSbjPunDqPfcyJ+SlPz1/SaCEK6Euf20OBpBAsS7Tfs
         IptAxlHxbBczKMMMYruNijg1Qciahg9xaxARXV6Z+csRTP6HtaMInHcRvKWbAXD2ut4a
         +y/o4g7wmq0Iga4nF0up6fccIjAkRNXKUiMPNlKJjeXO5jtJc5sFjla2VlzVHSDXoCxs
         aFL3Yed8a5XT1EHP+TYnIhUCYp/gm0ekv7VYdwKPWGR37dHcGLNAofhCvlgCzHTXHCaK
         YcQzXmwrSsrLglfDX88awO+6CLlq+Bpbi8icVREGeIab7QwXQH8coese4WYS44SvoTvn
         nJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791736111; x=1792340911;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gFt47LSAsQO+9dW+yOZPgrQ8Va/c7AWtExmCZjKK+GI=;
        b=QcWcvosc4is13KHuQEmn3CtTeutgMVaZzJYvlgM1uV6A3n0jUxkKgeOMYv5Hj8mMjQ
         qUEBAKQXTmTJdzO/Jbb/bctsBjSCT9OXbhQdsO2ckzqBazlWa9pvGRjnicCM4nx+CxUz
         c2NZKCwS3czVuAQsui5w3LI/neIAC0f/0pAISim4zO0bYmFQ6La4qvgirte1ZoGBp8NQ
         1PhbjUIBgb4mfbG8z1BchpZz3OWRGkRnoZI9MX86iqjhNHQtk0fqJ+CKwDy4utytYSLe
         fyKszGGquiR4pKO3DuIAfMbW6r7bthE+YpZyUwPZ1n9XEQ+AjsbRF3WblAgKiD6vNWzY
         xG0Q==
X-Forwarded-Encrypted: i=1; AKwUvByQYvUqDCf8B9PrzbRA/S5p3+sVDC0l1tN4iNuwC4+rnAKuhh/Xobez5ovEWdyuGOFHuxOqzXdy/Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYIDT8J8RH1IYqRxJy5PAJE4my4RAKpmJxL2FN0kZh7CxMatoUKv
	xZa1WE7qgNkyobYsxUs7MfMlqBf0rwEH3G9axqXKqcjtqkeiZwkZjB2D
X-Gm-Gg: AYBFou01+/NKaLvp3iaq0CFciKi+B84Hl0T8xVle12YQiMHJCl/dIUJmnBKZHsQmAt5
	/uhehUu0Julpcw/oOXJYyx0B865kOj1Wsubk+Bm1DLnr/5ej2dHYUAu03a7ga7ZcuzRffCxlRD5
	e1YLA7E8tKuyUkHKgGEImj2tBNPmPU0VinztGmrps04eGncRK/WWr4Vgz05es+riDVz/9q3jTEF
	+yE465UnA71f2cH5avJqEQXK2Zd1mmVKgP9fimWlZCum1mkWuHWm4gjpJ5S2N2HBk6ThwWJQZ8u
	yJycNv/yp8hVyR+M77owNL33+bx3a24WTp+sy9SfuIq2McvLPYUtpL+rICtszkED+VzUpRrzHos
	DkZ+FY/6cq28yf5k21F/7WKo+Vv9BR2EJDqj5gNRurg62tUkdwiP2vvRXsAOHuM9LK3kwLDMKz4
	5K2PjqEkz3JSX95pp4BDNOAn6LcQfS8W5SOA0CY+pOaDC0UDM876JJji2YwYLog31OA9eLdBPmr
	qA0+ckek+wF83NlpvIq0CDyWjZOcY3YW1hYVWjYhB9XDDr5FokY8hBY5cO4qn0PZpS56RGbOB16
	P2TvakaluNbE4vUe0+p4a21i8Xgfe7LiitcvT0oNF9pZOnIa
X-Received: by 2002:a05:690e:d4b:b0:673:572:4492 with SMTP id 956f58d0204a3-6793600cd9dmr1293447d50.24.1791736110930;
        Sun, 11 Oct 2026 09:28:30 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679356d5a8esm2788846d50.18.2026.10.11.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 09:28:29 -0700 (PDT)
Date: Sun, 11 Oct 2026 12:28:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: rafael@kernel.org, 
 lenb@kernel.org, 
 pavel@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-pm@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>, 
 steffen.klassert@secunet.com
Message-ID: <willemdebruijn.kernel.e128e48c07be@gmail.com>
In-Reply-To: <CAHmME9rW6Pav4vLdHbvvuf65v-+gtoHpDagFpmqrHYnkTKKNuw@mail.gmail.com>
References: <20261008124106.665014-1-Jason@zx2c4.com>
 <willemdebruijn.kernel.cf8fec88827c@gmail.com>
 <CAHmME9r+O=3i4JP94P0-gFwghfWtD=vLa1g3KB-LvW+xFbJWHA@mail.gmail.com>
 <CAF=yD-LO0u5z8SU_Aktu0-0aeM-1UknYsGc+rCpD3y9bpwxtwg@mail.gmail.com>
 <CAHmME9rW6Pav4vLdHbvvuf65v-+gtoHpDagFpmqrHYnkTKKNuw@mail.gmail.com>
Subject: Re: [PATCH net] udp_tunnel: drop packets when hibernating
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason A. Donenfeld wrote:
> On Thu, Oct 8, 2026 at 11:03=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> > Since this is an issue specific with security protocols and reuse of
> > their state across freeze and restore, is that the more suitable
> > location for this check? Drop transmit of packets with that risk
> > (unique for that connection nonce) only, if freezing.
> =

> I was thinking this is a pretty common problem to UDP apps in general,
> and it's confusing to have these sorts of replays due to hibernation
> that userspace doesn't have. It's an odd problem to expect every
> in-kernel user to fix independently, so maybe it'd be more clever to
> do this all in one place. I can put it in only wireguard, instead, if
> you feel really strongly about it. But I was thinking this just seemed
> like an odd behavior difference that could be easily fixed for
> everyone.

When it comes to security protocols, this does not cover many of them,
such as IPSec, MACSec, kTLS or PSP.

Independent of security protocols, is there a replay on thaw issue?
Your example points out that 6 and 8 can have different data, so this
is not a replay because of thaw, but a second transmission by the
security protocol, correct? If so, then other UDP protocols are not
necessarily affected: only the nonce reuse is the problematic aspect.

To avoid across UDP, udp_tunnel_xmit_skb would also be too narrow,
capturing only tunnel packets. Blocking transmission post snapshot
entirely may require quiescing at the device layer, something like
QUEUE_STATE_STACK_XOFF (if that isn't done yet, I don't know this
freeze process well).

> > udp_queue_rcv_one_skb is the UDP hot path. Since it touches all
> > packets, the last resort for adding checks that are relevant too only=

> > a small subset of packets.
> =

> Is there another way you'd suggest doing this? Some other trick for
> disabling the socket? I also am not keen on adding branches to hot
> paths.

At this layer or another, making pm_freezing a static_branch toggled
by freeze_processes() / thaw_processes() would make the branch a
NOOP in het hot path.

So far, most promising I see is blocking the new handshake in
Wireguard itself to avoid this from being possible. But that would
indeed require all other protocols to be warned and review for
individual fixes. A single choke point would be preferable, but I
do not think they share a single such code path.=
