Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792976108;
	b=Uv7lMkAsWXOkCjpfNZkT/o6lkwlgCOoNWWB5BLdLm18np7lm0sd9+KrAA6iMICPoA+r5
	 ZngYyUgVRGinYn6VRdBNJsVgPvOX8mu2YasU6rLepbRpdjzzKRoE45UeaUIvovvzyopkw
	 1f8UTlUNrBiJ+IVlAH3xOC20XjlJLitIFd7X/mGMII47wumOMcVqg9halTNLpJHhR/Nt/
	 5FQhxbM8+ynTRdl6Sy4WxOWbiu7UxSvwYYtAviVhrqM08wfbKNUtDPzjV8cVpDlw71hJa
	 bXOjQlJxZaRH/aYZBfj2QCWRrb9ah+a4z1r+EHMsEVz3OzyRiYuk1NV7P7amObD51hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792976108;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CUudlpJeZOkI9riG4lLVNFj/VnlRt+epI9j0e4fCGl8=;
	b=JQ7xr8bHATqsged8wrQ6Yz8PKMwXf0+0mWJgaXqKiE3w8bT0cnA9oeDUwsBRPLEili1N
	 1UTLB17dOxwj7uz7YWAA/Re0odazWTX3uJUBtfbMhM3fYQGSo4sQdYUGbDVzeEKvT1aAC
	 PZJjoIqlljwRfsCqRlQiveqjELIa/f4GpprfzxGrOPiPOJL/XnbJUK9ZPw5XAKgN4zPnp
	 HcDoe3O9rjM7x6dDIiVlFC9BbKUP9VKLPhXMt5B7ekLTQXKDiK/6mN2FSFTwxifXxty0I
	 ZO1VeDb8P0B9rcQiEZAeK75L7P2I+XosfPgwKpXZmeAKW52uMHCMfa/48smV8lEUm6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EHWyY0H/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0192606A31A;
	Mon, 26 Oct 2026 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHWyY0H/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE90E1F01825;
	Mon, 26 Oct 2026 00:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792976107;
	bh=CUudlpJeZOkI9riG4lLVNFj/VnlRt+epI9j0e4fCGl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EHWyY0H/qVZ0K+cpAZqToWPdHuJVESH5Kpc2A11iH57XjaHEvRQuq3GLIxKSu3PFE
	 DAPIXKyepOkk7OfGbz3kzk1UuvVgpQ/vZLqAWLhILLZxzyvOtu8BUGQRg/EcExti6v
	 Se8v8C3JnSpON2mMQA2kNDlJnZ/yUIEdkMrDHamIX5DQgDvQnQnV5CNEbS42UQt3eq
	 n9xHumczTc6CoB+m31j5WnNLkzrqj9hf4p3MstqlVyLwW98XYzZCva+CDWGyomm4Yz
	 Bg1BpH8GUetInu2pnNWBu2f1yO3WRDTOXcvveeU8TjatxiB3KQyPQ9/3EQ1i8zBsaP
	 HfGetOxOgMlDA==
Date: Mon, 26 Oct 2026 00:55:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/17] iio: light: tsl2583: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261026005504.7482bf26@jic23-hlaptop>
In-Reply-To: <20261021165858.v2.16.Ic3775fd68cac415d959c0456c4d4c36e9e5b95e5@changeid>
References: <20261021235818.3059519-1-briannorris@chromium.org>
	<20261021165858.v2.16.Ic3775fd68cac415d959c0456c4d4c36e9e5b95e5@changeid>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 16:57:17 -0700
Brian Norris <briannorris@chromium.org> wrote:

> This driver propagates the return value of pm_runtime_put_autosuspend(),
> which is not particularly useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> For this reason, modify this driver to simply discard the
> pm_runtime_put_autosuspend() return value.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
Nice and applied.

Note I'm putting these on my testing branch which I'll rebase
after rc1 is out and then they should show up in linux-next.

Thanks,

Jonathan
