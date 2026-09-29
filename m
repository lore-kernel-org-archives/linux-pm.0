Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301D3D9DB9;
	Tue, 29 Sep 2026 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687830; cv=none; b=T2wZeMn4fpolsQ2MXsSJi0kMoCRvNkq96UVg7mMDlKFAl9elYpN1CjYUydG2oAvxtiXML6mo37v4GQm+7dOwuE89+fuXS7o3kxjy3iHJCd65IUX11DxyLPDhGX6ksyPbvf8Iec74pc/4yJ+h37RDCk962lg4Aw3JBJEGq1n6c5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687830; c=relaxed/simple;
	bh=1tPk9bIDHljNXG6xcHyCvUpy9ne8uqkX7CNH2WJFv9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMIDoaLTCS0sQtAqH+zM6sm4BEy1+Rw3JfV0ThjC6YIoMMLFIZ5E/5njf2X4BR4hvtJ882GX84i3dxkG5bS1RQPpjuj6GxVJzP52rPdhgUy0hQg88nv2sgg5GZyVk5cHTG066Qe3q3zZuTOxmCff4kWbweL+IFGLs82vT3XQcnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P3uGIbXW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P3uGIbXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC5F1F000FF;
	Tue, 29 Sep 2026 13:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790687828;
	bh=84QJ+DOehUUzd+aMq4C51USs/Bf/a3+khVc9CH7FC8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P3uGIbXWn7Z++Q9HVxMPIFWWwS+lOPup2bV1bCSeyICPL95jq50NXqqHP+wI9KL2W
	 48mR+kwCHtFLt0NzqI4ibBLtT9Lri/wJ1vu+kK3rm2e20DZtC6A/kMgM84virjyx7B
	 RWgH6cP5ZwV1bCEKljR/d3VtHZrk6ZqEjnWG301Y=
Date: Tue, 29 Sep 2026 15:17:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fix for 7.3-rc
Message-ID: <2026092954-navy-overjoyed-feab@gregkh>
References: <20260922135416.1414403-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922135416.1414403-1-djakov@kernel.org>

On Tue, Sep 22, 2026 at 04:54:16PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains a fix for the current cycle. The details are in
> the signed tag. Please pull into char-misc-linus.
> 
> Thanks,
> Georgi
> 
> The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:
> 
>   Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-7.3-rc5

Pulled and pushed out, thanks.

greg k-h
