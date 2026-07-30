Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FE0432E99;
	Thu, 30 Jul 2026 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417396; cv=none; b=ptKrP6YqNrlKjW42BWNFYNJluW75Dp73kqoSafz1mGJkAUbXOYYKpJwbaMdDGNi4KkG8O7JOiqyvUdu9aQHx8S76M7SjL+syw0EQxEsR/taYIeMcDj5cEix6xMeQZQ1AcYWH9otA1XrqVpE3TAjKf+SQdXTTXYJpFbAgwHZTQKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417396; c=relaxed/simple;
	bh=jMg+iqDg1vHUkvxN5L9rxcFOWZfcy7JBoxtmU+M9+Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePXrF/tqViNrtl3g3W6BTAu4flGIj2c/p2g+0kWRck3IOpL635FIg194rnFHkjMN0tTq5jkuLaNwLIdGfJQoMYiZx06FlzqgCFOvrkKFJadRyovFt8ij3s6+hKyNoVk11PcAtqHnF8cbf31OIcpv8aeklY6gh7ZcL/nT4B+EGQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qN9a/EZJ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qN9a/EZJ"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 041181E4;
	Thu, 30 Jul 2026 15:15:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1785417324;
	bh=jMg+iqDg1vHUkvxN5L9rxcFOWZfcy7JBoxtmU+M9+Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qN9a/EZJ7pduCKubGbMIy0zM2SPcxCQtQIur9ejS4DnkM90L+LuipgC986K7rlYB3
	 JYWHjydDXxRPGLMOGKm6px+DgcKTJzsWj7N/Po76h/hJv8s1xhDkhmIlensAmBmFgF
	 TBglQwBVF6oIhksxoDfQCI9NHNNAsWpA+kkSW9+c=
Date: Thu, 30 Jul 2026 16:16:28 +0300
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
Message-ID: <20260730131628.GA1555789@killaraus.ideasonboard.com>
References: <cbac4803-cf65-4b8b-a662-073189df478b@kernel.org>
 <20260729075655.1187692-1-tuhaowen@uniontech.com>
 <0e22e9d4-da39-4d3f-9492-5c74295be312@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e22e9d4-da39-4d3f-9492-5c74295be312@rowland.harvard.edu>

On Wed, Jul 29, 2026 at 10:08:51AM -0400, Alan Stern wrote:
> On Wed, Jul 29, 2026 at 03:56:55PM +0800, Haowen Tu wrote:
> > On Wed, Jul 29, 2026 at 09:29:03AM +0200, Hans de Goede wrote:
> > > Right, so the purpose here is to avoid the LED turning back on and
> > > to speedup the hibernate?
> > >
> > > IOW except for the LED turning back on and things taking slightly
> > > longer everything works correctly with the current code, right ?
> > 
> > Yes, the current code is functionally correct in the sense that the
> > hibernation flow can complete and the camera can be restored afterwards.
> > 
> > The issue was reported as a user-visible privacy concern.  When an active
> > UVC camera enters hibernation, the camera LED turns off during the freeze
> > phase but turns back on after the snapshot has been created, while the
> > system is writing the hibernation image.  From the user's point of view,
> > this looks like the camera has been activated again during the
> > hibernation transition.
> > 
> > I am not claiming that this causes image data to be exposed.  The problem
> > is the unnecessary hardware reactivation and the resulting unexpected
> > privacy-indicator behavior during a system power transition.
> > 
> > Avoiding the restart also avoids unnecessary device work in this window,
> > but I do not intend to make performance the main argument here.  The
> > primary goal is to avoid the unexpected camera reactivation.
> > 
> > > I'm wondering if it would not be better to solve this in userspace
> > > and have userspace stop the streaming before hibernation ?
> > 
> > That would help when all userspace camera users cooperate, but I don't
> > think it is equivalent to handling this in the driver.
> > 
> > UVC is a generic driver and the kernel PM transition can happen while an
> > application is actively streaming.  Relying on every userspace camera
> > consumer to stop streaming before hibernation would make the behavior
> > depend on userspace policy and application support.  The driver already
> > knows whether streaming was active at freeze time, and it is also the
> > component that restarts the hardware during resume, so it can avoid this
> > specific unnecessary hardware restart more reliably.
> > 
> > > Hmm, the way you word this sound like this is a problem at the USB
> > > layer. But I think this is more of a short-coming in the generic
> > > device model.
> > >
> > > To clarify AFAIK the actual USB device to which the interfaces belong
> > > also does not get a specific PM message here, right ?
> > >
> > > The reason I'm asking is because the way this is worded in the commit
> > > message makes it sounds like this might be something which could
> > > be solved in the USB subsystem which I do not think is the case ?
> > 
> > Yes, that is my understanding as well.  The USB device resume path does
> > not expose the specific PM transition type to the UVC interface driver's
> > resume callback.
> > 
> > The problem was observed in UVC, and the immediate reason there is that
> > the UVC resume path is reached through usb_driver.resume(), which does
> > not receive the PM event.  But I agree that this should not be worded as
> > a USB subsystem bug.
> > 
> > My earlier thought was to expose the THAW/RESTORE distinction through
> > USB, but that would still need coordination with the PM core, and it
> > would only cover USB drivers.  If other non-USB drivers have similar
> > device-specific reasons to avoid work during the post-snapshot THAW
> > phase, they would need their own handling too.
> > 
> > So I can reword the commit message to avoid implying that this is a USB
> > core issue.  Something like:
> > 
> >   Some resume callback paths, including the UVC path through
> >   usb_driver.resume(), do not receive the PM event and therefore cannot
> >   distinguish the transient post-snapshot THAW phase from the later
> >   RESTORE phase using their local callback arguments.
> > 
> > The helper is intended to expose only the hibernation snapshot state.
> > Whether it is safe or useful to defer any work remains a driver-specific
> > decision.
> 
> You're missing an important fact: If something goes wrong during the 
> hibernation transition (for example, if the kernel's memory image can't 
> be stored to disk) then there will be no RESTORE phase.  Following the 
> THAW phase, the system will return to normal operation.
> 
> For this reason, during THAW drivers must not assume that the system is 
> about to power down.

All of this seems fairly complicated to me for devices that have no role
to play whatsoever in the hibernation image write, and that's probably
the majority of devices.

Is there a reason a driver couldn't set a flag at probe time to tell the
device doesn't care about hibernation, and have the PM core skip the
resume in the THAW phase, instead resuming only when THAW fails ?

-- 
Regards,

Laurent Pinchart
