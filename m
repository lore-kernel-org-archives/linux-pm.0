Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794764120;
	b=TbOpkt8Ppcl9mx/tI+oPKT70TYnYufy5Qf7aRr1nr9JQRbFeYZ23365Pgy6Fm9qjicLi
	 oPHsuq8px5HsrelxCgRe2ZsnYQ5fgZvZlfOqCoGWB23Kwz7cf0dhao+ux56SO9OHeWO62
	 gCak3xOgKXxgP+8oLMOQn/vBxCBD40lCHcZTnYiAT1MrE1zU48q9teDsnnpHj3yuJgjsa
	 JnDpPRrIeoi+MvozJqd7VfTGp9O61GNptbRSLPBOF+zSRFcpFesOUwy+AA9maVHAnZcA4
	 CDlo/z2Mw/zuJHwNPml9llEyccxj4/ucM4rDW8SmP8WjPvKN5uxHI11Csy1Q9GjbxyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794764120;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vSkVs/NCFexq7i4mA10Ok66soegfYDJAarmQ2hbSNkU=;
	b=TOs4jdUfETDAZ+9ZMOXvx52yW4IMXstVumTwX6gbn5q4kam5SjAH+ucVvwvPRitR47xB
	 8mSUeUinIT/6hLq2H50bX2zAc6Vg4NaTo7gAVXeor4VWqD4l0udz14ux46TJNboHXB2FH
	 BlPkneUN73bcvWH/C64vgJmIyjwzMWG8rROXIpzz1ypkEpFaCpMOuLE1F2BD4FvNiYNJ0
	 mdwpkj1lwZIbdqzl6qqTys5iqibpYjJqlvXi7gZoWjqEnBoOKiXY7buYHBmpXLQ0vM904
	 B2Q6yQg0/12cxrQeHe7FWsXvsWEjeW64Ly6g4H56sbFk0ZG8KncD1fbPPxLGNDOHHfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SaEWfD3D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AD606A31F
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SaEWfD3D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB321F000C9
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 17:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794764120;
	bh=vSkVs/NCFexq7i4mA10Ok66soegfYDJAarmQ2hbSNkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SaEWfD3DPYU79fQxOlvmcDo7nBzyI+yKIVrC9UOuggZbMnKBrky+hj89E48l5Y1PA
	 eVZLZJzxNVMj+P2wgK1hVDGEEkKg1f9bYIY0+Hj7KUv5RhwtIfAr0Xlph15FzkPdbI
	 t+ytdGd2FyFYJPvT8qqPxNRTraSWZbwXgRDjoof+RjBtU+nf64htLk0lApfQLpmjQ+
	 YvdmEk5n4CWe63D8BHFwsVIbF8enJ9Q9AFAnWd9WXiyCMMR2IeaYi1AsXCIdcZ5KuM
	 h2hjyaaCjNdRtNN5uOinuuHNnQ24IVXgme73BLiaZ+5+7xAm3KmJekaKML2/kwOGdf
	 EA+N0SC4bY7tg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ae417eb235so6470491fa.3
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 09:35:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGJXv4vFvM4+mx97qXak29O8EotJWtUkxa2RpD1imOOC0dLJnF2vDN2zzBTa5SNo8S24CnJkG4iyQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8bauK1kS5Bo7Igcs0ztSCSvqBaCprSVFOaQaDfVqPMGtcXkRLW
	KA20EkYYY70yjdVBrD1o/sZLNpxqbKyvtia/D4qW7H/o64K9hsLds4/ST4v948sUtMhCJO91WZe
	ADnB9os/Fe6KZtYVsKjbGYDlAVUNXY2Y=
X-Received: by 2002:a05:651c:a171:b0:3ac:429f:6d99 with SMTP id
 38308e7fff4ca-3ae2b423e83mr27535281fa.2.1794764118535; Sun, 15 Nov 2026
 09:35:18 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <4789427.LvFx2qVVIh@rafael.j.wysocki> <aveybY5Z9OWQYkRS@google.com>
