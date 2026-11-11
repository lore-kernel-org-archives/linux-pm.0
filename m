Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794388321;
	b=mTeFvB3m46EjnP62PXRfXzjGZY5g8fENVzb5KbBx7YaXspBGdQ3TqlUPQ0X+qufbwq7h
	 hNhStGp5uFgNIJs5WH7NBO5YYZAJW3P8oBB7VqEKNjuEc39vgOf0WX5FLSDSSCNMYL0YS
	 OrJ0lcB1Q1SHwLoipjfOdYDuTQRQEiGcXnFZ9VKUtaUS20VXREtGREs04rDtcduEmCtyF
	 yAkwhL/ps6OU0MZpcpglVGttt7bSPUMTv/HInwii0TQ76a4MGqpDrkq35Q/gxYufQK6Vn
	 Kq8Xv4pGHAb4MTPwK+5qArpivt0d2bFmh9o/c4TEpGP2n4jjpnV7C9RtIz/lCzYx/Fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388321;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xMsUgCsGYtAuzjV6fXKjB5LSgRF1fx8Yzkw480NcByU=;
	b=rCOxqVXBhqnxPZJSaQgjIxd9YLvflSVsi5zL9kNQLu79n60Xs/sq31halLejzDj0yjwx
	 aNaYtn6UbCjaVSQb4y5b/Rb+khRoI0j+j9XPHZRuQXtz9qUWFGjlsEtf8BET1vqoHiLjq
	 uoRXttqplp81goqwMHPXfKT6abb1PW0B2brHV4WgytVD8gFTG7leCbfP1SE2hEd27xikJ
	 tsBmSJCQSwE17xd7iAGR+cND80vgVHqJoNR7MHoWzaimAeczsM7hA1OkvbuQJR7IIID74
	 5+kdEJHH7iCNbKdHnsSsl/0VyIfWXsqxBMU5Ll/Vwudj8koPsAoPqDxQy88yKwKRSPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJ6mlt9Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49A6606A31C;
	Wed, 11 Nov 2026 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJ6mlt9Y
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794388321;
	b=iFfVSkaJR6km2bunnsvcj4jYwqm/fPWR1KdLi0pwL0w6+1vFvfVErfzWMFKd5ajaDLdE
	 YKFTK9BP9mpYrb0vXrSB/lWouSyPF9Gf0XSuboHWfzSPVDSFMF0GWetzykXu+SgDmYNmy
	 fde2Lf0nEK5zZUrMMNEfZ8ure4itvQCUqeQd+w7fvRUz9U0sMVez94BatZGFk49ShxrmD
	 BFVonLj2aQQzcDlMs4IJO7qNxC6vs9kV5HJ24Q4XaGZ2QTCRvrQHSqWA++FJAGkHz9Gwo
	 hCPZMfoRmR/YbMl6s8SsFPW/dLPIAuH//6Rc/aROkidSdjkuv5DEjvASAQ9zWVv0pAw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794388321;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xMsUgCsGYtAuzjV6fXKjB5LSgRF1fx8Yzkw480NcByU=;
	b=WLOH2uCGVB1192Ov09Md8reL0SLS7ODjVSj9gmyKDrtbfEk8uHeJ6PYYiidZ1CZmlnA0
	 dfmHuQJLWIuSvz57tNMthUOEvPHA5Gdh9+rPq/LZzc/2EvJkQMy/zgNuaIR7q9F7l4Hje
	 e7pz0CGlwqzgCOVK5akxhTv7swYQtRAwvs4f84Gx3VMd+l/931xhg0MT43UZDXDNQb4DJ
	 oo4zr6GSuDLfKWmJQuT+qbuipY200nLel6y5YHp/gCsHDealM3ObJlNd/qdYtIMfDlwgq
	 Qn5mw6o+MNrrOFxnqvcqrtC14szqaL7Iqjry3ZbiMYwHqyZIXI1NeKrflrMMpoxLcRQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 60E031F00A05;
	Wed, 11 Nov 2026 09:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794388321;
	bh=xMsUgCsGYtAuzjV6fXKjB5LSgRF1fx8Yzkw480NcByU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jJ6mlt9Y0hvWgVq3eymBZ6VNr8zYwwRBVTHJel4Zbbd5K6jpqi9NlNzcFAiBHgdS+
	 TK0hSyyZDYm6NK8sb78zk3Px/O0QSZTtOOmzebKgC1uSAdnUYoy3L4GGlVms2Kg/Tj
	 7o9Jb7+gldIxrzLOifi/ASAdHPttA816EYbMp2WuxDgu8npCESb93MOy1mgvFAy+47
	 9k9XJU6rE+cBiGwfVFqTwLDSgGHTAJdM19TsqNYikWXmi2tuSr1PX48Qk7aiQ9jVpl
	 rqooqOR+qL9AVO+phwSH1AhbAMv3PJCNlLamD0/uSXLNC8uqViSgGHFsljsi9nYCV9
	 GOeGpVVfzldtw==
Date: Wed, 11 Nov 2026 10:11:52 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, Johan
 Hovold <johan@kernel.org>, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, Dominik
 Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 0/3] PM: runtime: add new runtime metrics and summary
Message-ID: <20261111101152.00007785@kernel.org>
In-Reply-To: <CAG2KctpRRDMXR8wG40PeohsTyAdoNC=+4Nc9pHGQc1fmw9AXeQ@mail.gmail.com>
References: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
	<CAG2KctpRRDMXR8wG40PeohsTyAdoNC=+4Nc9pHGQc1fmw9AXeQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2026 19:38:39 -0800
Samuel Wu <wusamuel@google.com> wrote:

...

>=20
> What is the vision for using these runtime PM stats once surfaced to
> userspace? Runtime PM and suspend have disjoint portions, but I'm
> curious if you see any non-obvious areas where these stats would be
> insightful.

The main things this is useful for are detecting power "thrashing" and
tuning autosuspend delays. Currently, sysfs only shows the total time
a device spent in active and suspended mode; from an energy standpoint,
a continuous 50 second suspension is different from a device cycling
1000 times for 50ms each (these transitions can be pretty power-hungry).
This could help userspace utilities like PowerTOP to more effectively
determine what is causing an increased power consumption.

=46rom the kernel dev standpoint - this is genuinely useful when testing
runtime PM functions in new drivers (for example in the IIO subsystem we
deal with a lot of runtime PM stuff).

> And is there a reason the stats need to be surfaced in both sysfs and deb=
ugfs?

sysfs definitely, as you should definitely be able to access this info
per-device (and this is the way userspace tools would get this info).

The debugfs summary is however pretty elegant IMO and useful. I'm sure a lot
of people investigating odd device behaviour would like this (plus there
are overviews like this in the kernel already - clk_summary for example).

I'll add these points to the cover letter in v2.

Thanks.

--=20
Kind regards,
Joshua Crofts
