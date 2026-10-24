Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792866144;
	b=nWbVzn0IJaW1K+doBt+/emoPj33mKNndI1RxGO6GGjiymGPHdMHFLOl2Q0rTM+vUwIZ0
	 0d9tlAEu+d5VouHl9C4rg4HPsM9V9tmQXAzbil3gfA3J0k4REYHp8WL3gakPl4Pm0uMU5
	 GiTuBnVRD8c8yRSFhor2l3cK/Xo9WixhCRmgnycDKM6c2aET7Y3LFALCwp88gih1h6n5L
	 P48COjDlwGZDFf7QpH65nDtGKOKZuHefGQhdWDm0tFCroBFTm3jswxbszwa5WzBeZoG4W
	 IdeHZIUIkNX1ChpFIYPA42bdlKLo1TzSOq+/4FnWOhGLVv5cAfM/iWgusGEYRfI2dJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792866144;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=IVn0q7dgBF+mdNkk6TlfofpK6/6nmy4BV+TyXW7P47k=;
	b=2c7Rrk/ngdQtq/kKjpCiHUj2tVV5qJP+f/c7Ai4TFeu9v+5fg3cx8OYVWQ/VCx91bftE
	 BGwJsqurKlldiJ8pi6yaVrjaflcxEOGwTnvIV22JnvsA+uHxn4+HXpWyDLH6qcgSU/Uq2
	 f0ONkjqBp1PNTiK6OA6hW3Z8Lu7j2mhX/y5JrCUUvWVPnVd8a8BeHTwdLnxFMoTNlmSaq
	 GI5xMtyoHvdO9TnUadl6F9+/5FT29ZsQaB6hLWbksJMDDWuj9+V82/NqOPijzs7uh3XKM
	 J2OJS97vuXOsjzARrA0fiUYl5Cw75Pnk5KtlATdSg1s1VoBvdyaPnMTuWtoemk3nZ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyzOwD67;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1CB606A31A
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyzOwD67
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAFA1F01829
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792866143;
	bh=IVn0q7dgBF+mdNkk6TlfofpK6/6nmy4BV+TyXW7P47k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JyzOwD67ar62q/4/Sbts5ekIPuHk/VFJ/XTB0E0dcSUdT3XWwrvABesFrHVD/cf7Z
	 UkOS0N96y65rYFepDJ6p0fuZs8bJSk4k20ij9b5bdD9//rSfTrdxlkaFhXCMdAUFz5
	 U0HvUpVffNJ+oEFERiNf2OovCIXjxXjp49Opk4G+wCE967M6eEe8n41dZA2jwJeDXW
	 wpQKrUNs8Wtpv1CqwSGwXpovmwcxRgQOcrTAS2ocIbnqji70t59+drab5HumRhgeNV
	 NrHTFi/C2F2v2orH5tueEaboVjbOAgO0WBz+WtDuGOcyhMBhvKNt5mOpTnPtuFWXIg
	 exrOuFawdDKig==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6ac76a02368so2337495a12.2
        for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 11:22:23 -0700 (PDT)
X-Gm-Message-State: AFq9FYK3caiyvaRopajiW30uiPWAPL8Iubj5+vHnjQztrUN5SopEsQbm
	YJtwqDDDSjb5yONpae6t9TMBIxaJykvqz+JbkEXywUtghBEo1PZbbKxdeLqYJvCXNkBzS3Vs+nk
	rHUpL5DQRY23o9i2LrN+mly42GzCfgq0=
X-Received: by 2002:a05:6402:501f:b0:6b3:f05e:fd5e with SMTP id
 4fb4d7f45d1cf-6b44300d562mr3204282a12.33.1792866142730; Sat, 24 Oct 2026
 11:22:22 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <a6aebf7e2c69130fd8be86c8dd763abad28d5d7b.1792428130.git.len.brown@intel.com> <atjlQe1C-xU9fYuG@ashevche-desk.local>
In-Reply-To: <atjlQe1C-xU9fYuG@ashevche-desk.local>
From: Len Brown <lenb@kernel.org>
Date: Sat, 24 Oct 2026 14:22:08 -0400
X-Gmail-Original-Message-ID: <CAJvTdKkQQq5=TMGYypV8wAb+TPwH9CSJxJ_rF49E8KUt48ogww@mail.gmail.com>
X-Gm-Features: AclHuK8RjCzkAK1ut3JZFnbPR3RA9628whfjS0Vml2z65icRdTS_1E14HSWApJQ
Message-ID: <CAJvTdKkQQq5=TMGYypV8wAb+TPwH9CSJxJ_rF49E8KUt48ogww@mail.gmail.com>
Subject: Re: [PATCH 10/18] x86_energy_perf_policy: Cleanup: Define BCLK_MHZ
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 12:16=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:

> #define KHZ_PER_MHZ     1000

sure.

> Also not sure why not define it directly in KHz?

The origin of this tool is that you can actually use it to manage HWP
even if Linux has no cpufreq sub-system (cpufreq.off=3D1)
And so its user interface took frequency in 100MHz ratio, to reflect
the hardware units.

Then people wanted to use it with cpufreq enabled, and cpufreq has Khz in s=
ysfs.
Then we had to deal with not scribbling on MSRs behind sysfs/driver's
back, else risk confusing a driver.
Then hybrid was invented and HWP.REQ was defined to be performance
that is not necessarily 100MHz units -- and for that we need
sysfs/intel_pstate to translate...

Len Brown, Intel Open Source Technology Center
