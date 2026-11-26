Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697864;
	b=I+cEFvtvYnEWAeiiRsBPDZGs0r2+jgQF16FksFW5lbU8nuxt7CGXdWrkkksTrd+uKJfx
	 MTlG+mFGsgSBukXJHw5DM9H2meDKpkEg4QYJmh47EFczHrtuprCy0MXw5DTYjPHz16OOM
	 6oZHvH1y1yiShT9h08w3XS8TXTZIsulumPCmsuvxMc+u/YwruOeBs8kxSUg0LSU0zNPA7
	 8jwA6EG3/cqOgNXmYTzjhvRub/2RPNL3QLMacpoazUAZOvL7xe7/wS9xmsNQWwaUsuAVt
	 kRiDg1+kKl4HNx03ejsDCgQlYg92K6v24F9ytxJouUD5XC+4UYChggW+d4FpFVuFkmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697864;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Zdu6UqAiF7rTC1aAPngu4Lcf9W0UfVjpRUp67SpDNvY=;
	b=A3tG783JM8gpNaGDx9rvGwMoiUuuEoY0QGjnaarTlL0sB+E9/r+7BK4S3WIXqUQhygQp
	 9LFThq27aA2x8mMHC+tda38AJk/oDhQqzOXKu+BebpGur7wnYwWyyoSvBaL2xonzA3NCL
	 saBmBaHrUht99OFUUNubwbGOIU7Oh+hWM1f40rKcV3EUu6Bg93/A4hRa8Qw7lwzc72V0d
	 hyYgiX0Fxg6Ge0hVBP83ih11OJbwNRQxROSBRtEoQhBRTvo7IZn7RPtV2RKLK/+6W4nn4
	 gvohOqCEyRgjO4NoVcg/Hy9eg8MsnXc62HZsmEG08wwv/RTlcdKGWb9/3aOqqxls15Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCiBxPMU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B4606A31E;
	Thu, 26 Nov 2026 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCiBxPMU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE0C1F000C4;
	Thu, 26 Nov 2026 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795697864;
	bh=Zdu6UqAiF7rTC1aAPngu4Lcf9W0UfVjpRUp67SpDNvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JCiBxPMUkYBkMcC1aJRRzuQbERogqw97v/46zohcdy3xJMpwXTP9YRd+dqVQ2Vtfr
	 daziLHReeGFbbV7nGXDU5ujiwIA05VUT5XOEYPWYzmpSuKnUqSYtLNf74ixYQiSd5p
	 01DaBFFMPoiSsrp/UgagSdU47WtPdSujVD4dPcAmU4c3fp6SWFiSgBBHgQczqZdOYQ
	 in9l7KvCng9So6pbEsNRAr+LunBYJWU3A1jAe99pen8plegP+BjS9kMQp72W4ipfNj
	 b1wnWi1hTIREnr3iYwwIwBOmp/2BpD5e//C5z2bX1YmQ5Sfh0bS+Ub3nv8y/Xgic6K
	 XWCrkOTIEHCNw==
Date: Thu, 26 Nov 2026 12:57:39 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>, mfd@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd/regulator: db8500-prcmu: Remove EPOD regulators
Message-ID: <20261126125739.GK38590@joneslee-macbookpro.roam.internal>
References: <20261115-ux500-epod-regulator-removal-v1-1-f550c95dfa9c@kernel.org>
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
In-Reply-To: <20261115-ux500-epod-regulator-removal-v1-1-f550c95dfa9c@kernel.org>

On Sun, 15 Nov 2026, Linus Walleij wrote:

> Remove the obsolete DB8500 PRCMU regulator drivers.
> 
> Drop the regulator build hooks and the db8500-prcmu-regulators MFD
> cell now that EPODs are power domains.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Let's just merge this, it is ACKed and prerequisites are in place
> in the powerdomain subsystem.
> ---
> Hi Lee, go ahead and just apply this patch please.

Doesn't apply sorry.

-- 
Lee Jones
