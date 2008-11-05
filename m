From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [linux-pm] [PATCH] hibernation should work ok with memory
 hotplug
Date: Wed, 5 Nov 2008 09:38:37 +0900
Message-ID: <20081105093837.e073c373.kamezawa.hiroyu@jp.fujitsu.com>
References: <20081029105956.GA16347@atrey.karlin.mff.cuni.cz>
	<200811041635.49932.rjw@sisk.pl>
	<1225813182.12673.587.camel@nimitz>
	<200811041734.04802.rjw@sisk.pl>
	<1225817945.12673.602.camel@nimitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757023AbYKEAj1@vger.kernel.org>
In-Reply-To: <1225817945.12673.602.camel@nimitz>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Yasunori Goto <y-goto@jp.fujitsu.com>, Nigel Cunningham <ncunningham@crca.org.au>, Matt Tolentino <matthew.e.tolentino@intel.com>, linux-pm@lists.osdl.org, Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, pavel@suse.cz, Mel Gorman <mel@skynet.ie>, Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 04 Nov 2008 08:59:05 -0800
Dave Hansen <dave@linux.vnet.ibm.com> wrote:

> On Tue, 2008-11-04 at 17:34 +0100, Rafael J. Wysocki wrote:
> > Now, I need to do one more thing, which is to check how much memory has to be
> > freed before creating the image.  For this purpose I need to lock memory
> > hotplug temporarily, count pages to free and unlock it.  What interface should
> > I use for this purpose? 
> > 
> > [I'll also need to lock memory hotplug temporarily during resume.]
> 
> We currently don't have any big switch to disable memory hotplug, like
> lock_memory_hotplug() or something. :)
> 
> If you are simply scanning and counting pages, I think the best thing to
> use would be the zone_span_seq*() seqlock stuff.  Do your count inside
> the seqlock's while loop.  That covers detecting a zone changing while
> it is being scanned.
> 
> The other case to detect is when a new zone gets added.  These are
> really rare.  Rare enough that we actually use a stop_machine() call in
> build_all_zonelists() to do it.  All you would have to do is detect when
> one of these calls gets made.  I think that's a good application for a
> new seq_lock.
> 
> I've attached an utterly untested patch that should do the trick.
> Yasunori and KAME should probably take a look at it since the node
> addition code is theirs.
> 

Hmm ? I think there is no real requirement for doing hibernation while
memory is under hotplug.

Assume following.
 - memory hotplug can be triggerred by
    1. interrupt from system.
    2. "probe" interface in sysfs.
 - ONLINE/OFFLINE is only trigerred by sysfs interface.

I believe we can't block "1", but "1" cannot be raised while hibernation.
(If it happens, it's mistake of the firmware.)

"probe" interface can be triggered from userland. Then it may be worth to be
blocked. How about to add device_pm_lock() to following place ?

  - /sys/device/system/memory/probe
  - ONLINE
  - OFFLINE



off-topic:
BTW, I hear hibernation can be done by kexec + kexec-tools.
If so, boot option for disabling memory hotplug is enough for us, isn't it ?
Or there is long way to make use of it in real world ?

Thanks,
-Kame
















> -- Dave
> 
