Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE03890F1;
	Wed, 19 Aug 2026 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128097; cv=none; b=nstjG4rPeTgJsMY5kIHPqZvBHworTqFG9v5jggUW77q83cBqGI7P+yKxmaf3rC/zTU8g1a08znbHhkEAf74LNPA0cw7RCXxVqViApxddnOw7rTpbysCUNbXz89FZJ8hswtmau8dYifNxvkVVrUPDOw2SRuOBiAnwNiwyPiW/AOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128097; c=relaxed/simple;
	bh=MV1pkd+Pi4/GI2HxT5d8PF1jHPsH4xUPnvt9Qqn2dhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsaVYUj/mA0HxDlOcAskaEvjEV3c5/qkLHU8USs1yKtmE5L6jCYjJcXrAr2h3mDqOXXFurNioOcJSNTg2YFb336hS4qGQibrCRI6+N5Jsfwl/wO08Pc08pOlwjL+nxMVkiWZ43Bb2xsLyH1KV2mekAJr782nOUEyfpnEzbcmojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zUE6NDue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zUE6NDue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9111F000E9;
	Wed, 19 Aug 2026 08:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787128096;
	bh=iLA0I9/h/NhM54trir/eImz9Ii3J/jkxxxKmIfL/ojA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zUE6NDueMkehtQLF3/8QcSO0xGVxwrrKFKPAhv+TWQG5sCo/FAAiX8mvKPslXjQef
	 5CDs1scJiYKcaKYd/dB5r23h3EADCM9Wz4o3s0Mj7n+Qctg1VT0anU6awr4MSEeEza
	 DQJeuCDSQiZ5Kb2qDS6LNJvnbOJeCI/iFNG6MXhc=
Date: Wed, 19 Aug 2026 09:56:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 7.3
Message-ID: <2026081937-preteen-kelp-63a1@gregkh>
References: <20260810145047.422910-1-djakov@kernel.org>
 <7a580bae-13e7-46b7-af70-e4662973166b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a580bae-13e7-46b7-af70-e4662973166b@kernel.org>

On Wed, Aug 19, 2026 at 09:38:43AM +0300, Georgi Djakov wrote:
> On 8/10/26 5:50 PM, Georgi Djakov wrote:
> > Hello Greg,
> > 
> > This is the pull request with interconnect changes for the v7.3-rc1
> > merge window. As always, the short summary is in the signed tag.
> > 
> > All patches have been in linux-next for more than two weeks. There
> > are no reported issues. Please pull into char-misc-next when
> > possible.
> > 
> 
> Hello Greg,
> 
> Just checking whether this is still in your mail queue. Please let me
> know if anything is needed from my side.

Sorry for the delay, now pulled and pushed out.

greg k-h
