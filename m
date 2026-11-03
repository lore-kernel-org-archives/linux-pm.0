Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793728665;
	b=EI5mM8WNDni8wmR+uooktESYjvVbB8e/f7d4hxIryhy7auRz/3Jb8HpGD+Epww89JcWS
	 9gi3nthQZz4V2qLAzWs+vkMkWvG0Ee8csWinWoZFgnj1oaJlQ+X63sy2sgV0nA+sJYl+i
	 F6SaWQmQXMVfpzuAVzui/3TJxhFld46XEm/JbMaf0BINWamwoNfk6gXg03sv/FEnJXJnh
	 9tq6CNYlLPdSdhX93RR/cJDiqF0kgd2YIjaK7y0AtNUaTUDfQwvNAo+MFZ8fS2uIE77H6
	 xdrfMkhiN4I7kRygrE8K0e50P+VxR0YsttQkAh4owVglv1XARpo7Lj5hkgSsb4p1+Yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8gprV7xy1a71HLe2DJEJ0Eloi4n12O+LyzqN8PR9KuU=;
	b=ckgADFV0Q8BlHtN4LFwrJtVMzndc5MsWZ2Bki1rzuxKpJ46TiGP4KJvcawB6WOJ6gqY9
	 WdE2wUsI10JmNG2rZSZKlCCSlIetKG1tYUmq5kzfmm8Rk/snf0Q5nYkZIWyxHCXYUYrBl
	 IPXVqs6wUCPn4pS+6DwMgSlAqz56v6U4JlloQg1QR9BFtcNqtET0+iVIUdq+vgxfllZJz
	 Yi5pgTRFdNcbStULZ6pJCDJviakWEB+2oVR/VDex3ZJGT53DsyhhUpCSqLaruWiWB/Nhd
	 sZJOppWQbqxzNNc+qeMVp0VawnawMxwFzOKn9pPJDVo5hSbBJss0jIrLNP68WJN7I6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mNNpBSfW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F91B606A33C
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 17:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F91B606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mNNpBSfW
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso685e9.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 09:57:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793728664; cv=none;
        d=google.com; s=arc-20260327;
        b=norV4r6ue4US8lh62io9ooJ8B3SmPPnKG/pQpwJ5KSNbRLztmH+/UjbF5ICR5izqM3
         JJBG87x8oMQ6X4GQdiduU50b6OTV2McmthlUixiBmA6UtH85bLYTyVD8L9036HKCPdbK
         8dR7o8Zd2IybV3KrlILeKlmIVHVCw5xEcF+9n3hd00ef7cFcQwT2LtNN8Gnef4xOGZ9p
         +6U+DQ9ubfVcZJd+41309hYvGztFIgNa9yDp14tDS3i5B43idydG7bqhCr/HdwglJlDr
         luh1hbB3DefSnKOjbmr/XyK4oFKuPYUhSUv3f9LSehHOyLUhTV1hWA45KQbuIgEIYuRB
         XqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8gprV7xy1a71HLe2DJEJ0Eloi4n12O+LyzqN8PR9KuU=;
        fh=EMbbn7muqIWOz92DbThNgTdX64/6LKTCyQw3sKBFynI=;
        b=X8/4xVfP7bIkDZhvFfmcHg8Vh8C/d1aWmgaD3ar3ly/IN5+a/vN6n2ZmDbGWcAmdO6
         rZILR0ArMxs1XYLFeMi9SRT3NauAY+0JKfTkuOjL90OsyG87a5T2f8dBK3KLVht7ujRr
         cqRn4BObawtTGJMmy9wlsMHApILmuhxdg2Efn42wT47qzt5qutONgIznSA0WTNoeM+BK
         7mlgKh6N+TYpup6AG7Irh9Bwx9smHfZciu0O8vPvwCdQ8nOniB1pwR4fkZqJKT47bxF4
         RAbLI0czfzBj/fCE7xhwIFrYB08FypyfUgozsmcDXsaSrfMc213m6d2if0Kedg2pDoWv
         h4tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793728664; x=1794333464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8gprV7xy1a71HLe2DJEJ0Eloi4n12O+LyzqN8PR9KuU=;
        b=mNNpBSfW7U3oHqA/ynhmqeNxcf7VD5INJCcvqium3opsSQ6PpJHHG0HuQo6RrCGPRQ
         eOPXJN/3o/36RWKzCXa+DvnnzN0JteLWM44hbndWrNgNK+8Dq2ekmEEUoiS3qqWHRVBU
         AFM/SqwmHpALS8gQ108CebFr4blxw6ZjKVgDjh2F5bIvOshH0xMna3G15UGZYtJTpHE5
         c7eRZYr6+KDC6Te+/Bl1ijRdhQnNTBvF5JrK2tYBOaQELzEVRqyyEu8DRbT4mFfzFnh7
         IoyCQiGSL/6f/q/Eou0a7spJplQi+5xYxnh26wXm7ZE6QGeZWNE0btafYvSNrmOsadut
         0hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728664; x=1794333464;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8gprV7xy1a71HLe2DJEJ0Eloi4n12O+LyzqN8PR9KuU=;
        b=RI5n6ygS5PkV4X6w9BH7XmE/zzitCN6QNAN+C2QtchaVanMl8SZM1T2yzij4ht2vd0
         usVDo1sqH/GSWXKwdaV2f40r5XuuOuUm3nD7uSJK89NYTsWRJB6ZBwkD8amMKljNVs8C
         4Y9jOpaERQTRLfEWBUzuuTT83zXaDfIaD8Ezb6sL6GMfC0mc5qLV61MJlE4gTizm6e2l
         giI/lYo3I1NA5RaXX6W7lHrxwbxJq9g74n+CZwlxHFeHOLbVmHBdxtG1ZUzfie0JRjLv
         znE41SuKwaUcKYFhuyLkmAU/QLqAONmyUqG5KbqeC6PGOa0QLKNOT7SIJIb8x7QR5Vc7
         Hctw==
