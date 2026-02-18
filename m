Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FDD3321BF
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771405130; cv=pass; b=EbhCxOItpdeX1O8qlvDy5r9fYUZNNPGByb/AHFz897FUvWp9mEJhmAd0T19akP7wPfHnZbsbVN6gfZjzgoLcm3P39BQh1VCP647jD99WKlQDfFaCcriYqPGhu8/7uvWeuLwHQ32KUKjlFXQX6stgPDWYopQWAvitW0bhpTR32rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771405130; c=relaxed/simple;
	bh=K2u20GvrPHBhHPDflQMWkZX0JzhBFSyITEpy7OMZuNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqB+Qpbo9gnjasaETcDbZEv2qkq9FDN9v/Ti7sszeHHMjONZPli9D05tqIcDhnRn4tx274+JexNx8h0fgd5/NgR5u/z1oDUp9BBWSvymAw5A067dcf3Qjm+ovQu+2BVAejqnKDxyVxSljJQP/dMvUCYwiL/saK/K5NDDwdRuXRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTifsV32; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTifsV32"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8fa449e618so730745866b.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 00:58:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771405128; cv=none;
        d=google.com; s=arc-20240605;
        b=Nst2MZBgaDu98KMKWijthfxIxGBNMIsU9qpUBQFr2XfmDoUTEwwbCc6+GFMkanrFDb
         2fRUHRNjIAAI2M95SngR+FlxWW8p1WgM2YRS+feCf5r0bZYPfl62TggOUhbmupjE99nG
         5jl2fqjlRku8eviX8d/JcbQNIRz79U0E2A1ZatC8+F3z/HXuWdkqeJphCNg+GCkvRBjo
         cOHIf1KBEajiTdQU3P5BqtG0NlHuCxdqq6rOHMbs7lqDr0Ey19jCI0JKzsLqTWncu3K/
         v4efOSUXv4a2tShGRgOYOjBu+33DRWlLGkWRdyB0IdfxKer1EQqRvWZR+j2VB4eXiZHN
         kWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tvut1BfJ3cpazddpdU/nRmz0yZV3WbQMIAmidpNOpcs=;
        fh=xMkYmvsJcFK5792G4FkdPP/Am43gKyYEvfJtr6/+vMA=;
        b=lbp7rOITrFzrykKMiAL6cfgyYmczV48fbsgBWiw8nje8o5YNDAalTnCWVln65cn2HJ
         AJjVIdliE8xyGhCTr1uGl3XjIL+xtB/iS3SoDyS82r4e8Gynv7wtonZSbeS0JL3QWgfX
         Lbi4j9fxf2PqRx6C1Lnq4j6NGHxA3NMSepQ9c5dV9jXV7xM+m5knQ+JYu4B7z1/CpiIG
         a2xE1xOl+gr9Q0qy75YoJ5QSpwY4N8reyfv52vmEsLHsxB9edIZuCrPBabdgDQjUw3nj
         dcg5XPPFAxUiWI9bx9HLmrQHVFpD11Ezexee+qFzxVkW6bY5KNSqt5Ie1wkC0vrkl0Ax
         kX7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771405128; x=1772009928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tvut1BfJ3cpazddpdU/nRmz0yZV3WbQMIAmidpNOpcs=;
        b=ZTifsV32wk9ImBJlI2GFdrlnYLeeux6oFGei6itWNnRvxWw4WtjKqn2sclNcLGcZIl
         8qfeSLNrzAUaIKNMx1NwvlHnQAr/0oesyzADLQr1JWmRHXy4mylPiI93U6j1rPFEjAge
         z3SIUOkk0b656xUTv7NoLa6VhFB+l6s5hQ9GiMP7H6Wn5BAoIJWjxTJzhpinWEI7vbJC
         5KUTWALvH8Dmh+BH61ZJF9yzPqQnkU4MgBVl5cNqUsxe7LKSBz+34u18m/JtDMvhktp+
         Ub2pJG5+tsoQP90HSNDdfblT1WYv0JUicFf9MxaUCyzuvMQC/C1VGnYmYpm4qlPfR3T4
         oEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771405128; x=1772009928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tvut1BfJ3cpazddpdU/nRmz0yZV3WbQMIAmidpNOpcs=;
        b=arCtjel08qugY69WXghx39//Pk0kE6WEBJsM16R8pcMhmfByJqYfRm0Aumx9rkNvlq
         W9EDcQC613gFCkIUPRjHvqFPFUeeaLv9jsYktg6+9PllG85Nxf1k9/KKhz6xnZ1Q6ou2
         z6sjW32vdd22ksjySvaA8uEjplm9uCkRMr+77HLpLBF+LI9FlP/hIarm/Lgjbp2HgAtY
         YW4hdFVjpPvcKefZLqFT69XRQCcIW2HXSMteVG/8IPi7ayRm0vFFBuYnORYyjfG1YYWq
         ahDzMWM55OOzG2vVtAN4C/+IASVB8vbMUdkChFu6XvHdu1oAkyT7RgPREknKtuVfX6xR
         IK6w==
