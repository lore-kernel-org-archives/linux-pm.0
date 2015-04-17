From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/5] intel_pstate: Use C0 time, calculate target pstate directly
Date: Fri, 17 Apr 2015 02:46:13 +0200
Message-ID: <2686720.CT1omYuSKq@vostro.rjw.lan>
References: <1428811830-15006-1-git-send-email-dsmythies@telus.net> <002801d07863$591554d0$0b3ffe70$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57493 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750820AbbDQAVj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2015 20:21:39 -0400
In-Reply-To: <002801d07863$591554d0$0b3ffe70$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, kristen@linux.intel.com
Cc: linux-pm@vger.kernel.org

On Thursday, April 16, 2015 09:35:26 AM Doug Smythies wrote:
> On 2015.04.11 09:10 Doug Smythies wrote:
> 
> > Patch 1 basically adds better debug information to the
> > perf data. It was originally requested in June, and Dirk agreed
> > to include it in September. Regardless of the acceptance or
> > rejection of this whole patch set, please accept this one.
> > scripts/checkpatch.pl complains about one line as over 80
> > characters, not sure how to split the line.
> 
> Please consider to accept patch 1 of 5 for inclusion
> in Kernel 4.1RC1.
> 
> I understand the need to do regression and multiple platform
> testing on the rest of the patch set, but this one
> just adds some useful debug information.

Kristen, what do you think?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
