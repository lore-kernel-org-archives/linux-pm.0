From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: parallel suspend/resume
Date: Sat, 8 Dec 2007 21:46:46 +0100
Message-ID: <200712082146.47165.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0712071414210.27132-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0712071414210.27132-100000@netrider.rowland.org>
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

On Friday, 7 of December 2007, Alan Stern wrote:
> On Fri, 7 Dec 2007, David Brownell wrote:
> 
> > > What about ordering constraints?  A lot of them aren't explicit.  We 
> > > just depend on the fact that devices get suspended in reverse order of 
> > > registration.  You can't do that in parallel.
> > 
> > Those constraints should *become* explicit ... not stay implicit!
> 
> Why do I get the feeling we've gone through this before?  :-)
> 
> > FWIW the appended patch removes that rude "order of registration"
> 
> "Rude"?  What's rude about it?  It seems most logical to me: Since the
> devices obviously worked in the intermediate stages of registration,
> when the early-to-register devices were available and the
> late-to-register devices weren't, duplicating those same intermediate
> stages (with the same sets of devices available) should also work
> during suspend.
> 
> > policy, so that the suspend/resume list matches the device tree.
> 
> In what respect doesn't it match the device tree now?
> 
> As far as I know, the only way in which the list wouldn't match the
> tree is when the tree gets reorganized by device_move(), which doesn't
> change the list at all.  (This is quite possibly a bug.)

IMO, this _is_ a bug.  I think device_move() should move the device in question
to the end of the list along with its children.

That might cause some breakage in the short run, but we'll have to do it at one
point.

Greetings,
Rafael
