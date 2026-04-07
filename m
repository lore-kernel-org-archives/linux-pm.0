Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86F033507D
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 20:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593301; cv=pass; b=UTZ8SGS1AbbIvdA9oXxAUfTsCCrwnoCvHxQDWPoyD246P1q27gJvER9vuXv6KrGfP1tv0TYYgpxvIYpJ95d38Lt0i/aQclOAUmlqBmqSZ3ZPjR6kQNhlpqwZewpPEsBvC40NGYrcFUYAUpI1cJ+QHAR2tnjMbrhHjh3MXJMtR/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593301; c=relaxed/simple;
	bh=OJ1tQJvTeGMBujVZAtwZtubFV7cagCryNfAmpVWvX2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYg4gUrlOFrAXiT5S90B3jJ1XNysTQsKypSCp34+Mz02CYkk2yi8F/E5XFwZBl4ZJJ7RJCaz7GVbJVKr86t0uKXSUb+7/2TkGxkswOtCXSaxwOcPVCkSkA0K65pS9SyMrMQ3yAbuo4g/uga1TMUW8VNyAKWlNtuoU4bV1F89yaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Digbjsaj; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Digbjsaj"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b941762394aso740010966b.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 13:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775593298; cv=none;
        d=google.com; s=arc-20240605;
        b=JiSSjferbIsPq/wEGYYRnSGuP2OhHRjiWx7M021XrEXP7Bk9G3munNC1mLhqGOrdBo
         ZJKTJCA7Mr5Kac+3ul7PDoeq6CDJZmceDUTOdCD2k2T+mWhc2JUU7BcT3mHy1m6bl+A+
         cz4QerOuB4X2g3FWmStdXCZA5UwPqZmBvhMaNQ+mCTM6OQLDiw2V4oQh941ot9ZPPuzY
         2h7a2Xrnrm7R6ktiupCdIoOWWeIgi0SFeGNSGrGM+ldM+poL1h5OHuaOKksRo0wmdkMy
         wJlQBrKjD+HREgr9VeHRQrt4/ENoUWCe11Suk0iV6hdRvL3rJaSr5TVTCLKQi5TeidT4
         ic5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OJ1tQJvTeGMBujVZAtwZtubFV7cagCryNfAmpVWvX2I=;
        fh=kmDc4pJQEbbE3kddq9a8kW+xZnG7/gdx22dtwIts3lo=;
        b=f890qGQiz7qQ1E2UJXIKegLJ8j9N5M9J4YytQSkn7M0eqM2C0/bQMG5SOV1/6fRaCe
         wLo+zG74P2CYBxPxNE8IDH9iKDQcm4bNo0aV2AbRYYC1LNIcTF9DHSdTZoN1pk27efe0
         Z5cS06wNLABddf+dWPixjpAkIuGzWJDoo/0w5npKTYM5kgtjnIPERXo1uEg3aYxXTBWX
         GZjLsytgerqpYywsPRwshFZNoF3K3zAa30pF46nXy2OWtkWr0gl3WzcqY3zuuh88+rYj
         MLmVXe1zByHV7hNVzi+pYN6E43h1oLhA+GzGInDNRsHG4xYApKeMxij5Zg2MwcF7cvlz
         zyDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775593298; x=1776198098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ1tQJvTeGMBujVZAtwZtubFV7cagCryNfAmpVWvX2I=;
        b=Digbjsaj5m93nHOVCFbrS3mEpKIjOF4kS6gA7CWIqEpP3wvyqeZ/dsdw3MIxmi27HL
         VZWC9n+VFO/hCZ3c5zbfPz3WafWZBytYKl8NbTq7Pn8ejMvVECeP8s1DHrLCFz/WVzHg
         U8DgyM+IEaU1tBI4PlQ8DB7kI+czlsSQL0bgKEX+/lLwjTruuJ+J4EtQI7aEqlIopIZs
         5pBtHrWzBBRMy49lhxL6D4ksvk7rueuqlp/8QGqAbYgfnykffsJMEhVqqcKgKbP9TCWW
         aGYogSMDWI5ArIpl8vGQRgVQzrKgMMJibmE543+XHuFjJsAl4lw5hm1G1PjwKwKWXzlJ
         j6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775593298; x=1776198098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OJ1tQJvTeGMBujVZAtwZtubFV7cagCryNfAmpVWvX2I=;
        b=DGio4b1Q3Ubl4g3rKegxLj9/XhtrtN/CGJ7SgbQQcIFDxfujwOA2zcnwrJfJ2PxgyM
         tAGqBSRQdYc/HjbTn7Fop9VChgaQ5zpxLsLzDhVG4EjiArjFrT1etRw4FTJK+KUVOlTv
         cIKY2Ojtko19wDtLW1osJtlNzNrISxSf6U8+6BEaGCAaXhkGjaTEHYw7EzJXXaYhtyMq
         8+d1GBlbXGRO9RnwZLizcm61dRa/A9juVBH2q9rPUKd02xNxIEP73H+riRHxA98njHRC
         hts2o9Zl7WnVCTmZ121tM2jYIzpLDTPw3XOqY4oHSFC0BW8krcda9VY79/v7NoqSMVIL
         i+SA==
