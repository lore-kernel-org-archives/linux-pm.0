From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 00/20] clockevents_notify() removal
Date: Thu, 2 Apr 2015 14:39:35 +0200
Message-ID: <20150402123935.GA31934@gmail.com>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36300 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbbDBMjk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 08:39:40 -0400
Content-Disposition: inline
In-Reply-To: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>


* Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> Hi,
> 
> This is the next batch of patches from Thomas that remove clockevents_notify().
> 
> I've reordered the set (to put more stratightforward things to the front) and
> rebased it on top of the timers material currently queued up for 4.1.
> 
> This series in based on the bleeding-edge branch of the linux-pm tree (which
> for all practical purposes is my linux-next branch with timers/core from tip
> merged into it).
> 
> Please let me know how to proceed with these.

Would you mind to resend these merged on top of the very latest 
tip:timers/core (or tip:master) tree?

These changes conflict (mildly) with the other series from Thomas 
which needed some fixes/enhancements.

Thanks,

	Ingo
