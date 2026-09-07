Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3356A4EA38E
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794232; cv=pass; b=tydb1m+nZIHSzc9eHzq0EiBWFr7qua+E/bjdVLgIYXiCGbT4eaZVnhxo7N++v7Le6zBcoACgAbg5S1RQBYgY5gcDdHPraEEggUDxLyzSMrxVcY8d5d/8VpdmUzqfKguUZ4L3cR7KIe60Aj+wU+UcCDy0Y7hwCHZGrf68D0jmKkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794232; c=relaxed/simple;
	bh=tRadtUkaVvj04esL9CJgzsoORuST+i5234dOZxdyPl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZvinYTM6wOOc29lzqBXOFzVoEOu7Vhw2m8Pzy1UKKAhIcMPFMOQXUzZys1RX6Iz6yNkvKE8un1FrEcsB92grw6x83Xi9fkwY/lYEgBcOJEZG1t/+vBRJbdw7jl+vvT+s2U6MnnEOE1U/rOkhWwXP0WuSkdOixHnK5bqtpvMC2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=3iW/nw1V; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="3iW/nw1V"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2530cabcf4so559980366b.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 08:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788794229; cv=none;
        d=google.com; s=arc-20260327;
        b=SZiH5IccYm15HE8hSpueiKLjJOhTP0C46kJfjy9PRt0QtbeGVULYZylPuB2Z3cFOcU
         q2IB+kxNS/owhizNPB71oENd08UTD21KMyEFAEKaSnuk7msOknNEjtf/O2Y4+D1xTLsW
         cRti3tIvuMKf1zn0y21sRn9bgtEcYYteaT67bBb9R+AfBmaNIIABkaWZPv17G8R/adS2
         JPfXEjBEPKcaZ2GTlr5wjnYfRC9mvSbRFN7h8VQlMSWwQu8fmL91xK2FYtZg4Qacmhre
         DeKk6ojbgljO4yrCYvYZmUrjAsV5J24viyCuL3UFvCLMDZIziSnzDYdVb5mg/Grnw53L
         mALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKK5R4Wa7HrnZmxxyX5YlzuTj7TxD9g6ApN3R7me0Ns=;
        fh=UtCt4O+tqkRHg2jZEP0nB2k5EhotkT4oRfwX0Lmkn5w=;
        b=H4xCvynmdSbw2C96du1q4hsEcPTQg9L7qItAoj6Dt9Sx5igFD47oqVDA4b1B09DQUd
         3VfSGGi10zcRER4tte5syThrjZoJ1ZcKcfyTb4cBRycMZf8U3hGPI8EdH9/35xI4fWbm
         EHJjxfWJpqU5XHj/wj/RjcdQljjN0qkpv1UdvZYa03cNEAEBEWOwrUOwoRtizr37Grc5
         7uk9nAbY8c/MFUnDLOlvbCHTdU/3vdcf3zg1olSqfhoML/8cG96eJv5cSxktlOKU4vu6
         wYcg4ZL4LLdDq/ijmf6kapCh9Ri+CFt2qzqTSln7m+Fc59HN6S6ul+pxLysoxPi4f74M
         igIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788794229; x=1789399029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SKK5R4Wa7HrnZmxxyX5YlzuTj7TxD9g6ApN3R7me0Ns=;
        b=3iW/nw1Vdh8ghzDkYFr4HbQ0k1NentvcGosN+qxMNj45+uXsaH8fBQJ8Kf6aXPMC4G
         MrGJDT2VH2XbtRsQe7LtPVLgA4NHwowtUQFG+l+nZLadtNJ4emJlG3ts2lmb+s0R7nrR
         Y7cdqH3FIlSREJ1hnXAVsK2ydU4v3pWYHWDlESs12KHDsFk31BuFvdxQPM43W8Mortl3
         PP/rLQ1bW+Xmy6QYRgZ94u7bXii81fnHUfPiM6bh6Lte3juyB3M29u/DAQNJfUU18vQB
         iNkdRt8cn67pH/Gy/7B3JkO8DNLFQOTeOfgSk46JzM9JfPOzCRHagSHMTRKVCCAEn7ku
         i4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794229; x=1789399029;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SKK5R4Wa7HrnZmxxyX5YlzuTj7TxD9g6ApN3R7me0Ns=;
        b=NCWVftzcDVDIUTI1dLghSnAusJHqOTPYs0Jcn7Ys/qLwM81bSlcTrvinLk+fKRPCAx
         CTSrmhNF7wTzhLlkyR+IsP2dVpkzenlLhhMwEB7shMPQhEtSNnzfIt4v+LVvq9bfLiNr
         tE8t2KB8y3cJZooYCVuK2PRRiG1uE9rNJx51qWTPhLDkVMwfXFo+wNfmY40v6wK6NNzi
         slSYzlYWu20+nXayTOBKaQkZGlvF9YwJWo4QhSgRWskYp42L/rGLV4uO8MpM6rYxJoJK
         Sfgwtxdh6zzaUAEV3HbGrUnGluEYoSWPGFqyaoerG2TTWE0gN4xU48LVq+b6+A8susE5
         jVwg==