In-Reply-To: <aveybY5Z9OWQYkRS@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Sun, 15 Nov 2026 18:35:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h3Q3ySm0BmHG80QAQReV-6mbj2A0J5cSG1Pwc_ziGyDw@mail.gmail.com>
X-Gm-Features: AclHuK9ZGe1DCYfl55RNPK40fT2BLeHHgC6hXXe6KnRPa9ACxhbsULDfQP_GVig
Message-ID: <CAJZ5v0h3Q3ySm0BmHG80QAQReV-6mbj2A0J5cSG1Pwc_ziGyDw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Update last_busy before calling
 rpm_suspend() in rpm_idle()
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 1:59=E2=80=AFAM Brian Norris <briannorris@chromium.=
org> wrote:
>
> On Fri, Nov 13, 2026 at 02:27:23PM +0100, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > When rpm_idle() is about to call rpm_suspend(), there are no reasons
> > preventing the device from being suspended, but if the device uses an
> > autosuspend delay, it needs to be taken into account.
> >
> > For this purpose, rpm_idle() adds RPM_AUTO to the flags passed to
> > rpm_suspend(), but doing that alone is insufficient because the point
> > in time from which the autosuspend delay is counted may be too early.
> >
> > For example, if the device has children (or consumers) and the last
> > of them goes into runtime suspend, the parent may now become eligible
> > for suspending, but it may not be worthwhile for it to suspend until
> > a certain time later.
> >
> > Quoting Alan Stern [1]:
> >
> >  Let's say the last remaining active child goes into runtime suspend at
> >  time T.  Let's also say that the parent expects none of the children
> >  will need to resume until time T + D.  Is D sufficiently large to make
> >  it worthwhile for the parent to suspend and then resume?  If not, the
> >  parent should remain active.  If yes, the parent should autosuspend --
> >  and the length of time the parent should wait before autosuspending is
> >  on the order of the value of D (let's call it D*) that corresponds to
> >  this crossover point.  Thus the parent's autosuspend delay should be
> >  set to D*, or something close to it, in order to achieve both
> >  objectives.
> >
> > Moreover, if the parent's autosuspend delay is set to D*, it should be
> > counted from time T at which the last child has suspended, but that doe=
s
> > not happen because the parent's last_busy timestamp is not updated at
> > time T.  That leads to undesirable parent suspends occurring between
> > child suspend and resume [2].
> >
> > To address this issue, make rpm_idle() update the last_busy timestamp
> > of the device when it is about to call rpm_suspend() which most often
> > is right after the device's last child (or consumer) has gone into
> > runtime suspend.
>
> Is it worthwhile to note (or at least hint at) how many other things
> change along with this? e.g., how pm_runtime_allow() (and therefore
> auto > control/power), all non-autosuspend pm_runtime_put() variants,
> etc, also extend the autosuspend timer? I think we agreed these are
> acceptable effects, and likely even desireable, but I'd say these are
> fairly major changes.

Fair enough, I'll add the following to the changelog when applying the patc=
h:

"This potentially changes observable behavior in all situations in
which pm_runtime_put(), pm_runtime_put_sync(), pm_runtime_idle(), or
pm_request() idle is used on a device with an autosuspend delay.  That
includes changing a device's "power/control" sysfs attribute value
from "on" to "auto" (if there are no other active runtime PM
references to the given device), accessing PCI configuration space
from user space etc.  Namely, in all of those cases, the runtime
suspend of the device following the runtime PM helper call (if it
causes a runtime suspend to occur) will be deferred by the full
autosuspend delay, which arguably is more consistent and predictable
than deferring the runtime suspend in question by a more-or-less
unknown (and basically random) time depending on when the most recent
update of the device's last_busy timestamp has occurred.

It will also cause the majority of the direct
pm_runtime_mark_last_busy() calls to become redundant, and they will
be taken care of later."

> In any case, the change looks good to me:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Thank you!

> I meant to make time to test this out a bit more, but ran out; maybe
> next week.

That will be much appreciated.
