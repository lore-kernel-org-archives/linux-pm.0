Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23D17A2F6;
	Mon,  8 Jun 2026 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949863; cv=none; b=Zto6fM/4UFSh4IXIGijL+OVdzFt/Vew69A7NW0lJiQEF+GBrsBOOvRfKDFN3DNC/roxWwPe8GO4IukQ1Pb6zcCQ3x3g+dshua/PbjJNMB9Dldqs/ULdQZn/80ncbUOEMVFRTrp1aVDFl4rU3Vf6jQgT0MQ2f0/Whh4lErs4ftjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949863; c=relaxed/simple;
	bh=j799PautCqy/aNuX39pz9uH3vaceKaA2U+kxx7ymEgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckLpsA8iEcPbAYsKZdfBKVHYiPIifFCv7bpuLjP5Bl1iB/iGhOTzyFgyWMfhIgUsg21flxsFBskAXp7kEY2HdVZqdlKmjd+2roeQHWxc0QhRvXGE2UyUqJLAMhGPzJWsghhH9zOqcjEvW/e0ZYNwRTE7xK4Ynwn6bm6UHTloNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cLTR65Rs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cLTR65Rs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0D01F00893;
	Mon,  8 Jun 2026 20:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780949862;
	bh=hLnogMJ8SBXuxN52/5NotE7dSEFn4IuoxNHPzo6j0Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cLTR65Rs7BrKo++CLuO9kwJeOEw+s8OZ4EmmPtmnz5zABcyze0RTGuo6HxlYJi5T8
	 mmzhO4WBdBKsQ8n6m2OjgzFXm0cuOpL2GtDY792p0RXROLxIoc8fZYyuXpgcrjv0WF
	 lVv+xOtFdu18PxxUVeT29Wx3SYMgqH2WEy3rOD9M=
Date: Mon, 8 Jun 2026 21:35:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 7.2
Message-ID: <2026060814-versus-machinist-7321@gregkh>
References: <20260608112537.2701425-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608112537.2701425-1-djakov@kernel.org>

On Mon, Jun 08, 2026 at 02:25:37PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v7.2-rc1
> merge window. As always, the short summary is in the signed tag.
> 
> All patches have been in linux-next for two full weeks. There are
> currently no reported issues. Please pull into char-misc-next when
> possible.

Pulled and pushed out, thanks.

greg k-h
