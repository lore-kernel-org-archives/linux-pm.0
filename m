From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH] hibernation should work ok with memory hotplug
Date: Thu, 6 Nov 2008 09:48:22 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811060947250.2456-100000@iolanthe.rowland.org>
References: <1225936818.6216.20.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751553AbYKFOsd@vger.kernel.org>
In-Reply-To: <1225936818.6216.20.camel@nigel-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Matt Tolentino <matthew.e.tolentino@intel.com>, linux-pm@lists.osdl.org, Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org, Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org, pavel@suse.cz, Mel Gorman <mel@skynet.ie>, Andy Whitcroft <apw@shadowen.org>, Yasunori Goto <y-goto@jp.fujitsu.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 6 Nov 2008, Nigel Cunningham wrote:

> Remember that when we hibernate (assuming we don't then suspend to ram),
> the power is fully off. Resuming starts off like a fresh boot.

That simply is not true.  On ACPI systems, hibernation goes into the S4 
state.  Power fully off is S5.

Alan Stern
