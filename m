From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: parallel suspend/resume
Date: Sat, 8 Dec 2007 10:43:25 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0712081037001.28689-100000@netrider.rowland.org>
References: <200712080900.45623.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712080900.45623.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 8 Dec 2007, Oliver Neukum wrote:

> Am Freitag, 7. Dezember 2007 19:01:12 schrieb David Brownell:
> > FWIW the appended patch removes that rude "order of registration"
> > policy, so that the suspend/resume list matches the device tree.
> > It's behaved OK on PCs and, in light duty, a few development boards;
> > I've carried it around most of this year.
> 
> As it is a tree, why not store it as such?

There's no need to "store" the tree ordering specially, since all the
pointers already exist.  The question is: In what order should the tree
be traversed?  About the only explicit constraint we have now is that
children must be suspended before their parents, but there undoubtedly
are plenty of undocumented implicit constraints (maybe some of them
aren't known to anybody at all).

Given the vast number of possible orders, and given that the only order 
we _know_ works correctly is reverse order of registration, I don't see 
any big reason to change.  Speeding things up by parallel suspension 
would be a valid reason, but it needs to be done with a great deal of 
care.

Alan Stern
