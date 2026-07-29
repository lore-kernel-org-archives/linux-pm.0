Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB543033E7;
	Wed, 29 Jul 2026 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311841; cv=none; b=m18oxm4QKCkV9/cBMlBtwTtEZgliZQCj19JoQDWTKeWIRvGphJR8fdBMD/QMgHOIP3Ttw/KkL26zyBfWf9xWWJfdMlRRU5cIDCoH9mcQCd1ez8zTDItg84SvtvU0bii/i6GeWKlgRZRjNltYMWpF0DHgD5egn5RLkzhknqVpAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311841; c=relaxed/simple;
	bh=aC6agGiNkldsc7o0HfytXXz8CkacdipBUC1dfi0aRug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=COnfXvmVmVekL1J8ka45xbsFuxhp5NS++DONBuI2FspbqyRnaiS0vAgabdJFy1LFTN2hRtnVEFsa3it35ajj1uSpWd7pP2OhzxoPLpbNvVY0nbRyM21wz63lzdJwGtiTcjTrZxjTKaKR++4FrMl5jGR7O/9DY/7lK2u9n6d4+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=QeZlsI3k; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="QeZlsI3k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785311830;
	bh=itgUVnq6VcHbBFJWsgdQm1lRjbCgycLezZK+ZgcI9PE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=QeZlsI3kPaswlf9mxZSVubQPZNzBrAe3PUAyQQnoNJKAqohQOz+J2CAox5x33n/qu
	 kE8U29wKIB8xVedlux3pMtojfa3k+EQ+8IsAv4qLOv/x2rGW0o4oVWB5SkYigfFO4y
	 FVgCRc4la9ZWlw23b7maFADI9mkUKkFOwaaDy5F4=
X-QQ-mid: zesmtpsz2t1785311819tb4a40445
X-QQ-Originating-IP: IDvnEqS10eRIJW0l4dG/ReB7pCt1MH1n0LB6KCtqvrA=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Jul 2026 15:56:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2273207960292754276
EX-QQ-RecipientCnt: 15
From: Haowen Tu <tuhaowen@uniontech.com>
To: hansg@kernel.org
Cc: gregkh@linuxfoundation.org,
	kernel@uniontech.com,
	laurent.pinchart@ideasonboard.com,
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
Subject: Re: [PATCH v4 4/4] media: uvcvideo: defer streaming restart after hibernation snapshot
Date: Wed, 29 Jul 2026 15:56:55 +0800
Message-Id: <20260729075655.1187692-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cbac4803-cf65-4b8b-a662-073189df478b@kernel.org>
References: <cbac4803-cf65-4b8b-a662-073189df478b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N+GbB1GeczC4vnrE/BvWJqsxRl/m/55X6uPCpqaHGEyUW5s4GEhPj60a
	dENv7/ZDj0UH71UgM5eMYUIsICqjSvR1lGf7kbWZXUvu6i5T1jcDbdR653JnaJ8UH61xue5
	RayiZGldVl/N3d7DR5FONLOUHahrFgdRzHy/6nuNVPq3mWz16RM/cHzq4jHdzOijrKCUV/b
	87HMPYlVmHN1c94QaymVzHXpDovRSNs/a5FM11fZ3kf24KfhD5UpmjW6VdWt1HZ55+8sk2y
	Gc+pP7tIXhP57Exa3fdTihHmS0N3q2Ox39tz+Si/MsZekWaa1pfulyXwctoo2Gq9pDpfUrr
	dpHCFaG3YB27j+MUudhr6cBUZ0mcibPcSML0HRT2DQaX2m9kol6vA+XxG+IGX8c7CisI5gM
	eeWkKi5Kwq4b/mcovH+EDVdKFfoKle4Su33MFskHEv1CqR21gBw0IIm1fRIjtrooU2uAM1r
	UArhjMl6u+r3mCtbLYisd+OKlfRvRjwvz4fHXcU6RAVWPWKoFcVjoytQG2jIoQCQrqgr7c6
	STg0xc7dKs/fxANKcN7CoxBlSUdemIgS6+qlEwhXvwWcoNj79JdhnHlztc6LaWNk51mYbct
	FH91kUgiOBVfSB9I2fPUd4CgtZZH/QeRCu58ST+Ro3oBQHO2LDdI7VG5lE2L/0VDtMArr0u
	APVj8D20GLoobGrQVX46w7NrZruYfBWMCXvbfLYE5jyP1p6d/7prOyIbl9tXSd0ez408jZT
	dD3alR1TWeYOB8jRxgJwEgCiwj1X7OeyAFgRQrkgF2VPFksgWGnPisZFu5NifiNwZAOZMhE
	vaSQtETRpr2mHBsWCPaED1Bk2H2WqRVkUflrv51TfEhGRZMHQYtS/xMNkuKmGOOZTj13Dku
	y62x36PSZEpS7/7xzpYrh4cW3/eUGPRFE/61iBbDkwq2Ygkq7EbP7p38QuvpAKa9d6qgwKN
	3U1fHhDq+Q1V54e0eulG+xy5YwDpg53tYnb+MfTo8M/tGGmAEhepD5JSlV9Kma/OwGwVDUQ
	Myu/UYIam9sTRw8YjBhVeeRk43rbtJm1g4PzNzylPaxrrQPHcXCZTpsL/9/Rbdmnn78HOhP
	g==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

