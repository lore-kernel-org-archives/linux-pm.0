Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5AA29D27D;
	Fri, 31 Jul 2026 01:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461463; cv=none; b=q1Pv8Q4FkQZkYZWtgQLAbFHpH8OiZMFT+PC/QVzxTM+fVESHhYD7SvwLi98/BxOfOS6cdwcBeCTAlPnRTvIz1CNEAiAeJn6C7odnpZIktlUCXhhaKBD4VZFGkK5D7XbaPL/fRV1p56BYWrv+LFRoXUJDqWNixhRXDx2cC2dpZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461463; c=relaxed/simple;
	bh=JZl7+Iq+TkZ6KtfzXP/ZMoFzLUUZIidJ3IyemrpboMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pfu2nerbyqJMnZT/JQW5fZdrPwIVadcXzTXE0bMY0onTQP80Zu6YzfNLgCXCSQtfU2BIURFLwU9vjfGOnvF1BoC8i2GzVIsS6lLzAxXhrY74R4iOhiCGkxY/aox9/lyHQasxKUM5dWHalGN69vCG4ACLdqe+h/nhI5zhsm5J9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=m4BL+af6; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="m4BL+af6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785461449;
	bh=VOddwZB2ExC+qB3w6kRHEoXg3vMe6ErDqJixfcX5e1U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=m4BL+af6+znJQHIF1rsrHmjuJcIhS4CvW15do5v8Z4+nELU9cEU4sK5HIaim7xurc
	 V+IZT4hIwJHNl7ulbQhvJRzOKxy1esuit3wfN0tS7PfmIRgn24OwO4jZXsT+Mn0MER
	 W/xFlCAPPBXBX0p68zKO52JL6+LlwS3SS1sFMxiQ=
X-QQ-mid: esmtpgz15t1785461428tf7c0f590
X-QQ-Originating-IP: PGexwB07BwrBrwYbQb7cSisCsll351s8YVPydnYQXxs=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 09:30:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10344273564525670133
EX-QQ-RecipientCnt: 15
From: Haowen Tu <tuhaowen@uniontech.com>
To: laurent.pinchart@ideasonboard.com,
	stern@rowland.harvard.edu,
	rafael@kernel.org
Cc: tuhaowen@uniontech.com,
	gregkh@linuxfoundation.org,
	hansg@kernel.org,
	kernel@uniontech.com,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mchehab@kernel.org,
	oneukum@suse.com,
	pavel@kernel.org
