Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795122983;
	b=w1NEZbqJkpMj/UAY+6nBlTaG5PJbOb9XNxf8v29jKyrlbsIC1rj95M4/AW58NUQ4/i3h
	 CVKTuizdOqkiID3ymWMp0Zvrm0H7Q/ktrpheMbtIkAs9+yDIN5B23yn9aji9+ORyeCGbT
	 jNI2uL5LX5c0xCnfggwgdQmIJut1SRylQs1ten9wW4WjRLWW2dSoWgHvXRjZ3dVSkGJ3i
	 KM0FFeUNKxW4AHzUaK6m9Hlus2EQParUx50mB/1RccEeHamqqx9PLRIEObPHSM+UBY1l6
	 wm9BSR0Ylfm6JbDyTycZaz4quTS4n4Ct+5jz4xbVW4dfGfcyS162C2YQKyPzG2NuRLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122983;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=uk2iSiMbWIf9eudFj6mDV24oWgo0g9mcvTS55UWKw6Q=;
	b=WgazdFSWC02HaT+V9BPJ1cBE4GOuIY3Sv0+HF4KmvElRFbnD6SyXBE+d0oHt728yDLO5
	 l/4BX7cduXZHtJW/eCdLisj6jl/MDJUzJritEcnLEZB8mX/6ME+Jq7bko/g7BQYzl/YMO
	 i+AWH6bfXOuQdKJ/HQqLxQ49U+Jw1G07uq4MALUZKLw6UgrlEFwLTab86+/3Ozp8ktXdv
	 5Ic6CKd6SICWW0yTASKctlw3oidND+CiPeSBzVeSKY0L4qn8rx6u7O1MDMkFEx0RycQiL
	 1HOY+fDclIgksfAYfjdCBiBAdLYsgAIT8DKWMCRb406r+7MvLGcsatPtxQQq31S56XQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oKd1Sg7U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9567960A2601;
	Thu, 19 Nov 2026 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oKd1Sg7U
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795122983;
	b=CIFL92rN/XwXTPZenqrPkUCHoGcK1MraWV4gJBd70K3tFh+HiPHY9wseHQKYwFxb7rm6
	 z23COeUHAGuB8MLAMXHYqd2lH/f5kjSpP1U7Ys7paaJXxb84FCD7T0dzMN2pWskFnpZPv
	 WI210p6MxlP4Zg2AnL3abOkOtBvNSpKr2a2FjKXC/QMnjcRMf8mSc7FAQKssyfOeT0QTC
	 jatdwzC1P/7Bg+rRWhnTvwM40zoUYxg5V+ZT8qZfZmrkQBtbM76kEeRQ3bQHy6EEZ+uUW
	 LfCVfUeShg0qAySQcCQidBnJCVk0ByyMQlJ9a7X+eO+lZEbWmgi1dTGbPVoLmPQbx2w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795122983;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=uk2iSiMbWIf9eudFj6mDV24oWgo0g9mcvTS55UWKw6Q=;
	b=A8nRvCHegzWkwAK81nWBFZb4WDgHZXKBYDL2PzvyDta+JGmV4DN9v3HWhMFUGDkP2xCV
	 n6wuMMxNHbO76mBN/h+DGoP0zVgP+YBnLZONbDAz0o/N8f+VOp18GSaQNyo4JVpYLzm1A
	 x0uwLlcLW3RIhrWl5w9yEy6dbUjaasvKTtysp30AuDZx8xOPNHRAsDCv0hm6LaWfOqxUu
	 9FZ0UIT0+BpFImWPOobCjcBZZmA4p9bpPXp6eb7cEEj4snHJBoDLeOzi+Tv7t6PxS4T1j
	 0Tb8Z1CI9DzINRc+G3//dbBEpCnq57ygHzFhTIlRcjRS9AtWTrRUCnxfNQ/z5EMfejQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9FBA41F000C4;
	Thu, 19 Nov 2026 21:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795122983;
	bh=uk2iSiMbWIf9eudFj6mDV24oWgo0g9mcvTS55UWKw6Q=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=oKd1Sg7U8dz5jMQlvc+NyuQcbSJTrcxfEf9desfWqZ8OnkRzNw/3p1+PuNZeqSJGD
	 /tIx9IO5q2EZ6GRYBcyx1D3Ij1I8aCWTVP+EO086zsrJChVrZM3MlKkJI8wiPC9buJ
	 fvWANeYgohVV1BUsuQs8ttIDezAKgmAEEdvHkkDcUkTa5uRnSo+cq0EIbJrZ181xXx
	 2S4HSp0sYU5evVTiwed1KGCby0vAVbT/5/+nCc2RCmXu8Ez53IVuYqqe8j6wDu8dfF
	 bv81VlFw0Ke4wJnIr7BjdtWgWlBhAPuRzLK0AVfOpeYG0XvMW3M/9FdvTPX1P4O0mH
	 8z6gXoWbamldA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 009D44955F;
	Thu, 19 Nov 2026 21:16:21 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] PM / devfreq: Do not change the frequency of a
 suspended device
