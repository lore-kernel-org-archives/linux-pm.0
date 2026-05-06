Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327D735893;
	Wed,  6 May 2026 06:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778048347; cv=none; b=gYarciq3Qe7UGgqkSmb15X6JZGeqvzvyHHuf7M7KFb5Lj8647ZcziMzf8DtyCsrKszWjUcWt+pPXQyOe3SGgRHVAsbVqEmmGeuykCdzxGuavGESrmmwyTb+QDO89yWoHJp4Am4vBzuyVtZuKEYNyqbHrZnE5MRXkp6fJOBCWO/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778048347; c=relaxed/simple;
	bh=2APD5IIwouVNB/Q/mSKJeUGv7gO0fSWhsz31rBdTywA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7rvblpE33mBQVrmaLQlXtIkTfSOFvE4A/sDLnimzzNeWD2l0tObD8u1rv1WYsoEOOcmV5Xj/VHoWzvseeeKn8Jf919eqbPgfZbmMap8BwIHOp3jZtMmpPRs+MbSY1ociyRC8DOZpJtrdYdZTuX04imJBuhBRUMKldFkbAnCags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DxD3R6RB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DxD3R6RB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1778048344;
	bh=2APD5IIwouVNB/Q/mSKJeUGv7gO0fSWhsz31rBdTywA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DxD3R6RBIYJfem+4F7Zov3tQyppephjLgK74VK2waBqbzaHv85PXw435aYEOchD5O
	 WiCBsDJqcILf5acZy2F0QklJUt9KLpTlkfuYGWJTI5LHERGEyM9hj4RV9nD+ZmakuV
	 6lxIY9Y2iEQl5XnZEtrfvjQwCN1oV1SVT9wDFZd0=
Date: Wed, 6 May 2026 08:19:03 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Sebastian Reichel <sre@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: cros_charge-control: Move
 MODULE_DEVICE_TABLE next to the table itself
Message-ID: <122744c9-8e5a-4f2a-b380-3656e8b6b920@t-8ch.de>
References: <20260505102752.182089-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505102752.182089-2-krzysztof.kozlowski@oss.qualcomm.com>

On 2026-05-05 12:27:52+0200, Krzysztof Kozlowski wrote:
> By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
> exports, because this is easier to read and verify.  It also makes more
> sense since #ifdef for ACPI or OF could hide both of them.
> 
> Most of the privers already have this correctly placed, so adjust
> the missing ones.  No functional impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

(...)
