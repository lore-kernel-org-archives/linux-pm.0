From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Need lockdep help
Date: Sun, 2 Dec 2007 15:08:18 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0712021506500.4185-100000__4108.40264889902$1196626168$gmane$org@netrider.rowland.org>
References: <20071202120411.2aac7720@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071202120411.2aac7720@laptopd505.fenrus.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2 Dec 2007, Arjan van de Ven wrote:

> > This creates a lockdep violation; each rwsem in turn is locked while 
> > the other is being held.  However the only way this could lead to 
> > deadlock would be if there was already a bug in the system Power 
> > Management code (overlapping notifications).
> 
> or.. modifications to the notifier chain while all this is happening
> (remember: rwsems are fair, once a writer shows up, all readers wait)

But modifications to the notifier chain don't invoke the callout
routines.  Hence they won't try to lock the new rwsem and won't lead to
deadlock.

Alan Stern
