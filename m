Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794199290;
	b=YZ5Vgy46ElV5hgbnkUAMr0HIEUwJK9xn/4G/j7G19+Z7l9wucfooGVEgSpUymqallN1U
	 OesXOwpXnLJ8R9e37zBMcaZrNJ7hAFCJksA+TLvhsiCL1X/Lul1Yi+qj8islUfQY416cO
	 wV4tiMPyBJv/VKsNZYbGqamkowL/KJ0zNnyt+hiPNTK8StPHPoqIM+0MnVT6wVrUl/zDl
	 QeY5qLxlH90N2Z278I/8o53s+6JfapXnnCi+hPhzZe31Gyzng4LBSQg/Tdr/6vvK3qtve
	 qcHb20TWI0GsHeGYNcjs5UlqRfk2yjcUgzQ5gvu7JCn5Cl+/7NU7A3ETDHibaLwq2IA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=WPUgjz9yrlSKqR8e85QEERzjQTMyzYLvqAjjoRM1I1A=;
	b=mj5l5i7H43+ZL5ZtoptVXgvtoqEaVKi03qYYrqB6v/cwGLncayi3TCy0B80T8U81Wdlh
	 RSnGu9vOgG2l+pry8PJU2J4Gush2GfFg86Xp6Wm83eY8Z+E7cbLYrw+V+/qFWopQQXNbM
	 bhSYm/YGgA1GhCoDV2/eCAvRWIixYW0tFW9oyq1TGW2LFc9dW8bY3LzAE6UcSOg9CVKYf
	 4NFO6K3T3im1QfKY+zXnhs5P4pjXAer9abWJuEUnF5bIDXElVotGAbdNZjDLcG3Cf/gUg
	 oFw5GvFlntRhXuMtzwDzKwIh0rVSoNlueHxEsM2Mtu4/wNXy+3YT/clWSJ43AfP2UEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qWzyW8/u";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC7606A322
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 04:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26AC7606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qWzyW8/u
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so1183874eec.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 20:41:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794199289; cv=none;
        d=google.com; s=arc-20260327;
        b=A7m8BtZLwrnl7iUfgorwup5w5kvYzkzwRyWnTlsaO3ZGtN9BnVC9MM9cpgOxDwd/1N
         IMcN5ahdlgYCrGZM7IwAyX8i/lst/A+P4d0v619f8oX/puxVTO2kRYonL45n0ArxnN5z
         k/xEQPjiJiYoqV2UtNAGwwXCRNLycoeJhdE0yco7XiDSMx2krpndKlGqH39f0EUHvb/g
         DkZSE6nzD+RxbKeJ5HqYKMr1YE5O9XXmtG41jd4IhwXlL/nnnCw+NoNS8b6fq6WfWwXa
         CKrBCfXsdyrb+1C2c2jYFvrqi0PgEIm8TQqti0ybH3J3rcVUqsRqwtTUD/6MFTuzdYTQ
         aqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WPUgjz9yrlSKqR8e85QEERzjQTMyzYLvqAjjoRM1I1A=;
        fh=uQbEQUIeAg79xlmW0T5rgt+YyjEtBR/mpLSzRoO4tKY=;
        b=nQx3kDOqMBAwIt2b9fHg3gEXbZ6SqkyasV2WW3x/Ztqi0jvC6i3E/EYGRNbxejj8Pv
         7vk52Waq3NGWRoKrOhRrS/Eov0Z6VO21/TiTRT7zucmroI49ZiiWTtZDCqG0hBOQkYZT
         0zc2oDrtMWDgLSV8HRUrCurzLL6sRb9zo6f+ZImoCM2p8eldTsf3fevddoEtstj45N7Y
         BP0UIR7clp5Oc1zjxHgqfP25FJThyb/n0DBDdntyFS89fY6f52ckEtANKMRlizOK/FYX
         gLsn8JIq5EYxjrslaXV+0AgdoWZKWi+tTTpqiFzNNwfxRvCIWKWl+f1Wq4yrw9zat7TK
         7xJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794199289; x=1794804089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WPUgjz9yrlSKqR8e85QEERzjQTMyzYLvqAjjoRM1I1A=;
        b=qWzyW8/uDqqZV968N5KMa+aeZcBBcxYqwpr0/9uFEACzVarzJn7M4ZXAcInHD+Iags
         WhCbpkaDQ/9NNQte6f9vGtRS76hEzry90XVMO0itGzxrEdLe2sbGinMrC+/gIVrgvWfK
         gPDLMDVzLSwdAkaWSknCY+DGn+bfibCfcNtHtV1+NBFvliwTCB66hgl/SBeEYptEr1LF
         MUovj3LVM1XdPGgRzvOcjiiB6G7rG6UZgK0fxjK4RGlnVcx4JyoYoaeByMwyCV5NzoYG
         tKM6eZ2IE6Ciq4whjh3oUr1hvfTkQ6fCjA79BYWdP6zX3YsvZ0PqwUMUfTtydn0qmR2/
         qLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794199289; x=1794804089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WPUgjz9yrlSKqR8e85QEERzjQTMyzYLvqAjjoRM1I1A=;
        b=nfs5xwaTcrgSKNJ7ghwlpsDrQd66AyjWYR/vCBxE9W/9evimaeug1NyxjTzn3RTwCC
         Dvn94jI5svswyKYTJy6KTPM7FN6ZuTbHzzDRLqlZYZULLjhbkIWCVBolXt9blvDu34o5
         H3BGNaiRqzbqW5UcURvEC5QwqjyCp2hbXGSR99/kPo0fqkcentrBgU3eF3xwlryEeBGu
         ZU1ppY6LlF+1281qINiAzAwC6OxkXqHZNwX0Ggs3oAg0H3Z6JahtwEhnMmYggP7yG4/1
         NfiCMMTD1xToY1YI/W4rap1380FBBMnNGgqjKBJ1XofIUmWRsvNaVCCXj/NwL71flqjS
         pw1w==
