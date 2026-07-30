Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34860270545;
	Thu, 30 Jul 2026 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425905; cv=none; b=kYhzGfRzAF8OOMzwQyy3Wp59GZTS1DG7IIm2f+Fetcs/V4Yg+HPRnBlup4yFJR/f6Mb+PjEUG80zAHknD0k7v4VDxVrpJxYUK6mZs2kfpVkGzjbqeW56dqQ947FvCx70CKBL0VvdNVst2IHuJlGRKfZfXPCGKm6l0kV76bninHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425905; c=relaxed/simple;
	bh=ugiPkk6ymF50jzIIdLIDww3QYXfEzU9GjSCj/4sd1Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIvWqOlwJ1CNV1yXphjAgnbzAHgckgOWxvrmjxSevXNvbu/Mkkd1j3Uhg60ZwWaCxi3MgcukRC5bLgTv/Bpd5TxMse8JeTaW43XDOVVPQH+OE/wuWpTon2y0uj679ZDDYT2OrITvclHXTi7yUIHH3CjdlhEinDf1X6MKa1504TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fOW7VEtP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fOW7VEtP"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D9429BB;
	Thu, 30 Jul 2026 17:37:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1785425834;
	bh=ugiPkk6ymF50jzIIdLIDww3QYXfEzU9GjSCj/4sd1Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOW7VEtPjQUuveOx0Di8R+LQPFvV7fte++RdpjjphX3zsOSjcn7eQfRnhQM00FyFS
	 RUv6VWgYIC7E2kOZieELlviec9NRxnxRLXlUyRgK5JcRpgFwaqjNavkCWmeXPSnPle
	 JotpDhf7vFG3JmIV5G9IDZVzWiqBStM7sB1q5E7E=
Date: Thu, 30 Jul 2026 18:38:17 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Haowen Tu <tuhaowen@uniontech.com>, hansg@kernel.org,
	gregkh@linuxfoundation.org, kernel@uniontech.com, lenb@kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	mchehab@kernel.org, oneukum@suse.com, pavel@kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH v4 4/4] media: uvcvideo: defer streaming restart after
 hibernation snapshot
Message-ID: <20260730153817.GA1555869@killaraus.ideasonboard.com>
References: <cbac4803-cf65-4b8b-a662-073189df478b@kernel.org>
 <20260729075655.1187692-1-tuhaowen@uniontech.com>
 <0e22e9d4-da39-4d3f-9492-5c74295be312@rowland.harvard.edu>
 <20260730131628.GA1555789@killaraus.ideasonboard.com>
 <a1f8d865-531c-4f30-85c1-735254940763@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1f8d865-531c-4f30-85c1-735254940763@rowland.harvard.edu>

