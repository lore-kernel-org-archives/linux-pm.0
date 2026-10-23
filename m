Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792726606;
	b=3+62hQud9opzNLlifkVxTnbonCqnQ19oI2cKEXh0HoLpJAloFl3v3vGo0U5D7aKElxYi
	 WDwEtZrReMgIQG8eKvNDqYYT87P8T+YyAPsFSLs0Z77Uonn4ILPbCdzSMU8pb0I4pgHWt
	 VAJ6uPxMca1ol3kTM4BoOZ7LLoINdLROK8mrEsn++dJy2mnyR402jCHtcEKTw9Y2Pj6EZ
	 VslxPjKtohlTlsqYjap1yAmeHvCMPL1UzYEND5hTu+YkKrywjPYPRbv0wXipaWCawzI5W
	 It1EDxpbDFrOm6tS4wB4XMsqyXueAaZOvPLwrA/hxfVQvWzjXH7nqhLX0/miPERfXpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792726606;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tGJnBB3za7V+turiDpKBeRFe+muQYW2Nd69w9rxpr6Q=;
	b=4p7ahN5Rc/8ig5/FtO7tzxQhWdMDS4TP9QggSbkp5FVQfHS7taW+Bc6NLawxz+5/18kw
	 FhOPa4Vf97HBYh3/m592e1T5ytug7c9p/jtO9KAefeF8SvxtfF/M7v++eX0ZPbmKkCtzw
	 DMAohpb1JJ7mN8GMFrQkOSjLNOWfsfoygGLIUZdTC3ZRJ28pe/gEwg14TWJ5Pn5rGIeAk
	 I9Gokskga4XPOQ3+dNOm9RzA3YzQRNWvcrfyLTEmRwMpXdyYbVacNwnLzF5Sp958Ia480
	 +xv9pfhJpweW7v58YUj7WhDaWBykKeB+XmkaFxEGMvyWcKiJivj7v9XU9/BqAN8n6Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iiIBkYXt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CB4606A322;
	Fri, 23 Oct 2026 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iiIBkYXt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964EE1F01828;
	Fri, 23 Oct 2026 03:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792726605;
	bh=tGJnBB3za7V+turiDpKBeRFe+muQYW2Nd69w9rxpr6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iiIBkYXt4NDWiY2HWSZUMB3YltBrsVxnWbsEVUgDVJjrRwpFqz/ZwIVPERzEWyA6u
	 hAYafzaQtWbk5wtdSVBPAFy8ZiaYro/fGhHwPxD48MjePI+rsBLr8bCnZr1FUZ8kw7
	 7KNB7TERStx+aIrUrrnHYqn02dUK4rxK44hgvY2PnNFArC7Pz1EWZqroTxdU1dJnFQ
	 8yLbEN8B2WO9P25aFRZRam/kv8q1lO9AEe0iH0JqnHvZhkwIn3hiuL8XfKtmhAZ4HP
	 u03OkZGcevnO2bqjjUI+tPgYtyq95h7f83eyWUwGZgAC9c6AO/AsK62z+yNisOxVF/
	 oU/eVog7hN6DA==
Date: Fri, 23 Oct 2026 04:36:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/17] iio: accel: kxcjk-1013: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261023043637.102d9a70@jic23-hlaptop>
In-Reply-To: <20261021165858.v2.2.I7751f8c9dde6f4a576a17dcfa13a4c729fa748b4@changeid>
References: <20261021235818.3059519-1-briannorris@chromium.org>
	<20261021165858.v2.2.I7751f8c9dde6f4a576a17dcfa13a4c729fa748b4@changeid>
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

On Wed, 21 Oct 2026 16:57:03 -0700
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
> For this reason, modify this driver to discard the
> pm_runtime_put_autosuspend() return value, and inline these pm_runtime
> calls for simplicity.
> 
> While doing this, it becomes obvious that kxcjk1013_write_event_config()
> and kxcjk1013_data_rdy_trigger_set_state() are intentionally mismanaging
> runtime PM reference counts and instead are relying on (racy)
> autosuspend delay for correct ordering. Undo this choice, and instead
> properly drop the reference count only after we're done touching the
> hardware
.
Sorry, I should have looked more closely at this in the earlier
review.

I'm not sure this is actually true.  A device being in runtime suspend
on an i2c bus doesn't in general mean you can't talk to it.
Whether the mode switching in here is a problem or not isn't
that obvious and will require a datasheet dive.  It is inelegant
but maybe not a bug.

Anyhow, out of time and energy for today. I'll take a closer look
at the rest of the series in a day or two.

Thanks for looking at this.

Jonathan

> 
> Use guard() for managing the mutex in kxcjk1013_write_event_config(),
> because it helps simplify the above refactoring, making it less
> error-prone.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
