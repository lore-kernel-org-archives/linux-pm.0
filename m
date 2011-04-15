From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Make power domain callbacks take
 precedence over subsystem ones
Date: Fri, 15 Apr 2011 10:34:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104151033020.2051-100000__40791.9326368303$1302878135$gmane$org@iolanthe.rowland.org>
References: <201104150045.54904.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104150045.54904.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 15 Apr 2011, Rafael J. Wysocki wrote:

> On Thursday, April 14, 2011, Magnus Damm wrote:

> > My only thought on this is if we really want to limit ourselves to
> > only control power domains using these callbacks. I can imagine that
> > some SoCs want to do other non-power domain specific operations with
> > these callbacks, and if so, perhaps using the term power domain as
> > name of the pointer in struct device would be somewhat odd. OTOH, I
> > really dislike naming discussions in general and I can't really think
> > of any good names. So it all looks more like a set of system specific
> > PM override hooks.
> > 
> > Or is there something that is really power domain specific with these hooks?
> 
> Not in principle, but I think there is.  Namely, if there are two groups
> of devices belonging to the same bus type (e.g. platform) that each require
> different PM handling, it is legitimate to call them "power domains" (where
> "domain" means "a set of devices related to each other because of the way
> they need to be handled"), even if they don't share power resources.
> 
> Of course, if they do share power resources, the term is just right. :-)

They could be called "PM domains" instead of "power domains".  That's 
legitimate because they do get used by the PM core, even if they don't 
literally involve groups of devices sharing the same power supply.

Alan Stern
