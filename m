Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB849B207
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765192; cv=none; b=o5rhivKDvJAOenC07g48Vsruhh1I/bGrgk/cZlaX8GvvffaBYwWtFi0DL7lHPWK6PW8sFZ/k5zkbXna9l42qepYR9iA0DHqI7wwUBiTn88A23B42dMaTrGZZjNOAAgTRhLUQayYFyM3iDmVKko8/zbqt8i7JZ6UOb9kpeIedaC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765192; c=relaxed/simple;
	bh=z3BNd3t5QI0iZuIsQagNY7Y2xxs7h9n+zoA/0fsn5lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPd/6nDqncaF7HFoCs+7MsGpfixuxd9PyW8r2aKwL2ehrsg1Q20lO1gj8V/6rjWwJfXBMXpzxV+8dxfFr0reBXAIHYLKAdwHDmsaphnS/f1qK60VEYSyiEsbtg6TQD+7TX+csHin5KsCd/q4US699I8OO8JJyVtA/PvLSMwQBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBgP2REI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBgP2REI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CD61F00899
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 10:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790765179;
	bh=z3BNd3t5QI0iZuIsQagNY7Y2xxs7h9n+zoA/0fsn5lI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IBgP2REIcEx+w+IJM3M7B78p8wLDKNpqHBl3GWaVQWbmSSQgxcx8xWJscOl1vl3Qb
	 KFPzKiBSFaQ9I3s/Yy/jDXHsFVk77iaj7MpA0KK1CiNm5nFZggYhs4KsfWPvw3sp2I
	 uRPFhvrkSziUf3ydJujWOlTDggp/D769/ZQ0EWefwgEUk1oDn41HcsgJI53rhhQT0N
	 W5xk4jYpBjtTtIr3LvhXyi3NVxwXWvCMkjt+gaXcfLW+7ggkwZEaAoNmNxaatb126n
	 nc9OLCdYSYHRYSQ2ufeXychtAuNisu5sWRgWZopwixyjEzkszw+vy+ig6HzOot8lmH
	 JpR8Ujoo92GHA==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba37427a3aso1251554e87.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 03:46:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByX4a17tUoee7L0rZ/iA5+q2B4eMsdb3MhIsyxHrPG8jnuPh2CgMLpvHnYiHFeWhEw+g+UvQZ9Jgg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ02fk9vcEf6PCr4SZJfRBdN7ForFzTrUwsKVL7iOXqgc7STVV4
	+TG5DYgb2PmITJtl7agEzYq4pL2zRovXwMesV0K6Nwuys7UYFMih/unJOPsy5il4tB4vGU/TPI4
	LICoF/WZRHVs1vZRCz5bVuP+l9CaX7+k=
X-Received: by 2002:ac2:5962:0:b0:5b6:1a7c:fd8a with SMTP id
 2adb3069b0e04-5ba40609bbfmr334357e87.48.1790765178551; Wed, 30 Sep 2026
 03:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-hibernate-tlb-flush-v1-1-a0143c144c19@amlogic.com>
In-Reply-To: <20260930-hibernate-tlb-flush-v1-1-a0143c144c19@amlogic.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 12:46:05 +0200
X-Gmail-Original-Message-ID: <CAD++jLkB9KE_XEcHDHj576oUzXUyAN3KX2DxjENDwzSNpu1ohQ@mail.gmail.com>
X-Gm-Features: AclHuK-mQu3SqsQZujhGStlMhedJD3jinzee-CBwOj6U-mdqpZr3J1pXDQy3c2o
Message-ID: <CAD++jLkB9KE_XEcHDHj576oUzXUyAN3KX2DxjENDwzSNpu1ohQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: hibernate: flush TLB after switching to idmap
To: Chongchong Ding <chongchong.ding@amlogic.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 8:14=E2=80=AFAM Chongchong Ding
<chongchong.ding@amlogic.com> wrote:

> On 32-bit ARM, hibernate switches to the identity mapping to copy pages.
> The idmap keeps an early RW snapshot of kernel mappings, so
> STRICT_KERNEL_RWX text/rodata can be written during restore.
>
> cpu_switch_mm() does not drop the global TLB entries from swapper.
> copy_page() can therefore still hit the old RO translations and fail to
> restore kernel RO sections.
>
> Flush the local BTB and TLB after installing the idmap, matching
> setup_mm_for_reboot() and the cpu_suspend() resume path.
>
> Signed-off-by: Chongchong Ding <chongchong.ding@amlogic.com>

Ooops yes this does look like a real bug, albeit rarely exercised.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Please put this into Russell's patch tracker:
https://www.arm.linux.org.uk/developer/patches/

Yours,
Linus Walleij
