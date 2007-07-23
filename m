From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hibernation considerations
Date: Mon, 23 Jul 2007 11:23:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707231120380.3545-100000__26139.508575625$1185204240$gmane$org@iolanthe.rowland.org>
References: <200707231311.56398.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707231311.56398.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@suspend2.net
Cc: david@lang.hm, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, 23 Jul 2007, Nigel Cunningham wrote:

> Take a step back for a second.
> 
> The problem we're facing now is that we're getting some userspace threads, 
> used in processing I/O, that are functioning as exceptions to the "freeze 
> userspace, then freezeable kernel threads" rule. They are only exceptions 
> because of that role in processing I/O - because they're de facto kernel 
> threads. So, if we orient our thinking more in terms of I/O processing and 
> less in terms of the userspace/kernelspace distinction, we'll have a 
> solution:
> 
> 1) Freeze processes that aren't fs related (ie stop them generating I/O).

The problem here is that with things like FUSE, _every_ process is 
potentially fs related.  Nothing prevents a FUSE thread from doing IPC 
with any other thread.

> 2) Flush pending I/O.
> 3) Freeze filesystems in reverse order of dependency, the primary purpose 
> being to stop them generating further I/O on their metadata.
> 
> Locks that are being held are only being held because work is being done. If 
> we progressively focus on threads in terms of their create/process work 
> dependencies, we'll see that the problem isn't at all intractable.

As has been mentioned before, keeping track of all that dependency 
information would be very fragile and time-consuming.

Alan Stern
