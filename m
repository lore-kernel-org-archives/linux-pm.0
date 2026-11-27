Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818773;
	b=U41XVOIKZKH+E0HtVnN4jBexymHm+yvtwLHoZRRRIurMWNwt95VTJ4DIB+T2QeKYb2He
	 jr9DlOm1tbBE3njrNY4sDYYjUMCnk42sH9D6buQNi1nhFk/3G7BKyLusYVXxJNtUykzju
	 9Kw5LMuxLfnunTioJogo/WD6XIUHxmAcFepYTuhFq4MqsrMvDpMtieSAS9Ob5HsNqAfK8
	 A28UzfdIjRep8OIZwDD9s3IGg1TCTyd9zJN0BD14q9jI8+1hN5g8m6UCzPe+z9m4n5uma
	 T5YOe54QCz1usX32sLKlYTBGTYSVAa2k46gADLBaYy6A4EFl5qPVPRhoCWRLA1Qptbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818773;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ou2g7nn/DCLn1ZLnX4pv5BlxBC/pBsmXn5R2lvY25uI=;
	b=YXPEcDqcaWH42dyE38pm0HNBTQqTECdmxA9lTJHGoLqCrVeFUG0B8LvWXKoB/79hyebX
	 MugGT40xCfTUzyp6Ig46RlM8ffFC98jI9k+qb1gNSfw8dPscqmp+4cVZ9Hk75AJf9GzRe
	 AsxO2MylD3nlkp5o544mispauhyDphIM31wedgJLnZF7p2rrVDFgxbjGZnbkcMowi1N9s
	 zTG2SuRdzS4N5nDYU0lqL2xzFnQqrQHHMX0ARWbMsP4IYDqfEcc6ygzsgCGKpYlvG+QUB
	 3G9y3nwPWtDIam9/0LJkQwADknF9MAfr17yJGX92SKqwq9Ks4vnd3Hz64F3Irtxwh2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zh296D85;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57751606A324
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zh296D85
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48361F0089A
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 22:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795818772;
	bh=Ou2g7nn/DCLn1ZLnX4pv5BlxBC/pBsmXn5R2lvY25uI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Zh296D85sBb9Z0ys7EATPHcQqD+46DEjymhTHMyvsg8cctICfsEedgwaLf50mVMnl
	 30rIvTiOoakDvoxVmLa3TT8fKTZEGNc9EjohEzlZ38uVmNeepeD/UTJgUzJeeEXXAA
	 R+p2zBjXCYnnyBr/j/bgwfGR0IGZ3glhS7QgZC9aeezWVBR15G6QU8r5hgHDbAMS2K
	 a8bIZMOY4eAT3Bor1FyMH6v5JNugOxlMsDM7IGbtq76iredUp6F3ri6D2JXVQQvDCi
	 ZFLkziyr764umlHLs/WyWkVaSbF8QOjxkHJHCO20tNF6tHdq2Y0hERFYerAJzaFZJS
	 IW4/L7N06c7KQ==
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-14394530ec6so2728697c88.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:32:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGooqInjmbj1Yz2fuzAc2f5HEvWkm3DeQczPNoi832WLINn2vVZ3dxBYgVPZKGHKy1ZjA5WKRXB3g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9PE1w8V9ojGkCA5T5EZ8dkPpZURc8XDU2HspHZDjYW3QCs6LwJ
	LliVD9/TVuEKqu0+Pj4AXC3Xeg/X06DVjrtBNjwVgYhUZduSNJ97AHRQl20ubG2b7EsgyihMXEs
	3Vvm983gV9cqLPzQxz1/Gzt/c4mrQt2I=
X-Received: by 2002:a05:701b:4585:10b0:1b5:8f22:9803 with SMTP id
 a92af1059eb24-1b58f229b6bmr6669172c88.1.1795818772183; Fri, 27 Nov 2026
 14:32:52 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126223225.2257410-1-beanhuo@iokpp.de>
In-Reply-To: <20261126223225.2257410-1-beanhuo@iokpp.de>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sat, 28 Nov 2026 07:32:14 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3UP82EoWBJVrgn9vPRWb9OSUNby=67_pBO6kD1sGa9QA@mail.gmail.com>
X-Gm-Features: Aa3M54rDu129OStZbPS8ngAuo_8hyHfvyDi8i8AX6XevstHcoyHvOyPiPxIkwek
Message-ID: <CAGTfZH3UP82EoWBJVrgn9vPRWb9OSUNby=67_pBO6kD1sGa9QA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] PM / devfreq: check the get_cur_freq() return value
To: Bean Huo <beanhuo@iokpp.de>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Bean Huo <beanhuo@micron.com>, 
	Jie Zhan <zhanjie9@hisilicon.com>, Avri Altman <avri.altman@sandisk.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 27, 2026 at 7:32=E2=80=AFAM Bean Huo <beanhuo@iokpp.de> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> devfreq_set_target() does not check the return value of the optional
> ->get_cur_freq() callback, so a failing callback can leave an
> uninitialized frequency in freqs.old for the transition notifiers.
> Patch 1 fixes that by falling back to previous_freq, like the other two
> callers already do. Patch 2 writes down what a driver is expected to
> return from the callback.
>
> v2 had four patches. Martin applied patches 3 and 4 (the ufshcd part)
> to the SCSI tree, so this v3 only has the two devfreq patches.
>
> Changes since v2:
> - Patch 1: do not call ->get_cur_freq() inside the if condition. Read
>   the frequency into a local variable and only use it when the callback
>   returns 0, as Chanwoo suggested. Behavior is the same as in v2. I kept
>   the Reviewed-by tags from Avri and Jie, since only the form of the
>   code changed; please tell me if that is not OK.
> - Patch 1 and 2: add Reviewed-by from Jie Zhan.
> - Patch 2: add Acked-by from Chanwoo Choi. No change in the patch.
>
> v2: https://lore.kernel.org/all/20260907192140.2701755-1-beanhuo@iokpp.de=
/
>
> Bean Huo (2):
>   PM / devfreq: Fall back to previous_freq when get_cur_freq() fails
>   PM / devfreq: Add more details to the get_cur_freq() comment
>
>  drivers/devfreq/devfreq.c | 12 +++++++-----
>  include/linux/devfreq.h   |  7 +++++--
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
>
> base-commit: 4ff20abe28d65a0c52f0b280008fcfb93c3ee2b2
> --
> 2.34.1
>
>

Applied them. Thanks.

--=20
Best Regards,
Chanwoo Choi
Samsung Electronics
