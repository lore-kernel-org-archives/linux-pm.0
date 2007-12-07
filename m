From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: parallel suspend/resume
Date: Fri, 7 Dec 2007 11:22:08 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0712071120400.4209-100000@iolanthe.rowland.org>
References: <20071207155122.GA4252@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071207155122.GA4252@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <marcelo@kvack.org>, Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 7 Dec 2007, Pavel Machek wrote:

> On Mon 2007-10-08 15:46:39, Marcelo Tosatti wrote:
> > Hi,
> > 
> > I spent some time working with the parallel suspend/resume idea, even
> > wrote a simple patch (attached), but that obviously does not scale to
> > large number of devices.
> > 
> > What would be a better approach? 
> 
> No idea, but thread per device does not seem _that_ bad. Debuggability
> worries me more.

What about ordering constraints?  A lot of them aren't explicit.  We 
just depend on the fact that devices get suspended in reverse order of 
registration.  You can't do that in parallel.

Alan Stern
