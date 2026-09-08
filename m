Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC81F192E
	for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2026 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788831294; cv=pass; b=CDEuuCJeMpNVImCG7odcwvrDLwpuiC+TOU/bTM+x3C5/YdWmKWTK693QGAfWAspOKL/IeIB/NtCbeHde3u9Uc4d8ijTYmin+2pw1kH8+jeigkCAouMx8aqhUglxyxRbITaahf+DLYUuQEKvwDD+AgYlmGy/CniOgdmEYJuSZ020=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788831294; c=relaxed/simple;
	bh=C8sk1qEEBHqvgTdmahyfxl6izzwTI6I+XEK6unrL7yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhOWyW104TlKJcDdrR71l5ZO2+jBvCtWVBNz161J4QwNdXDI+f/BW8HdwzUPHIWkGpcnOl1rqyMhIonyUDuJd6hQSMPfIiZvwqExyn+DECJ7zV54lXgs8zT5L9tugtt92FoBD7xNWudl6B42zbOEMlP56rHhja95X2MWdaTXfWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DymFgwAO; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DymFgwAO"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so422751cf.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 18:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788831290; cv=none;
        d=google.com; s=arc-20260327;
        b=Yo68bqqFPri2Bd1nkRQrYrnOEm+/9ZAEE+d7ziVRTI63XLKEo3PZWfjbc67LvCSOg5
         kJIWfZNe3hDcrsr/H/bwK7r7RNecM6vs7GHfdoQ+XhkgYTEfKAewGdcAluA3OSzDpiBg
         zvMGQTB/l2nVkPDL97rBuVzCyqMVfwPUP0xqlIkffRH5osG1CVQgYcrrHB8DZUG8QVQB
         08sgLvHtyWwed5PfTXcRm4K2z35JTBE3iV1g+M3QbkprORF3vW7LBSxDPvdSVFrRuE3h
         qy/vVyVc77BLvwbotVqdP3bW/Ep47g22OmKDxoZy0PLjx+Ou3R49xkk23BGIkZbrLrcp
         gCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YQzs+TvnkG8jX4qlU9/TEe5EeymKa8IftTGzTEUV4Yk=;
        fh=Xn0sgGT6BSlYLgDdgoUCPoWzwK4IaeC3IKdjtDjdmW8=;
        b=iodNb6/e+3ydttMWxMCyqOtkIzd7Wv068sh+RJ4DFXiY1apsBS5TJ+eMOVrzC6TZVX
         QJDvAsh0EGNUrQcP+nXXZOPbYMTNoaZ0pDzFe8fDxowEVOyTQMwRoMJ7yJA7mOmdvmLi
         6YPOM7FjXQc5d0ypd81uIVKCK1oEoN0zXWKgqxBXqpDPfZH7RR6EQdgTOEU9RStr9y/g
         ACaRK2iwBvWDD/joKQZNL1hw1ykmIy4nXN+ssOewQwSP98WE8SbfQ3efa4jH0EZvAAwj
         2M5S4ez+jh3lKQIlqNVwC2P6M+GxB1OP9NT/QwVUKE3owHRFL89K9GjGLzvdNqQTbdTy
         crXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788831290; x=1789436090; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YQzs+TvnkG8jX4qlU9/TEe5EeymKa8IftTGzTEUV4Yk=;
        b=DymFgwAOtJUFGZt5lu1Tshdi/d8zDIHmuinpeTQTNgWV0ex6voSVJR9OID1gJb8Y7m
         pcMFQ2d6JRyJJ/jIKuxmiT6A5x4sJpz0/1DDroDqCROFVYLApkyutPOJzm0AbECRKQ3e
         TgSdtFxORfU3kSpIn7tMFqtP4puzKQUM3Mk8cCYHa9dhvQ8FTKbyo9q1euOqd3UFlfL6
         83F3tGuaE/trAXkb5dSe7fQySehyEFGoTgFJD6V9sSTQZf9+yDuR3pGjbIOxf9Js87K/
         lP3NpB1LimQgUQBFafZSEOky2bs67jzN9b/dSlChv/3QLQJo4rf4/CW/b4tkg2V9uscP
         rVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788831290; x=1789436090;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YQzs+TvnkG8jX4qlU9/TEe5EeymKa8IftTGzTEUV4Yk=;
        b=EKiSuN6a5CdxRBuczRKTG48+F8K6EX2bjTHactiycsQ/FyuY1NcyfXI/duR0a+hmp1
         bkXzAgEOujGxIAJK4a/QBkPWSU1shpREMDhUOV7r1/QoZcKV6RDOUcr0CZ0U2mygifYY
         xZWCSIShbtKCHQwCFY5YxyGfujcKjlRleAJDGqE/day+OBCduZYUIPEg1xo8KurF5lI8
         g+WFW2Einft/zGLsFdSlE6szqj2wZsKi7orblQdHyxGPqFpQWZTR3wbw3TGo6PKbvMMx
         iKqZSjGtqWAd3tJaTiBWvuKk9Iq5sk0OlPx7Vkjh7+3i4ZJiPHsfbvNfNUbOZ+EbbNkN
         4S3w==
