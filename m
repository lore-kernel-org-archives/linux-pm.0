Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C274D9914
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618535; cv=none; b=QlZDuRqh0kEW5lgC1tI1T1rsEfFUKftfUB5CmjiIO9Me/kzYV+Yw/Y1t/DMfmE3viOQndz7m5E8aiP1uhtBbJv4s5lxfNTfSqUw5CJkyjkjOspJIDnLGIBEO2VxcT1KNLxvC+5CHqnzlMpKxR8Q4pT1c4z2CcjE6W96wQthp0NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618535; c=relaxed/simple;
	bh=lsP6huJ9ct03Z1zKO/sCXP1Yr6xrLwhLc0mSXcIgtsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVT5Y+l6SX6c+eJQ4bnIilKgUg4DzZ3WFcI8IsYalqcigLG2FMW02Eo4IrGkSBIWSXgw58UbEpydL18NRjcrRVRHrrI1cab4S13n3NB00mJU1kvMkersJuRFY+p0uztAQCqZzF4g7h6PInfFycN9iBIQm5v6Q8P1XCixYU+KxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIIEumld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIIEumld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74781F00ADB
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618532;
	bh=hoLMINlV3QqsEhjkSKeIdqYNPL53JDMS7s0+KJ+FeeU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mIIEumldZR6U8Vsyv4uN8iTJ9ynjNG5mE+fXNsti76WpUMH0GHVCrajUR2B8tWP18
	 +YmlR3JZcgl+QesapPEsAJo8jBtRXwQmGlQrZR1Eg0OpTbDGRpbchBJH3jASgL8aeZ
	 1c7BHlV3rBiKYTzP+YdqSYlG99mXe6jrQHtEjujE6WauG1K3k3Zmsz6/DA/4YGQZs8
	 QMpVaQfy1KNwnxSy3fYB0pMTbtvsf96GOdZ5QaFzHoYG52HbiF8OWPeYZIDzQLwLgq
	 wsDt56MqteZPeqUZmEWeqJKLd2CJmLpyXZekYDv8FwHcqr9Ku4GOSEpFkIaz97jChs
	 9n4FinlkBnh8g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c94fccfa8so119221fa.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 10:35:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpTxD6+bGDk9yxEMsH9ID3er/OKdkTSiQ98P81/6ADibExPPz4a0iIGLK6adCLmEdec+3SIUe2a0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZYxfYAA8tFROM32Cu9osArbJCmWCYyx0nUEu1KiLUMIycql39
	WiBouLIxw3iQDGapgi/mQ9AZys3nAsYKx/9VI0YOEvVsT0JEz3Gr6CJ4clnh4lSDU7fcN8kgAno
	nf2HvqH91wm1xTG8s2CZVFZXzciqiQN8=
X-Received: by 2002:ac2:5984:0:b0:5ae:b9b3:8ba8 with SMTP id
 2adb3069b0e04-5b011477c4emr1214774e87.57.1783618530978; Thu, 09 Jul 2026
 10:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
 <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-1-92feb5a7b926@oss.qualcomm.com>
 <ae915278-2f21-4bd0-8651-d2e02ac04aae@sirena.org.uk>
In-Reply-To: <ae915278-2f21-4bd0-8651-d2e02ac04aae@sirena.org.uk>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 9 Jul 2026 19:35:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ga8qqYg79+hQVtO8T=FOCj8XLmTz3HpEKoOykV_K-HSQ@mail.gmail.com>
X-Gm-Features: AUfX_mxSopoNn7_P9sl3mlA1rhOj4sbv78uOl9S8bWEr1uQf2zt3I7w-icfoGgs
Message-ID: <CAJZ5v0ga8qqYg79+hQVtO8T=FOCj8XLmTz3HpEKoOykV_K-HSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM: runtime: Only set runtime_error on suspend
 callback failures
To: Mark Brown <broonie@kernel.org>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>, Stephen Boyd <swboyd@chromium.org>, 
	Girish Mahadevan <girishm@codeaurora.org>, Alok Chauhan <alokc@codeaurora.org>, 
	bjorn.andersson@oss.qualcomm.com, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, aniket.randive@oss.qualcomm.com, 
	chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 6:35=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Mon, Jul 06, 2026 at 02:23:09PM +0530, Praveen Talari wrote:
> > When a runtime resume callback returns an error, rpm_callback() sets
> > power.runtime_error on the device.  This causes all subsequent calls to
> > rpm_resume() to return -EINVAL immediately at the top of the function
> > without invoking the callback again, making the failure permanent until
> > runtime PM is explicitly re-initialized.
> >
> > Unlike suspend failures, resume failures should be retryable.  If a
> > device's resume callback fails, there is no reason to permanently block
> > future resume attempts on that device and all of its consumers.
>
> runtime_pm.rst still says
>
>   * If the resume callback returns an error code, the PM core regards thi=
s as a
>     fatal error and will refuse to run the helper functions described in =
Section
>     4 for the device, until its status is directly set to either 'active'=
, or
>     'suspended' (by means of special helper functions provided by the PM =
core
>     for this purpose).
>
> which needs an update now?

Yeah, it would be good to update this one.

That can be done in a separate patch though as far as I'm concerned.
