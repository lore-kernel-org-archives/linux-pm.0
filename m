From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: parallel suspend/resume
Date: Sat, 8 Dec 2007 17:00:04 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0712081658290.7082-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0712081119080.29812-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0712081119080.29812-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 8 Dec 2007, Alan Stern wrote:

> On Fri, 7 Dec 2007, David Brownell wrote:
> 
> > FWIW the appended patch removes that rude "order of registration"
> > policy, so that the suspend/resume list matches the device tree.
> > It's behaved OK on PCs and, in light duty, a few development boards;
> > I've carried it around most of this year.
> 
> Actually I'm surprised that it works with USB devices.
> 
> As they are registered, you patch adds new devices to the list
> immediately after their parents.  This means that the children of a
> particular device will be listed in reverse order of registration,
> right?
> 
> So if you have a USB hub, the hub's children will be added following 
> the hub, and the hub's interface will come after all the children since 
> it gets registered before them.  Hence during suspend, the interface's 
> suspend method will be called before any of the children are suspended.  
> But hub_suspend() will fail if there are unsuspended children.

I take it back.  Interfaces get suspended along with their device;
hence it doesn't matter in what order the interface is listed with
respect to the children.

Alan Stern
