From: Thomas Renninger <trenn@suse.de>
Subject: Re: cpupower reports uninitialized values for offline cpus
Date: Wed, 30 Sep 2015 18:23:58 +0200
Message-ID: <2397035.37ChXSYNtU@skinner>
References: <560ADF55.6090901@redhat.com> <560AF3CB.1090401@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47977 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754459AbbI3QYA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Sep 2015 12:24:00 -0400
In-Reply-To: <560AF3CB.1090401@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Jacob Tanenbaum <jtanenba@redhat.com>, linux-pm@vger.kernel.org

On Tuesday, September 29, 2015 04:25:47 PM Prarit Bhargava wrote:
> On 09/29/2015 02:58 PM, Jacob Tanenbaum wrote:
> > Hi guys,
> > 
> > I have found a bug in the cpupower tool. In the most recent pull of
> > linus's tree cpupower reports bogus information for offlined cpus.
...
> Thomas,
> 
> I'm not sure I see any benefit in reporting the offline cpu status here.
There have been discussions to use CPU offlining as a power saving mechanism.
This is afaik no real option on x86, at least not too frequent, but it could
be on other archs?
So the info would be nice to have...

> We
> could I suppose output a message at the beginning of the output to indicate
> that some cpus have been hotplugged, but I'm not sure that is even
> necessary.
Yep, just that people do not complain that cores are missing...
May make sense.
 
> I would prefer changing cpupower to reporting only online CPUs, but there's
> probably some situation I'm unaware of that we need to report offline cpu
> status.
> >   2. When printing the results check if the cpu is offline and if it is
> >   obscure> 
> > the incorrect information and change the cpu->pkg
> >      value to reflect all sockets with at least one online cpu.

Hm, not sure how difficult to implement that is right now, but IMO info should
be set to -1 if the files do not exist or initialized with -1.
In this case there is no sane info to show and the cores need not to show up.

> 
> This is papering over the issue IMO, but still an option.
> 
> >   3. Change the sysfs to retain topology data for offlined cpus, may
> >   require

I had a quick look. I think this could be done.
/sys/devices/system/cpu/cpu*/cpuidle
also is kept, not sure why, because I cannot see any advantage to access
this info on an offlined CPU.

But reading the topology of offlined CPUs makes sense.
Argh, but yes. For real on-/offlining this is hard...

    Thomas