Subject: Re: [PATCH v4 4/4] media: uvcvideo: defer streaming restart after hibernation snapshot
Date: Fri, 31 Jul 2026 09:30:24 +0800
Message-Id: <20260731013024.1577337-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260730153817.GA1555869@killaraus.ideasonboard.com>
References: <20260730153817.GA1555869@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MfQnJH+7WKv6TS5mRVB3/RA2ZYsYkcEzOAHTYcFIjoOMObrvyo86w0In
	VwNF+uqMfvf4pgQjcCk0jnbdwKQkS9T5LK+i9rz3M6XhZlQhGM74SI+WeSIXDjott1tOHxh
	AGyJPlyO8ib/CBejNdlsiZtQR0yRn0nPzCDOH8yjn1YfJrYV0vH/g9GcDgk3TZxlX8SxCnP
	UnRY1S0d/ouo/9l3feJ8zj0LCbzfUbn0gPirxQffJfJ1ALWxwBPPaiJO1zDJUChVfusaQ6A
	d9QdFOJqPzUutY+fYBfjtjIZdW3PEYa/Ep5dtkrmoX76mB5tSE7GKFgTlfZ1aTNKhQsMD8l
	h96PcENzCH56klPkP9id8Zg7f7q7i84uQpTMtklGDjFjxzrZNgf0YZoa6ch8qNbb21YqN+e
	x61sTBM45YdXgxpVHjMdZYBvFVIShUMKubq8xs77Cokwd2eAC6mGlKvFy3lRQp3u242iZK7
	HBNxqPovU6wLjDMPr2XniuGVUpR9YUa/5LMzfDBhREe93Qv9FNJMKNBMEYf4YOeFXfmeWve
	M2S7eS+GUKDe51Tjf5smGpE6n1Kq/AWj+sswqWiO00GS32t41yUu92g7r159wJa6K9Tmq9a
	Jc1XnK4ZVB/M8la+/71hH5Y6+L03Gw7pJlsnAZT0nIUALle21oYU8//CiZMrFABbqPjEa1x
	ynUsJtTN2hqsAWpcSjv4qFv8MXpLf4IWpDdzDwaxtdcvQbOrqZzAUODgMASUveb3F6PHspq
	P4m3RQxV4jkd6w1BKW47pEwXOFEQq4s/eW4qQFW5iSgLw0+/4yYbdpp2H42a7kYKG4J0h0n
	+zcz2G9BEecUf74GybBGJC7hUdJYVVSVBixLiE7Uos+Fb0Xyd1vXwMm5pwMhMIXc9qSTNr0
	EOqhj7RoPoeljLQliFZcfmEXAvxOBTTh0Sh6eSrxDDAvpc9iKdrh7N8raEVXoAOqlhBtDs1
	6GzHLNjRm3cqLYYPKH853kemso9DpWtaYCPxID7uwiRnu7U2lHygu+1huci0sN0mPMPN3p+
	mjZn/2FYZQQWsBWfBg1zFObfBzu2MfmR459XbAvQ==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Hi Laurent, Alan,

On Thu, Jul 30, 2026 at 06:38:17PM +0300, Laurent Pinchart wrote:
> Something like that. I'm very biased as I mostly work on multimedia
> devices, but it feels to me that for many drivers the current
> hibernation procedure is too complex. Those drivers don't need to
> differentiate suspend and hibernation, they only need to be instructed
> to suspend at some point, and resume later. Resuming could occur when
> the system is woken up, or when hibernation fails in the THAW phase, and
> those drivers wouldn't care to differentiate between the two. Seeing an
> extra resume + suspend cycle due to the hibernation machinery needing to
> write the image to disk, and having to handle that cycle manually as in
> this series, is additional complexity that (unless I'm missing
> something) could be handled by the PM core.

I agree.  This was actually close to what I considered before trying the
smaller UVC-specific approach.

My initial thought was that the PM core could distinguish the
post-snapshot resume used for writing the hibernation image from the
later path where the original kernel continues running.  In that model,
devices that do not need to be resumed during the image-write phase
could be marked accordingly.  They would remain suspended after FREEZE,
and would only be resumed if the original kernel continues running
instead of powering down.

That would avoid making each driver open-code the same kind of
post-snapshot THAW check and recovery handling.  It would also avoid the
notifier ordering issue in v4, because the PM core would keep the normal
device ordering when resuming the skipped devices.

The reason I did not start with that approach is that it looked like a
larger PM core change.  It needs a clear definition of which devices need
to be resumed for hibernation image writeout, and it needs to preserve
parent-device and storage-stack dependencies.  It also needs to handle
the case Alan mentioned, where the restore kernel cannot restore the
image and sends THAW before continuing; that path should not be skipped
in the same way as the post-snapshot image-writeout resume.

So v4 was an attempt to keep the change local to the observed UVC issue
while still handling the swsusp_write() failure path.  But I agree that,
if this is viewed as a more general PM problem, a PM-core solution with
an explicit skip and recovery mechanism would be cleaner than a UVC
notifier.

Rafael, would such a PM-core direction be acceptable to explore?  For
example, a device flag indicating that the device does not need to be
resumed during the post-snapshot image-write phase, with PM resuming
those skipped devices if the original kernel continues running, before
userspace is thawed?

If that direction is preferred, I can rework the series around a
PM-core-managed mechanism.

Thanks,
Haowen
