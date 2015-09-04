From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpupower tools: Fix error when running cpupower monitor
Date: Fri, 04 Sep 2015 16:51:47 +0200
Message-ID: <3332765.Ktj2LzF70A@vostro.rjw.lan>
References: <1438582560-13352-1-git-send-email-shreyas@linux.vnet.ibm.com> <55DC58BD.4070108@linux.vnet.ibm.com> <55E7E6E2.3090900@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55E7E6E2.3090900@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Cc: Thomas Renninger <trenn@suse.de>, pavsubra@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, September 03, 2015 11:51:22 AM Shreyas B Prabhu wrote:
> 
> On 08/25/2015 05:29 PM, Shreyas B Prabhu wrote:
> > 
> > 
> > On 08/17/2015 01:22 PM, Shreyas B Prabhu wrote:
> >>
> >>
> >> On 08/10/2015 05:58 PM, Thomas Renninger wrote:
> >>> On Monday, August 03, 2015 11:46:00 AM Shreyas B. Prabhu wrote:
> >>>> get_cpu_topology() tries to get topology info from all cpus by reading
> >>>> files in the topology sysfs dir. If a cpu is offlined, since it doesn't
> >>>> have topology dir, this function fails and returns -1. This causes
> >>>> functions relying on get_cpu_topology() to fail. For example-
> >>>>
> >>>> $ cpupower monitor
> >>>> Cannot read number of available processors
> >>>>
> >>>> Fix this by skipping fetching topology info for offline cpus.
> >>>
> >>> Looks fine.
> >>>
> >>> Thanks!
> >>>
> >>> Acked-by: Thomas Renninger <trenn@suse.de>
> >>>
> >>
> >> Thanks Thomas!
> >> Rafael, can you please pick this patch?
> >>
> >>
> > 
> > 
> > Hi Rafael,
> > 
> > If this patch looks good can you please pick this up?
> > 
> > 
> > Thanks,
> > Shreyas
> > 
> 
> Hi Rafael,
> 
> If this patch looks good can you please pick this up?

I picked it up last week, sorry for being silent about that.

It should be in the Linus' tree already.

Thanks,
Rafael