X-Forwarded-Encrypted: i=1; AKwUvBxBPifc01ezQ8QvvHiY4I1r0azK5n+uLKkxFoqdbZOFexG2YyqfkTXEr11e+7WoolGT+8LxmBhtgw==@vger.kernel.org
X-Gm-Message-State: AFuF++lI4aFGm5FmX7hvRKrPudMafz62cB8OieYDwgkzzAset4uhTTMT
	xoH7G7SnntVw4tfejX+6N0C4qMuu1p8vPbCEWhfJpdJC0fEcjRPPPO73+U3UnmdO3H5DVA2IQZB
	x3yrsMR771w8hUFQYLqR0OzyVIyLejlTq/VTezbJQ
X-Gm-Gg: AYBFou2Fm28bbo9Y6Jjhq+TIWjyGR/TJoI6z/C3bMxS9CFLynLveM2n5/v3eeFt856O
	bK8BxPRHdaMLz1Hb071ioYPtHfAB36Um2rAI64t5rTlnJ/0u/Ndd6IxM2OdpM7GpgcXMWrnyzPi
	is4YGWGXERoGy6uyBLgamVvbjKacbaUO1ERhdOWOH0rutbgKF68c8mhVHeEAUx16b13gXTPkfGB
	2DzZpoa+3HNCkEue6xCUmrI0Mn2bQS3Os3PNDdSG8zyVqloWnn9Ey7wBHqC3P85kCUB0wT2oqBR
	VUNCqpRYwOjpAvZB3BWRrZB1Xlo4lUR29lxG9rKMq8uOvfP6pdl2PhHfTKwnkiOT+36sOsvR2/4
	=
X-Received: by 2002:ac8:5752:0:b0:530:5120:19da with SMTP id
 d75a77b69052e-53065d62b52mr36529551cf.2.1788831289919; Mon, 07 Sep 2026
 18:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907192140.2701755-1-beanhuo@iokpp.de>
In-Reply-To: <20260907192140.2701755-1-beanhuo@iokpp.de>
From: Stanley Jhu <stanleyjhu@google.com>
Date: Tue, 8 Sep 2026 09:34:12 +0800
X-Gm-Features: AcwNN1Xobqe2_angS2HD3JLnQDpNBy1jGEuPGetaKk41wua1zBXLIX34Pe_T310
Message-ID: <CAE14pddo4ecRZLZs7XmuHtUhhcPnPphbn_AgJ-yZyzMGq=QjRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] devfreq: check the get_cur_freq() return value and
 use it in ufshcd
To: Bean Huo <beanhuo@iokpp.de>, linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	"Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Avri Altman <avri.altman@sandisk.com>, Bart Van Assche <bvanassche@acm.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Sep 2026 21:21:36 +0200, Bean Huo wrote:
> Changes since v1:
> - New patch 3, so that target_freq and devfreq's previous_freq are not 0
>   at boot (suggested by Stanley Jhu).
> - Patch 4: drop the !cur_freq check, it cannot happen any more.

Thanks for addressing the initial frequency desync in v2.

For the series:
Reviewed-by: Stanley Jhu <stanleyjhu@google.com>
