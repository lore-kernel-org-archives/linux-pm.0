From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Possible problem with device_move()
Date: Mon, 6 Aug 2007 09:53:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708060952180.3265-100000@iolanthe.rowland.org>
References: <20070806113141.2289e5e3@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070806113141.2289e5e3@gondolin.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-pm@lists.linux-foundation.org, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 6 Aug 2007, Cornelia Huck wrote:

> On Fri, 3 Aug 2007 23:39:31 +0200,
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > > Suggested functions:
> > > 
> > >      1. Move A in front of B, together with all of A's ancestors which
> > > 	aren't already ahead of B (or maybe require that A's parent be
> > > 	ahead of B already).
> 
> I'd prefer "move includes ancestors" as not to introduce another
> possibility where users can get it wrong.

We'll see how it ends up being used.  If we check that A's parent is 
already ahead of B then callers won't be able to get it wrong.

Alan Stern
