From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/2] PM: Reduce code duplication in the
	core suspend code
Date: Mon, 11 Jun 2007 00:43:15 +0200
Message-ID: <200706110043.15933.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0706101635510.31578-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0706101635510.31578-100000@netrider.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sunday, 10 June 2007 22:37, Alan Stern wrote:
> On Sun, 10 Jun 2007, Rafael J. Wysocki wrote:
> 
> > On Sunday, 10 June 2007 16:55, Alan Stern wrote:
> > > On Sun, 10 Jun 2007, Rafael J. Wysocki wrote:
> > > 
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > 
> > > > Reduce code duplication in drivers/base/suspend.c by introducing an inline
> > > > function for printing diagnostic messages.
> > > 
> > > Could you save object-code space by making the function non-inline?  
> > > It looks complicated enough.
> > 
> > I thought I would do that, but then I thought I'd want it to be compiled out if
> > dev_dbg() were a noop (like when the debugging is off).
> 
> You can always do something like this:
> 
> #ifdef DEBUG
> 
> static void print_msg(...)
> {
> ...
> }
> 
> #else
> 
> static inline void print_msg(...)
> { }
> #endif

Well, IMHO, that doesn't look very nice. ;-)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
