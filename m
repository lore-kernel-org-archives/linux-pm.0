Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D234C3B3898;
	Fri, 11 Sep 2026 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133085; cv=none; b=e3dmku2Eoo89SEyVtHsxWGhWB60eqbk5Fj6uLdbhC5nNra23XbbAI6C6xqFklbxl7hFduNEPhEzNnpy6Hz7emdWG+GZwjH/qFgAdtNEHjfvZ6RzUuL+wtxusnCDboDpiyosijoxUK5q/bdhI50RJJfbuZlSAgT2ODXaQqgR5po4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133085; c=relaxed/simple;
	bh=c1iublC0mhypbTgIMf3D4kLe/BVlyAIs8VdYDIeTNYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=At+SOQV3Ht0c0jHQ5Mfa9jb54fDpS/Ph9jX3RlLU62NxLo3rMJxVf2P12M6TgS/0J+l9fVEvTRiIPB3le1xN1noPn+sUtVubhipGD/hqCBRbnPLV4rD6I46vavyDun6ZO+5oqjO9VBDzS2Lh0PWxgOGNhp8zzeIQmRyc7dhCMiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8Eful+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8Eful+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64011F000FF;
	Fri, 11 Sep 2026 13:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789133083;
	bh=SMYDo0mS8IruC7pcDUtbzz482fP6SAlsS4TJFBZn9o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c8Eful+50kpD+eujut74fJr+fd1tzE/IjB/xjLHj0OuSNTD3jto2hhX0XLHXY7JIs
	 q7PKnA/+V0SS2S13WXUji0pzQiuX4dD8HuaQn9RSTq7PyBfdEgr7tk9pQWrB7Os2Nr
	 ArgmZ7vJGuJhSyh6VU8wmTtp/LpDvDNgRYj535BCwkH8KfJBxPaP9X7BUYLJEnzAkz
	 mFXfMe4zoASCJTxu8t6tkzDCglWrqG2oEYewCG90p6Orz47EkzTLRySSBKCzoGGdZ6
	 CSeyfKPk4PJ82IrghuqVpXGlau0QL7Hx6vbGbwSHe5a+BMf0sor6hzVMlt97arsUeE
	 SW7lScYP6NGcw==
Date: Fri, 11 Sep 2026 13:24:39 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Mayank Rungta <mrungta@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM: sleep: Add DPM watchdog to
 prepare/late/early/noirq/complete phases
Message-ID: <aqQBFxCjSdPmFJXh@google.com>
References: <20260909224818.2177311-1-mrungta@google.com>
 <CAD=FV=WFBmq3kniULxcXNsKgY-Zrb82JfaX5uRWVewQi_tJyJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WFBmq3kniULxcXNsKgY-Zrb82JfaX5uRWVewQi_tJyJw@mail.gmail.com>

On Thu, Sep 10, 2026 at 10:01:40AM -0700, Doug Anderson wrote:
> On Wed, Sep 9, 2026 at 3:48 PM Mayank Rungta <mrungta@google.com> wrote:
> >
> > Extend the DPM watchdog to wrap device_prepare, device_suspend_late,
> > device_suspend_noirq, device_resume_noirq, device_resume_early, and
> > device_complete callbacks. If a driver hangs during these transitions,
> > the watchdog will fire and dump a stack trace to help identify the
> > offending driver.
> >
> > To prevent false-positive timeouts, the watchdog is set only after
> > waiting for subordinate (during suspend) and superior (during resume)
> > devices. With this change, DPM watchdog coverage is extended across all
> > phases of system sleep transitions.
> >
> > Signed-off-by: Mayank Rungta <mrungta@google.com>
> > ---
> > v2:
> >  - Extend DPM watchdog to device_prepare and device_complete callbacks.
> >  - Update commit subject and description to reflect coverage across all
> >    system sleep phases.
> > v1:
> >  - Initial version adding DPM watchdog to late/early/noirq phases.
> >
> > Testing:
> >  - Tested on an ARM64 SoC (Pixel platform running a 6.18-based kernel with
> >    DPM watchdog enabled; Android 6.18 kernel has latest DPM changes
> >    backported).
> >  - Verified hang simulation in device_prepare and device_complete
> >    triggers DPM watchdog panic and stack trace as expected.
> >
> >  drivers/base/power/main.c | 31 ++++++++++++++++++++++++++++---
> >  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> Thanks! I guess you dropped my (and Tzung-Bi's) Reviewed-by tags
> because of the minor changes between v1 and v2? They look right to me,
> so:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

They look right to me too:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