X-Forwarded-Encrypted: i=1; AKwUvBwFBde6cv1m2kifdXi1KWiVlKuaaPkNSeRiF9nHOBLBh2++3g8CLFbEfX0OSxge6/gRnBMp8BfJFA==@vger.kernel.org
X-Gm-Message-State: AFuF++nQo9S2ixB5wonKkVwCbZzRYwqLFRX18HiPH7Ra/R2g+ZhAR3i9
	Z9pJKTFD/QSBt5kScTREWXsZn9wjSDLtdGF40VQh3GssRrczvLN5O5jyuOuTegPGijIVhX87MUy
	17elCHBQkLhF/oNlQdwrJMT4VN3ouN2ZH239jpb5nOf58Mumc9P45
X-Gm-Gg: AYBFou3wTENV3PDzE59O75c6PMJPoPTOELkYsSQchjYRtN0aOsRPA8Am/AgaaXx/OL8
	dJs8H3XVwV7Pgf49aMSVl85VHNLw5KHcvKKQitV55aIPPMtBdcohNMzESSLIookygivT2xvnBgf
	3zpRaCNrZiCy456c2KkbjmQFZb+H63tYv+ZxFp+fYypqMefiJFFQZaI2Q0W0AnfTIOWK04zMK/u
	cRe1aMrave04bt/bCT1nQbIxq1cauOaGmRhUumkljUUU0smACTOczz4IPDXAVy5K/grUU0pW3ma
	c3wv9ji5ezzq3M9IF+8dJYRFGwMF5gW9ML+jQzU643CWHNyu1Ad7w4N+dI8vrY96VXY1UAqwDYh
	ttSjwmVpgqUlL
X-Received: by 2002:a17:907:1b1b:b0:c26:3190:2965 with SMTP id
 a640c23a62f3a-c2631903285mr1089445866b.12.1788794229405; Mon, 07 Sep 2026
 08:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-bq25792-v8-0-c1c70473bbe7@flipper.net>
 <CAKTNdwF5yW4YFFmsvDFVY+Q+89Uo=YS79nb4qYrT4WyKOszyvw@mail.gmail.com>
 <CAKTNdwGC=AZ9jmD71tz6JqCWk-00QLWCYb9wiG6RRQ0bO=mC4Q@mail.gmail.com> <7c9d0cfb-361c-424c-9e12-0fb35930576e@sirena.org.uk>
In-Reply-To: <7c9d0cfb-361c-424c-9e12-0fb35930576e@sirena.org.uk>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 7 Sep 2026 19:16:58 +0400
X-Gm-Features: AcwNN1UnkWmNQ4cjm6HuUENUEdivKAN15-Dx3TSE__uWOXkXPewLiSPKYPBjbEI
Message-ID: <CAKTNdwE-m7_=EE1cp+B6dF0D5VXbrfnkYrJx48=78p04mccSVQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Add support for the TI BQ25792 battery charger
 (regulator part)
To: Mark Brown <broonie@kernel.org>
Cc: Chris Morgan <macromorgan@hotmail.com>, Sebastian Reichel <sre@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 7:10=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Mon, Sep 07, 2026 at 05:49:55PM +0400, Alexey Charkov wrote:
>
> > Gentle ping :) This still applies cleanly to -next, so I'd appreciate
> > it if this could be applied.
>
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
>
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.

Sure, but it has been over a month since the last ping, and several
months since the patches in question were last changed and reviewed.
At least two merge windows have passed since they received your
Reviewed-by, and no additional feedback has surfaced. If it got lost
(as it appeared in this case), I'd rather ping than live with it
falling between the cracks. I didn't mean to get on your nerves.

Best regards,
Alexey
