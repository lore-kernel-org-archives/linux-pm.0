From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Added multiplier for APERF and MPERF counters
Date: Sat, 19 Sep 2015 00:17:36 +0200
Message-ID: <15373816.LjezmY7jZV@vostro.rjw.lan>
References: <1442407938-5228-1-git-send-email-lukasz.anaczkowski@intel.com> <6353648.5IiCL7fVmQ@vostro.rjw.lan> <C1C2579D7BE026428F81F41198ADB172378E74B2@irsmsx110.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54005 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754412AbbIRVtc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Sep 2015 17:49:32 -0400
In-Reply-To: <C1C2579D7BE026428F81F41198ADB172378E74B2@irsmsx110.ger.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Chandramouli, Dasaratharaman" <dasaratharaman.chandramouli@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chrzaniuk, Hubert" <hubert.chrzaniuk@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Friday, September 18, 2015 07:08:47 AM Anaczkowski, Lukasz wrote:
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net] 
> Sent: Thursday, September 17, 2015 7:05 PM
> 
> > Please *always* send PM-related patches to linux-pm@vger.kernel.org (CCed now).
> 
> Ok, thanks for noticing.
> I've addressed my patch based on output of ./scripts/get_maintainer.pl
> and gave me output like this:
> 
> Len Brown <len.brown@xxx>
> Dasaratharaman Chandramouli <dasaratharaman.chandramouli@xxx>
> linux-kernel@vger.kernel.org
> 
> Should it be fixed somehow?

Well, so to speak, the script is not an intelligent entity and while it can
give you hints, it by no means is an ultimate source of information.

If you did "grep -r -I -l APERF *" in the kernel source tree, you'll
immediately see that PM uses it.

And while at it, we really should only be using the APERF/MPERF ratio so I'm
not sure why this patch actually matters?

Thanks,
Rafael

