Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69542DA76C;
	Thu, 23 Jul 2026 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796398; cv=none; b=mOX3SHV+nesFHnsl9YnN3QjiGMTeaqWLeAUiEj1/aRhf3EwWBx4owx8nuFKXJC1UfYX8rHQG7LcTfRpSEXqBzyzlQ5rOihFAuH5VvKcCwHSH7IlkG1qMhEheFil7CEErnBuHuP0HmFzKUaIWINODdW29wiRlSe04GeINlZTGEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796398; c=relaxed/simple;
	bh=aPSzjPeZdGK78AseBUEUYJRBq7XGHnAu2rw48krSXUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHAlpXeVFWJ994XjySU2gsrapoSXWPLu76LZYquHhqwAFhPZ4mIsqY9WZ1SoLzDotyNDKwSiLnCGvxN3C87gA1pqEGqx0Bkp4h/+ipByJz4Z34R86rjQRmyyN5ZwpgJ8DcUxlNRk2l2ErA+x+H2vUpnLf01uoic4iS7EYZqyo3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vH6rb20b; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vH6rb20b"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B9D5B1C37;
	Thu, 23 Jul 2026 10:45:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1784796333;
	bh=aPSzjPeZdGK78AseBUEUYJRBq7XGHnAu2rw48krSXUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vH6rb20bN7Fsn0LP+0OV4yZiJRxOPjdmi22JrwR8fkM3ydnYSVL4dbkT7dXy63Cm1
	 pBaG3/QGfBfd/3bgrQ3M6RNootmMRNANdzfkeSq0xPp8le9A0dKBS8RlND0N/sBFUz
	 I6eikyjDM8HcEDAauetUMF/xZFHv+/tETfDZTj1A=
Date: Thu, 23 Jul 2026 11:46:33 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Haowen Tu <tuhaowen@uniontech.com>
Cc: gregkh@linuxfoundation.org, hansg@kernel.org, kernel@uniontech.com,
	lenb@kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, mchehab@kernel.org, oneukum@suse.com,
	pavel@kernel.org, rafael@kernel.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v3 3/3] media: uvcvideo: skip streaming restart after
 hibernation snapshot
Message-ID: <20260723084633.GE648629@killaraus.ideasonboard.com>
References: <20260618013133.1047270-4-tuhaowen@uniontech.com>
 <20260722200620.GC648629@killaraus.ideasonboard.com>
 <20260723013955.3724344-1-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723013955.3724344-1-tuhaowen@uniontech.com>

On Thu, Jul 23, 2026 at 09:39:55AM +0800, Haowen Tu wrote:
> On Wed, Jul 22, 2026 at 11:06:20PM +0300, Laurent Pinchart wrote:
> > On Thu, Jun 18, 2026 at 09:31:33AM +0800, Haowen Tu wrote:
> > > After the hibernation snapshot is created, devices are resumed with
> > > PMSG_THAW before the image is written and the system is powered off.
> > > Restarting an active UVC stream during this phase reinitializes the
> > > camera and visibly turns its indicator LED back on.
> > > 
> > > Skip only the UVC streaming hardware restart while the snapshot is
> > > available.  The driver's frozen state and clock are still updated before
> > > the check, and a subsequent UVC suspend can stop the stream and select
> > > alternate setting 0 as usual.
> >
> > Why is that desired (both the decision to only block the resume of the
> > video interface, and the decision to not block the next suspend) ?
> 
> The intention is not to block the whole video interface resume callback.
> The callback still clears stream->frozen and resets the stream clock
> before the new check.  The patch only skips the final streaming hardware
> restart, namely uvc_commit_video() and uvc_video_start_transfer().

Yes, I understand what the patch does.

> In the earlier version the check was placed before those state updates.
> After Oliver pointed out the image write failure path, I moved it later
> in uvc_video_resume().  If swsusp_write() fails, the system continues
> running in the original kernel, and the driver should not be left with
> stream->frozen still set from the preceding FREEZE suspend.

Does that mean that, if swsusp_write() fails, the camera will be left in
a hybrid state where the control interface has been resumed but the
streaming interface will not have been restarted ?

> That is the part that reconfigures the camera and restarts USB video
> transfers, which is what turns the camera indicator LED back on during
> the hibernation image-write phase.  The control interface resume path is
> left unchanged because it is not the source of that visible side effect,
> and because I do not want to change more of the UVC PM flow than needed
> for this case.
> 
> The later suspend is also intentionally left unchanged.  The patch should
> not alter the PM core sequencing.  If the platform hibernation path or an
> error recovery path later asks the UVC streaming interface to suspend
> again, uvc_video_suspend() can still run the existing cleanup path and
> select alternate setting 0 as usual.  This keeps the interface in the
> same state that the existing suspend path expects, instead of introducing
> a special case where the later suspend is skipped too.
> 
> > > uvcvideo does not provide a shutdown
> > > callback that requires the streaming hardware to be restarted first.
> > > 
> > > This is a device-specific use of pm_hibernation_snapshot_done().  The
> > > helper does not cause other drivers or USB core to skip THAW resume.
> >
> > I don't think this sentence belongs to the commit message.
> 
> Agreed, I can drop that sentence from the commit message in the next
> version.  It belongs more in the cover letter, if anywhere.

-- 
Regards,

Laurent Pinchart
