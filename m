From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Singlethread vs. freezable workqueues
Date: Tue, 22 May 2007 11:03:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705221100260.3391-100000@iolanthe.rowland.org>
References: <20070522124520.GA256@tv-sign.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070522124520.GA256@tv-sign.ru>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 22 May 2007, Oleg Nesterov wrote:

> Probably Alan is right? Perhaps it is better to rename it to
> create_singlethread_freezeable_workqueue(). This way we don't need to audit
> the users when we add multithread freezable wqs.
> 
> Also, this name is more consistent wrt
> create_workqueue/create_singlethread_workqueue.

I already sent in a revised patch and a request to revert the 
create_singlethread_freezeable_workqueue() macro!

Whatever you guys decide, please let Greg and me know as soon as
possible.  This particular fix is needed before 2.6.22 gets released.

Alan Stern
