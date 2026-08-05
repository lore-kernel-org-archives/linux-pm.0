Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34C37C112
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939680; cv=pass; b=TznW4YP7fqZ6aHf86c0gt7ASqZEV5akWFhBwAsUt2fozf4NYH75CTFXSW4DIDyfSB0eIIjLhYbM+49AS4gXiTzkgXDNtCtzbUc7xsG/1Al6NHojSiA0PtIcFdra1EL1YSLLrj/skSM3tJ1hBFxYghLWDV8SEsqi95UzUV8XN7dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939680; c=relaxed/simple;
	bh=wKjwPL4jiFVVhZn8wxbyMovG0KIp+IBVwz8BtgdODCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WW9RAbO+lzM2fSi1Br4yx2NgvIm9zDqDTOIVMFsCAlDnYDAdrVIaOyGki0IxPinvR9XUpwIW1n3xvV/Kkz5JMVyVloCALOLevuBbu0iYKnp8BXC3+mxdr20/UzY50BTeoUi+mlWaUf2Izigw6lxdPc3QVVyYwsb9uLc6A+wmPDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=O7qPt0hI; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="O7qPt0hI"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so112578466b.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 07:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785939672; cv=none;
        d=google.com; s=arc-20260327;
        b=QGHvFMEtWTL4aPPAobpJwC2q/P7JBqG9vGyuaK/5In+VDzsZlCdam55jX6cV+tOFpY
         7WEe8EnWoEyzzboBTQk6YZxK/doXXN7ZrK2v99nGhQN1d1KNnBoCn9xhwZjQRDwHnVJf
         2Vb/GU77m9/dlfZZ8JWeLKlZPPC1o0QkF5r/7426kPyq125WlutrQt5xXwBzpi2DIJZx
         Fp14ToK3kjf5jnRU7UtsbVy2ohNLaW2nSjK9SJD9ZlHhSv4kJeihFMbEA+duxAsBVd+E
         WkWy81A+IXDreu+JSGDg1XlACK0IZxmdtAmU+LVfjtAyHv6vieu6owr4XDnVrNzfvxKX
         6zsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wKjwPL4jiFVVhZn8wxbyMovG0KIp+IBVwz8BtgdODCA=;
        fh=iCGmFj42PFBil4rr2XZ3gLkmmztW4I1XSsk7U10DRQc=;
        b=AFofcep8YJILN8cLSL3L08JX5LUwPE6T4B+HiVqFSfBBgf5HVNlBqC6YSjWXpzdwpw
         n0RTKe+x4pnfxcUvfZxmUkIuzMIxy7o1sVrU6AfieZcbJfdZClFAxVDKHpaVTV/ychMz
         SyCNfqOU44MzzG3BiK98OQuaSi1uymXC2RDPjw8Jx9//XM0gUSUyJmZ+5+blmJO89Nr5
         4hfcXIjt4qr6QLVY20CPCeuaM9OYYLwEuPkrpJpYDY61Y43FwNTeKeQlBxBU7OAKLCSP
         anTVH4R6e7ORKVOqYuJlF6ngonhLY680/eG6bE9MLDYCcPulM/KxmsoxtPTRcN/qLaZj
         UNHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1785939672; x=1786544472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wKjwPL4jiFVVhZn8wxbyMovG0KIp+IBVwz8BtgdODCA=;
        b=O7qPt0hI2pcJ76n/K2mHJSuc+BLkQl5xJO44Cfr5+pYX/0VqL1p9NwUGfpAHTB329H
         Uo3vxAFd/+gQGzxK5u/1HrQxlxFqFnx5+cUl7QffDUKiyGiIMYPGQXST/z5/b3gGfGsA
         AKyW2Rp+n3K4B/z3BxRetX1pC6LbswiwYymxKXBMg6TUb1LmpTXsG73UEjMO0MLMk6wr
         6kKKIyvqFv5TGn7KhSKWHcSXmNJpv51MIlxkbkczXL2Esa1Xc0JkuOu4jCNtvj5pCuz5
         ukSs4hx8H1s60/+0NOarbG5xVSDc8sMC0uTGcbSJ1dKJI/OwyWqNkwWlezt51t2mKqnV
         gfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785939672; x=1786544472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wKjwPL4jiFVVhZn8wxbyMovG0KIp+IBVwz8BtgdODCA=;
        b=icALctyIRpMVfnUJ1pl3EUmOZ15W5D47dO26dLqy/OfUPSDgKPKVLnoTsqVlyrDQNO
         bZcYCJWIUpZYOz/inU6KaLZWC8G1ktjJDIdLyXmeZHAvk0LfrjOtIVqLZuQdr5/v4FOI
         4SGec28zx8kO3S+slc4o0iQTm0e7tTWj23ALQpEBrheV9SlMOzxWq6i4QhbYEWU0b4vp
         uQS734oqyICLyCCIRx31mBYH6M1VyD2GF3SFZp+GzUZrRAo576N15gsiG3EVV+VUZFPj
         ca29TkUOFd7VwvrA44D8dUcCsB4jTE1y/wOQQj8yNFR2UAfD7y6gbcHDI6gxg39QdT/v
         TN9A==
