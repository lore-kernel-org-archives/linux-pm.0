Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31F3644C9
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626734; cv=none; b=RVdn/fa2map/wcCHycRAuhUkK67eVZbzDpMoj2JIcKs6gp3rci5c2f2iLjsckZClGFbDzhLs7GvZdm3COGpK+ML7s70TlKou+wgIk5Y8iHPkePji7hRCYR9fdcDYluA7wORQUXH7NAVMQHh39nwynSFxXo35fPMDmdPsq3Re+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626734; c=relaxed/simple;
	bh=yfMpwjR4Mb76xt9y9RfMOOwobv/4i5sPUE8M+81Aq+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsuZCvzz/JzaHc8mN3i3LWvJuNl0Gh/U93xdiMBQ0bU3rTw13pE3uduyRZVLhH6dbiZplw4dHb6lDawSWgBdANFaeprCc+hbj3E5SBkkdjoPkYLxDT6u7rqassacAPEcjwpjun97HPSRc+NeHx/9Ok9OfHo0NKLm1JsApIR25R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cezuWU/0; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cezuWU/0"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3115c4451c8so202008eec.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 13:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790626732; x=1791231532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cr8XQlonHStI5lsvWXRcBcaqjtnReUb4PPL/E4xIzB0=;
        b=cezuWU/08FS+by4fS+xPJMIyemHPtvVMgqEP9iCj3hXYYqH9x683FpcrjpAv9IDr77
         jpsXJaY/tVeUhTBoJB4Ysi+zasoM82RFIMqMDqlQJq+dHEv+9ZjmSI+wQvZQgPZgsFWQ
         VgaYTlMVHOGjTil9kAFWedOdPpBbbG6fraWDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790626732; x=1791231532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cr8XQlonHStI5lsvWXRcBcaqjtnReUb4PPL/E4xIzB0=;
        b=C9JZD3jG2XhKGfxe0++tJajCMskBpAiHa378yejj0QKo6c4jIa6AK9lgLwHV09rKwA
         YGEVeLVaFONTMYbdFwhOKflqBJVSgcvrHUwpAzxXzR+x1nQ/iHRv06pl8HBteUoDLW5N
         UwtqWFeL3v6oz3/pXkA4jMwpdo1e1u38kTp0jxF1L4rb5J/YfKKR2Is1xrzH1+av58Jt
         9Sk4D2RzF0xAL2SyV2riJ0hYbMJHkeXXg0jw5xyZeTeky/7gAyvZ3fKL8+CHOBvysCRs
         LNMWamhpMivyo2XU3QpgYdbxe/5ekxgmTLSDv86oP2rYhAvkzbJdYle5qOzNDStchPPq
         LOuw==
X-Forwarded-Encrypted: i=1; AKwUvBxzS3bNepHGHM9SAiB8N/imDLYrvmu3GHIKbsAfQ649N4w2Fasuewqu/6HLkcg/bjD4jBihuafFbA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKMEDfXC4T916LkRgwCYTvejdJbnmmFRak3G41jSb6BgDZL9yGZ
	QGCYyF+G0y+rBaMpwhFOZvijVemDfWXB9c1ePSES/kU5ycYn73HtmfXS0sUTyySNSQ==
X-Gm-Gg: AYBFou35ziHXhqUvOmRPSsX1pd3l4gTmtuNgxUrmF2r249X2aBVwqS0Av/MkAc+3/Ko
	optdKCwsD9YkmhDeiCMG8VyykmXcf7qh09S5jdWO0ubZVqbynW05qXPDsZnWAXwMySDf5RyrsF7
	zZG/aqdsDYb52GNJvzn4NrKr8xDGH2e34uq/XqbdaoDZ5XAl/AyE8AiDH5bhGsFN8RH16LrbFot
	d5r63nOta0FHcypxDJygPih9Jj/3zDpxRp0gHXBd9LzAPQNtesIzzb1AkfRGJ6oM9gCjit8Zmpu
	zyyy14h5Jf8sH6IA6ZJd5FsX4cbU/JRIBsZgzzE9P57PVNAEE6LAfxB9NQTBa1k53BpHNWVnjkA
	qJCtUIfNsppc+ga5Nu+Zfzzf3TkM5qgdEpcw5gVyHPC9yGrX4F0XQCfrtaOR6+TCxpwYjHVNGM2
	ZpA16gGjDXMHWoOpiOQEWrjuq3tDez5TOUklWyy+LrP/jkM+wXTN4it0j5kYT3TBasSD4/MwnHY
	dwOSm9O5a0sERZ2CjG0u6pWEKZrVJyLXgBXqg==
X-Received: by 2002:a05:7301:433:b0:342:890a:4088 with SMTP id 5a478bee46e88-34af520868fmr530048eec.2.1790626731636;
        Mon, 28 Sep 2026 13:18:51 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:a706:cad8:8223:aefa])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-34141a49febsm32169717eec.2.2026.09.28.13.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 13:18:50 -0700 (PDT)
Date: Mon, 28 Sep 2026 13:18:48 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] PM: runtime: Misc improvements to runtime_pm.rst
Message-ID: <arrLqEyoXhIm1vVu@google.com>
References: <20260923174711.1283986-1-briannorris@chromium.org>
 <20260923104031.v2.3.I383681b22c12d7caee976cb91aa90d1a94d4a591@changeid>
 <CAPx+jO_1qYnN37diVN1=PA0xGa0iSBfXD_uqgSdFpTn4t0zJiw@mail.gmail.com>
 <arVWVA3lks7SopQH@google.com>
 <CAPx+jO_A684fd8SJML9NEmsGzNx2Ge3-mWyQcyjgGP2S5aX1jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO_A684fd8SJML9NEmsGzNx2Ge3-mWyQcyjgGP2S5aX1jQ@mail.gmail.com>

