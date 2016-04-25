From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/1] cpupower: Add cpuidle library
Date: Mon, 25 Apr 2016 16:30:09 +0200
Message-ID: <1685056.NeGEfvDZMv@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45944 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595AbcDYOaL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Apr 2016 10:30:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

Hi,

this is a cleanup I wanted to do for a long time.

I already added the change to our build service and things
still build against the same archs like arm, ppc, x86:
https://build.opensuse.org/package/show/hardware/cpupower

It would be nice to get the one or other review.

Rafael: If you could queue this up for mainline inclusion at some
point of time, I would very much appreciate it!

Thanks,

       Thomas
