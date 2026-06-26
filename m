Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472803BB682
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782505915; cv=none; b=Owcpqr8vyniOoUgP9/qLtrDOdq7+T43Njnw3b1mqpBnbvcZ0DlqmdtzNQQVjoOugWGvtHVKtuSpCDPUFpQOn/aS2CjxeWuusgFlCBurlfv02vhYk/ZyAZOlyBQklSAXrQQJ6xDu5wFLYPsn7+9ppCR/pp/GF6ZpNh4MQEtaBubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782505915; c=relaxed/simple;
	bh=nZYsBrhmQesky+duTw28oI6HX6hYlSNQo3RecstP7BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rv517s74BYAzszKIkLj7A+VL1GXdMZ7k+2VsrU0KdsqtvuQJl157X70xF8Dfnt1Ct7ZuhtfU1D1pmNu6Tju066VVHJI7NYS9nR1SLxQdDGIqpB8r2oMQM5CvGpkxvcMRGOh0nMjJmLbbCEuaOGXxu/FsY+JANZ0ZsMVdEZProRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DJzfkiWG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DJzfkiWG"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37dedd62b90so901669a91.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1782505913; x=1783110713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MQEizdZJqfwhrqcgsnjIRIwjSErEYCfch5iAelPHGlE=;
        b=DJzfkiWGNZMnhIdOqnHfbkNdap71L/WgezeN14Vcl66dZogmnBWByUh5z33cn9wsjb
         kzURXxvQXlVPdQgvJDawMg4osUV/qruG6aqqH8OaIXucNHVEFdxF3RjRtIXHLt/8/XKp
         JfQ15xkI8FWVYX8HbiBHySwuwdUgg/K5oEHUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782505913; x=1783110713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQEizdZJqfwhrqcgsnjIRIwjSErEYCfch5iAelPHGlE=;
        b=WyhHRLwXpSb8PfaEuBRsObYP1B4aAktdspURC+U+XWdZlCE9w1twx9RGkI+zvRHO5p
         leZr4j3MQ222Z+uJ7IA3zrTcZSEFdvNsxrycjZ5mULsSJiSmD05CtPXko076+tSHPuY1
         Vi0XMjvsnVTWVgly6cPmzdCDd9JK5TJ4g7tagmFeJEgjQqRgDXk48dw8eeUz3FThphaY
         2iVj0ru3zyGwjyprK/a17bPJbvBhdcs2Hl8KlygrLAoB/RVPhnizys1/6tpaPn/RmJoW
         InjSffztUSRPytJEGXXpF8MZRkjXJpf0jSPpDBFS64DhEbHYXERp4LKHHgcHFZZNVvrm
         pZow==
X-Forwarded-Encrypted: i=1; AHgh+Rph9HLxR3ZyU1US5ugZih+LrazptE3bnGRGUeu80jEt8qujiTchDm1S/6HursK9YjlLGSmD8up7TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxobuXUv0pmAOBi9jWXrWvhxpVq4eQGvqhCC1aOij+9SCzhmt8b
	FA9bk1Vk8HNs/cxQiNWLlNfaylaMdvPfa6lU7YH9rVFkm/PkQ1Y4WxxNjPWT/wDTsy3Uy8NNJKb
	ZxM4D
X-Gm-Gg: AfdE7cmhIYANLOrXo8MnSgoYa5NTfm2RpUJa/Kgi0nDkXscTd8Eurl3KAOW/BAf8T3w
	AS6L/8kY/Ha/wuIM5pToBtKfIypXi9UO2X5E0x5YpNx9W7/QYn/wPJmvGwEIFLAL/YZTDUfVlVG
	NN5+zpFScTYm33PBkXQZ52pcvP/g8rP+NbadKnCsFbxgVkkFn6m2zlOQVXDusTJx9IEgckhOKaH
	X+3a1qhO3Ew92hmg5GFh+7moQXgrhI7HKJtAP7bYX627875Le7Di32aCaSyDyde8itk6LYSK+o4
	+tVYh2F/RfPHMYihwNye/zN4yXyfxdS/Rt3ZsNingCHWmhrPJm1gnlp8KgOxMVbFMxgW2CR4FqM
	Qt+K708gz7WBm8BNDulxJNvLwZU+Cp+WbHIqy8ZaP7vt9+QMRYeiQaKiS+DhcFiZbvYpz2N64S0
	+2sWHVtu+vZunyhBGi4PA022Q7Ph/2nQ7abWJgVhGUixtg13uTt3vNC+Ghm59Box3YPw==
X-Received: by 2002:a17:90b:2f87:b0:35f:b9f1:fded with SMTP id 98e67ed59e1d1-37df9163af0mr6037282a91.12.1782505913283;
        Fri, 26 Jun 2026 13:31:53 -0700 (PDT)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com. [209.85.210.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df39dc8a9sm4441913a91.1.2026.06.26.13.31.52
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 13:31:52 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8422f395a4aso851411b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 13:31:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/e5P8msP6tF+O5yWSilSw3fXwHsrNkgs7DVyhe7NBXnXfQJo2/DhisfY5Eagqw6rbSkuP9cUCcFw==@vger.kernel.org
X-Received: by 2002:a05:6a00:1daa:b0:81f:5acb:55fc with SMTP id
 d2e1a72fcca58-845b42dfcf0mr6772578b3a.10.1782505912059; Fri, 26 Jun 2026
 13:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0juZ6YJVALVEi1s_O0qgcr_o880TJbRHXWsd-Drb-sUXQ@mail.gmail.com>
 <CAHk-=wjS6CuKne+v6t3J=ppXTJj7dwRE0FiuXjT_O_wBiW0yVw@mail.gmail.com>
In-Reply-To: <CAHk-=wjS6CuKne+v6t3J=ppXTJj7dwRE0FiuXjT_O_wBiW0yVw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jun 2026 13:31:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZi-oiX3_eFCLVWRk-LDQF--NHtwks0GYaUsuLnNM8Qw@mail.gmail.com>
X-Gm-Features: AVVi8Cd80J3LDiO4w3Ru44VP1Wu1Xj8zp4FzZXuERUV9kLLmJhLujIVfzKlBvXY
Message-ID: <CAHk-=whZi-oiX3_eFCLVWRk-LDQF--NHtwks0GYaUsuLnNM8Qw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI support fixes and cleanups for 7.2-rc1
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jun 2026 at 13:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> How about just adding a trivial strncpy_pad() to
> <acpi/platform/acenv.h> or something. A place that already knows about
> the whole "I'm building the app side" now.

Actually, isn't this what tools/power/acpi/common/ are supposed to deal with?

IOW, maybe just add a "strncpy_pad()" implementation there?

(I'm not very cognizant of how this build is supposed to be done, soo..)

            Linus
