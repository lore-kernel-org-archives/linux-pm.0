Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D53128B8
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148053; cv=none; b=OP45nC693tCafFCNyAWLkE7ZAXOWtM2AgE7qHGBq8tmJL+m1o47cTEHOw2/0uaeP4bAypxNG5SQahwaPd7mObflxfYdmWF7WQD5ClYEi8Oqy1jVYVP7Um7mVPywHpnqoBavckv7lVoFPkPklLtJ77wSzo2luna0pPLaCtyj5buc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148053; c=relaxed/simple;
	bh=c2+6ZuLDCY6ck719urD1l3DG0slVGM+vvWi5oUZnApk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOtETyCSwryKl91j7QV6+a5ipvrF9beePW7rRakjbucj4BMR2x1EaPpUsX3wbEXHG75xV42mmYB4rf6fxiTcQQJPPGz0xs+XWVPHqvt6L/0SZe0uj7eXaCHyleXsDbFfB8gawj9VIasB79OpcwgYI+JPDIIT7nuvtyjTKWAaIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Woz6bUXz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Woz6bUXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602E21F00A3A
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 17:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782148051;
	bh=c2+6ZuLDCY6ck719urD1l3DG0slVGM+vvWi5oUZnApk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Woz6bUXzEBKQEcCOEALFI8tfOJIvtuoj+wfvFWrIrMd87C/q9dGPte6mGldDcns/N
	 +H1Y70i1kUrZCbcBwc190/O23B6ij14ZLWtNlOmWctHzXXPsefFX1EGfUY8PNl0pc/
	 4ZBc73IMlIekm9rh6HFb422xoj/uYvqooj1bvosngNvy+6QhIvtqR8VmTxH5MB+f1M
	 j/BdIc7XWPFVJE70fx3c+aq18Ueid/5v1eGomzrwBcg3ngTGq3oK5uliUdZn77GkKf
	 UBIt/gVYKxUSoi5shRKivssM9MEuhgH1kv8EVwfnP4KlGTwlh2NQcdPKTJIktzufTl
	 AW7fKoVbtRZTA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa7a7ad4d3so3641583e87.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 10:07:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ88n7ZL807tg7PYOxOPiZaAtwHfO3mG1hd6IfLI9vn4p8aMoyypSPiwWKgBFGO+NUmn3zBcCjVkmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMk4Y5bdamRPVwEs9Xyh5X2hWVtSNej4061VazHBz4xf/w7XT
	B9nJWHxjwqfGGJQVnsQWHZyJSuKpNyail8hHyPD65Gi4/ioFRO+qCjXbMP5jnHfF8IW2GCAE72i
	8eoprSd/jI5eYDrOC80bqCQtVZWbq4ZU=
X-Received: by 2002:a05:6512:3583:b0:5ad:4ced:9ca2 with SMTP id
 2adb3069b0e04-5ad5771f134mr3185992e87.48.1782148049795; Mon, 22 Jun 2026
 10:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
 <e624cd2b-9b07-4e7e-bab3-0cf73e9f9db9-agordeev@linux.ibm.com>
 <749b0206-f2d5-44dc-b95b-5ade0bf3801a@arm.com> <09172d0f-e0d4-48c0-9504-698981de5495-agordeev@linux.ibm.com>
In-Reply-To: <09172d0f-e0d4-48c0-9504-698981de5495-agordeev@linux.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jun 2026 19:07:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ifKbS3MNg34PKpr3ECr70ZR88YrdsoKn-UxXkmhYGCPQ@mail.gmail.com>
X-Gm-Features: AVVi8Ced5fKGuIGrUrjqIhM5cMHqvHrPDObXaUb3BAMePzDRDAGHRYkwazaSCOA
Message-ID: <CAJZ5v0ifKbS3MNg34PKpr3ECr70ZR88YrdsoKn-UxXkmhYGCPQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] s390/idle: CPU idle driver
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Loehle <christian.loehle@arm.com>, Mete Durlu <meted@linux.ibm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 1:35=E2=80=AFPM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> On Fri, Jun 19, 2026 at 11:38:07AM +0100, Christian Loehle wrote:
> > > Applied, thanks!
> >
> > All of it? Rafael should probably at least ack drivers/cpuidle/* things=
...
>
> I assumed your R-b is enough, but I will hold this series until
> Rafael or Daniel have a look then.

So please feel free to add

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

to this series and route it as you see fit.

But yes, Christian is a cpuidle reviewer officially now as per
MAINTAINERS, so his R-by is sufficient in cases like this one at least
IMV.
