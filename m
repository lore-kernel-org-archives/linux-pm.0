Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56922FE056;
	Thu, 23 Jul 2026 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784770823; cv=none; b=CUcozUWILO5SlzwsKcqYzVo4VepcaxnVV7ucfYrzHKMaQxfS0nby7/jRdyP3e+NH8rFdXipVQwi4sna/YZ4wU+01nMbgkwv6+alhBQqomUeSm7bRmQ32gvV0ef3p0dkJc/hJ3BzGKajJL16bDg4ZdudRd2Pe8H20m+bpu0zWDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784770823; c=relaxed/simple;
	bh=tDiVFKZNRc4Xa4VPQB5587fGdq0BGe1G0rK39Z3yEBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wq/cVx233njxCWj5JtHlJF5dk6hNuyViPYEOCPgeDTMUWjH5Ycc5FNJ+3jfGnqxeKglpA/B6sWyLdJFCmjsR3JObIP/aCKBzoMvm0NZ8l1APM6t5CtrcEONQhtKB4lDTSE8CPN9AzFE5dqF3uiFBu0fb1x4/knU3Dq7V0+pEizE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=p2jPaWGQ; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="p2jPaWGQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784770813;
	bh=39BXAVAV22NPOzYN+mKCQLJtCYn25wFR01/w/75Csns=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=p2jPaWGQmaa/lmwOFIGhxV1ZDUP6bxEbCjxhtR2sLXO4ei7ZugH0kZfskN75pui4w
	 Ke3HD+vKQzfQRPqJK4rYP+pG9a8SnBYwpb1H4YnG0DdGhB9MfuNzKx0mrO/qIPK9U/
	 X3unKiN8eOTIHE/o/qZYx2n9cXQZj2SgtNJk/dSI=
X-QQ-mid: zesmtpgz7t1784770801t1c349629
X-QQ-Originating-IP: tTDg4oK26foSmXmz/lkoC55/Q2YBBwv5cAWyXcflEm4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Jul 2026 09:39:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2330629455518813040
EX-QQ-RecipientCnt: 15
From: Haowen Tu <tuhaowen@uniontech.com>
To: laurent.pinchart@ideasonboard.com
Cc: gregkh@linuxfoundation.org,
	hansg@kernel.org,
	kernel@uniontech.com,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mchehab@kernel.org,
	oneukum@suse.com,
	pavel@kernel.org,
	rafael@kernel.org,
	stern@rowland.harvard.edu,
	tuhaowen@uniontech.com
