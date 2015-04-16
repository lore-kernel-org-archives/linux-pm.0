From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 0/5] intel_pstate: Use C0 time, calculate target pstate directly
Date: Thu, 16 Apr 2015 09:35:26 -0700
Message-ID: <002801d07863$591554d0$0b3ffe70$@net>
References: <1428811830-15006-1-git-send-email-dsmythies@telus.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta6.telus.net ([209.171.16.79]:56282 "EHLO cmta6.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067AbbDPQf3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 16 Apr 2015 12:35:29 -0400
In-Reply-To: <1428811830-15006-1-git-send-email-dsmythies@telus.net>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen@linux.intel.com, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

On 2015.04.11 09:10 Doug Smythies wrote:

> Patch 1 basically adds better debug information to the
> perf data. It was originally requested in June, and Dirk agreed
> to include it in September. Regardless of the acceptance or
> rejection of this whole patch set, please accept this one.
> scripts/checkpatch.pl complains about one line as over 80
> characters, not sure how to split the line.

Please consider to accept patch 1 of 5 for inclusion
in Kernel 4.1RC1.

I understand the need to do regression and multiple platform
testing on the rest of the patch set, but this one
just adds some useful debug information.


