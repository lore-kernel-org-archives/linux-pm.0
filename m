From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: parallel suspend/resume
Date: Sat, 8 Dec 2007 21:43:25 +0100
Message-ID: <200712082143.26388.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0712081037001.28689-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0712081037001.28689-100000@netrider.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, 8 of December 2007, Alan Stern wrote:
> On Sat, 8 Dec 2007, Oliver Neukum wrote:
> 
> > Am Freitag, 7. Dezember 2007 19:01:12 schrieb David Brownell:
> > > FWIW the appended patch removes that rude "order of registration"
> > > policy, so that the suspend/resume list matches the device tree.
> > > It's behaved OK on PCs and, in light duty, a few development boards;
> > > I've carried it around most of this year.
> > 
> > As it is a tree, why not store it as such?
> 
> There's no need to "store" the tree ordering specially, since all the
> pointers already exist.  The question is: In what order should the tree
> be traversed?  About the only explicit constraint we have now is that
> children must be suspended before their parents, but there undoubtedly
> are plenty of undocumented implicit constraints (maybe some of them
> aren't known to anybody at all).

Yes, that makes me nervous every time someone suggests to change the ordering
of suspending devices.

> Given the vast number of possible orders, and given that the only order 
> we _know_ works correctly is reverse order of registration, I don't see 
> any big reason to change.  Speeding things up by parallel suspension 
> would be a valid reason, but it needs to be done with a great deal of 
> care.

Agreed.

Greetings,
Rafael
