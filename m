Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E41477E4A
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062456; cv=none; b=iwQ/Vz0wsI6c5ys5FxzOX8C3UX/oV/nx9IDgxsRasvd9KLPDfxWR0PHlftS5q6Kxo8Vm8GnBEIc5/9qtknwDPNqx/FRX1+IuAOLqSKiQHo1+02Iz95w4o+EjzKu231FwtdYAMVj2Q61oUusez5FTnQbbAUynL+9ZTpOREI38HKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062456; c=relaxed/simple;
	bh=xPdtfsh6DtiJKw3NNWgGtI+kfvS8+Uh8OTR0ljg4pcE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bAAvak0kWgvu3z1Kgs5peB4SOUNLK7d81tsn4ObwPzeI9wklj1JQnuOcspaxO5wE9qOmYBxfcRN0L4g1kdxVZRcC3PkO1iGPt4L/QAzIYQw0eTQaXja+yT5Du+WO68RCZRQtZ2rcX9oyyowFly4GMImrdf7qahgj6p/xvWaGjrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=OnyUhngE; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="OnyUhngE"
X-KPN-MessageId: 683a3a0b-2deb-11f1-afda-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 683a3a0b-2deb-11f1-afda-005056994fde;
	Wed, 01 Apr 2026 18:54:11 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 683a189e-2deb-11f1-80ef-00505699693e;
	Wed, 01 Apr 2026 18:54:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=JDtkHVtdaqDtGFKDRrHTKel3gvzMpvxr6qe6ySWOnTM=;
	b=OnyUhngEPxjY2LVqiLsAIx0O9Xc6lrcXncXCGcSJqn48S97IVQjVmqtDrwTRHiavPWSl3hmS5D01I
	 yKo8hfybwkcVObiH7tlv/To4GUpiU3CRWU730JETAaAQZpNWEmZ0gbuutLLAAAtVwJNe1UUlyFKQEN
	 aEa/OT623DXRLYz/inaUVpTQJ9NoF6bl+x4IYrAhyk74cZUcNrnl9wOK6VX2hHjPr4FAD0Rh6RsKYZ
	 CNAckyvV6UMRVP6fGfJS6xKKGXDyT4F6W3YwhyT6LY6lUcpIUkO+i5nY05Q7ha8tfyRANzxhZSZNVE
	 yaLsInZQzAiKSrnBaTCTnom32FJngew==
X-KPN-MID: 33|JYhc+jiArJy7o/gsp9OstXSXwoeGBS8y4SNW5FdgI/rF8etAF2G9bICdgE6YjWZ
 lRJT4xGYVcl8Okz08m8m1iqxV91WprD9VwusCmN46Vj4=
X-CMASSUN: 33|jQXQ+v9pdp0jGDjz0K2w3iDs8dqB7d6UDlXmDn1qDOLXRLozaL96xX17LG3gKNC
 IWF+Tg31S2nNxYXwmB4zbSQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 682fc9fc-2deb-11f1-b8d7-005056995d6c;
	Wed, 01 Apr 2026 18:54:11 +0200 (CEST)
Date: Wed, 1 Apr 2026 18:54:11 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Chanwoo Choi <chanwoo@kernel.org>, kernel test robot <lkp@intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
Message-ID: <890652743.852439.1775062451369@kpc.webmail.kpnmail.nl>
In-Reply-To: <CAGTfZH0bZMGpdKjvgw7S54NF+KeXPtvhsanKmSs1vHDhx7F7Lg@mail.gmail.com>
References: <202603211336.i375F7lD-lkp@intel.com>
 <CAGTfZH0bZMGpdKjvgw7S54NF+KeXPtvhsanKmSs1vHDhx7F7Lg@mail.gmail.com>
Subject: Re: [chanwoo:devfreq-next 5/5] drivers/devfreq/devfreq.c:1946:37:
 error: redefinition of 'devfreq_group'
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 21-03-2026 16:11 CET schreef Chanwoo Choi <chanwoo@kernel.org>:
> 
>  
> HI Jori,
> 
> There are build errors in your patches.
> DId you test it? I hope to fix and test the patch before posting.
> 

Yes, I have no built issues. Can it be the test bot did not apply the patch
correctly?

Looking at the build error it seems that ATTRIBUTE_GROUPS(devfreq) is duplicated,
not moved.

> 
> 
> -- 
> Best Regards,
> Chanwoo Choi
> Samsung Electronics

Thanks,
Jori.
