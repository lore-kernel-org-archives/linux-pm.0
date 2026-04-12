Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD07637B023
	for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776003063; cv=none; b=aa6GVxw4Gv9dHxA3bzIlYJf2NPr+zwHZWdtEDGONeGw9NPCYJxwKSyNpZ1CP9JOS5h+3h2RQB34piJyhqFmbtdyvmLdIZF1tCoSxI5N0gmM+LtE3lPj7s3CRoStUWseGLKMrNOvKvkQxPLmZG6Jm8DNfdS0v9Ki0Xa9X5Xm8y/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776003063; c=relaxed/simple;
	bh=WJHNicUIa0RvAOGUJWcYH16AKm8wpNVQ40hrO98JoZw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YjhXovOw5jeT+9Ar2m5NmcOF9M9Zt6VM2zvqhal560fwUNvBuiSf6fsoMucVlNxf6sy+hG3Aux71KFlAVfNqpixW3aWCrgIDqfI03P8zIt7w9T/+yvNhIlI2uSl1XfBKD3wFJBzYIg/Atyx8Hul/6HFoctXKAJVQk0UuS8U/pjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=PrOFffjy; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="PrOFffjy"
X-KPN-MessageId: 46378645-3679-11f1-8ff2-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 46378645-3679-11f1-8ff2-005056999439;
	Sun, 12 Apr 2026 16:09:52 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 46398d28-3679-11f1-83d8-00505699891e;
	Sun, 12 Apr 2026 16:09:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=uQPQKBmsmHuREHix+TshyR67DOumQIwtgo4jB9DzxbA=;
	b=PrOFffjywsrIsYHNSFpFhCqrIQwWBKYLTQYuKGgrzqO1YZnpBcz/ceo5Y31C+uppPXPNRv0lCnWfY
	 ITFLYB8tGGs5gygcCoFiscV3qHKlNVh0UqG0D9lC7lqUhuZgUZNZ75D8QReAEd3c2GOyrc79rHytBs
	 7V6Ms6BUyNc8CLzaq1VNxP76TTPgX+9WtzVVfhTIxkjzc1r2zVr0d8JzOHAQu4uV1PTFCm1Xx9FrtR
	 yZRD/KuDV/tBMRhwtQwx1NH0O81k4OUdfszljGv9W4Fzfcv2KmY0m1kdxVzX5RDlxl7hN0rhiuJo2o
	 MQY0H5Af+85IytuMmGtR0Sg1xiqBb2A==
X-KPN-MID: 33|38Wc9e1JKeq3H9eYTFMVGICy3rH+0LLI6uS/0RLFcDUG6sQRzeBTdE/3QWWODQG
 Rp2kqaaYK6ZlDdmSD5R/rujT3vVT9xSe5Efue1e6IDdc=
X-CMASSUN: 33|xlCGv98JpPgXi8VxQKiUBeg/fJkOFjpWuC1JkFLUuGsgHX1JlKgLsjBiIXf8DyS
 mRY0gfiAU0SI7Z6c2BBU3mQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 462c0130-3679-11f1-b8d7-005056995d6c;
	Sun, 12 Apr 2026 16:09:52 +0200 (CEST)
Date: Sun, 12 Apr 2026 16:09:52 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Chanwoo Choi <chanwoo@kernel.org>, kernel test robot <lkp@intel.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
Message-ID: <1451499330.2050120.1776002992138@kpc.webmail.kpnmail.nl>
In-Reply-To: <890652743.852439.1775062451369@kpc.webmail.kpnmail.nl>
References: <202603211336.i375F7lD-lkp@intel.com>
 <CAGTfZH0bZMGpdKjvgw7S54NF+KeXPtvhsanKmSs1vHDhx7F7Lg@mail.gmail.com>
 <890652743.852439.1775062451369@kpc.webmail.kpnmail.nl>
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

Hi Chanwoo,

I replied to your email a bit ago. Just sending this as a reminder again:

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
