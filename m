From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: suspend regression in 4.1-rc1
Date: Mon, 18 May 2015 10:41:34 +0200
Message-ID: <20150518084134.GH16478@twins.programming.kicks-ass.net>
References: <20150517185041.GA5897@dhcp22.suse.cz>
 <CA+55aFy2wWy-k0O-Sb2vUCLiLjeKMu7r95bf294qP5UqQHuxfw@mail.gmail.com>
 <20150518073046.GO17717@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44038 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbbERIls (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 04:41:48 -0400
Content-Disposition: inline
In-Reply-To: <20150518073046.GO17717@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.cz>, Stephane Eranian <eranian@google.com>, Ulrich Obergfell <uobergfe@redhat.com>, Don Zickus <dzickus@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, May 18, 2015 at 09:30:46AM +0200, Peter Zijlstra wrote:
> Let me go see if I can reproduce / test this.. as is the below is
> entirely untested.

I cannot seem to get suspend to fail on my x240 with linus.git.

echo mem > /sys/power/state

makes it sleep, and pressing the power button brings it back to life.

And this is with X loaded and everything up (well, except the wireless,
as it turns out I need a newer firmware version).

So I'll have to ask someone else to test this :/
