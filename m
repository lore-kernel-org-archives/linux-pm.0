From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH -mm] Freezer: Handle uninterruptible
	tasks
Date: Mon, 9 Jul 2007 10:45:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707091043480.3851-100000__45358.9609860957$1183992408$gmane$org@iolanthe.rowland.org>
References: <87odimw6k3.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87odimw6k3.fsf@jbms.ath.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Mon, 9 Jul 2007, Jeremy Maitin-Shepard wrote:

> Pavel Machek <pavel@ucw.cz> writes:
> 
> [snip]
> 
> > I don't know how to do that mechanism... but if we knew where to trap
> > filesystem writes, we could simply freeze at that point, and at that
> > point only, no?
> 
> Any operation at all that has an external effect must not occur after
> the snapshot is made; otherwise, there will be random hard-to-find
> corruptions and other problems occurring as a result.  Thus, for
> example, any writes (either directly or indirectly through e.g. a
> filesystem) to non-volatile storage, any network traffic, any
> communication with hardware like a printer must be prevented after the
> snapshot.

You have forgotten one critical point: The writes to save the snapshot 
image must be allowed.  That's what makes it really hard.

Alan Stern
