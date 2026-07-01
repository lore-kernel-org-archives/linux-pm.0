Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5DA386C24;
	Wed,  1 Jul 2026 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890441; cv=none; b=Rn0Kdo8gbzYtDzgKBPro/+SblQyTgfOhVaVjtrit2nKIQoKMkDrNo+LZKyR2Ec4KxluRiCD7p0/smHW/FhmCPoq6nzPYIwHyLyiN/ZRIeI5HyAo9Y0qcskzQfnqwnDFY+lxeTBFbUYjybl6PRXH0WACJ2XANNDcHq5TzeUFpwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890441; c=relaxed/simple;
	bh=bOcwdlvrB8Ehn5Csie4Yehgl0UKcGfcP3sIJAIKz/OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQJuAje71riPVuR9RhAwEZF7hqsg4bulP5sapq9c5Q4lLOGVDkG4IJDx11cuAswvYYor4BXSXBGoOsQa1L7RdVboQEBGH5dOa/2s0t4b2gZriSo38NugK4NdNzc7PPKqse7V2r5d5mMIoBy1rFyk97kOdXClaYzFXU7GBgF8wMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dKMCi26D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dKMCi26D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1151F000E9;
	Wed,  1 Jul 2026 07:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782890439;
	bh=aDsZvo1S7Yg7bB8Qh4hUT2oygbCaSH+pPQ6xt1kwzg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dKMCi26DaBx3zYW/1o17Cj5agyQuEXODWD0xV2Q8BDJW+F+1roSo18SP95XCOygGH
	 IjcEAwvxpP1BNLRGyiFhCKvL2VSHDQ1znana+XHzyxzKarp9uQzFSn2uT9xV5V/Pqz
	 gd8Op5Qt8aMtEHVN/dhXZ3ZEpdMWEVPrn3iXuWwQ=
Date: Wed, 1 Jul 2026 09:19:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
	tfiga@chromium.org, senozhatsky@chromium.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 1/2] PM: sleep: Rename module parameters prefix to
 "pm_sleep"
Message-ID: <2026070110-unrented-crummiest-d6af@gregkh>
References: <20260701045640.3130090-1-tzungbi@kernel.org>
 <20260701045640.3130090-2-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701045640.3130090-2-tzungbi@kernel.org>

On Wed, Jul 01, 2026 at 04:56:39AM +0000, Tzung-Bi Shih wrote:
> Currently, the module parameters defined in drivers/base/power/main.c
> use the default prefix "main" (derived from the filename).  The prefix
> is too generic and non-descriptive.
> 
> Redefine MODULE_PARAM_PREFIX to "pm_sleep." to group the module
> parameters under the namespace instead.  This makes the parameters more
> descriptive.

You just changed the user/kernel api, right?  That will break things...
