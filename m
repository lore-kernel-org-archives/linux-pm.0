Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CFA40683F
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944650; cv=pass; b=eH1dTJM0JbKNwWdfvFA2Qjj7TWDrNlZ8Jb8Xq0WPeghZxzijUwacgkTV2KzmLK921BDnzVKCN92ekHBVF3z9YzJWJPkt1cdXy4ukQtWoyiX3yT01lK5CZ04nfcK5V2cQOkUPMlJT4dXmrjQtW0z3ciBhWc0nwpCZadiW/33SAy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944650; c=relaxed/simple;
	bh=qguXd1Bmb0JoPYCTB9Cy4VECjzPPKEDsS8mS+lKAv24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzFYb53yd7IdoB5uoQSuYnaSxtb0Rtsx1tLW0By9rQAwHOhSS8eRxPECgmeXRZ+9fgaQ6Nj59G/rBBPu19MepvGcDGmOJPGUaGB6bxkr8WBut2AaZ671cKkIvt2lPM0FxrOaR8U7WLMLntNtLnz0smxO89OgSWntvzds+xiJTkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a18yvu8u; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a18yvu8u"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-667f1390f58so800573d50.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 05:10:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783944648; cv=none;
        d=google.com; s=arc-20260327;
        b=aNsvAJsXcwajzRaqhPLnjQpNdWOuZ5zhj8rPG5qM7OIT/lXskh/Cf6OYSLtSLkhWNg
         mAmnoY0aIrKq7FQ5wgS7R+UCgrq/pormqWJjeGJ0Boy/4ZD1nD0uJKcwfMyfgjpBSYe1
         II6sNJ0PvXjFGqqeGOy4Wv1VPJzeMkF7KT5r4NhLU85a+c9ziZe1J1ofw3zSElfPL0ep
         oGKFY6XhY/E03lpO0Hizqhpba32mvAU4UIuFbXRUP+5XiRH8atP0GbedrAj8/TixI8gW
         ZIpyuR67l0yqaP0vFXxjL5h8YkjHfGdvzIMetQN/yZLq++G/xIJ1H667pmKwxawJ8SGa
         fUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qguXd1Bmb0JoPYCTB9Cy4VECjzPPKEDsS8mS+lKAv24=;
        fh=oQhFGWSDEjYW6ajryZKhSXxCoiG4vbG9oOPByOmfP28=;
        b=V/V0KDXCekTUgO3vwNSMKXU6TQac+aDoQaJKn8BSXHJ0244cbw9u3kCiLPtRU6FGrN
         +qpBRpHfpnd1te45jM3AxlBfysWaRuesEhdjCbulxp3K25joz1mOVlLl60gH888+7h4p
         zPyGmCAd7O6AaWSa+Jcd/48g4SHLmuEYHoNpOch9VysnlrLa63wRzQ/m9ABYzYFySeGf
         lhhQZscx/CpyZmg6CiiCmWwu3OexkNjm3AgrJTO+KmuDPAOJ8xeE/Rs1UBxfhCOWDodt
         hU7qEz+HdN1u9PC5a8fX5tVswQ0DcaNhQpw0KrhAptqqbpD7i4SYX73YLmLNEXCrBsro
         K/UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783944648; x=1784549448; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qguXd1Bmb0JoPYCTB9Cy4VECjzPPKEDsS8mS+lKAv24=;
        b=a18yvu8uFOVU3XDo78BveS8PyS5F/eaGFhPmd0e6Pq+4DWffpRwIuCFdA0nKQSS56i
         HBRW1F3eP/ByXV+DtpF7aB837NLFz411+tXiKwAAHymYMHJzItRTP89HSdw3FvuPbPjJ
         SnLgGgN04Hc9zjICL4jfPYJoqEaqIHQ8JHYcvuNSIzdeFDIyLyE4eZpsCtTIehZkrTj2
         b6mWF1yQ+jLzatqz6F+Luk6pnN8OG5c2cpEEVTlYmML+IphMFeNTACAmz+NhhzuuosAs
         xypucSE7s0AIgfwd8O3FKmZ/THlHRpLfkRNBJFTWn9Sj+K0r+OkZEku23oGy/JGSlgCd
         25hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944648; x=1784549448;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qguXd1Bmb0JoPYCTB9Cy4VECjzPPKEDsS8mS+lKAv24=;
        b=bJAA9NC4oyLiWLyGXx7nuK7XJIUCj8a8YZvHy6IpI7lUR53S+UEmg4V+vI7+1DWx6f
         sGF6HRdkl3nYgd8vdmMWGUSnnJwjGlPwbnSD0XruvkihyZipgub/bZT1Snt+IYBRXWNT
         V66p1eALnoezhpnByYTuJ7x1MPtcEuk5pQBBtQ08a4n0TweCUQHP7Bf+hpwLtgLkUDF+
         7n7B6LGOr3IEoXfwCzYxwSS6X+JLrWxzs0jTdTQXrv1629B711rW/CIU7SxV7K2JdYgE
         3NNO1J5fIW6TDnmfNEqNlbfb0tAxuMpWmqD18wVRq88mSvOKLkMucGgITeoHPOtRmrhq
         P1dQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrr6lb8LLDBmgRVyzjKbHVNi1sbD+h1h1cK+MSD0ke/2EWWvKqHMPlx8TuBDjnxd1QXUZm5cr7Ltg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoA3l28P5Fi/909JGYw8cWiQV7M99+eWeVACKPXCrilKKAIg00
	aWWWJZIkO0eeBZKKR2xTa+ReKBDKM/BIDSgoa6tORHi2VieThEqoP8yQPHae0TZrZVmz594cFSg
	st1IS4meGSv6J5VOcx9tIXMg1rP6Dv7o=
