From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 22:27:58 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912072225390.4179-100000__42590.0551410907$1260242946$gmane$org@netrider.rowland.org>
References: <200912080051.13061.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912080051.13061.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:

> However, the parent can be on a different bus type than the children, so it
> looks like we can only start the asynchronous path at the core level.

Agreed.

> > Unless you want to do _all_ of the async logic in generic code and 
> > re-introduce the "dev->async_suspend" flag.
> 
> Quite frankly, I would like to.
> 
> > I would be ok with that now that the infrastructure seems so simple.
> 
> Well, perhaps I should dig out my original async suspend/resume patches
> that didn't contain all of the non-essential stuff and post them here for
> discussion, after all ...

That seems like a very good idea.  IIRC they were quite similar to what 
we have been discussing.

Alan Stern
