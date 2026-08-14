Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A931625;
	Fri, 14 Aug 2026 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786665911; cv=none; b=g32R/lE464wgYF4pCUxeeprfCpJ6j/uGjIyxahOGB/7f/UhXaaw9UPuB+JQGmpCNuRcjSXLdNVj96hINS5Jf8vjj3mXvIVtvofwLeR5dICkcKXA2L3tMxQ4zZOZ4h/n3gdh2Ux3CxH0qIzQdgg2WWPoUKdfojGBoFVLRmdBGgOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786665911; c=relaxed/simple;
	bh=HTYz+1+OXx/VMQAT+H8BrHcyFrgGh7it1g/3K6nlOgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOWE1kw8av0xJZgyWJwwDkZuSasf00IKR4JavP5rWR+tcfkiiSHI/xwP07PIirmWl2MVcTVi0njG4CuEaAMA5fcvesRX5IT6z9vxW1LM7fnHn6orfvipXd6n9nSKdsx3zatcl2GKQ0GoE5Psx+eK79lMxAk/JdDS7dI4sFrcfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz7opB8B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz7opB8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEA11F000E9;
	Fri, 14 Aug 2026 00:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786665910;
	bh=2UwPabubH9K9Mv/vNFA1OjOJl8HywX8fyL/3Qra5Beg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tz7opB8Bi2eT5DOEbKUoUua+D6kQFLVGivUrNK3XJBghP9xctbaM3RJIXpTlM7SiH
	 tmaserpW23FVCqUKMIpt7mBOXxxnzbmzR9DUiy/oJ2Nmvznir6u8tqIVDegrgv3Eaa
	 oUmdzrenCWQzxBri2pCAUTWkXHh6+YQGVO0XTW9XD+6FqZcellRQ1hg33XDz3LaH98
	 lc00dM9FLu08MrvpyNF6iIEme7ns+F/KVkVL4D+rA9+sP68p0Z9j9JVMML5c8dj/on
	 rGF3wWG5+Nm2TEUkCZj9DExnlv9wt+RNg4Z6qFgQS0xGajF/hyVOM5BZzZ6f20Szrd
	 G8QgZKUAKccuA==
Date: Thu, 13 Aug 2026 17:05:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Mark Brown <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH linux-next] thermal/drivers/qcom-spmi-mbg-tm: Add module
 namespace import for IIO_CONSUMER
Message-ID: <20260814000505.GA3919970@ax162>
References: <20260812-qcom-spmi-mbg-tm-ns-modpost-error-v1-1-d849390d2714@kernel.org>
 <20260813023543.6936b188@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813023543.6936b188@jic23-huawei>

On Thu, Aug 13, 2026 at 02:35:43AM +0100, Jonathan Cameron wrote:
> I did plan for this being a possible issue:
> 
> Ideal is merge 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git #iio-inkern-namespace-ib
> to the thermal tree.  If I'd called that out originally (or a thermal
> rebase is a possibility) it would be cleaner to do this before the
> qcom patch adds another user then squash what you have here in the appropriate
> patch.  Alternative is do it as a merge conflict resolution whilst merging
> in that tree.  If the second, I'd also mention that in the thermal pull request to
> Linus given it's a little unusual.

Ah, I did not realize that you had a stable branch with the module
namespace patch. Merging that in then applying this to the thermal tree
seems like the best course of action. If rebasing is possible, I do not
mind this patch being squashed into the original.

-- 
Cheers,
Nathan