X-Forwarded-Encrypted: i=1; AHgh+Roc7wuuYvm/UCZC4eLVPgLC/3S2lknw9y8LyfTGn25k8TIALxC1xUfNo9v6QCESQ4r/oXG+JTlUfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqhPCzVA8P+t5iMKqFHBHG6ZZFYx5oD4rFVvtajTiucpWzcEfR
	irwDEOrq8Pi8jOGsIFKLonRnvcgm0NIHXPWiteTKdcmHP/cTAHEXmxuNTxf0pKw2jXryIsUN8pg
	tEO2e21yx56z3YaI4SQGfPiFS4g5Z2EWLY6mIGc5inw==
X-Gm-Gg: AR+sD11rMNwD7M7SzWuiDzLI3BfdVvmgfcpeS7CE/AAHnAuK3cM9d6VSOBwsvJGyCJD
	8RYCNnO0wO+I8NPQPV6LUPtWDAbvp7mIdZX568ti1rwIqTRAAD31l5ymLje9qOTdqG07hOrI5tX
	jyZQI1/ToQ+Rx2SXV5LZZvo9YpKJqC9lwhEffUPXCsvHgnZr7XG4O+kTB4mq6Z6HR4cHBXDga/u
	rwzPdP0CaHsRYq1S1MI8nZeL2UslIhUKvv/odq+FvjrS8jwdWVKJscOXwJ2XC6EVjJK81oIHfAY
	2SD0PtomaVDvBS/2+69Afjj5qgl+ujUfyzfRQdqIHVRh5uIiGOGtVcdqAEcmXfOBlm9h9d9PPz+
	s
X-Received: by 2002:a17:907:d01:b0:c0b:e9c1:93a7 with SMTP id
 a640c23a62f3a-c2039cdc5d2mr377589666b.29.1785939672153; Wed, 05 Aug 2026
 07:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-bq25792-v8-0-c1c70473bbe7@flipper.net>
In-Reply-To: <20260727-bq25792-v8-0-c1c70473bbe7@flipper.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 5 Aug 2026 18:21:01 +0400
X-Gm-Features: AUfX_mywkqyfgyeBQlzqodZxjMyPljgBw6KjVXhsQ053pRBoVui5bPUMtAfjvBE
Message-ID: <CAKTNdwF5yW4YFFmsvDFVY+Q+89Uo=YS79nb4qYrT4WyKOszyvw@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Add support for the TI BQ25792 battery charger
 (regulator part)
To: Chris Morgan <macromorgan@hotmail.com>, Mark Brown <broonie@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 11:52=E2=80=AFAM Alexey Charkov <alchark@flipper.ne=
t> wrote:
>
> This adds support for the TI BQ25792 battery charger, which is similar in
> overall logic to the BQ25703A, but has a different register layout and
> slightly different lower-level programming logic.
>
> Mark, would you mind applying the regulator part, which already carries
> your Ack, and which is the only part outstanding from this series?
>
> No cross-tree dependencies here, as the MFD part is already in master.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> Changes in v8:
> - Rebased onto recent -next and dropped patches already applied by Sebast=
ian (thanks!)
> - Link to v7: https://patch.msgid.link/20260603-bq25792-v7-0-d487bed276d0=
@flipper.net

Hi Mark,

Gentle ping. Any chance for this to go into 7.3?

Best regards,
Alexey