Date: Thu, 19 Nov 2026 21:16:21 +0000
Message-Id: <20261119-devfreq-suspend-sync-v3-0-ef19fbf94d83@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOTQ6CMBAF4KuQrq3p9AeNK+9hXNQyhRoFbKGRE
 O5uQRPZGJdv8uabGUlA7zCQQzYSj9EF19QpiE1GTKXrEqkrUiac8RwAOC0wWo8PGvrQYl3QMNS
 G7ozeW6NAKaZJWm09Wvdc2NP5nUN/uaLpZuvTSEqf7nXfWuVC1/hheSbCPP1zNwIFqm0ucybQS
 oHH8q7dbWuaO5nByNeI/IHwhACzzAgEyaVaI9M0vQD5X3nYJAEAAA==
X-Change-ID: 20261112-devfreq-suspend-sync-7ca8fc51550a
To: MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795122981; l=3640;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=zRcwh0X/csqSTO8PFOHLtSayo1tqobLNJE+EuERfHnA=;
 b=YXff/cIq2Din9p4fBQzh0CpqPVb7vE5xGDQdUvXRBxcZ3UauImYZPboIUexA6YYOxvnY3MEmI
 9vJv6PKqb2iAWkKjWTebIAoPDr7I60UIUiKMPffb/Op9d8fno7CLAvO
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

From the review of a panthor patch [1]: Boris Brezillon pointed out that
the devfreq core, not the driver, should stop calling ->target() between
devfreq_suspend_device() and devfreq_resume_device().

1/2 is v2 of [2], which 2/2 builds on. The panthor side is [3].

Tested on an Orange Pi 5 (RK3588S), v7.3-based kernel with [3],
GPU clock on SCMI_CLK_GPU with a 200 MHz opp-suspend (Jonas Karlman's
RFC, not in mainline).
min_freq, max_freq, the userspace governor's set_freq and the cooling
state written while the GPU was runtime suspended take effect on resume,
with no SError; min_freq also after s2idle and deep suspend. 200 runtime
suspend/resume cycles with changing limits. A KUnit test (not posted)
covers the passive governor, the single transition on resume, failing
suspend and resume, and a resume without a suspend.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

[1] https://lore.kernel.org/r/20261110-panthor-suspend-clk-v1-1-53457050e51e@gmail.com
[2] https://lore.kernel.org/r/20261110-devfreq-resume-freq-v1-1-90de450ccbd0@gmail.com
[3] https://lore.kernel.org/r/20261112-panthor-suspend-clk-v2-1-62e1b168052d@gmail.com

---
Changes in v3:
- Run the pending update instead of restoring first, so resume makes
  one transition; the userspace governor without set_freq keeps the
  frequency from before suspend (Sashiko)
- Keep the passive governor out of the pending update, which evaluated
  it with freq 0 (Sashiko)
- Leave devfreq suspended when suspend or resume fails, instead of the
  v2 undo: callers may power the device down regardless. A caller that
  ignores a failed resume recovers on its next suspend and resume (Sashiko)
- Add [2] as 1/2: commit message corrected (lima on RK3528 is the
  mainline case, not panthor), comment shortened
- Rebase on devfreq-next
- Link to v2: https://patch.msgid.link/20261114-devfreq-suspend-sync-v2-1-10f0c3e14245@gmail.com

Changes in v2:
- Keep only the suspend count, now a plain int changed under
  devfreq->lock, instead of a separate suspended flag that could
  disagree with it when suspend and resume race (Sashiko)
- Resume at the resume frequency clamped to the current limits, then
  run the deferred update: the userspace governor without set_freq
  stayed at the suspend frequency (Sashiko)
- Don't defer the passive governor's parent updates: exynos-bus
  children must follow their parent to its suspend frequency, also at
  shutdown (Sashiko)
- Drop pending_freq: the deferred update runs like any update_devfreq()
  call. If it fails, resume logs the error and still sends
  DEVFREQ_GOV_RESUME (Sashiko)
- Undo a failed devfreq_suspend_device(), as rk3399_dmc and lima abort
  without resuming; an unbalanced devfreq_resume_device() is a no-op
  (Sashiko)
- Leave polling governors to their next poll after resume; the driver
  has just reset their load data (Sashiko)
- Link to v1: https://patch.msgid.link/20261112-devfreq-suspend-sync-v1-1-af64603ef43e@gmail.com

---
Arun Iyengar (2):
      PM / devfreq: Resume at the frequency from before suspend
      PM / devfreq: Do not change the frequency of a suspended device

 drivers/devfreq/devfreq.c            | 86 +++++++++++++++++++++++++++++-------
 drivers/devfreq/governor_userspace.c |  3 +-
 include/linux/devfreq.h              | 10 ++++-
 3 files changed, 79 insertions(+), 20 deletions(-)
---
base-commit: f9316c13d6f621af4f6f4a6089d3c989ffe899e6
change-id: 20261112-devfreq-suspend-sync-7ca8fc51550a

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


