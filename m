Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792977229;
	b=ueykCiTjrVsHXuEvmJLn3z196twnJgRHgyVsF4YwYYgPuYQEy2NkgGAGkFTtJtK0lE4l
	 nxic8qfN/nGbVc8Q/Ag7vE6QRw0Yw4KF2KekPSEge12d6oAwHR6B0bxrKRqIxTRxouFh7
	 KX0bLEQ8JYBJcNQZ8WjF8a7/0Ube6oskIGMZh23ysSdSPGL6bz9j1TzfbAUL2lN3YgrgA
	 L/hoGQblIAEIPRT+jtYNZALVbVhM3EDvZcQVr3Y918TcP/EARwkBcvNu2TxxFvwKXbHS4
	 gPf553h/M0JF/Q6NlPTwpjibmQDXmHeVf/tboQWRQn/X59pWqgnV1QlwfZrW3arGr5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792977229;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WVvNKLceFMws7Rkx2c9OqMhvST1ZscHVOQd+zxV06sg=;
	b=Lq7BgJZqk846es/vTwDJDENKkaKBRgQgXUejaPCo7Ky6LYwjkFypoteOp2FvqOBg7HB5
	 IgooKzEHtwVCtt4j8gWv47zT6cSXdVwyvETwBj+TZQTDNnGVDl3yejXENqhqKVwLCspXU
	 nXEslEB6AsVgqwU8DlhNem92UzAYIaKSFTcJG9BxZqyagOu2EhdLd0DIqTv6Wbxpv9eye
	 W+Mbr1fMjkfgMuSaN6wOKXghtdcJr02DFaVJ1XlI8Cre7a3G3f5dNTT0PLVNbvObRXod1
	 M83KDIAT3LF4Ui1V9ciQqqDyxU5fbM2QaNQZz2OvWVBjQrktrT9Ej3F88x2YmQQdutA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DN0LU9ue;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7079606A31A;
	Mon, 26 Oct 2026 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DN0LU9ue
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F247F1F01825;
	Mon, 26 Oct 2026 01:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792977228;
	bh=WVvNKLceFMws7Rkx2c9OqMhvST1ZscHVOQd+zxV06sg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DN0LU9ueW46ghLNxA1WGEN7h4QWnL9ZK36HtUd4zIPyoj1UxHcLGJVeux15BJ+Glf
	 ureZF9JS2feNem6FB/IR/iiSSRxMPlZixW5JCJwTRdZknMnjCo8HgPeGFCH7ZmkieR
	 GDrigtBdv4YFOXXJME0+6HFRiwvH0NSpqR/vVPx2+wfckfsuTg4XmFVBHuAlNp+zlO
	 Z/DibI/xG18H04uI9TdhkNaodYTzRNIRDZ9fZTASOgYcQD9Ldn62Dmca5QoGXzHomC
	 WFb+pFMx1joQYopyGWu44gXINE88rCzfKgFmf2jLsLkoMzLg3sm/184y3AHu9dnmpi
	 w/UPx5nf4bLjg==
Date: Mon, 26 Oct 2026 01:13:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/17] iio: imu: kmx61: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261026011341.227e575a@jic23-hlaptop>
In-Reply-To: <20261021165858.v2.12.Ibb6be74faca4446a1147537fa1a82bb6b9d5c580@changeid>
References: <20261021235818.3059519-1-briannorris@chromium.org>
	<20261021165858.v2.12.Ibb6be74faca4446a1147537fa1a82bb6b9d5c580@changeid>
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

On Wed, 21 Oct 2026 16:57:13 -0700
Brian Norris <briannorris@chromium.org> wrote:

> The kmx61 driver propagates the return value of
> pm_runtime_put_autosuspend(), which is not particularly useful.
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
> Note: kmx61_set_power_state() is a possible inlining candidate, but it
> performs some non-trivial logic on the {acc,mag}_ps fields, so I leave
> it alone.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
Agreed with your analysis that inlining this one hits some non
obvious complexity.  So applied - maybe as step one of of
cleaning this up more generally.

Thanks,

Jonathan
