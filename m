From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [regression] cross core scheduling frequency drop bisected to
 0c313cb20732
Date: Sat, 9 Apr 2016 13:08:07 +0200
Message-ID: <20160409110807.GT3448@twins.programming.kicks-ass.net>
References: <1460092854.4051.1.camel@gmail.com>
 <20160408064510.GK3448@twins.programming.kicks-ass.net>
 <1460098254.5582.17.camel@gmail.com>
 <2428384.mEkP3EOpsR@vostro.rjw.lan>
 <001101d191e4$b00602d0$10120870$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:49917 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbcDILIJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Apr 2016 07:08:09 -0400
Content-Disposition: inline
In-Reply-To: <001101d191e4$b00602d0$10120870$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Mike Galbraith' <umgwanakikbuti@gmail.com>, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>, 'Rik van Riel' <riel@redhat.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>

On Fri, Apr 08, 2016 at 03:19:14PM -0700, Doug Smythies wrote:
> Could you send me, or point me to, the program "pipe-test"?
> So far, I have only found one, but it is both old and not
> the same program you are running (based on print statements).

The latest public one lives as: perf bench sched pipe

