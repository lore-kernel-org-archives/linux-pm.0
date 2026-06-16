Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745493D88FE;
	Tue, 16 Jun 2026 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589582; cv=none; b=Ycmfq4jIJ8uo66PubnPCCwGvrJRNrA9G4BkSGbZQhXS1hWRqlu1a2w5wYQHntuXJNdBdJ+LiYGm1oeGTstyQpFF84Ma7kHZcWnJUZpB+jMzC8X/eshONh2a+JbqF9Opga6PMoJrvZ5jyLFyY3ObXSLo7vvfX0GNKZRzu86WgEdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589582; c=relaxed/simple;
	bh=FORDhV96tdHAtuehrNe9uRAGj2+EE9JY3eY5E1wbhGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXlbJ6V7gyvDiK0opa7/pg8Hnzj+pPIoxXchj3ECmSOFUQzVMbKDRrK8SzkxBD/PLhNQKuacS/efVspWrG7apz06xh1bwgZjo2w2xVC+ZfOb3PF/zDpBrRs1PFHbkksPlhoMW5e4d+uavz79mr/1YbVbpRwEqCqEtvZMyU9I3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0LiBs4D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0LiBs4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DF21F000E9;
	Tue, 16 Jun 2026 05:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781589581;
	bh=i32F6IcVlEV6y4PPf1ZL03Yo1piH7IqR+iTxHu5YPYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F0LiBs4DEwdLshrybaFYa1AIHGMXFkFPT7N4Y8CXQGusJskh+tDlz3TB5YaftBOMC
	 ZPWmxR/vHfkIRFi87CUw7LWEobq6Mxb5xoxDw7YdqWrgh6lrqUjDUP1mn6qbiFclV9
	 KcJx73FRyOItc2yr7dAS8WSXaSyoRz3S/DhCae0SuarBZRFVRWxUO+vr+SiKRxPzSB
	 Y1cfd0HFwq+VuS2iU4sonNXGMp+AHqCOl8IbxZvlwSTrGrxvgeufNyRPOHqrCiqem7
	 Xa7wr3GWvLCy/2+ZGLHg3x2nR40Ih3aGHLN8pEky5WDFgV1CIFnpfVk7NgtXWUEr9D
	 8EGbXFha+nExg==
Date: Tue, 16 Jun 2026 05:59:38 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH] power: supply: cros_peripheral_charger: unregister EC
 notifier
Message-ID: <ajDmSuK-eahNO1xu@google.com>
References: <20260615063105.39152-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615063105.39152-1-pengpeng@iscas.ac.cn>

On Mon, Jun 15, 2026 at 02:31:05PM +0800, Pengpeng Hou wrote:
> cros_pchg_probe() registers an EC event notifier whose callback uses the
> devm-allocated charger_data via container_of().  The driver has no
> remove callback and does not unregister the notifier, so the notifier
> chain can retain a pointer to freed driver state after unbind or probe
> cleanup.
> 
> Register a devm cleanup action immediately after the notifier is
> installed so the notifier is unregistered before the driver state is
> released.  Also fail probe if the notifier cannot be registered, instead
> of leaving a charger device that cannot receive EC events.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

A possible nit is to use s/cros_peripheral_charger/cros_pchg/ in the patch
subject to leave more space for the summary.

With or without this,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
