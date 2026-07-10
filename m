Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA63537DE
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712379; cv=none; b=kwqCYhlJ9t6Pinq9QCbPCXUunTR0QHho3k2GwTrXqgv4DZtPxNQjliJCxAlKcUkwFwqABb7JMg/iEiKdQ/TELSLRVdorhoTJ1YYL6psZ7GFQc3hjdjry0x5bf0DZAi42shar6VBLy4XRuc6o/AtlRd9bKlZhL5HP2P27VVCcfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712379; c=relaxed/simple;
	bh=htOp00x4FdqXR1iq4aGwDRJJXYEyQzl2O/yVzKc31B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1S+iieRcGIk6Xeb5EeR7KFbJ74F8/spgMb+9Z3BF8HZkcN4Yr43fyBNakOpad6u2K774tJ3Ti41SLygfc50upZK8IUkOYyryKnBd0EVowmB0cygxQtJqAdhkt2ePAkyJQn6If+lH4MKdryI+DTnBKI9BMgHSDog6cM7QfXerqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX6j77Ou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX6j77Ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9191F000E9
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 19:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783712378;
	bh=htOp00x4FdqXR1iq4aGwDRJJXYEyQzl2O/yVzKc31B8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZX6j77Ou6W60RfnG2KS2eWc/qhe1js15APXVy50oucf1gRhI1L2QAUUcgWzQtRkx6
	 LaefnuxWGCd+XutmrgHHPUgJx/J4mUiCSEK4k/cb5elPurObnfA1lQFSu/kI+Ihmj+
	 7FkP9o2dqxfDKVUuDUjG9BqGBp8eN+MhLBfm9z+K67u4Hqs53yhUKhmnA385DZsa5m
	 VK2bYXVECIwENkv6fzNIsJZm+7Zu55E1T0i+WGZl0Z484WiRZAeeJZ2qZzZieo4RP+
	 C9aTXK0HqPxxWM0j6qe599sKh3dwILAkMRkafA7GbrB2voyJ4MM5wRwWDDEV7o0FSE
	 3ulOgGQlmka8g==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeb5829fd5so1182752e87.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 12:39:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqjnZ0wutVO8ZWvV3Ujc/HhfFX1x/0vFFQ2g5DigMbzP4HC797T7UKPmEYTInn355LtvSjbFHXMGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YypAH49g71HvhiXbIR5HBRBDI/xkvunxs9LiVxYdiLU1DxaFRDm
	hius6eXM5NrtJhBBzfsnxdU3KP93AjDTocMWpGsycLsYFYrCX/oL7IcTH1HCPweXE98/jHgs7Nd
	DAq9R5Tkjl3lvXqhkc8AK7ffDiKQ46OQ=
X-Received: by 2002:a05:6512:23d8:b0:5ae:b7d4:7dd7 with SMTP id
 2adb3069b0e04-5b023667798mr72591e87.24.1783712376889; Fri, 10 Jul 2026
 12:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709033428.362970-1-panchuang@vivo.com> <20260709033428.362970-6-panchuang@vivo.com>
In-Reply-To: <20260709033428.362970-6-panchuang@vivo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Jul 2026 21:39:22 +0200
X-Gmail-Original-Message-ID: <CAD++jLmtYcRF2jYHWgjSw4wRbAdSV58rNAFq-qioqzdeQRpu5w@mail.gmail.com>
X-Gm-Features: AUfX_myHVc3pRd5FGuDcXG8WtrClYu9WtvG_FvIwRXD4Id1VzUZn_eWOgcjyLZg
Message-ID: <CAD++jLmtYcRF2jYHWgjSw4wRbAdSV58rNAFq-qioqzdeQRpu5w@mail.gmail.com>
Subject: Re: [PATCH 05/43] power: supply: ab8500_charger: Remove redundant dev_err()/dev_err_probe()
To: Pan Chuang <panchuang@vivo.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	"open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 5:35=E2=80=AFAM Pan Chuang <panchuang@vivo.com> wrot=
e:

> The devm_request_threaded_irq() and devm_request_irq() now automatically
> log detailed error messages on failure. This eliminates the need for
> driver-specific dev_err() and dev_err_probe() calls that previously
> printed generic messages.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