Subject: Re: [PATCH v3 3/3] media: uvcvideo: skip streaming restart after hibernation snapshot
Date: Thu, 23 Jul 2026 09:39:55 +0800
Message-Id: <20260723013955.3724344-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260722200620.GC648629@killaraus.ideasonboard.com>
References: <20260618013133.1047270-4-tuhaowen@uniontech.com> <20260722200620.GC648629@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MNzjxjeHhySas2iGtuu7+sD6lZe414OW8U6CJsmcJcGT1t5BxshT6a6G
	sS2jnhjIV1/j4SQKXGi2JnjSnLd+e6R1pWel3NXkq+bDxgK8r2O09vGLOKHDA/rIh48FOIS
	dbhw7bSclKUf6Hazs2KZIu3tqpqkjiBSkTq8tCjCF9wAG3Exd2itNwTOw+c7GNNyC9XCiru
	hZqfhp7OZ5kxcUDf6j3W1UkeMbNDow+/42h6gccUrrAcdYZRzoQNpgNLEhiwhlz0hxi+iBj
	Jj3QdwBiooPyo1S+SOOlL25M046k/V+fB843R86jF6Rmhm3zmnNw8bu5ryCwlN8zfKxIoxU
	6SZ1gFifhtRzv3+gGURXs2DnukfpedPh/puXGmh4acPjIb37joYA/HvTjc7Y6g57GYQOdYU
	WucEuVSu47JHw6Fktgz0gCbBcNmzHMzwNAPZ8HU32FyxFcIHMyR3S5yx1VFNiBVcqdI9Sn/
	wv+ownELyxNU94/wbGZ0a7t3e2cBrZdiTKAfKKz/xW0DKtI++gCXptjwain4Vur3P+7ctkX
	vIwJqNZcM1PdGnEKP0RkFruyalh65JZf4klo2AIYF60A8nhRvl1MhU5yquXTZWQJnZza0Xl
	Vl48y1dUxGYs5t07wVseRYKwPwImBe72x5D12Q9zKtgFRCGK2vwF7ZoCUmr3E5ArO7z8nhp
	g3nqly3mFkVWEP10OJHfg8TtGI6PKEi/w7lXYW4ksDreBQckA0hAX6/yyDBIE+0ZUxrohVv
	rAO6jjLGEV2Jcsi7JlwfLaeXyGd64utr7Tgsqw3gmKpL9fkeSbwlnVaoOQxa3NBerPT+ezx
	43mOEPtBXU1Q+SYOuvyaNtYKCeRUzrFZWNkjMj/zg8FcQpARSqC5ylUbcoCTtlfH79gCHRd
	TNBUveDRES4iaSiRyIJirvLGZFsVWCnAbMwMMPSFMO8pbKJLNNkug6p7BlWCOHuKy9BHDJ+
	nukXeS3H4iKRheOMJNxlgJkBCMC+YkO3SLhBoAKtkB6K2ajz2vCMbnHK7cPQB4CgykiKgpb
	fAGjPxvXLzmrfzT3FDezr1qXHDegE=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Hi Laurent,

On Wed, Jul 22, 2026 at 11:06:20PM +0300, Laurent Pinchart wrote:
> On Thu, Jun 18, 2026 at 09:31:33AM +0800, Haowen Tu wrote:
> > After the hibernation snapshot is created, devices are resumed with
> > PMSG_THAW before the image is written and the system is powered off.
> > Restarting an active UVC stream during this phase reinitializes the
> > camera and visibly turns its indicator LED back on.
> > 
> > Skip only the UVC streaming hardware restart while the snapshot is
> > available.  The driver's frozen state and clock are still updated before
> > the check, and a subsequent UVC suspend can stop the stream and select
> > alternate setting 0 as usual.
>
> Why is that desired (both the decision to only block the resume of the
> video interface, and the decision to not block the next suspend) ?

The intention is not to block the whole video interface resume callback.
The callback still clears stream->frozen and resets the stream clock
before the new check.  The patch only skips the final streaming hardware
restart, namely uvc_commit_video() and uvc_video_start_transfer().

In the earlier version the check was placed before those state updates.
After Oliver pointed out the image write failure path, I moved it later
in uvc_video_resume().  If swsusp_write() fails, the system continues
running in the original kernel, and the driver should not be left with
stream->frozen still set from the preceding FREEZE suspend.

That is the part that reconfigures the camera and restarts USB video
transfers, which is what turns the camera indicator LED back on during
the hibernation image-write phase.  The control interface resume path is
left unchanged because it is not the source of that visible side effect,
and because I do not want to change more of the UVC PM flow than needed
for this case.

The later suspend is also intentionally left unchanged.  The patch should
not alter the PM core sequencing.  If the platform hibernation path or an
error recovery path later asks the UVC streaming interface to suspend
again, uvc_video_suspend() can still run the existing cleanup path and
select alternate setting 0 as usual.  This keeps the interface in the
same state that the existing suspend path expects, instead of introducing
a special case where the later suspend is skipped too.

> > uvcvideo does not provide a shutdown
> > callback that requires the streaming hardware to be restarted first.
> > 
> > This is a device-specific use of pm_hibernation_snapshot_done().  The
> > helper does not cause other drivers or USB core to skip THAW resume.
>
> I don't think this sentence belongs to the commit message.

Agreed, I can drop that sentence from the commit message in the next
version.  It belongs more in the cover letter, if anywhere.

Thanks,
Haowen