X-Forwarded-Encrypted: i=1; AJvYcCVftQkakNrQ6A6SqjBtUPdSBiGbJtO5hAaSZqccB6sEWBaN3QgpDAIPbYpXDj5bCLxsFMjMbsDpsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBQXgrT1Cdyw6by8TBZ2FrHdv3Gkyw8/5lgxzr8VuZJToljS//
	3RV99Q6Vug4p87ZbGfFoCXH9cCtlFkglqqLT0CuLnLalwxB6ULyc8cBcu6QSAfFTH8+bTzuBHUE
	0Qo8Gf6GTOaWpXUuomtXu59qSlaKaQSRy5G2rDXQ=
X-Gm-Gg: AeBDiesjw36HtPnlbw8Blt7m+bWQHI0c8g70aPdiGHMGwSHBtBQkBZkUyhlm6uq3/Ku
	kq1bbG4yB0zn2zqIgQMNR7HVB+9aH+QVbroZhHS/Ak0sj2eC6H2DYsxNoIopZd+aMIpm/c2uDcZ
	yB5rR8dvvW6e/LgxjkZXUzrIXdJiozpW3rRMwNS09QCB5KFFyZIEYFU6tPY/ZqMt/lQQE3Xm+x4
	z4DM7qeuscUJZHLbOJzkR6zGOdJi6eIEUczBOnipjD4GVCtQ8gsI3OVytL5NzOH90GQCFhzhf5/
	WenQRsjZjJVZftu9dYHBUVZildbb+cTtGLeD
X-Received: by 2002:a17:907:d87:b0:b9c:9594:e10 with SMTP id
 a640c23a62f3a-b9c9594137dmr648296266b.14.1775593297523; Tue, 07 Apr 2026
 13:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407083219.478203185@kernel.org> <20260407083248.303293327@kernel.org>
In-Reply-To: <20260407083248.303293327@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 7 Apr 2026 13:21:25 -0700
X-Gm-Features: AQROBzC7PDFv8vCtFbIbXkiDn8QPhKuu5um8yGzNerNDgS5PLItAWlJfqN0nP1w
Message-ID: <CANDhNCoTUyvQ_-Vn3neffN_Cu2uwPW36O4CtZLCu2JHPztW8Kg@mail.gmail.com>
Subject: Re: [patch 12/12] alarmtimer: Remove unused interfaces
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Calvin Owens <calvin@wbinvd.org>, Peter Zijlstra <peterz@infradead.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 1:55=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> All alarmtimer users are converted to alarmtimer_start(). Remove the now
> unused interfaces.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Stephen Boyd <sboyd@kernel.org>

Acked-by: John Stultz <jstultz@google.com>
