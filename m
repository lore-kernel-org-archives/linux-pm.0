From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Wed, 4 Jul 2007 11:04:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707041057230.25704-100000__16329.1390556426$1183562026$gmane$org@netrider.rowland.org>
References: <18059.7151.841436.329553@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18059.7151.841436.329553@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Jul 2007, Paul Mackerras wrote:

> Alan Stern writes:
> 
> > > Most drivers suspended their hardware in the second call.  If they are
> > > in the middle of a conversation with their device that *has* to be
> > > completed, they can do that by polling.
> > 
> > Ugh.  That will cause problems when you try to integrate runtime 
> > suspend.  In fact this whole approach is unsuitable for runtime PM and 
> > it obscures the similarities between runtime PM and STR.
> 
> Yes there are similarities, but it would be a big mistake to say that
> a requirement for STR is that all drivers do runtime PM.

That's not what I'm saying.  What I'm saying is that it would be a big 
mistake to force all drivers which implement runtime PM to do it using 
a separate code path from system PM.

> The main attraction of the late-suspend call is that it really does,
> reliably, guarantee that the driver's I/O request methods won't get
> called between the late-suspend call and the early-resume call.

For some drivers (like USB), carrying out an actual suspend requires a
delay.  Right now we implement those delays using wait_event(),
wait_for_completion(), and so on.  Would you have us check at runtime
whether or not a system suspend is underway and in each case use a
busy-loop instead if it is?

What happens if, in order to carry out the late-suspend, a driver needs
to acquire a mutex which happens to be held by some other task?  That
other task won't be able to run and release the mutex, so you will
deadlock.

Alan Stern
