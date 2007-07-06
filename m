From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Fri, 6 Jul 2007 11:13:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707061111050.3737-100000__11500.101167667$1183734839$gmane$org@iolanthe.rowland.org>
References: <1183676393.3388.89.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183676393.3388.89.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kernel development list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 6 Jul 2007, Benjamin Herrenschmidt wrote:

> Why are you guys working so hard and spending so much energy to try to
> avoid doing the right thing is beyond my understanding...
> 
> > It _does_ apply to kernel threads.  That's exactly why I wrote above 
> > that kernel threads which try to do I/O during a suspend will need 
> > extra attention.
> 
> Ok none at all if you don't have a freezer.

In answer to both questions: We need the freezer in order to implement 
hibernate.  Even if we take your advice and stop using the freezer 
during suspend, these issues would still remain and would need to be 
solved.

Alan Stern
