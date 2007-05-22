From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: Singlethread vs. freezable workqueues
Date: Tue, 22 May 2007 20:26:22 +0400
Message-ID: <20070522162622.GA668@tv-sign.ru>
References: <20070522124520.GA256@tv-sign.ru>
	<Pine.LNX.4.44L0.0705221100260.3391-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0705221100260.3391-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 05/22, Alan Stern wrote:
>
> On Tue, 22 May 2007, Oleg Nesterov wrote:
> 
> > Probably Alan is right? Perhaps it is better to rename it to
> > create_singlethread_freezeable_workqueue(). This way we don't need to audit
> > the users when we add multithread freezable wqs.
> > 
> > Also, this name is more consistent wrt
> > create_workqueue/create_singlethread_workqueue.
> 
> I already sent in a revised patch and a request to revert the 
> create_singlethread_freezeable_workqueue() macro!
> 
> Whatever you guys decide, please let Greg and me know as soon as
> possible.  This particular fix is needed before 2.6.22 gets released.

Ah, I am sorry for the confusion, I didn't see the start of this thread.

Please do what you think right.

Oleg.
