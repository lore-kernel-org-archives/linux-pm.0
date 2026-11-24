Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530391;
	b=AfUYjcCqNE6NpnTZf9rwhnFkDBv4RXkN8WsV76hQ0k0b87oyJifroXSIP6S474LOTovc
	 guOe/71x0aiFWTf+qlC/GYOjfRxDo403ZtlH/UZJ1TwDYWvysuDqaH4jj8hQRpzcB7A7p
	 EVmEFjqUBTs3+9vbJNOFBb2udvMcuDHeIy8ZaYQjGRn7jMQviRlPsVo0T0JbSM5BaSYZ6
	 DKQb+nYoM4fkYBDftlh5OB0S7RB3pDbP8zE/lhDhnQncWOcfJEFpBeNm3Yc+F/j2bsfKx
	 z0iNrAsDuswPsezM9ruDgNFWCRw4xovDIRrvYu6n/JhtKQyN28fv3x7ESZr68LhYDHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530391;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3db4StPoGHzLR3P8qIYajcunqsZlDDnwGfdWKFu0rXM=;
	b=NK9pRuveySvKqnHQmf6wrnF/Vu5Z6KxYdMTQQtNzupWzTMcZfYPmAkcs3hxgjbD0j2rY
	 7r2mvR2dBhO+fkPqZsRSWuCdwUKjfLUwlNrQX10FETUD29iIWH8XxES5sf3m9JEmDp/bh
	 v/UaUyu626/uFgqcKlHxwgdKjsNO/c9IPTVvbDIi3OXKfptSsdsmWDXIcsTed5CHfRFrm
	 eZoP70H5ley/+stPQWyj4EMu/C0GSBiG6j8SVo1jierSoKVEQoUfOvfWeg65qNj+1YctK
	 PDinu8IONUKIPquQVoIkb6MY8nLYMA2dIvw15oX+6xFIIVOzDTckJN2jlGqx0ZuJ5yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dd4xCAHn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B63606A339
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dd4xCAHn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230621F000D0
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795530390;
	bh=3db4StPoGHzLR3P8qIYajcunqsZlDDnwGfdWKFu0rXM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dd4xCAHn6W+ssv6VCVMk+tI1gQbax2JNZkUVEpYMJqNhdQZ+250kq6gJ0GDo9KbdI
	 /L5wFVfaew9CcT2OBKIlX1qLuwRyvHCgREaSXQyZHvsrGT75p/EKNOVPJTJXrrD+bj
	 Db5yTOFEM40zo5xtPkKHAQrWalhIBHbfSgdKVxDsSbwnw4pPZy0ampzczuArhILinO
	 tYjOxkaRzpN2lg7DAwlxvg16HJDUHaJ91hvF6umYT1gAz6rjpd3EYvh4DIW2MWm3vx
	 5VRZZHD9qC+ZcvQxYX2n706AGInn4o1v966ZVjHOSl6BugUlFdc8i8PtE2AI2wny/c
	 H3D50dYCt95Iw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ae854fd0f5so33414201fa.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 06:26:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHZsi5cT3zNBX/pUDiCgtx9Rw5jtLGsOjAOuFrfP44AXSLhuukqyQk0I63qqRkyzOjxrWbjPV7rrg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8mq88BoivogBrIyZnVZwRO4olyfVkeoq2QmgT5n60HNjUaKpnf
	RjVRdkkzWd+f6NfYWpgSajppieeP3HlSm3dPf0ER1SMfDPkg76GDef63DKIXgZCE4qP72+rFl3Q
	i/N0kA7lvMN9kJYDl9DcNa+7hJ6tP8q8=
X-Received: by 2002:a05:6512:3e1a:b0:5c1:4f34:922b with SMTP id
 2adb3069b0e04-5c1bc8726b5mr4143827e87.54.1795530388031; Tue, 24 Nov 2026
 06:26:28 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120194507.593601-1-sashal@kernel.org> <20261123212630.1203859-1-sashal@kernel.org>
 <CAJZ5v0gAwqHNkLGkoKx=mSxeC4UuHdpY=71O3UDxBK99WshULQ@mail.gmail.com> <20261124135909.3358923-1-sashal@kernel.org>
In-Reply-To: <20261124135909.3358923-1-sashal@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 24 Nov 2026 15:26:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iup0grrQ56mpAWPW35HP-a7mVhhqJC5WnOk-YRa7ha-A@mail.gmail.com>
X-Gm-Features: Aa3M54rpsJXDzvWdL1vU1NQNEl5zjEdyhaWjriTBkl_ER4Ug-kKwamW6cKuo9WI
Message-ID: <CAJZ5v0iup0grrQ56mpAWPW35HP-a7mVhhqJC5WnOk-YRa7ha-A@mail.gmail.com>
Subject: Re: linux-next: semantic conflict between the hid and pm trees
To: Sasha Levin <sashal@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Joshua Leivenzon <hacker1024@users.sourceforge.net>, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 2:59=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Tue, Nov 24, 2026 at 12:31:17PM +0100, Rafael J. Wysocki (Intel) wrote=
:
> >I think I'll create an immutable branch with platform profile changes,
> >so that the hid-asus can be rebased on it.
> >
> >Will that work?
>
> Yes. Once the hid tree is on top of that branch, the two
> CONFIG_ACPI_PLATFORM_PROFILE checks in hid-asus.c can become
> CONFIG_PLATFORM_PROFILE there, and linux-next won't need a fixup.

Done.

Jiri,

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
acpi-platform-profile

which is an immutable branch, can be pulled into the hid tree which
will allow the conflict to be resolved locally via a follow-up patch.

Thanks!
