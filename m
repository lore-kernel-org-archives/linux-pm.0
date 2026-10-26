Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792985253;
	b=aKcsdx6jS/KK/RGB4uzamL+pFG7TFUvsisGD+HhVeU7K2fDFTbLMP2gtQFdZ4lZQ+Qsb
	 9hJFhTMPHPNjuddxEmgBu+yVcfze9Fty7NQ6hlTKM884/TgbaIRsuywGpc30wh9i9nDmE
	 kO2Bd/EnfW4kWH0+t/YGmJpbk6dt/p5xYCt8ZSLeD5UmeppBwU1NA7RB3awNmcEXCy4q9
	 CnNF5+pubte6RiEASzGIa51I2c/LMS4xEn2Xe3ViBB99e/u2X7uZhAzwg6bYh2pI+92Xs
	 b6g9YZa+z/q0ktJApeT806zpkeG04tvbR0tExmvrEvggLVaMgC75OEKWztGdNR+0wrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792985253;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=y+VtLfq/MdIYVkK2DxK4rvhjYdfZfO4NoblIfof12wE=;
	b=wh0npzRhMqgMzjL7EFvtYiGdTIbEqtqpLnYasNmflPVyVDQHIzlPjmAuu993XW5UMeRu
	 CVmANAyb7ZTpL37J8kWgY7s6qHjnHGrT9lnSuAEPN3sGjdAVUYU870JHvCmIMdf6gWv4I
	 /N2jYPxtOKj3LLRPpWz7d4eAp8F3r84HJdMPV/gVP/eMa8Ci84F/4plpizoCDePCL/5mu
	 BlyrnP7U/aP1jFmiDPRXR4WuhNcrCgFQVloagyNJrCCVGHpsOM7uFpwSySAuxvq9TRqOh
	 KThbpAOy082VOWllBCK1oLZtC6j93+ltFZDuWffhy0TegAFnzHCksUqD3RH2YAJP0og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dBG3BIj0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EF5606A323;
	Mon, 26 Oct 2026 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dBG3BIj0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CEB1F01825;
	Mon, 26 Oct 2026 03:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792985252;
	bh=y+VtLfq/MdIYVkK2DxK4rvhjYdfZfO4NoblIfof12wE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dBG3BIj0tVgTaX/Eb3I8cJzfU5J0t/VaD1HoIIeNAAW4vyEuhuL2vUgHAY9UtARrL
	 ZfcPK8sLhbLW1iUnr2PbeDjQXq1XFqlidBtoak6axocX3Bis1PtbVvX0yekKZ3vS1S
	 Y5xTqmZzkr4qABIdLEA4ZYqJbs+dDw4Hhb1S3KPG3G+Cu+WIpVqDBR7nL6+15t/pRI
	 Y8QrDFvqNqj0X6cxw0EXB6m4A90cqIKZSGLMXugIPyVNPsUXDshXtBfBhzmDhgHv8f
	 Bxn+I3hdu9cHYAD8An7MN8tIC6+KGMJClVgfLerrPY8eeIMEpwxAck1XrPK7BIZXNp
	 pmEq3NAr2CH2w==
Date: Mon, 26 Oct 2026 03:27:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/17] iio: adc: ti-ads1015: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261026032725.47b5843a@jic23-hlaptop>
In-Reply-To: <20261021165858.v2.7.Ib4e8fc11192ec5721b98bd85fa9a68d3349ba9e8@changeid>
References: <20261021235818.3059519-1-briannorris@chromium.org>
	<20261021165858.v2.7.Ib4e8fc11192ec5721b98bd85fa9a68d3349ba9e8@changeid>
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

On Wed, 21 Oct 2026 16:57:08 -0700
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
> pm_runtime_put_autosuspend() return value. Inline
> ads1015_set_power_state() while we're at it, since its behavior is now
> the same with and without CONFIG_PM, and it is otherwise trivial.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
Fairly simple one and clearly a net gain.
Applied.