X-Forwarded-Encrypted: i=1; AKwUvByyVNOHo4qKkJqm1K1kBcS/X/RqLrQUhUAi4InJURJVBX1irk8hRNIZJ4WxiIlu9Vybmqft1QBQ8A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9nbGHff5IgJnb9JyxniviydNT8Coz/I2C/wVaOka+QMhGJl12D
	jZLmsQ8jWMUnlPPmz4/pWFnkXJ5H47udNZS5CTteii5XgK1yRDNvYODaPR8Pj/8KQGaVzA1Wcmz
	hhpRHY3p8oXCDrtNPOqnO9aQR8kJ+xZvNsH4UYL7F
X-Gm-Gg: AYBFou1FtZHd7xjAQ4CWfWvrL2GMAMT5w4wJUdprZEJkO99TcCUe4xFquksIn0aWuxw
	dKKY7IMCOXeKlVQ/0y9wUGvNl+ZpPUKvaj2SNR/h9ZxEEM6mzGVwsfidE4ctKZCxoeMipUSj7z7
	U/KfKf7zVxEjbVD6k0WYw8UDVcpJ7PBQdrWqPG/+2WDPDwys3ih0/GVOTUxIphoFqRk1xZ5oVMe
	dXGTZoDry+FO3H9g33f1XklA+Zm+XQIYBvyRNN47gcn8gEgj/akkaEPShv8HMMyN4y8mop2xm8Q
	t1Qerr+gDrnvw3iYeENattc/X9HGodWq2QNOvKCUf1X63UnVmB4DPEFn2GX4s2e4n30ioW6wxxt
	9Fab/W0gEy6NA7aZ9ojdqi29vitJQlppdBjX03AQ5LXDPdr2Pl9aDwFxJoFrVgfJKBPIp976XRK
	Ag6j2KTX37QL1xVbhtNWV7
X-Received: by 2002:a7b:ce01:0:b0:4a1:d75a:8b4 with SMTP id
 5b1f17b1804b1-4b2e3c650b1mr815155e9.12.1793728663404; Tue, 03 Nov 2026
 09:57:43 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102234813.1069156-1-wvw@google.com> <8f1ccb65-e4a2-450b-944c-9883ff12bc37@sirena.org.uk>
In-Reply-To: <8f1ccb65-e4a2-450b-944c-9883ff12bc37@sirena.org.uk>
From: Wei Wang <wvw@google.com>
Date: Tue, 3 Nov 2026 09:57:31 -0800
X-Gm-Features: AclHuK8vz5vkqxj17UdSeFCslNabswTrlQCvg-mwh5UYxKg3Wjf31NJ5q0jNNus
Message-ID: <CAGXk5yr4LqdguVMBeXP=pkraY7rbQWMePWs0Dq4tbGE-dCLe=A@mail.gmail.com>
Subject: Re: [PATCH] arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	wei.vince.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 5:56=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Mon, Nov 02, 2026 at 11:48:13PM +0000, Wei Wang wrote:
>
> > On systems with FEAT_SME, TPIDR2_EL0 is part of userspace thread state:
> > the AAPCS64 SME ABI uses it as the ZA lazy-save pointer, and the kernel
> > context-switches it eagerly in tls_thread_switch(). While a task is
> > running, the live register is the only copy of its value.
>
> Thanks for catching this:
>
> Reviewed-by: Mark Brown <broonie@kernel.org>
>

Thanks!

> but I think we're missing some other registers, I made the same mistake
> for GCS with GCSPR_EL0 and GCSCRE0_EL1 and I'm not seeing where POR_EL0
> is handled either but possibly it's somewhere I didn't spot.  I can look
> into those incrementally once this gets applied (or if you do a v2 and
> roll them in that'd also be great!).

I think you're right. As far as I can see, these are only switched in
process.c and nothing touches them
in the suspend path. Unfortunately the hardware I am testing doesn't
implement GCS or POE per cpuinfo,
so I couldn't test changes there. I'd rather keep this one minimal for
stable and leave those as a follow-up.
