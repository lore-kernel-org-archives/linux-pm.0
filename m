From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH] hibernation should work ok with memory hotplug
Date: Thu, 6 Nov 2008 09:43:40 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811060941200.2456-100000@iolanthe.rowland.org>
References: <20081106091441.6517c072.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753346AbYKFOnx@vger.kernel.org>
In-Reply-To: <20081106091441.6517c072.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Nigel Cunningham <ncunningham@crca.org.au>, Tolentino <matthew.e.tolentino@intel.com>, Hansen <haveblue@us.ibm.com>, linux-pm@lists.osdl.org, Matt@smtp1.linux-foundation.org, Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org, Dave@smtp1.linux-foundation.org, Mel Gorman <mel@skynet.ie>, Andy@smtp1.linux-foundation.org, Whitcroft <apw@shadowen.org>, Yasunori Goto <y-goto@jp.fujitsu.com>, pavel@suse.cz, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 6 Nov 2008, KAMEZAWA Hiroyuki wrote:

> Am I missing some ? Current linux can know PCI/USB hotplug while the
> system is suspended ?

With some machines, yes, it can.  Some computers provide minimal 
"suspend current" to devices while the system is hibernating.  This 
allows the hardware to detect and remember hotplug events, which can 
then be handled when the system wakes up.

Alan Stern
