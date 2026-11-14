Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794619979;
	b=KYhfeESwdUSk6ku60INb7xcThHiFsoIBgNPNBPm/2979FlxsRGAWAWQ3ju9gvIvQI4fx
	 bRHx3GKPcCazH8whsQY1msTTfpx3bDGt7UHZRflLhVeiay0toH59tf6YcUmIOgjyBsOSy
	 5H4nQ6u49XeVQeqeW89EIs1zRm6R/v3zTHKq+ShGIzh6MC3XDhE2wW3xkeHVBpbO0AiOM
	 6V6hiZp/ZfTz72/Bi2xH6n/bTykyeJlTlEIL1r3AafIMO8KGdnovnqMqs2kjPdKwxz0Gi
	 j6rgHv3yNCM0GE3g+pkOm64khcJJNbgQHOcNvW4NS12lIGfG/SlsHgcbBck91+fOnLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794619979;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=C0oAlm2vEYleIlt6mCJn4j5fnbEYzFEgLIf7M7v0Fow=;
	b=kZytbTBwBKbLUamv2WESz4alF0MBtZcdmmkedUoEN+vzHywrumKYTbimLrfJKjEXr3zR
	 8leCGy2Mnmxskt4k4HbTiQYJ73TcCiTQaKJTthHJtzxMaaGi/cUI94I2UYg90IK1tqWT5
	 T52JfrSyBK5iwDlfPA9fp3MLz3QHq2bOrJX6VhQy/ORb6XV3gxCSuNCd5CTLLq3pS5AjE
	 MCi0tpkeSMdEhpp3CFPa3vfIWf3GFlaCIcMzpqETWroJV42haVdaPQUKynuqiYQM5B4+v
	 T3UuCBCLkR4aIf+PGuMrloZvMKzepuWUHMXRyb+dDnXQNXFDADHLsEtVZ+Lko1m4h5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sOEzV1DN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47706606A323;
	Sat, 14 Nov 2026 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sOEzV1DN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646C91F000C4;
	Sat, 14 Nov 2026 01:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794619978;
	bh=C0oAlm2vEYleIlt6mCJn4j5fnbEYzFEgLIf7M7v0Fow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sOEzV1DNGsl/FwRVquOSpT6jHSbpS2J5CTxyR48F9L1D5qiPdPE3uX/gk9oRFmt3V
	 0snbZmjOcMUggp3XX+OxalKSdRIZVgtQlkkTry2Soo+LIYxBfHe8ipPOqCwGD0hnry
	 8Oany7IJav4xzKA4UdMiDYIxGeQ4w0wT/hrSyfuQ=
Date: Fri, 13 Nov 2026 20:32:57 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arun Iyengar <aiyengar1990@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Saravana Kannan <saravanak@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] driver core: fw_devlink: Don't report refused
 sync_state-only links as errors
Message-ID: <2026111347-poach-boondocks-a547@gregkh>
References: <20261110-fw-devlink-sync-state-v1-1-6385be961c2b@gmail.com>
 <179460189995.183918.12921536578133287930@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179460189995.183918.12921536578133287930@gmail.com>

On Fri, Nov 13, 2026 at 08:31:39PM -0000, Arun Iyengar wrote:
> +Cc Saravana, Sebastian, Ulf, linux-pm.
> 
> This message was explained before, and I should have cited it:
> https://lore.kernel.org/all/aixze8zFboY3huSf@venus/

There is no context here at all :(
