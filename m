From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [GIT PULL] kernel/time cleanups (related to tick_suspend/resume)
Date: Wed, 01 Apr 2015 00:45:07 +0200
Message-ID: <1905859.5HhZc2HfYG@vostro.rjw.lan>
References: <20150216121435.203983131@infradead.org> <4241632.Wi7SZdKMQs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61004 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750836AbbCaWUy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2015 18:20:54 -0400
In-Reply-To: <4241632.Wi7SZdKMQs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, tglx@linutronix.de, Linux PM list <linux-pm@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>

Hi Ingo,

Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git tick-pm

to receive kernel/time cleanups related to tick_suspend/resume from Thomas Gleixner
that I've rebased on top of the Linus' tree and reworked slightly.

There will be a conflict between this branch and tip that can be resolved with
the help of the patch from Stephen Rothwell available at:

http://marc.info/?l=linux-kernel&m=142778874014355&w=4

Kind regards,
Rafael

