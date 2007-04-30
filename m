From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: shrinking memory for suspend?
Date: Mon, 30 Apr 2007 11:09:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0704301108290.3269-100000@iolanthe.rowland.org>
References: <1177943076.5102.83.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177943076.5102.83.camel@johannes.berg>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 30 Apr 2007, Johannes Berg wrote:

> Hi,
> 
> Paul Mackerras noticed that even for suspend to ram we currently free
> some memory in suspend_prepare. Is that necessary because we freeze
> userspace so devices can allocate a bit of memory for suspend? Why do we
> freeze userspace anyway?

So that user processes don't generate I/O requests while the devices are
suspended -- such requests would be bound to fail.

Alan Stern
