Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CF48122D
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997169; cv=none; b=JLRyS0BZv+jeHN9Q4rE0DxaEk4WoMvI2gZTgb/0yyknuONyLqFH31NKG6dyBbDaTz/ebdoodSRLWfWEBh6mDYRwME0vOmfvBw7jUAkC+AK2cxXS94IEWGhn5tLqWrfy6uAxtUEfLn520Eg1A7SQSEKp64wfVEH1O/6CVs35hspg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997169; c=relaxed/simple;
	bh=uUKDkqlNCglYPmuMqaEVfRyX46iCIZHXBkJAj3Zz+ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOd1AEzbgvh7rIfHiogBjSvrFYINbdiUG/6gPExIS2jXwoXKjc8La9gbB9A/gk/iPsK/UFgTvJCrlGeyx/bVzheufgg93zwhPwnUgxqjwTKTQTmS9n5JchIkvkKfvajBILbBRVoEuFM39nbQyo/S6dZhGNhzdLRzMVsU8gGLxyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjDbmUPo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjDbmUPo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8111F00ACF
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782997168;
	bh=fjPgbB2H3M05UY5za1DjwijyWrPVl+qvmy/SwWaWVlQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CjDbmUPosDXkDQ0gaFgP9Td33t/PSi2SD3nxJftGeXxNW8RiJElNKqlcqDz46EVH6
	 D91vh4elkYdGmayHmXno/bAWFv9D8kusroSMCzAPxpT1bAqPlAhdE0mrCSe3KGXx62
	 SM5oB96oAD46KuID2u8ctCawRy3OF23yfsJU3++1+n5JkqbaV9QJMIqDrWiCZof3d8
	 m391bmJ3NI0h0naSydbb7eJ30wOYunjB8B6+DMzJDV66gtUoISpDDg0dcsKGi4exZM
	 bwWNmjyTWcyHhZLJbhj38P5yCNkbymKttYI8psEb+EKlVD2rajbcmNoS+donyYWaaM
	 oPzrSk+nWJdmw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aebf162770so472892e87.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 05:59:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrGsQWkX11ZXVcDBRJeujpgVatZZqnRaGR5hhkb7W9CB7iGPanckjJ/aYHVYAhZJFUtNXiBrF7dNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCnhr3bNXsqjARbbGkUcd7b6AXJrtbHOBqLHo8Cml+T2KbxI9e
	hi1lolQSYD0bldu00vJfCPkvUAo4C5B6ahnpKzNUyRXYuiZ0PPLHAjuIKBL0CBzm+Id1nJsR/6F
	SOOF9VXChCQLAnljgGSsSYrVK9pCvHZY=
X-Received: by 2002:a05:6512:2310:b0:5ae:b686:d9d8 with SMTP id
 2adb3069b0e04-5aebf967210mr2544930e87.9.1782997166443; Thu, 02 Jul 2026
 05:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com>
 <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-1-6ddc317011c0@oss.qualcomm.com>
 <CAJZ5v0g6iRNUAKtDNKWa-_pshmnSCdStenNBJ91Xt=PSrhx=aQ@mail.gmail.com> <04b67f29-2afe-4c72-8c9b-bbde56f27a83@oss.qualcomm.com>
In-Reply-To: <04b67f29-2afe-4c72-8c9b-bbde56f27a83@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 2 Jul 2026 14:59:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hc5yYphPjtF8kNBTPaTaVDxq4Fdb=DRuQ953EAo-CMqQ@mail.gmail.com>
X-Gm-Features: AVVi8CcLlsfEYaX75GZe8RjqszCs33_BhtDCHTaBpZCGdeHCkGSnOhwt3W2pLYY
Message-ID: <CAJZ5v0hc5yYphPjtF8kNBTPaTaVDxq4Fdb=DRuQ953EAo-CMqQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] PM: runtime: Clear runtime_error on supplier after
 failed get_sync
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Dilip Kota <dkota@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>, 
	Girish Mahadevan <girishm@codeaurora.org>, Alok Chauhan <alokc@codeaurora.org>, 
	bjorn.andersson@oss.qualcomm.com, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Douglas Anderson <dianders@chromium.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, aniket.randive@oss.qualcomm.com, 
	chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 1:53=E2=80=AFPM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> Hi Rafael,
