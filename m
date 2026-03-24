Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E235E925
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390147; cv=none; b=Piwfe5HNgU/WPcxw7DCPC6LPtaReN0XJhjPY1LY69WVyqcxCiTglFCy5kIj7/m3ZVtfjbbGWYYIlg7/I9ahxt6NNaJcJJR8K574dZWogJN7aBZNfK7IssTcLSCXBfKjNIa3kQhVqvQw/gJQUOcR12MOP2nBZNXZMMY0AaCa613s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390147; c=relaxed/simple;
	bh=gqD/4Nj/KWzshaxOKj9bT9EyA+aY0PJljwP9fL3ShT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyId0MLHwISbGP6jMLiRg+zLqVtStIblT9gBFBn3jMbvsbk+RUI57KBP9oNIhURpwGzInAAoorGAKwck65SKDUwH5LCPwHCBSEYUb5Ji8NjSP7VZ+emutHFV3VLNjAHP3yazRBdEipcQpPz6IzUsYPn1ZCxrVoVhcyTK/LQiICQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=tVAniFzF; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="tVAniFzF"
Date: Tue, 24 Mar 2026 23:08:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1774390134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nyjqmTd/iomHdPO3sFpvymjrRaB4XA9NFCHgvnliVAk=;
	b=tVAniFzFs9A+feiMRtpRnjccXtmHMfW2jKZxq9qTwIPYq2bxbb2AdD1+nN1edChqDab+it
	tyRgMnUXuT74NzMNbZYiir9zShb+ocFRkn6JBvHhcgJ2mCEbVS8PJ7CbnJUWsgd34nN8+J
	uTmI84jY33awsOugR5gvr2wawmNZ7Lmz4wXN7zVC7TeQQBy8Fbd5iy5oHERgLiJZ4bQd4v
	Aeu6LQ3rji8I+UBH3MDUtn1Exs54HsK+qaEEzJb+cXmCcjqXykk6FgKHJTTrM8m2x1HpvG
	JibAZXk6n5SuKSosNzFw4r/cohK3ySJrihsjsT/QvyVYx4MHeOzMOzTPs2IN1Q==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] cpupower-frequency-set.1: trim trailing whitespace
Message-ID: <acMLc8HX35YyVlWz@desktop0a>
References: <20260324013543.4776-1-io@r-ricci.it>
 <20260324013543.4776-2-io@r-ricci.it>
 <1c76b560-c40f-4069-b056-c4addc33f470@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c76b560-c40f-4069-b056-c4addc33f470@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On 2026-03-24 13:59 -0600, Shuah Khan wrote:
> On 3/23/26 19:35, Roberto Ricci wrote:
> > Remove useless spaces at the end of some lines in cpupower-frequency-set.1.
> 
> Why are the spaces useless and what happens if you don't
> remove them?

The trailing spaces seem to be both useless and harmless, since the
output is identical regardless of their presence. I trimmed them from
cpupower-frequency-set.1 for consistency with cpupower-frequency-info.1.
See also my reply to your question about patch 3/6 in this series.
