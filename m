From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 01/70] cpufreq: interactive: New 'interactive' governor
Date: Mon, 2 Nov 2015 15:02:55 +0100
Message-ID: <20151102140255.GS17308@twins.programming.kicks-ass.net>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
 <4534884.dsz2GVUDrG@vostro.rjw.lan>
 <20151028030042.GD13324@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:52692 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbbKBOC7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2015 09:02:59 -0500
Content-Disposition: inline
In-Reply-To: <20151028030042.GD13324@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?iso-8859-1?Q?B=E1lint?= Czobor <czoborbalint@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mike Chan <mike@android.com>, Todd Poynor <toddpoynor@google.com>, Ingo Molnar <mingo@kernel.org>

On Wed, Oct 28, 2015 at 08:30:42AM +0530, Viresh Kumar wrote:
> These are the last memories I have around upstreaming this governor:
> http://marc.info/?l=linux-kernel&m=132867057910479&w=2
> 
> Has anything changed after that? Or we decided to go ahead with it and
> upstream ?

Urgh, I thought we were trying to kill all the various governors by
integrating the lot with the scheduler !?
