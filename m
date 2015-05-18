From: Michal Hocko <mhocko@suse.cz>
Subject: Re: suspend regression in 4.1-rc1
Date: Mon, 18 May 2015 14:03:49 +0200
Message-ID: <20150518120348.GA8787@dhcp22.suse.cz>
References: <20150517185041.GA5897@dhcp22.suse.cz>
 <CA+55aFy2wWy-k0O-Sb2vUCLiLjeKMu7r95bf294qP5UqQHuxfw@mail.gmail.com>
 <20150518073046.GO17717@twins.programming.kicks-ass.net>
 <20150518090336.GA6393@dhcp22.suse.cz>
 <670732402.598272.1431943820988.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33897 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbbERMDw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 08:03:52 -0400
Content-Disposition: inline
In-Reply-To: <670732402.598272.1431943820988.JavaMail.zimbra@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulrich Obergfell <uobergfe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, Don Zickus <dzickus@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon 18-05-15 06:10:20, Ulrich Obergfell wrote:
[...]
> Michal,
> 
> if I understand you correctly, Peter's patch solves the problem for you.
> I would like to make you aware of a patch that Don and I posted in April.
> 
>   https://lkml.org/lkml/2015/4/22/306
> 
> watchdog_nmi_enable_all() should not use 'watchdog_user_enabled' at all.
> It should rather check the NMI_WATCHDOG_ENABLED bit in 'watchdog_enabled'.
> The patch is also in Andrew Morton's queue.
> 
>   http://ozlabs.org/~akpm/mmots/broken-out/watchdog-fix-watchdog_nmi_enable_all.patch

FWIW: This seems to fix my issue as well.
-- 
Michal Hocko
SUSE Labs
