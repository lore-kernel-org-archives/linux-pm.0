Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE03C443C31
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548276; cv=none; b=oKV9c/yZJAsKm4YW1SEqHng/iigyX2KJodAazVpei04EM2GaOl08TY+FjlGE2AOh3y4nyVa2s92NqnHsgTFoSWFyJebZ2wHjrdleg0vkgkpH7oXERgE8UcjX+NB9sa2+bVY3bZk00hQUaLKVC41Ln+X8mvUGqyT1YFLRjRmcW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548276; c=relaxed/simple;
	bh=ZeBFVu7Fsst4uAOVgc6REmRpgUidwNjQW2vFog6mAN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtMOQFSErxG2VL3OjvBRmw5nIHNi0fMsayzH6ChCItd8YJVQVg4WSnwkTxAPQQpGhAiQjX6e/kCyEAqMHCjxZ1OdXwZ1sopGsF2fc7zWStVRCKZpfS+yahlygJ0PNMb4LCgfVjNqsrlcjWu5/FcwJ5vu+PHLqDGFN5jGVqLqFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0UfczYg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0UfczYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768631F00899
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 12:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791548272;
	bh=ZeBFVu7Fsst4uAOVgc6REmRpgUidwNjQW2vFog6mAN4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m0UfczYguNWEZKhK+J0FgXFZ8pA7496N2v45m1k+j6SlSFIYLSpGgTk19D0klfiHr
	 q7iK2U3LmuGgCS8Hw0F9bDjJG1BRXf8EfnyV6gwMMmRt062TzHyi7dtlvKFGuf6a3O
	 6wYP9ev/td38hqfz+ruqr8VYmMUs+XtwpXbOrLse+yvEF5Vrti+s7leAJb+r50XI6e
	 njr1o2Do4yv3a6MQH1xjxhpCWPorTQm7jrzqD6czYgUzdiR+hKq8oTYGHO0b2DsHja
	 nOaOR4MPwUkBE4tB5XWhdWhqUcO/7PhIKmV7AzN7X6cI001QrV92L8S/0WmjuSvb77
	 kG4p/X8/M91oA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bcb4f23ddeso250393e87.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 05:17:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByRN3MTTgFXxp5pwhCUj0I6XsvOTXMahqMpwfWPuLU8+lMQtMi7aFlyhzqcyxL8Jnw0zhJHw5gtgg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKnkWf2SQXaDB+mjr1glEx+9CKtZVu4jfm8NPxynZUmilzxjqMz
	ykron+7LrEyR0ppx69oEq0jLyb5MHEDrLTHNCLrL2KRobtSGl6BrPqLXZGEzvc4npELDteZzjU5
	kMwprf1oI7lA20sYbPM5s2fk1itLFSJ0=
X-Received: by 2002:a05:6512:39c3:b0:5bc:44d5:89ce with SMTP id
 2adb3069b0e04-5bcde8dfb58mr708846e87.62.1791548271232; Fri, 09 Oct 2026
 05:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <CAD++jL=gFt9kKZH9T-m8B_pbwRvzc35tTrMn5V238d3528DpUg@mail.gmail.com> <CAPx+jO-wb6NLYjnn_k7xu=Wqq61+vop9o7UM=5Y47U-WiGFXBg@mail.gmail.com>
In-Reply-To: <CAPx+jO-wb6NLYjnn_k7xu=Wqq61+vop9o7UM=5Y47U-WiGFXBg@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 9 Oct 2026 14:17:38 +0200
X-Gmail-Original-Message-ID: <CAD++jLkQET3CRONQbpqdt+Y9ts3wPHdNdYz8PvbaohSjm0JF6w@mail.gmail.com>
X-Gm-Features: AclHuK_UVxhW4eapDTA7jDAxjwJcfqkweBn8QG3EWf3yBuy98smFVfeDPpDUrY0
Message-ID: <CAD++jLkQET3CRONQbpqdt+Y9ts3wPHdNdYz8PvbaohSjm0JF6w@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] pmdomain: st: ux500: Implement ux500 power domains
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Frank Li <Frank.Li@nxp.com>, 
	Frank Li <Frank.li@oss.nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Frank Li <Frank.Li@kernel.org>, 
	Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 12:04=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:

> > What do you think about applying these three patches to the
> > PM domain tree as a starter for v7.4 if it's not too late?
>
> Assuming we get an rc7 on Monday, it's still okay for me.
>
> Although, please re-submit these three separately in a v4 to address
> the comment on patch1 from Krzysztof, then I can apply them.

Ooopps what was I thinking... probably I thought I had already sent it.
https://lore.kernel.org/linux-pm/20261009-ux500-power-domains-v7-3-rc1-redu=
x-v1-1-5eb1b90bc35e@kernel.org/

Yours,
Linus Walleij