On Thu, Jul 30, 2026 at 10:29:34AM -0400, Alan Stern wrote:
> On Thu, Jul 30, 2026 at 04:16:28PM +0300, Laurent Pinchart wrote:
> > On Wed, Jul 29, 2026 at 10:08:51AM -0400, Alan Stern wrote:
> > > On Wed, Jul 29, 2026 at 03:56:55PM +0800, Haowen Tu wrote:
> > > > On Wed, Jul 29, 2026 at 09:29:03AM +0200, Hans de Goede wrote:
> > > > > Right, so the purpose here is to avoid the LED turning back on and
> > > > > to speedup the hibernate?
> > > > >
> > > > > IOW except for the LED turning back on and things taking slightly
> > > > > longer everything works correctly with the current code, right ?
> > > > 
> > > > Yes, the current code is functionally correct in the sense that the
> > > > hibernation flow can complete and the camera can be restored afterwards.
> > > > 
> > > > The issue was reported as a user-visible privacy concern.  When an active
> > > > UVC camera enters hibernation, the camera LED turns off during the freeze
> > > > phase but turns back on after the snapshot has been created, while the
> > > > system is writing the hibernation image.  From the user's point of view,
> > > > this looks like the camera has been activated again during the
> > > > hibernation transition.
> > > > 
> > > > I am not claiming that this causes image data to be exposed.  The problem
> > > > is the unnecessary hardware reactivation and the resulting unexpected
> > > > privacy-indicator behavior during a system power transition.
> > > > 
> > > > Avoiding the restart also avoids unnecessary device work in this window,
> > > > but I do not intend to make performance the main argument here.  The
> > > > primary goal is to avoid the unexpected camera reactivation.
> > > > 
> > > > > I'm wondering if it would not be better to solve this in userspace
> > > > > and have userspace stop the streaming before hibernation ?
> > > > 
> > > > That would help when all userspace camera users cooperate, but I don't
> > > > think it is equivalent to handling this in the driver.
> > > > 
> > > > UVC is a generic driver and the kernel PM transition can happen while an
> > > > application is actively streaming.  Relying on every userspace camera
> > > > consumer to stop streaming before hibernation would make the behavior
> > > > depend on userspace policy and application support.  The driver already
> > > > knows whether streaming was active at freeze time, and it is also the
> > > > component that restarts the hardware during resume, so it can avoid this
> > > > specific unnecessary hardware restart more reliably.
> > > > 
> > > > > Hmm, the way you word this sound like this is a problem at the USB
> > > > > layer. But I think this is more of a short-coming in the generic
> > > > > device model.
> > > > >
> > > > > To clarify AFAIK the actual USB device to which the interfaces belong
> > > > > also does not get a specific PM message here, right ?
> > > > >
> > > > > The reason I'm asking is because the way this is worded in the commit
> > > > > message makes it sounds like this might be something which could
> > > > > be solved in the USB subsystem which I do not think is the case ?
> > > > 
> > > > Yes, that is my understanding as well.  The USB device resume path does
> > > > not expose the specific PM transition type to the UVC interface driver's
> > > > resume callback.
> > > > 
> > > > The problem was observed in UVC, and the immediate reason there is that
> > > > the UVC resume path is reached through usb_driver.resume(), which does
> > > > not receive the PM event.  But I agree that this should not be worded as
> > > > a USB subsystem bug.
> > > > 
> > > > My earlier thought was to expose the THAW/RESTORE distinction through
> > > > USB, but that would still need coordination with the PM core, and it
> > > > would only cover USB drivers.  If other non-USB drivers have similar
> > > > device-specific reasons to avoid work during the post-snapshot THAW
> > > > phase, they would need their own handling too.
> > > > 
> > > > So I can reword the commit message to avoid implying that this is a USB
> > > > core issue.  Something like:
> > > > 
> > > >   Some resume callback paths, including the UVC path through
> > > >   usb_driver.resume(), do not receive the PM event and therefore cannot
> > > >   distinguish the transient post-snapshot THAW phase from the later
> > > >   RESTORE phase using their local callback arguments.
> > > > 
> > > > The helper is intended to expose only the hibernation snapshot state.
> > > > Whether it is safe or useful to defer any work remains a driver-specific
> > > > decision.
> > > 
> > > You're missing an important fact: If something goes wrong during the 
> > > hibernation transition (for example, if the kernel's memory image can't 
> > > be stored to disk) then there will be no RESTORE phase.  Following the 
> > > THAW phase, the system will return to normal operation.
> > > 
> > > For this reason, during THAW drivers must not assume that the system is 
> > > about to power down.
> > 
> > All of this seems fairly complicated to me for devices that have no role
> > to play whatsoever in the hibernation image write, and that's probably
> > the majority of devices.
> > 
> > Is there a reason a driver couldn't set a flag at probe time to tell the
> > device doesn't care about hibernation, and have the PM core skip the
> > resume in the THAW phase, instead resuming only when THAW fails ?
> 
> You mean adding an extra THAW phase to the hibernation transition, which 
> gets triggered only when writing the memory image fails, and which 
> affects only drivers having this new flag set?  And as a result, when 
> hibernation succeeds these drivers would see a FREEZE callback followed 
> directly by a POWEROFF callback (unless the flag causes POWEROFF to be 
> skipped as well)?

Something like that. I'm very biased as I mostly work on multimedia
devices, but it feels to me that for many drivers the current
hibernation procedure is too complex. Those drivers don't need to
differentiate suspend and hibernation, they only need to be instructed
to suspend at some point, and resume later. Resuming could occur when
the system is woken up, or when hibernation fails in the THAW phase, and
those drivers wouldn't care to differentiate between the two. Seeing an
extra resume + suspend cycle due to the hibernation machinery needing to
write the image to disk, and having to handle that cycle manually as in
this series, is additional complexity that (unless I'm missing
something) could be handled by the PM core.

> Another thing to be aware of is what happens while waking up from 
> hibernation, if the memory image can't be restored.  In that case the 
> restore kernel would send THAW callbacks to all drivers before 
> continuing, and presumably you wouldn't want this callback to be 
> skipped.

I wasn't even aware this was a thing, which only strengthen my
conviction that we're making it too difficult for many drivers :-)

> That seems like it could be feasible, but the decision is up to Rafael.

-- 
Regards,

Laurent Pinchart
