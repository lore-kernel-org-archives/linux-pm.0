From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH update] PM: Introduce core framework for
 run-time PM of I/O devices (rev. 12)
Date: Fri, 7 Aug 2009 09:59:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908070957010.2886-100000__13343.2529903532$1249653648$gmane$org@iolanthe.rowland.org>
References: <200908062350.25426.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908062350.25426.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 6 Aug 2009, Rafael J. Wysocki wrote:

> > If we defer a resume request while a suspend is in progress, then when
> > the suspend finishes should the resume be carried out immediately
> > rather than queued?  I don't see any reason why not.
> 
> Well, it's not very clear what to return to the caller in such a case.  I guess
> we can return -EAGAIN.

I would have said to return 0, just as if the resume had been queued.  
But it doesn't matter very much.

Alan Stern
