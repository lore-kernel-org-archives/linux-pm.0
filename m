Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8C2EDD6C;
	Mon, 23 Feb 2026 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861247; cv=none; b=SHagQ+HID1QNWjx4VxHkia90XnzFKj4r1CIc2D5u7m/xPTn0nnsvncdZrBmaEB8kK9wYKt12Jjri8+3IpqmEVlDDW6yrt/e0s8quAr1SBCjsV6scpoSaCLuNUHcsAyOgyglZsyq2DPL7K16pgSUwAhjU6xo1qJMEcElCzR6wZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861247; c=relaxed/simple;
	bh=6KqK3Kokr9PTuL04N6S7S6pbl18j/jJvBjYqEnLsud8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BwegTMWV//75yggGIxHZZ5wbE5HNOGh7reF4Vy5aDU7f5+FPvvN4M0yeZPeO/KqA4AltL9V+seKr4n8KTsq86vQfKcfo260F0tRqoVTbof3cdSwEgbWJE1y/jlUKERnE4dQVeGXwzwC6LJOUwwd60i5b/k2AH4zMJBCkTw3JAsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX9ARNsI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX9ARNsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBD1C116C6;
	Mon, 23 Feb 2026 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771861247;
	bh=6KqK3Kokr9PTuL04N6S7S6pbl18j/jJvBjYqEnLsud8=;
	h=From:To:Cc:Subject:Date:From;
	b=TX9ARNsIiS/emThJRBXxir+ijCCjmUPfXaP9HgVa7dE7FsfCet83+B8CygA9sUAxw
	 nagjmmuoKL5ukFee1FNWIbgoZKTAras4y5BIiIrS/hoJtnCGU05GNOZ7aXxV1uNhuT
	 g4sXEDho1EqCAhEb57nBPn5jreehBa40q8gI/GlEyFyDqpx0nvhFRehunNzVAvCWrS
	 WpeSNtDP+UWcVAgUAnize11c0fcZevDStQ0MGCUsOsf2/9EIgSKhCfs2V+QipZo9E2
	 weUz7CQ3c+CO4U62SdrUBMntfKdsBlg0atB0NCB9VYnb0C6174IRtvoWgFUGfn+dL0
	 MF3cLTmgqUkhw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Subject: [PATCH v2 0/2] cpuidle: governor: Modify the handling of stopped tick
Date: Mon, 23 Feb 2026 16:37:21 +0100
Message-ID: <3693525.iIbC2pHGDl@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This is an update of

https://lore.kernel.org/linux-pm/1953482.tdWV9SEqCh@rafael.j.wysocki/

that fixes an issue in the second patch.  The first patch does not change and
the changelog below still applies.

When I was thinking about possible ways to address high CPU wakeup latency on
isolated CPUs resulting from the selection of deep idle states by cpuidle
governors, it occurred to me that it is not always necessary to select a
deep idle state if the scheduler tick has been stopped.  Namely, if a timer
is going to trigger (relatively) shortly, a shallow state may as well be
selected because the timer will kick the CPU out of that state anyway and
getting stuck in it for a long time is not a concern.

Changing the menu governor to take that observation into account is a 2-line
patch, modulo a comment update (patch [1/2]).  Of course, the SAFE_TIMER_RANGE_NS
value is somewhat arbitrary.

Updating the teo governor accordingly is a bit more challenging, but overall it
is a major simplification of the stopped tick handling there, so IMV it is very
much worth doing (patch [2/2]).

By itself, this is not going to help workloads running on isolated CPUs too
much, but if SAFE_TIMER_RANGE_NS were replaced with a per-CPU tunable, that
could help people to configure their systems to avoid the latency issue
mentioned above.

Thanks,
Rafael



