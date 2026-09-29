Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6252B5172FB;
	Tue, 29 Sep 2026 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681477; cv=none; b=LaWl38GRgthxwruJXrOBrJDB3rEmIdmZ2eaL1qHUYWIXjmbvNVMuQIOoQRieDXdRhZEYIA0cztfQ1KjD6PChkzx5Gf49Zg+szzl3Yi1VCrdfe1RPMGvW4l6Cw3lfvQQ5X5sJckBDy6XpXD03LtVyVfDjvVQVXfUEPJGAAXS+1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681477; c=relaxed/simple;
	bh=VabN5MWOccwr90MQJdvNcKPQuFFRcjkMXRb5TXrpz5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izvd7UDWyZVBl3KTThrgVcy7QO8Na3vZVWWC2qX4yCtdqlJqFz+M7rNgkgK9hlAGzdlLGAEaMRHCz2UCt/X8PqdC/3Z4lwgYC7fJyCEpxCly6oe4PtNq9AsnYS+k+Gf3WIi3HmL3Jq0PP/CckCAFzq3A2H7baAa2yq/7bvBy2N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f7/qn2Zr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f7/qn2Zr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B351F00893;
	Tue, 29 Sep 2026 11:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790681475;
	bh=usX7uaNlIeb7eaSCYVixrLocm7MWHnkEztaSNwy7j9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f7/qn2ZrS7+0jhMmqjlexjXMkLVuhgnEz640oWXD+ve/wzqkFo+5kHiynh1t60JwB
	 ToQbXpQagl15BUY/6QBPla3bwp45K+v98HdWx8vnwTY/KTYIFTueuCsTzy0gchKjpZ
	 nl+476EPxTKlQShwGeWxS8vO4+AoBuMIgCklMixM=
Date: Tue, 29 Sep 2026 13:31:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [GIT PULL] interconnect fix for 7.3-rc
Message-ID: <2026092952-mosaic-guidance-1f15@gregkh>
References: <20260922135416.1414403-1-djakov@kernel.org>
 <e1069657-439f-4296-964c-5ccd10a068ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1069657-439f-4296-964c-5ccd10a068ac@kernel.org>

On Tue, Sep 29, 2026 at 02:12:14PM +0300, Georgi Djakov wrote:
> On 9/22/26 4:54 PM, Georgi Djakov wrote:
> > Hello Greg,
> > 
> > This pull request contains a fix for the current cycle. The details are in
> > the signed tag. Please pull into char-misc-linus.
> > 
> 
> Hello Greg,
> 
> Just a quick follow-up on this fix in case it got missed. It's addressing
> a boot failure on some devices.

Sorry, conference travel and the flood of stable stuff got in the way.
It's still in my queue...

greg k-h
