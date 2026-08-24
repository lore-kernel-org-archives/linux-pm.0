Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB95379993;
	Mon, 24 Aug 2026 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787548254; cv=none; b=fHQ6IPcJ/HdHB/4BOejZwLr8g2tkg7DjN+Yxk8X0CUymH/wcQNxM7UtBU3O8heczU+H1fMLS+xtKEqLTfvZNGwnaSPsxTnhQIeimt3tMR+S1mTHqJCfMd3/RjmV/6ruZZh5vac3aV4jvDOpl6Rw2H9BPvp85qmJt6uoSggKwnTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787548254; c=relaxed/simple;
	bh=5jQJn/D8iaU2S5Ve80HtVA1sQkD7wg1QX6FXOZ5iZ0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgG9DHJjAI5Ic8/uOyHuJ7oLCk6AhqpVCO471GMZruhOzW4uLytDDtg3KzegRJs7wOfARRC2L1jgqNep42uWqJjmGeEA6PUOetL53TMoo39eN0lZ0Ar6NpZuaGXP6io19uviVSDPJ4k4OwWJpf71ZHUOzsx13XoBddhcIAt/j3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HSQ2RtQI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HSQ2RtQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5427D1F000E9;
	Mon, 24 Aug 2026 05:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787548252;
	bh=bPYHB14yRGrkL6FsbljVADpzKAdVSzClNWD119Unhuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HSQ2RtQIm4l5t1bmXrtJY3EyQoLgzUp9eLOp4AXv4hFX00A/e7WJgfxzQdxJ4ozKo
	 +PnPDXufMWw4eHFG3+fmyPlOXKF2GqoVypk2wNj4ukuDcwpQbbgT/t45JOVVrOZGq9
	 E+YAIcE/XWVmO1sSokCqpNyWX0Cmra7ssHghmPrc=
Date: Mon, 24 Aug 2026 07:10:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chhabilal Dangal <yogeshdangal66@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk, rafael@kernel.org, pavel@kernel.org,
	lenb@kernel.org, dakr@kernel.org
Subject: Re: [PATCH] treewide: Fix typos in comments
Message-ID: <2026082428-stadium-coconut-057c@gregkh>
References: <20260824033107.347011-1-yogeshdangal66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824033107.347011-1-yogeshdangal66@gmail.com>

On Mon, Aug 24, 2026 at 09:16:07AM +0545, Chhabilal Dangal wrote:
> Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
> ---
>  arch/arm/kernel/cpuidle.c      | 2 +-
>  drivers/base/power/clock_ops.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Please break patches up into one-per-subsystem, and provide a valid
changelog text.

thanks,

greg k-h
