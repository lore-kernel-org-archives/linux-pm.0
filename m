Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5893D8111
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932033; cv=none; b=Wdz/J/0++GjMsI0Dyml3z8HFoLIGNrwzTRPxnWIWtHsNTB6mNziIaw7kj3Cur5EclqFQL70I6u5FMMtz3GjzeVg6EpCQYeOVbWmDI8BC6VFjJxkW7DkG2ZSlwswLe5KRURtKburReAmwcVRxWsIbJTuRuJKKxRttEiWGCel+rYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932033; c=relaxed/simple;
	bh=ZTdwzVwbdm4Sdwy4dxuDY5+TL5HQanmuNj4zGFmocMI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BonHw9glGhh5vH9ITlzERD0xN4cdSNAa8mNmxfYqUKagt4fTvIIyVjM+wSgdDIBvGyTL+3ieRmr3fliES4HeDGWh0HnfiYpiAc7PbjlNwTNLDpxGJhpwKMgvsUou/z9oCLtAoolpwek1x6jMSKzcXw+N/iQvah2r+Ilxv1HLScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP411hzQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP411hzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7976BC2BCB0
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 14:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773932033;
	bh=ZTdwzVwbdm4Sdwy4dxuDY5+TL5HQanmuNj4zGFmocMI=;
	h=From:Date:Subject:To:Cc:From;
	b=KP411hzQVnXb7cZug6rOOxjRyt0qQZQTgCfTOnaZkw3ugNWlJJYyru3tqcFxh16oo
	 adqfIihqiz0YfYOzJmpmKtkvU06DmgTt2gUk1MouS6Qt3LEh9G6PvtwET/I7karWU9
	 +8wzWT0TLL2r+L/Y2WE4I5j043fohHMxpY+cWT4Zb+sym1M5+MVkGK/d8LW9+9vYDt
	 z8EcmzOCJEAWsMm3m+jA1LqiVt1Fa6ras4fwSGK5DPXQ73BPPpHa+BqqTTFGDIuqt4
	 k8UTK9mkj/b1QcjY0XTM0gW6btXgfyJKDIiwQgzkEZ46nDxFhQ9PmcD+L3RWvITLtN
	 i7kATLipeWVfg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-417571c6083so706736fac.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 07:53:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YxRq/Pt6WaAHWbekvFb+/z0vFMDDRgS+PynK7koOFoWiPVyN7mX
	W3kYVqoGC2+90g4+/UEgfd4cnNbsIvoGCkAUCJE4S+EnKgWPnGGRoplkmnoVXZIF4iy5hCMiM+8
	EpvwXtAixSsnOEjJu3jF/g89nWqSaszw=
X-Received: by 2002:a05:6870:fb9e:b0:417:4320:26fd with SMTP id
 586e51a60fabf-41bd3e3e95dmr5136544fac.7.1773932032572; Thu, 19 Mar 2026
 07:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Mar 2026 15:53:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jQxkAKLgx9e7FqdWq67EO_97=A9kyT_Yd2QQbDZakUjw@mail.gmail.com>
X-Gm-Features: AaiRm53RoadodDcdXqjvIKlZ4rPBLotQ8lXrqQ8wxK17ifFAezu4gCraY25W53c
Message-ID: <CAJZ5v0jQxkAKLgx9e7FqdWq67EO_97=A9kyT_Yd2QQbDZakUjw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v7.0-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.0-rc5

with top-most commit 9633370653151a0d5637634d1887d2f32511e69f

 Merge branch 'pm-runtime'

on top of commit f338e77383789c0cae23ca3d48adcc5e9e137e3c

 Linux 7.0-rc4

to receive power management fixes for 7.0-rc5.

These fix an idle loop issue exposed by recent changes and a race
condition related to device removal in the runtime PM core code:

 - Consolidate the handling of two special cases in the idle loop that
   occur when only one CPU idle state is present (Rafael Wysocki)

 - Fix a race condition related to device removal in the runtime PM
   core code that may cause a stale device object pointer to be
   dereferenced (Bart Van Assche)

Thanks!


---------------

Bart Van Assche (1):
      PM: runtime: Fix a race condition related to device removal

Rafael J. Wysocki (1):
      sched: idle: Consolidate the handling of two special cases

---------------

 drivers/base/power/runtime.c |  1 +
 kernel/sched/idle.c          | 30 +++++++++++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)
