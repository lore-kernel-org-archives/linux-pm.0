From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: Singlethread vs. freezable workqueues
Date: Tue, 22 May 2007 16:45:20 +0400
Message-ID: <20070522124520.GA256@tv-sign.ru>
References: <Pine.LNX.4.44L0.0705211621000.5679-100000@iolanthe.rowland.org>
	<200705212320.07126.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705212320.07126.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 05/21, Rafael J. Wysocki wrote:
>
> On Monday, 21 May 2007 22:23, Alan Stern wrote:
> > 
> > The reason I asked is because, prior to the release of 2.6.22, I sent 
> > in a patch which added a create_singlethread_freezeable_workqueue() 
> > macro.  Now it isn't needed, since create_freezeable_workqueue() does 
> > the same thing.  Is there any reason to keep the macro?
> > 
> > I'm worried that if I get rid of it and simply define the workqueue as 
> > freezable, then at some time in the future it might turn into a 
> > multithread workqueue without my knowledge.
> 
> If we introduce multithread freezable workqueues again, we'll have to review
> all current users of create_freezeable_workqueue() anyway to see whether or
> not they need to use a singlethread workqueue.  Still, if you added a comment
> saying that your workqueue had to be singlethread, that would certainly help. ;-)

Probably Alan is right? Perhaps it is better to rename it to
create_singlethread_freezeable_workqueue(). This way we don't need to audit
the users when we add multithread freezable wqs.

Also, this name is more consistent wrt create_workqueue/create_singlethread_workqueue.

Oleg.