X-Gm-Message-State: APuU4Z+vbvHXUe4xiMwfF+Pi2ZmQLI8oCs5QFIxYjgGgff1NSyRU+Uwr
	E9+hrckNOPCSZnMDkIXyTibFyLygwrtwGxZmXQ/ktooc54VDHkTSP8cltha+9VQLgZ83aClUg6r
	QUBTrzCCOB2trxWEcYhc2ThFpNDeGXyg=
X-Gm-Gg: AYBFou34ERryIbRfFCgImEpztBjzza0OIW4fZ6F2QI8Pu+KiaO7FJUmpedY9QiPEGQz
	ZBGzPUOMqHQNH9anY8f3jZ4N+8vNWjRJw8mVZOmn1uRWry7osUHA4NYmdFxcpNJ4gYQduGVrxD9
	O4Hzn4Coa04pvwNiwYvu3S+n8fLF35zQhGH5y5ZKdeVhHPghwdlI8XMCjO0V7n3bINOg5PV4mnF
	1eRXtlQsU4YwhF8hK9s7+QJokwptoW+xpEyuffd4Zg67BTuHxUBSIC7hdVSTu5uhF/TkYiXZw3+
	89g7X8neFN7WH/iUsVyA4/bU3WSHxcDdO6QTFZURI9QVefpV3ss6+/BcI+EmKRUZuIjcefbf+6A
	i2fklV0x8cuQM50qqOtgA66ruBTMoga7oL3etXFPZQus0XoAftlfaDoC3jMZ9OKJhxWl9
X-Received: by 2002:a05:7301:1285:b0:343:9eb1:9940 with SMTP id
 5a478bee46e88-3725e33de65mr8199608eec.26.1794199288994; Sun, 08 Nov 2026
 20:41:28 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106160057.2754689-1-hj351016@gmail.com> <avEdYFDUHIj6mq0Z@venus>
In-Reply-To: <avEdYFDUHIj6mq0Z@venus>
From: khj <hj351016@gmail.com>
Date: Mon, 9 Nov 2026 13:41:17 +0900
X-Gm-Features: AclHuK_VP_O81IVVw6nsjch_EUlJXziP3JNmGnD4QyN0YGW8m1KTdax5oeelWrE
Message-ID: <CAGr5VtNJwmMej+90yoLa6su5fcBc1gwOPviMGtjj7pis+Y7jjQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] power: supply: fix work-vs-devres teardown use-after-free
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

Sorry about that.... and thanks for taking the time to look.

You're right that the commit messages were far too long. I had added the
"how found / tested" note out of habit -- another subsystem I send to asks
for exactly that information, so I carried it over here without
thinking -- but that is no excuse for the length.
My mistake...
I'll resend as v2: commit messages cut down to the bug and the fix, the
inline comments dropped, no functional change.

Thanks,
Hyunjung

2026=EB=85=84 11=EC=9B=94 9=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 10:11, =
Sebastian Reichel
<sebastian.reichel@collabora.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi,
>
> On Sat, Nov 07, 2026 at 01:00:54AM +0900, hyunjungg wrote:
> > From: Hyunjung Ko <hj351016@gmail.com>
> >
> > Three power-supply drivers register a poll/detect/charger-detect work f=
or
> > device-managed cancellation (devm_[delayed_]work_autocancel()) in their=
 probe
> > *before* they register the power_supply via devm_power_supply_register(=
). devres
> > unwinds in reverse order, so on unbind the power_supply device is relea=
sed first
> > and the work is cancelled last. The work handlers call power_supply_cha=
nged()
> > and dereference the power_supply, so a work instance still pending/runn=
ing in
> > that window touches the already-freed power_supply device -> use-after-=
free.
> >
> > Each patch moves the devm work-cancel registration to *after*
> > devm_power_supply_register() (and before the IRQ/poll that arms the wor=
k), so
> > teardown drains the work before the power_supply is freed. No functiona=
l change
> > otherwise. The relocated devm_[delayed_]work_autocancel() still runs it=
s INIT
> > before the work's first queue site, so no queue-before-INIT window is a=
dded.
> >
> > This is the same class as the recently-applied cimax2/extcon work-vs-de=
vres
> > fixes. Found by static analysis / code review; none is reproduced on ha=
rdware
> > (each needs its charger/PMIC/gauge chip and is not QEMU-reproducible) -=
- treat
> > accordingly.
>
> Please don not send direct AI output. You need to drop useless
> comments and trim down / rewrite commit messages to a sensible
> length. Instead of huge amount of spam.
>
> Greetings,
>
> -- Sebastian
