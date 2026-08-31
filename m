Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44363909A3;
	Mon, 31 Aug 2026 02:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788143719; cv=none; b=BWgF+koAaiR8OIXJaaTIUCQEl7RBNyynqBks9xSN/AZ/kSmp5Nqw7qSmxqNnjl5Ri0kmTw8UqxtyRpuoVLkGQHWiwsdJIYj1+OljNhbMSvXI5kC8ybjm/aCfEkIpxbsK1S7CvzzduEj+drlICR4sSBx5SP3s8O+6NjMRDrM3Ysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788143719; c=relaxed/simple;
	bh=Du+WbW8CEZ8HIp670v4OT4MQE1Vt2sloNq38MTjN30s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV1NtDMqRHYtmoV4z/Z4nmIRmVcyPPQZj7bCqyrVjqhcIBQZB8ofxT9LSh7gU6lawxL6cXNhhSg5UOWx3x9Vt6JrEn0befCVLDfScKs5aZnmS/GbHYtU4DuKyWFWWMvtLretG44T/xmReOezGKazH6ipo5QdzGvr3Sovce8KytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFLrDcaR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFLrDcaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFDE1F000E9;
	Mon, 31 Aug 2026 02:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788143715;
	bh=DTLOuVJdqUxRUFg/cC+Yx7h1/JI94tOyJxrClyNyqY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YFLrDcaRJurPYIY5Gnrlm4dAFzZUpq10JInXB0yK3uIbI5gFm46PvjyvQ05AQsPkr
	 1/1q4HsaQ23vVqu9QbPhRLYLwFpWSlel/qf0jvZXTsObjC1bS/HxK+BtLC572LaGbT
	 E6BkCOO0qArDT772rnM+dBdZbruhW0rooSmp2QJgYtFyoZa5KoXpj/1xQ5pjUDeFeT
	 sjbH61ZAx7Jz3sCpskzuzMT+7SjzfKQ1t9BLCT8GlS9ynU+wV1CD5fVtXpvmQMIbbI
	 gad5kOp/QOgwtltkxQLpJbQvRwD/qF1o+PawrbAY4WmZ/J2gv37+MLlD5jVD8oBRi6
	 8xwjRLDeZBP2Q==
Date: Mon, 31 Aug 2026 02:35:11 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Matt DeVillier <matt.devillier@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] power: supply: cros_charge-control: adopt EC charge
 state on probe
Message-ID: <apToX3Paxb5sdClO@google.com>
References: <20260825120929.13168-1-matt.devillier@gmail.com>
 <20260828142318.1881516-1-matt.devillier@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828142318.1881516-1-matt.devillier@gmail.com>

On Fri, Aug 28, 2026 at 09:23:15AM -0500, Matt DeVillier wrote:
> The driver previously always forced AUTO with no charge limits at
> probe, which discarded sustainer thresholds and modes set by firmware
> or firmware setup before the kernel loaded.
> 
> For command versions that support GET (v2+), read the EC state into
> the driver cache instead. Valid sustainer limits are adopted as AUTO
> with those thresholds: while the sustainer is active the EC may report
> IDLE or DISCHARGE as a transient hold/discharge step, which must not
> be exposed as inhibit-charge or force-discharge. Sustainer off
> (-1/-1) still maps to Linux "no limit" (0/100); other invalid limit
> pairs are remapped the same way with a warning and pushed back to
> the EC so the cache stays in sync.
> 
> If GET fails, fall back to the previous defaults and SET them on the
> EC. Command version 1 still cannot report state and keeps forcing a
> well-known configuration.
> 
> Signed-off-by: Matt DeVillier <matt.devillier@gmail.com>
> Acked-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
