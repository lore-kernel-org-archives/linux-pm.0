From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/2] Some changes to "cpupower frequency-info" command
Date: Tue, 10 Nov 2015 17:12:53 +0100
Message-ID: <2325479.e5jlCo6cZ6@skinner>
References: <1447097219-31370-1-git-send-email-jtanenba@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32820 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753940AbbKJQMy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 10 Nov 2015 11:12:54 -0500
In-Reply-To: <1447097219-31370-1-git-send-email-jtanenba@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Tanenbaum <jtanenba@redhat.com>
Cc: linux-pm@vger.kernel.org, prarit@redhat.com

On Monday, November 09, 2015 02:26:57 PM Jacob Tanenbaum wrote:
> patch 1:
>   - makes every command return a printed message
>   - refactors so that debug_output_one uses the functions already in place
>     to get the various values to print

This one looks sane. Let me play a bit with it and I add it to my submit queue
if I do not find anything suspicious.

> 
> patch 2:
>   - fixed bug in how cpuinfo_transition_latency value is interpreted

This is a nice bug fix.

> 
> Jacob Tanenbaum (2):
>   rework the "cpupower frequency-info" command
>   fix how "cpupower frequency-info" interprets latency

Thanks!

      Thomas
