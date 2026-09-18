Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4695172C2
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749038; cv=none; b=jWqKcVVi83Scs9sDbamt8KsLI+G7HrynqZymCriNCSbgcDNUKxwb5HRgTMVtrDoqFphfyUK5MWwM9nw6hpA21RfZm6Mb3LFJmPmBBel1nly9HfmclZDLPa6Lm38Ejbh8UqYx7rzqhAXvxLvcq/Qb20kGHvqczvx0ZrdkAq9UgPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749038; c=relaxed/simple;
	bh=nVyy7RW+ergekuB/uPOMCJEpJFWqYOWoZXegAiVVCME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCDlFDI/PQtpkiCGExs3juERMoH1vTLSZPuPpU9potE0fVlvm0891+mtfDDN4qsZ1YjEJCyj+khEOvzeV8jLTOw+HbzGLz0e4CbLKwMRAKF2cFnSsqpCMpWI7ifGA3Fjw95aYjWwyHbe6R4e1ZzRKYS8ErQFYHu6Z0vqbJFOdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW9r0F8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW9r0F8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DACA1F00898
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 16:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789749036;
	bh=nVyy7RW+ergekuB/uPOMCJEpJFWqYOWoZXegAiVVCME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XW9r0F8kS+IWuqtVDkgtB2FooS5PntWPpAOWJrLEsoR7zHE5rmcIwTR3mzPu2dUzA
	 wJj08hc3bJPNe2B+ynw/DwaGxvqi1bpmEy37PCbQOGzLGnBXjnesr8OUhW5wHFf5tR
	 Re52/tmUXJbknZJ3YnyP//UI+3+zfdAbwX/BGoczzUmb8tgOFjTWaXqL4ZUmm7Lqe2
	 IvVnIlymKOwUXBBcgYLjATMmKzBmf3KEaT59p9qb18c4Y5hrslyYRnZHphe4l1HTSA
	 tcQsp0KvnH48tDstgzEoDFMdxgxDwfBJLosOBXlvfGIqkFusTboM98oQfUq6x49qE8
	 1A5rnc2tBfV7A==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8b402f4e3so981805e87.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 09:30:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByuK0B0xEf7vPGcqZ/nCxMO4xuPpKXT8/Ga57eE4sbun5+DYVd/UlGhk3WTlR41yHQe7u6LwvA9kQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kLju0LTsC6dsvGSRF9P+PMX1AqNN3n/BOCt0lt3FFGArZxBufY
	MVI2vbF+nsb5KlnLJtjYwc0whYQbJgrjaGZgyjoS6/J42MPe2Rq+2VNnJDogNgC/P5VkkSYAi1b
	h9mBZZEzVGoWXXdbdeskW7rMUYctYToY=
X-Received: by 2002:a05:6512:1389:b0:5b7:6489:37c7 with SMTP id
 2adb3069b0e04-5b8c179d8cdmr984730e87.0.1789749034962; Fri, 18 Sep 2026
 09:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-ab8500-charger-dt-v1-0-10b7b387e6a6@kernel.org>
 <20260915-ab8500-charger-dt-v1-1-10b7b387e6a6@kernel.org> <20260918-cerise-chamois-of-speed-af2e93@quoll>
In-Reply-To: <20260918-cerise-chamois-of-speed-af2e93@quoll>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 18 Sep 2026 18:30:21 +0200
X-Gmail-Original-Message-ID: <CAD++jLnwtzxNjTJXW9C67pR2EBFuqdRHPzwqmCX5kQ6qeX+2gw@mail.gmail.com>
X-Gm-Features: AcwNN1WdXWgijiWOr0m5rk2m597QDFcKhkw6iGYMsxL-jbJcKd6zzeJ40K6OZv8
Message-ID: <CAD++jLnwtzxNjTJXW9C67pR2EBFuqdRHPzwqmCX5kQ6qeX+2gw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: ab8500: Allow AB8505 interrupts
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 11:00=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:

> You should have a different compatible for ab8505, with ab8500 as
> fallback, but maybe we just don't care about such old hardware?

Hm!

The parent MFD device has the two different compatibles:
Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml

I guess I should add it here too.

Yours,
Linus Walleij
