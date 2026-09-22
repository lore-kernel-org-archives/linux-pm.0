Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ADC49B5AC
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104420; cv=none; b=mhM7BN+mVVtc3zG2ZOVYoap9XZYeEvhRR1Xjw89OKyjrh7K+b7Rz1LMBhYabA8KJjyVkT4+DT9XlZUEyh//jcmiXTL4cbSoNWEe2KwOpB48JkN+Ol5ZSEyDXwQ902lWuX2w+jM/KhAA127OUnvaTivuNtiUtHbXLQOmibdTaM94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104420; c=relaxed/simple;
	bh=PM3YWhQj26OxqlfqxABsAhf7EA9P5fAzAXziwoQMM6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ub3ApuoeBPOz4vRyUNI43hVntBJRej0mCvxXaITcsfCBMzj5qqDHqGgV6Leo0Lh70DoGQ1iEeOkTS2jpMwXveTtZVPzeGIsng95Hxhsnb59XBQCn+T6YyNsvWCJdezrkqDb1rN8ZHkFS/yF3XdHTLZYI70WBVaC5b6hEYQqWx8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtU56KyI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtU56KyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509E61F0089B
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 19:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790104419;
	bh=PM3YWhQj26OxqlfqxABsAhf7EA9P5fAzAXziwoQMM6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YtU56KyIUs+z5oJoBxZVr6j3xV9VZ5m1c8xOG7x2c35Pn+q4LGUmvXP9emn44D4Rm
	 P2dAoN7anvD/e44J732zKnJmyT0kiBWbHBoEXC7vBMukwGOHWYeQYBNOB6EukgneZm
	 o6hYWiOYsarJu6O7pp5CC+9nQy/aykEpviGWre1VM553nGXe2IdbAN/BiTIRgT9z8O
	 /Ig9csMr/UjtYxA97lfZFreasI/Odhx0hU3ogStU+7pbc4XU/kFWANlDf3NZJSiARb
	 oa5mTVXvBJGaJtmcI5M8Zq5hPK+PTTADqcJSHsGNm1vcqnHuDoXS4hfIB42MGib783
	 rG+AynjKnlwWA==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f17452so102785e87.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 12:13:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBysuv2qk0fiY9sogG4Gq19L5K211FYwjLHFHLiq7+HQsjMXylQjd4326RHKAkv3Cvcj7dDE+nIChw==@vger.kernel.org
X-Gm-Message-State: AFuF++nej9bvJ2w0cErWhFg6dBEVIQKaGAR8YS8MYOjExXgnc7LI0bee
	mtTMmo6OHHUDv/a/SWCjlCFbLjgiM3bupL6MguF0BJtxo0TQpqLDU0NLnr/ITUJa8ASnBkZzJtj
	qD/aGxJt/f8pfdvm/5dJTzr5zipbRD2o=
X-Received: by 2002:a05:6512:618c:b0:5b6:183c:5c8c with SMTP id
 2adb3069b0e04-5b8d89a565fmr71281e87.42.1790104417597; Tue, 22 Sep 2026
 12:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920-fix-hibernation-v1-1-f9940c2d7d7f@geekplace.eu> <87zex963x1.fsf@collabora.com>
In-Reply-To: <87zex963x1.fsf@collabora.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 21:12:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g4OXgxELt98Ea8KVg+QDuG+7=9O44kHWQW_1koZWMXxg@mail.gmail.com>
X-Gm-Features: AcwNN1XAFesbYtGuG1wmKNFnZTylIzRVQgeFA-Zt8JbiqpgYhDwswKfHRBP2Pwc
Message-ID: <CAJZ5v0g4OXgxELt98Ea8KVg+QDuG+7=9O44kHWQW_1koZWMXxg@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Freeze kernel threads after image preallocation
To: Matthew Leach <matthew.leach@collabora.com>, flo@geekplace.eu
Cc: Pavel Machek <pavel@kernel.org>, "Mario Limonciello (AMD)" <superm1@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 11:17=E2=80=AFAM Matthew Leach
<matthew.leach@collabora.com> wrote:
>
> Hi Florian,
>
> Florian Schmaus via B4 Relay <devnull+flo.geekplace.eu@kernel.org> writes=
:
>
> > From: Florian Schmaus <flo@geekplace.eu>
>
> [...]
>
> > Fixes: 783c81098445 ("PM: hibernate: call preallocate_image() after fre=
eze prepare")
> > Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> >
>
> Thanks for the fix, and sorry for the breakage. I've tested this on top
> of 7.2 and the original issue my patch addressed remains fixed. I wasn't
> able to reproduce the deadlock under high memory-pressure locally, so I
> can't confirm that side of it.
>
> Tested-by: Matthew Leach <matthew.leach@collabora.com>
> Reviewed-by: Matthew Leach <matthew.leach@collabora.com>

Applied as 7.3-rc material, thanks!
