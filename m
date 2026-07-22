Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196DD33EAF9
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700673; cv=pass; b=S7c2q4zVrBOADeZJw3B2wg/y81JPtQw/hXeMV6uLRQj03wlqNve0xQPK1uJixmMbXv+etw/k55dXcvtdVkd7qfrRMps+SG5HFMki46WRJKIUwtD+wd0aCZaBU8rSecTHXRAwfdy3FikNcrC1A85x/qie95tbh0es0GhVPl5H55M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700673; c=relaxed/simple;
	bh=OkMxB1ADgZoX24fSd2GYMMEAXbeVXA9oKqgABoNYoMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioFIYqx1KIpf36IV3UT8GVntGQBvy4fX8E90pUBb6liw8E4Uu494rtcnuc/hs2F1jVP8vq76mqokRxKyEZR6Fs//jIjY3F/ZKu5Ra9Li/14LsdxdL96oC946+eUoSusplR7KfMUpukgMg4E3BNvkpND7UtoQxaKLPyzOSOx7w9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mechasystems.com; spf=pass smtp.mailfrom=mechasystems.com; dkim=pass (2048-bit key) header.d=mechasystems.com header.i=@mechasystems.com header.b=wHk1ZFhP; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mechasystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mechasystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mechasystems.com header.i=@mechasystems.com header.b="wHk1ZFhP"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so11293346a91.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 23:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784700671; cv=none;
        d=google.com; s=arc-20260327;
        b=Mw365JVOGl5aocooJ7DrLTgAYzgw3IC6m37pfI0wIPmfngEop+cnocmdzyYOh5nxih
         VfIt4RJWwUjv+5VD8RxadWYV59LWj+7hN7CFMHe1obGVMXEFeSdKGEU8/o1joodrOr2B
         tLh64F6XuKRj9H9M3rf8PG3h98KqktGWkzwwLwpWtogp7nU9d8bPk6WBWeJWszORnGDt
         lLx/89eZPZ4v8Q/6XopsYpLwPAJtKO80og4g9acs+OU85f5nGTyWUAjvbs25eZhzrEL2
         W/kwvHz2K6h3JBuiLAUWNw+ACTxrpDAPsEw7Yy8H+G+5bVhLp/YmPKmd3fTpdsGTPWeM
         5grw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OkMxB1ADgZoX24fSd2GYMMEAXbeVXA9oKqgABoNYoMs=;
        fh=ukEMP+ZEBqqzFNLXVYKiS/LfuNTCMBdbU1TlxB6b9dU=;
        b=L++aorz2CoRaNzqB9z0OHdUIYoszIRXpgxOoeOx/if9mE1OL/0ReIi1M0Ynf0K1Gi+
         Opc9kY8xcHGPHAg6CIy3z0RSt0928JacTsQp25IeTt64EFban/KTWxDjCf4vq3EyYqgj
         8zAy9QKXs/NaI5SzGhErWKVYEl286BcAUaUV2iE0f9nTtmbB4ztsuiA5Zcdsv7f8Z7p1
         8TO2kAI3IY7i7WXbW7LjzzQjronpVDw+BWXCeJcn2bE258AtvwNVZUDxAURn4nwroU8V
         0sH9wBilTfTSYcQlat4KZJQRIUkoINtWjvKrQjGUnOo1Q3lb3C+MzdRr9+GR6UEaLodN
         NlKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechasystems.com; s=google; t=1784700671; x=1785305471; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OkMxB1ADgZoX24fSd2GYMMEAXbeVXA9oKqgABoNYoMs=;
        b=wHk1ZFhPb//G22jkCKLcVEjqWlN+n5rooR/FuFd/Xwf2GXs5GFPLid2XlhQUnb54+a
         +FTXplOIW7X5GUIar5WlmQr01wg2cxD/puuUbJE+QXcw8PmZNjFi8jUqnfbwJbv0mS2i
         7Thsq8WaMXHTIT3guOXvTc8ZCpkro2o68GSDALF0OdOauVyjUCQoGlhxOQqBwpA5ppVa
         1hmsYB+LFD9iTUydsp2+cTfTumb/UKWQm/rEgSBdyVX65X74/qv4eIDHBISzXuUkw/N6
         ZVMcW1FAQaJm7YGCmnAHXyXiWgGxk1fdrGTcVaAC3KU9eLr4/+WcRfOJdkPkEAGfeP7V
         ADNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784700671; x=1785305471;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OkMxB1ADgZoX24fSd2GYMMEAXbeVXA9oKqgABoNYoMs=;
        b=q/JLC6zavpDvQUKGuAYVYduNLF5zsBNVVSo5ii920pi2vonFEPk3PT9/4jdE0GE9ct
         Zv5DMmW8OYe4RXc9HXwZUU3WQDR2SVFBHcmLUFnBdr6c80C6DGugkhYWfE2iR2seLDkj
         BiWi+H9tdxdsZbXXW5Q9scECL/1/OReK8uvJPyW8Maz2sZy0kw+DBg0IXadRb/iHUqc4
         MRhXZx1Gb0LQ6EkHJe1V/cKBdHBgnmnwYnA55EwGIqPEqqqZGFabiVXt5cToKuta0blZ
         xFSPqEjxxS12u6zBu+YDz3dmVv4dwC3xt7qc6wuIoSriuhYZJaaqc951LPC8H6E0wLEq
         U8Bg==
