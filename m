Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70087374197
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202403; cv=none; b=WkvY2M3fWz1FNOgHl2nxaNoGEtqpy2M/h76wVM2NvKD5k3qIytxYwAOgtoFcz6lYtHLSBQrAcPm5YQrYbI7U/tQ3XpF2FsFocToNpbu2vuPfND4UMDdrXyfq7gkFc1LL9AmAQLcvX6PnIcJvJ8QjOLReuUgL+wnT4rmW/iSPELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202403; c=relaxed/simple;
	bh=P3zkQ6XgzYgXsHEgx6qPcSJ5cAhQqGRNFMvwsdKupso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uj7P+cREIqPFZTkOyNCpxTEfDy8ANzMlr0aK2JFm5YB+5ZJuSyvQ4r1fLA+tARHwvZUFmGJsUqC5l1NKHn5li4R1ykuUr7UAJ7PVXMMxCHWVser4NC3iI0UMOnMqqzIiOzRXKpWZ6l3YzBC6tXBrAXJdWziwfjSqmBNCDoqGsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i22zbFRS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i22zbFRS"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c074ac8adaaso641345866b.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 01:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782202401; x=1782807201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+TIRRzOP5f40W2P6qE1IkeX7ZWgsBW+lVzgic3aztgQ=;
        b=i22zbFRSMinIKPpuirPi7VtkkK/YWHu2wKZ+3LfqeTQcjvKaBzvHWCGNqkt9suuR4p
         XjGi9OAyJbl+XyBpK7ttMW9d8RJ9LbC16684e10dSCebfj16ULGca7RuGplIJ/TS94Zb
         YNuyqL2ju/Z3fudyTq+M5sW6LfRvR4R63E8p+NP0RVsaQErBCoZcJ8evJ2raTCmfx0N4
         2trMDSkl4g9LHS2gcyVzMOOmfxibxy5fSzdbyCuT6ggTHwKmKsYZHwm6A6OiMNTvPN+U
         VkV7d8362IYGLq7PM7TFmQ0y+2QnRJXlkJ3Twk/lGyGg741iy9Q8dGw3OAVm2IlTfTOw
         Z+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782202401; x=1782807201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TIRRzOP5f40W2P6qE1IkeX7ZWgsBW+lVzgic3aztgQ=;
        b=b+tmlgiJG8hZv7xC0EcenARkdqy3h+IbHHa75wbFVpHIYiHedZyfXBQyogKNdT35gl
         lp1oq1td7a2rgNBJ8FeNJNLJQ3PI3FXU+/99XKS80a2MFCuB4Mbv9SPkNlH2avUUMdmi
         fPviLy8+ohGWhFDX14j9uuhnFQSyaqFc0vcV7s/sFeMH9/+W7NzV4QyUngIF4blrfUoG
         FHhL1q5n6FIEQR07hN7pYvGjhsdHh5WtRb7URen9q/3vMWv3a6VTtK6pMd47mzgmkEQ5
         3AB5d49MkWfjaL+JUo+KX/HNdH04Hzr+qtXJuhlR7jThL6XURpIfvz1sGHHSjUE949hO
         arnw==
X-Forwarded-Encrypted: i=1; AFNElJ+2ngYlVQObVR5XrgSjxl+fnmqyI1IQLJre37a2fDYtOqUBjMzHWnBUJHBJls7QCiF609XuoBPOnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyE8XdcYMZ9BCM+Q6XZylY7J8jA1uPABM38+JRtMIjQkrBt9pZs
	3dazcyX0rgax9c9rGra5J3XztKRUFZhswK3LLjkKhJGCO0OmDTwxsp4LJ2FbEg==
X-Gm-Gg: AfdE7cmtr9Bsjqx6E1LITvmwQVgeULneIWyIRqdh864oO8HbD/XmBMrx3JqpkyVghOH
	/5/+hrDO0kquXA0JshkfsLUWp29Lb7yU6rsVxjORNID0XcUjFX6I+Gp6Ohwom+aPcQxmVpn0RFa
	YTGexIdE99B9WmyN73OLmmzXIvMhQYK5RppoNUqX/dv8iEygOMeFR+8PMcACBh12jZm34h0gT1M
	8XGDSTjWawf2CmGHWbHaeaLNks26xqjIj0MzmNrLp53UEm3EI9alyUOUm+mCGzBPY4QtdVW21op
	+uFOSayu3AE4LhUy0z1lftGbCQfOLiDM9/YAQXBlR9voQnXNLMPjDin26lvOTAQFRG5DNpv5Ntw
	KmEVG19FZMyI+9dWTZ5Bs9c4O4+zOHCmbjnLgyM8opKLL2M98/1Pu/ahs23FwLPzzm92ekAv7gV
	i9a05DRoQT
X-Received: by 2002:a17:907:78e:b0:bb8:b593:edba with SMTP id a640c23a62f3a-c097ccc02eemr928113566b.38.1782202400801;
        Tue, 23 Jun 2026 01:13:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c610e12f6sm487614366b.47.2026.06.23.01.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:13:19 -0700 (PDT)
Date: Tue, 23 Jun 2026 11:13:16 +0300
From: Dan Carpenter <error27@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: Re: [PATCH] thermal/drivers/rcar: add error checking in probe()
Message-ID: <ajpAHMPdR3ty-N-n@stanley.mountain>
References: <ajo6iQ3VWvcxedA9@stanley.mountain>
 <CAMuHMdUXkXCj7ijeQmOkK7OQSAGkYgBZJyMJoEV4i_XhamwDSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUXkXCj7ijeQmOkK7OQSAGkYgBZJyMJoEV4i_XhamwDSQ@mail.gmail.com>

Yeah, thanks Geert.  You're right.  I'll resend.

regards,
dan carpenter