Hi Hans,

On Wed, Jul 29, 2026 at 09:29:03AM +0200, Hans de Goede wrote:
> Right, so the purpose here is to avoid the LED turning back on and
> to speedup the hibernate?
>
> IOW except for the LED turning back on and things taking slightly
> longer everything works correctly with the current code, right ?

Yes, the current code is functionally correct in the sense that the
hibernation flow can complete and the camera can be restored afterwards.

The issue was reported as a user-visible privacy concern.  When an active
UVC camera enters hibernation, the camera LED turns off during the freeze
phase but turns back on after the snapshot has been created, while the
system is writing the hibernation image.  From the user's point of view,
this looks like the camera has been activated again during the
hibernation transition.

I am not claiming that this causes image data to be exposed.  The problem
is the unnecessary hardware reactivation and the resulting unexpected
privacy-indicator behavior during a system power transition.

Avoiding the restart also avoids unnecessary device work in this window,
but I do not intend to make performance the main argument here.  The
primary goal is to avoid the unexpected camera reactivation.

> I'm wondering if it would not be better to solve this in userspace
> and have userspace stop the streaming before hibernation ?

That would help when all userspace camera users cooperate, but I don't
think it is equivalent to handling this in the driver.

UVC is a generic driver and the kernel PM transition can happen while an
application is actively streaming.  Relying on every userspace camera
consumer to stop streaming before hibernation would make the behavior
depend on userspace policy and application support.  The driver already
knows whether streaming was active at freeze time, and it is also the
component that restarts the hardware during resume, so it can avoid this
specific unnecessary hardware restart more reliably.

> Hmm, the way you word this sound like this is a problem at the USB
> layer. But I think this is more of a short-coming in the generic
> device model.
>
> To clarify AFAIK the actual USB device to which the interfaces belong
> also does not get a specific PM message here, right ?
>
> The reason I'm asking is because the way this is worded in the commit
> message makes it sounds like this might be something which could
> be solved in the USB subsystem which I do not think is the case ?

Yes, that is my understanding as well.  The USB device resume path does
not expose the specific PM transition type to the UVC interface driver's
resume callback.

The problem was observed in UVC, and the immediate reason there is that
the UVC resume path is reached through usb_driver.resume(), which does
not receive the PM event.  But I agree that this should not be worded as
a USB subsystem bug.

My earlier thought was to expose the THAW/RESTORE distinction through
USB, but that would still need coordination with the PM core, and it
would only cover USB drivers.  If other non-USB drivers have similar
device-specific reasons to avoid work during the post-snapshot THAW
phase, they would need their own handling too.

So I can reword the commit message to avoid implying that this is a USB
core issue.  Something like:

  Some resume callback paths, including the UVC path through
  usb_driver.resume(), do not receive the PM event and therefore cannot
  distinguish the transient post-snapshot THAW phase from the later
  RESTORE phase using their local callback arguments.

The helper is intended to expose only the hibernation snapshot state.
Whether it is safe or useful to defer any work remains a driver-specific
decision.

Thanks,
Haowen