X-Gm-Message-State: AOJu0Ywfm5l/slSVrxKIMTLS9v5QmtemZT2nGsrzbknnEMCT7iQZTZCQ
	AuuDxSVFSVmxCzNHX+SVpBKeTwY/1xBAa+yN95jt9l/TfKE+cGM51e/94eG5RHvJ36r/T80X9jM
	lndKaJrifzBRtIzUWZMWi2ozZ+qYZ7n0nlTnC7hVZYVnWZCPcR4qAGKc=
X-Gm-Gg: AR+sD13fAAwPmL35VAstVNKd2i8GPUIW9PCU+Yq7i1ncrWNnjBCh3HMRjfYGKWPcKtF
	H4/Qh7N+xwqAkcdE7Go9q2ERzh+9Mymg3BrX13u9a/nFrAzNLHD+UgWm53F4cW/bl4SAScvSXPR
	GAuNkf5QI9khQe4MB2R4VxnoNhLERt/16VX+0EPJO08ni8Le+kYb63aFSuOBl4pZA5FOnnQ8pkW
	A8WQRrxfXKo0GByISie2xDFGkPtRrn6mpPP87LUDAcA0Snt7l8l4FJdAisLboU=
X-Received: by 2002:a05:6a21:1f81:b0:3b2:8685:118b with SMTP id
 adf61e73a8af0-3c3ad66b6f7mr24333720637.20.1784700671391; Tue, 21 Jul 2026
 23:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAPs2HTo=4+AEw1+vcU6c9vt_O2BfF+gv3FFvx9G3KLLzCOsHw@mail.gmail.com>
In-Reply-To: <CAAPs2HTo=4+AEw1+vcU6c9vt_O2BfF+gv3FFvx9G3KLLzCOsHw@mail.gmail.com>
From: Advait Dhamorikar <advaitd@mechasystems.com>
Date: Wed, 22 Jul 2026 11:40:59 +0530
X-Gm-Features: AUfX_mwknoj-Deg8-Dcg-e3PqQ1pi3R_hwflRITqu0EFCqpynuUYicNGSZbPQgo
Message-ID: <CAAPs2HQcHpDGqhiBXSLOKmXWGevmWbGO3UtfV1pmoiF+wC6aLg@mail.gmail.com>
Subject: Re: pmdomain: imx8m[p]-blk-ctrl: resume hangs when waking from
 suspended state
To: linux-pm@vger.kernel.org, imx@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, ulfh@kernel.org, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	bhushan.shah@machinesoul.in
Content-Type: text/plain; charset="UTF-8"

Another observation I have is that if I disable the MIPI-CSI related
nodes(MIPI-CSI, ISP, ISI), HDMI and VPU nodes from the DTS, or else
unbind their respective drivers before suspending, the suspend
wake sequence works just fine.

Could this indicate that the issue is related to the media clocks or the PHY
during the suspend/resume sequence?

Best Regards,
Advait