On Mon, Sep 28, 2026 at 03:15:43PM +0200, Ulf Hansson wrote:
> On Thu, Sep 24, 2026 at 6:56 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > On Thu, Sep 24, 2026 at 04:01:00PM +0200, Ulf Hansson wrote:
> > > On Wed, Sep 23, 2026 at 7:47 PM Brian Norris <briannorris@chromium.org> wrote:
> > > > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> > > > index 39fdeeda7a1e..352cdaf0650d 100644
> > > > --- a/Documentation/power/runtime_pm.rst
> > > > +++ b/Documentation/power/runtime_pm.rst
> >
> > > > @@ -315,7 +319,10 @@ removal of their drivers.
> > > >
> > > >  Drivers in ->remove() callback should undo the runtime PM changes done
> > > >  in ->probe(). Usually this means calling pm_runtime_disable(),
> > > > -pm_runtime_dont_use_autosuspend() etc.
> > > > +pm_runtime_dont_use_autosuspend() etc. Alternatively, drivers can use
> > > > +devm_pm_runtime_enable() during probe, which automatically takes care of
> > > > +calling pm_runtime_disable() and pm_runtime_dont_use_autosuspend() upon driver
> > > > +detachment.
> > >
> > > As I have stated in earlier discussions at LKML, the
> > > devm_pm_runtime_enable() API is not entirely easy to use correctly by
> > > drivers. It means that pm_runtime_disable() gets called at some point
> > > *after* the ->remove() callback has been invoked, which can cause
> > > problems, unless the driver's ->remove() callback has managed things
> > > correctly.
> >
> > Yeah. And I think it's rare for drivers to have done a thorough job. A
> > rare exception: I found commit 2d90ecdfa326 ("ASoC: rockchip: i2s: Use
> > managed hclk and runtime PM cleanup") an interesting outlier -- it adds
> > an additional devres teardown to power things off afterward.
> >
> > OTOH, between v1 and v2, I chose to tweak one of the Examples to avoid
> > devm, precisely because it was committing (or hinting at) these kinds of
> > mistakes.
> >
> > > My point is, the above makes it sounds like it's easy to switch to the
> > > devm managed version, while it certainly isn't that straight forward.
> >
> > Right, I said as much in the cover letter too:
> >
> > (possible future work)
> > <quote>
> >  * Adjust the way devm_pm_runtime_enable() works, specifically for
> >    remove()/teardown. Currently, this is very hard to use correctly --
> >    some common driver patterns may assume that a device will tear down
> >    while RPM_SUSPENDED; but that's not actually guaranteed. Notably,
> >    this makes some of the "Examples" section fairly tricky/subtle.
> > </quote>
> 
> I think having some examples that *don't* use devm_pm_runtime_enable()
> would make better sense, as it would show what is needed to take care
> of things correctly.
> 
> Stating that there is devm_pm_runtime_enable() available would of
> course be fine too, but in that context, I think we should point out
> that the user really needs to address the ordering problems that get
> introduced when using it.

Yep, that's exactly I took out of the patch 8 discussion. I have such a
revision ready to send out in v3.

(Some part of this is a general problem with devm_*; for one, if you
only use it partially, and still have some manual teardown in remove(),
there's a high probability you'll get the ordering wrong. But that's
general advice, and not really specific to RPM documentation, IMO.)

> > Would this be a good moment to pass this possibility by you? What if we
> > taught the teardown to force a device back to RPM_SUSPENDED? Something
> > like:
> >
> >     static void pm_runtime_disable_action(void *data)
> >     {
> >             pm_runtime_dont_use_autosuspend(data);
> >             pm_runtime_disable(data);
> >
> >             // New code:
> >             if (pm_runtime_status_suspended(data)) {
> >                     int (*callback)(struct device *);
> >                     int ret;
> >
> >                     callback = GET_CALLBACK(data, runtime_suspend);
> >                     ret = callback ? callback(data) : 0;
> >                     if (ret)
> >                             return;
> >
> >                     pm_runtime_set_suspended(data);
> >             }
> >     }
> 
> pm_runtime_reinit() is already taking care of some of the above.

It gets the set_suspended() part, but not the real key point -- running
the suspend callback.

I believe this is one of the bigger RPM-specific misconceptions and
pitfalls people make, and is made worse with devm_pm_runtime_enable():
people assume that as long as their driver isn't trying to use the
device (e.g., they've closed any open handles, etc.), then the device
will leave in the same state as it came in -- suspended. But that's
absolutely not the case, due to:

1) race conditions -- async put()/suspend is not guaranteed to complete
   before pm_runtime_disable(), and therefore the post-disable status
   is not guaranteed.

2) forbid() -- if user space forbade runtime PM (on >
   .../power/control), the device will not suspend.

I think it's a clear win to ensure balance -- that
devm_pm_runtime_enable() can ensure the device leaves the same way it
came in -- suspended. (Or, if that was somehow not true: I could add a
check into devm_pm_runtime_enable() to make this conditional on initial
runtime_status.)

Note that many (most?) drivers *do* care about balance -- e.g., they
expect a balanced regulator_enable()/disable(), because resource
teardown (regulator_put()) will fire a WARN_ON() otherwise.

Anyway, unless I hear major objection, I'll try to put my proposal into
a proper patch + description, so it can be reviewed on its own.

> Moreover, we have pm_runtime_force_suspend(), which may fit well for
> some cases, but not for all.

Yeah, I was imitating that, more or less. I suppose there's no harm in
using it here though. I'll think about it.

Brian