X-Forwarded-Encrypted: i=1; AJvYcCWG4fq56XbBckI4dl7TGtcvgEuj+yS9SZHdmUiHYgQNFm63jhbK7bbsDhTuAaVntxDxOsAf2y0KQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0fW6NccdHB9gH/LujQMmfs/dZ99UR7256kTneWo5vyi8Kf+Tq
	Cu+VGVxD21xCdctm0xuwDRe6/gvxMQm/aCvPlz0uo5g1FdGcOvgVPhqqPV5oASufFbDgByl4sBf
	Q7KkcaLqM0nerIbOHfc5WOPoieGWAK8c=
X-Gm-Gg: AZuq6aIYWiYLbJIF9fhPvpmdVNWtfBLqdG4SuDkdaAD5rrjhtctJ9pa6iXpQrQUAaJ1
	FWIk0+nT81RFaobgCoo/3HxNQqaDC+hL6PAtymUlVjo4pG8/j9RwWcMMrgSMWhjxHXJwbx0P3CX
	jqBDVqym/p6VP5ps1IGEym7bWzl0zN+t3IvsGirLyEPtg84hKHCPXL24MwUa9gmZa+OQU5v/EJd
	APFwzOp4WuOx4nOkKY39E+fPSCDUr6FvJAwDGyo6yJPOMLSZMwUgLwr8ppHb/ZKTx2lh53X6GSt
	qdBF0eiGwzVZrTxxibQoXk1WChr+Awp6bWh/OnfI
X-Received: by 2002:a17:907:86a9:b0:b84:1fef:329f with SMTP id
 a640c23a62f3a-b8fb4376aaemr897638566b.26.1771405127545; Wed, 18 Feb 2026
 00:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216-hibernate-perf-v4-0-1ba9f0bf1ec9@tencent.com>
 <20260216-hibernate-perf-v4-2-1ba9f0bf1ec9@tencent.com> <CAGsJ_4z83AvzDNXFOY7UftOAkPcK+6AoR2rE_2rzQLTqx400eA@mail.gmail.com>
In-Reply-To: <CAGsJ_4z83AvzDNXFOY7UftOAkPcK+6AoR2rE_2rzQLTqx400eA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 18 Feb 2026 16:58:11 +0800
X-Gm-Features: AaiRm50JBT6LZj4if3-0mAdpnUKWCt8vsnCaw7Vnh_a3smSA4u8vVHCPWn2aMxk
Message-ID: <CAMgjq7D5P7n9z6w+MbQGXq7RY1iTpwxztVOd4B=tiyXDbNXxHg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm, swap: reduce indention for hibernate
 allocation helper
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Carsten Grohmann <mail@carstengrohmann.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, Carsten Grohmann <carstengrohmann@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 4:23=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Feb 16, 2026 at 10:58=E2=80=AFPM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> [...]
> > +       /* Return empty entry if device is not usable (swapoff or full)=
 */
>
> I feel like swap full only affects the swap_avail_head /
> swap_available list. Does it also make
> get_swap_device_info() return false?

Yeah you are right, full swap device doesn't affect
get_swap_device_info here so the comment isn't that accurate. I'll
update the comment later after 1/3 is moved to stable. Thanks!
