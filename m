Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6254F7CB4;
	Tue, 13 Oct 2026 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899579; cv=none; b=jRVr8McUtL7NJphAY/2vyxcjsEBYFZc60mPMZib9javj921GKtSkwsDv5pe0lWd4CM4UjiZtoCm9gKgUu4wRLAH+aRUy1UhdJ51kCitKK2V4Grp6fYmXkdpKVOvwtMiuM7nMXC4J243T4lg01aam46xQZmOhmnnmmCJzxqMOYJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899579; c=relaxed/simple;
	bh=MoF3qebbUMCzGHpu1IQbVxMhV31KvNPhnUVnq492Pyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUdm554NNmZdCPAm1PmVKiZHarcj8RQI75ehkmYkCz6f9kM4n13VfRkFrVO4TUx2rRq+Sp+dtDmFbvut8tiM8KRNZxI9q/YfEPaNafJ2BudwvfoOkVsMTDoPd+lDiLgujGHaDNk+b3o1/TMiGx2goQ5A/2s8anb2/u/tGTK6YHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bLccm1S1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bLccm1S1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705461F000FF;
	Tue, 13 Oct 2026 13:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791899578;
	bh=SrE05MZWi0Mxzzw5gRVN5txHJ2M27/v22vzK8mb4Xls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bLccm1S1y40pFYMId2ws9HP/f++aVdVyyerMyqEskMY1UJGC2Jha2A6ypEj39E0+G
	 Q/WSQLN9CssqZGYpHWruPbAdMATer9yOtZTkwWkhdHN0+2/MclOtp49Wt7NeGmT5h4
	 TSEsna39mKTQQlP0w+jnuJGregt3KkhoSfbpOpvk=
Date: Tue, 13 Oct 2026 15:53:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 7.4
Message-ID: <2026101355-platinum-hyperlink-0f60@gregkh>
References: <20261012100103.2518883-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012100103.2518883-1-djakov@kernel.org>

On Mon, Oct 12, 2026 at 01:01:03PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v7.4-rc1
> merge window. As always, the short summary is in the signed tag.
> 
> All patches have been in linux-next for more than a week. There
> are no reported issues. Please pull into char-misc-next when
> possible.
> 
> Thanks,
> Georgi
> 
> 
> The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:
> 
>   Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-7.4-rc1

Pulled and pushed out, thanks.

greg k-h
