Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0363264E7
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364431; cv=none; b=fu7QMBC+kTT9T2D9EK/w+QabP6rB9xwGOiAuwTJiVJjS4bEmlTSoyh139VlijBBGlUqY3I4TMyGShEwd4ju6Xri4LbXxD0CmqwwKNQl0/DOgyQBwCTkJ0jXr/fZDTJLyx9Lmkt2rsDqrkEksVEUPZiI3h1BsaFbec1Km6cryKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364431; c=relaxed/simple;
	bh=kTJR19SoEdh1czg8JlSshnD3uDyzbyIuGTHfMdpoGEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3Q0Nz+91SzDSH/QmKBJOlgwbt4tXYW4+XnFfcgCYejg6B/OQkYmxKUesH5EdASCPt8xmgbBN8ihuG5HyO+1EB5DpA3lMg/JZYXmscIjdJuh7OdDBv8Z0vtvkJI6PilP+Of1V3uLwf1PngAoXs2GCnH4mW8QA10BG1Sv+gQSOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfSJ3sPA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfSJ3sPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D7E1F00A3F
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 19:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783364421;
	bh=D9Z1H0bgUiWiN9spnbgMkMfWfZ4P3cTWthhmlBsSR78=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MfSJ3sPAlWx3MEXmGmGd57V3MjhhTccMYLHPBHetuJaNuzJMPa/SUA8rcQ/OBxYQ3
	 FmD/jOxC684OGia7aoM8PRMuo/aazsDXygi6ETDWesxIXQ54afpkzv8WoxpLczj+zz
	 8e6IJ0AvMENUH+sJW9z7xMtHoDThqMy8mW+gqMgTmaMO52uJmcEdLsqM6+gyBXp5H4
	 QuxDc72xGd1AZIfJAnEKeGdx8mfex7YNfM2dV5SX6zbuwI7IfibS4X9EKzCnA/D7Qz
	 gm02DYqnt8twfzDWDTeem08Ty8YuYh3uAlsD32fa3N1Qjra5Ol6DsflBths+nUNzTt
	 KICDsmn4wWvGw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aebf120839so170780e87.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 12:00:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpMMPELQbPlpcgvg5/U1OdT1QEVWAaSIaKK+giNU+aLrEZt1r0wBc9yncDt6yelv31NLyRqu2rZng==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbbOs5LGWEhTCM/zDnFL3zqQB8GI4MybJJpEOYt9qtttaFwQLu
	MSRY3YbhCT65DLGx36c5eu5BSlNZOf7yW/WXPVVVt5Mo/kAXh+PZdfHj7kB9x5i9LRO1DYS7/ah
	mzWYQ3KeqWl2FtSXPC7pZXIrajSwg4oY=
X-Received: by 2002:a05:6512:605:20b0:5ae:a787:4cb1 with SMTP id
 2adb3069b0e04-5aecf506d04mr2037074e87.22.1783364419779; Mon, 06 Jul 2026
 12:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624053839.2150567-1-tuhaowen@uniontech.com>
In-Reply-To: <20260624053839.2150567-1-tuhaowen@uniontech.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 6 Jul 2026 21:00:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j7voqyiPp8xoAOnZ2YsTt3s0ycX=oJKqUbJKH75z9eFQ@mail.gmail.com>
X-Gm-Features: AVVi8CcvrT5-XBRI_eXq4ZRX-YdsIPSEtvBNF9wUM8ffpbBMT31pZI22sPIwTDA
Message-ID: <CAJZ5v0j7voqyiPp8xoAOnZ2YsTt3s0ycX=oJKqUbJKH75z9eFQ@mail.gmail.com>
Subject: Re: [PATCH] PM: wakelocks: Fix off-by-one in wakeup source limit
To: Haowen Tu <tuhaowen@uniontech.com>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 7:39=E2=80=AFAM Haowen Tu <tuhaowen@uniontech.com> =
wrote:
>
> CONFIG_PM_WAKELOCKS_LIMIT is documented as the maximum number of
> user-space wakeup sources. However, the limit check is performed before
> the counter is incremented and only rejects new wakeup sources when the
> current number is greater than the limit. This allows one extra wakeup
> source to be created.
>
> Reject new wakeup sources once the counter has reached the limit.
>
> Fixes: b86ff9820fd5 ("PM / Sleep: Add user space interface for manipulati=
ng wakeup sources, v3")
> Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
> ---
>  kernel/power/wakelock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
> index fd763da06a87..a8b6bd5ec46b 100644
> --- a/kernel/power/wakelock.c
> +++ b/kernel/power/wakelock.c
> @@ -63,7 +63,7 @@ static unsigned int number_of_wakelocks;
>
>  static inline bool wakelocks_limit_exceeded(void)
>  {
> -       return number_of_wakelocks > CONFIG_PM_WAKELOCKS_LIMIT;
> +       return number_of_wakelocks >=3D CONFIG_PM_WAKELOCKS_LIMIT;
>  }
>
>  static inline void increment_wakelocks_number(void)
> --

Applied as 7.3 material, thanks!
