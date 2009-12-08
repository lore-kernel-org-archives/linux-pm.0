From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Tue, 8 Dec 2009 22:52:51 +0100
Message-ID: <200912082252.51916.borntraeger__12453.3775415786$1260402717$gmane$org@de.ibm.com>
References: <Pine.LNX.4.44L0.0912081626400.3046-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912081626400.3046-100000@iolanthe.rowland.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> > Sure they can. Control dependencies are trivial - it's called "branch 
> > prediction", and everybody does it, and data dependencies don't exist on 
> > many CPU architectures (even to the point of reading through a pointer 
> > that you loaded).
> 
> Wait a second.  Are you saying that with code like this:
> 
> 	if (x == 1)
> 		y = 5;
> 
> the CPU may write to y before it has finished reading the value of x?  
> And this write is visible to other CPUs, so that if x was initially 0
> and a second CPU sets x to 1, the second CPU may see y == 5 before it
> executes the write to x (whatever that may mean)?

No, the write really depends on x being 1 at any time before the comparison.
On the other hand x being != 0 during the comparison does not prevent the 
write without proper locking or barriers.


Have a look at

http://www.linuxjournal.com/article/8211
http://www.linuxjournal.com/article/8212

especially at the alpha part what can happen when dealing with pointer accesses.

Christian
