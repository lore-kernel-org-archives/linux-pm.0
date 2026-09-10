Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E4334C1D
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064192; cv=none; b=unNZjfTQBHdem6ch8BW0YHuRSEtbKfmdLYUyCR0wqIerisUgXwtb6aRMFDlKdCMBNtkYzXMVEXH+R7QPs6E0mkzBvFPE1FdeUi5LlJrtxZVfj0UPQJGMr9MT+F9u2V4SMI48eIMvIC6tv6oWzO7NbE916RuhsdHPBoSXLx/AdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064192; c=relaxed/simple;
	bh=IyfKLKmxaYXrhSNyWb73jH2AF7LtopQk+34GTZWRsp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhv7f6x7VeB7w+TzDEwy+3jJUd4PFOoMO89FoqhV9yU+JMytUGHFbRF1e2IZZv1m47dB0zvZdbB8vHWrc4mkgtgRLtGb7BhjM/SyYArIfkzueMVwbXAs6xuR0lvS4m86sBleP7s6uWjk4DDiesahKsYFDR9vkSQ7kBrRcL5sAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNYOnSr9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNYOnSr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FA91F00898
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 18:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789064191;
	bh=iYP2qe14sslKEUZSzgh7KWv0u7bOcOWMPJR8nM1rWxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DNYOnSr9CaWUYOxcQMwLPzSHOVPHoJqo2bZVB0f9GBNvXjvhgOOgmVE4f5+jetkRb
	 fArj/KJ1SUfeTnLu5a5sM7nYEQ/MOVqPV2KIcpKaL9mevBRR5IFRp6rynfR2MMkwPV
	 F+LocT3HhaRB/8wisUBK3wfcicw3PsMRtzxzf+QRHy9if3sv3Di5KPyKjK27qTsf7c
	 e22C2HiC4YhkOBEYbokCU/Te6WeevY5knlc8wZocJKZZlokoLAn7iSo42G6zWTeFIg
	 06gVbFR1QhM2W98xeuOu1fr1nmoJvwkHSsKjW3Y3ZTI7F43ZlsHCdz3nK7tqfyNdV2
	 afvaREzoo8Xzw==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff176d7eso343571fa.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 11:16:31 -0700 (PDT)
X-Gm-Message-State: AFuF++m/i3qX8ZNWi5ZpjojpBgfD7I29Qd41wfUjMcFmQeUNtT8LgUOs
	x/9PlyKd0FnPjSlEitFZMOdf0xrt8G9uNTF1AcHlCdm3OIqTT5SXxcAiMgmvKyUEKpMbQ2j03SK
	u+GWdrTWkCQuEE//Ct1LpOuZqwcc6K5Q=
X-Received: by 2002:a2e:a988:0:b0:3a1:ab57:ea2c with SMTP id
 38308e7fff4ca-3a49760daf1mr32775011fa.2.1789064189690; Thu, 10 Sep 2026
 11:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831194235.1182138-1-robh@kernel.org> <14ef8279-22e4-4910-b7d8-18e2ba274d82@arm.com>
In-Reply-To: <14ef8279-22e4-4910-b7d8-18e2ba274d82@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 10 Sep 2026 20:15:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h4wcS=LRPax9wKiVEKWvR75dc=nWWmfYej0zczfNPmYg@mail.gmail.com>
X-Gm-Features: AcwNN1WhJiZf95ZqUQGBx1f0gKp4Zw9GOi_HhoukTKLBduo2wBrYpCOtDwaLDaM
Message-ID: <CAJZ5v0h4wcS=LRPax9wKiVEKWvR75dc=nWWmfYej0zczfNPmYg@mail.gmail.com>
Subject: Re: [RESEND PATCH] thermal: of: Match trip property helper types
To: Lukasz Luba <lukasz.luba@arm.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, 
	linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 9:45=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
> Hi Rob,
>
> On 8/31/26 20:42, Rob Herring (Arm) wrote:
> > The thermal-zone binding defines "temperature" as a signed int32
> > value and "hysteresis" as an unsigned int32 value. Using helpers with
> > matching types avoids dt_property_check mismatches and preserves the
> > signed interpretation needed for trips below zero.
> >
> > Read "temperature" with the signed helper and keep "hysteresis" on the
> > unsigned helper using separate typed temporaries before storing them in
> > the trip structure.
> >
> > Assisted-by: Codex:gpt-5-5
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >   drivers/thermal/thermal_of.c | 11 ++++++-----
> >   1 file changed, 6 insertions(+), 5 deletions(-)
> >
>
>
> I can see you've missed my previous tag, here it is:
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 7.4 material, thanks!
