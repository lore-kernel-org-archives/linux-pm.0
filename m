From: Thomas Renninger <trenn@suse.de>
Subject: Re: cpupower reports uninitialized values for offline cpus
Date: Thu, 01 Oct 2015 14:29:59 +0200
Message-ID: <3211183.5fvOAutzxZ@skinner>
References: <560ADF55.6090901@redhat.com> <2397035.37ChXSYNtU@skinner> <560C292B.5030905@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47973 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754923AbbJAMaC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Oct 2015 08:30:02 -0400
In-Reply-To: <560C292B.5030905@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Jacob Tanenbaum <jtanenba@redhat.com>, linux-pm@vger.kernel.org

On Wednesday, September 30, 2015 02:25:47 PM Prarit Bhargava wrote:
> On 09/30/2015 12:23 PM, Thomas Renninger wrote:
...
> Yeah, we'd have to add an additional state to the CPU hotplug callback state
> machine (CPU_ADD_PHYSICAL?) to identify when a cpu was hot-added.  I
> suppose it could be done but it seems like an awful lot of churn for little
> gain.

It shouldn't be that hard.
If I find some time I give it a try.
This is a rather central piece of kernel code and affects
more or less all architectures, so getting this finally mainline
may take a while...

So it would be nice if somewhen in the future we have 2 independent
fixes:

The cpupower one as you wrote before, ignoring cores without
topology sysfs info (but not simply checking for "is core offline"),
better check whether the directory or a specific file exists.

And a kernel one which still shows topology info of soft offlined
cores which with above cpupower solution will result in previous
output (offlined cores listed, but with valid topology info).

Makes sense?

      Thomas