X-Gm-Gg: AfdE7cnCqZj/waggRDXEuIKCktzN25+jzTyyaVfgXUJ5JHLcP0VoIoZF1h3xyxOJQfq
	zzJcdi8LFhT6hqvQcppV41Qsqk7/e5/TKrXYAA+/fxvpS3uf2ztrEUYmZ48vHEtlnLX9XFZfLWS
	QcPXlOwaDiaYVt/VVmEM7/AGUoXVyOyt0YcaBWJYHmB7U6bwe6etQ1OM66C0iE33DQrRj6s9Hv9
	BEGBoAJafY/gC80MoU3SL8KnfRt7Pq9MnrYxrx1IGJ6/4oqmdcVX8tF90ByAskSaF87OeQuO80=
X-Received: by 2002:a05:690e:1555:20b0:667:8b90:2e55 with SMTP id
 956f58d0204a3-667d7ee139dmr4779810d50.97.1783944648180; Mon, 13 Jul 2026
 05:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705103256.284467-1-lgs201920130244@gmail.com> <20260706-dashing-dazzling-sambar-453a4d@sudeepholla>
In-Reply-To: <20260706-dashing-dazzling-sambar-453a4d@sudeepholla>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 13 Jul 2026 20:10:37 +0800
X-Gm-Features: AUfX_mwaflEwq5O1c14YKWIRx5LpcE_68yYNnGKkNrsplECeT8LOM8_s9_IYQRI
Message-ID: <CANUHTR9ed+A5OJLX802LZieSvp-m=pQQww4Y4F=7VcEO5PPN1w@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: scmi: Check pm_genpd_init() in probe
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>, Ulf Hansson <ulfh@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sudeep,

Thanks for the explanation.

On Mon, 6 Jul 2026 at 17:34, Sudeep Holla <sudeep.holla@kernel.org> wrote:
>
> On Sun, Jul 05, 2026 at 06:32:56PM +0800, Guangshuo Li wrote:
> > scmi_pm_domain_probe() stores each domain in the onecell domains array
> > after calling pm_genpd_init(), but it ignores the return value from
> > pm_genpd_init().
> >
> > If pm_genpd_init() fails, the genpd has not been added to the global
> > genpd list. The probe code nevertheless stores the genpd pointer in the
> > domains array. A later provider registration failure then unwinds the
> > array with pm_genpd_remove(), which can try to remove a genpd that was
> > never registered.
> >
> > Check the return value from pm_genpd_init() and only store successfully
> > initialized domains in the onecell array. On failure, unwind the domains
> > that were already initialized.
> >
>
> It was done that way intentionally IIRC. We don't want to remove all the
> power domains if some not so important power domains fail to initialise.
> You can log the error if that helps but removing all the domains that
> have initialised seems bit of extreme.
>
> Are you facing any issues on a real platform or is this just by code
> inspection.
>
> --
> Regards,
> Sudeep

This was found through manual code inspection and has not been reproduced
on real hardware. My concern is that a domain for which pm_genpd_init()
fails is still stored in the domains array and may later be passed to
pm_genpd_remove().

I agree that unwinding all initialized domains may be too aggressive.

Thanks,
Guangshuo
