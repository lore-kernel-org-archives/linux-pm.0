From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 1/2] PM: Reduce code duplication in the
	core suspend code
Date: Sun, 10 Jun 2007 16:37:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706101635510.31578-100000@netrider.rowland.org>
References: <200706101842.54871.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706101842.54871.rjw@sisk.pl>
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
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sun, 10 Jun 2007, Rafael J. Wysocki wrote:

> On Sunday, 10 June 2007 16:55, Alan Stern wrote:
> > On Sun, 10 Jun 2007, Rafael J. Wysocki wrote:
> > 
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > Reduce code duplication in drivers/base/suspend.c by introducing an inline
> > > function for printing diagnostic messages.
> > 
> > Could you save object-code space by making the function non-inline?  
> > It looks complicated enough.
> 
> I thought I would do that, but then I thought I'd want it to be compiled out if
> dev_dbg() were a noop (like when the debugging is off).

You can always do something like this:

#ifdef DEBUG

static void print_msg(...)
{
...
}

#else

static inline void print_msg(...)
{ }
#endif

Alan Stern