>
> Thank you for review.
>
> On 02-07-2026 17:07, Rafael J. Wysocki (Intel) wrote:
> > On Thu, Jul 2, 2026 at 8:08=E2=80=AFAM Praveen Talari
> > <praveen.talari@oss.qualcomm.com> wrote:
> >> When pm_runtime_get_sync() fails for a supplier device in
> >> rpm_get_suppliers(), the supplier's power.runtime_error field is left
> >> set. This causes any subsequent rpm_resume() call on that supplier to
> >> immediately return -EINVAL at the top of the function without
> >> attempting an actual resume, making the failure permanent until
> >> runtime PM is explicitly re-enabled.
> >>
> >> Fix this by calling pm_runtime_set_suspended() on the supplier after
> >> pm_runtime_put_noidle() in the error path. This clears runtime_error
> >> and resets the runtime PM status to RPM_SUSPENDED, allowing the next
> >> consumer resume attempt to retry the supplier resume normally.
> >>
> >> Change-Id: Id5067d09caca464f663fc95fe745d037e9c56664
> >> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> >> ---
> >>   drivers/base/power/runtime.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime=
.c
> >> index 335288e8b5b3..9811d024d140 100644
> >> --- a/drivers/base/power/runtime.c
> >> +++ b/drivers/base/power/runtime.c
> >> @@ -309,6 +309,7 @@ static int rpm_get_suppliers(struct device *dev)
> >>                  /* Ignore suppliers with disabled runtime PM. */
> >>                  if (retval < 0 && retval !=3D -EACCES) {
> >>                          pm_runtime_put_noidle(link->supplier);
> >> +                       pm_runtime_set_suspended(link->supplier);
> >>                          return retval;
> >>                  }
> >>                  refcount_inc(&link->rpm_active);
> >>
> >> --
> > I don't think that this is the way to go here.
> >
> > Can you please say some more about the specific scenario in which this
> > happens and explain why it is OK to effectively discard runtime PM
> > errors occurring when suppliers are handled?
>
> This was observed with a consumer device whose supplier's
> ->runtime_resume callback returns an error (e.g., a transient failure
> such as a timeout or resource unavailability).

In runtime PM, errors returned by the suspend and resume callbacks,
except for -EAGAIN and -EBUSY are not regarded as transient, which is
why they stick.

If the driver or bus type wants to signal a transient error, it should
return one of the above error codes.

That said, I can see that this is problematic on the resume side where
it may be desirable to repeat resume attempts in the hope that one of
them will succeed.

I would then consider changing the runtime PM core code so that
power.runtime_error is only set on failing attempts to suspend, but it
will not be set on failing attempts to resume.

> When that happens,
> rpm_resume() sets power.runtime_error on the supplier and returns an
> error. pm_runtime_get_sync() propagates that error up to
> rpm_get_suppliers(), which then calls pm_runtime_put_noidle() and
> returns, aborting the consumer's resume.

Right.

> The problem is that power.runtime_error remains set on the supplier. On
> the next attempt to resume the consumer, rpm_get_suppliers() calls
> pm_runtime_get_sync() on the supplier again, but rpm_resume() now
> returns -EINVAL immediately at the top-of-function runtime_error check =
=E2=80=94
> without even attempting the resume callback. The supplier is stuck
> permanently in the error state until someone explicitly calls
> pm_runtime_reinit() or re-enables runtime PM on it.
>
> when rpm_get_suppliers() fails and we're already propagating the error
> to the consumer's resume path, we should not leave the supplier in a
> state that prevents all future retry attempts.
>
> Would you suggest a different approach here? I want to understand what
> the preferred recovery path should be when a supplier's resume fails
> inside rpm_get_suppliers().

Well, this isn't really different to any other cases when runtime
resume fails.  If it fails for a given device, it will also fail for
all devices depending on it.

But fair enough, please see above.
