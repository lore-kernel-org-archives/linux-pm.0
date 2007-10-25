From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: lockdep report in hibernate code
Date: Thu, 25 Oct 2007 13:13:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0710251310030.7029-100000@netrider.rowland.org>
References: <1193319079.6092.22.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1193319079.6092.22.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 25 Oct 2007, Johannes Berg wrote:

> We have two paths here:
> 
>  (a) sysfs write -> lock buffer -> call power management code 
>      -> lock pm_mutex
>  (b) boot code -> power management boot -> lock pm_mutex
>      -> use name_to_dev_t() -> call sysfs -> lock buffer
> 
> As you can see, lockdep rightfully complains about a possible deadlock
> scenario although of course (b) only happens once at boot at a time
> where (a) cannot happen. And now we're wondering how to fix it.

Why not use mutex_lock_nested() for the boot-time pm_mutex lock call?

Alan Stern
