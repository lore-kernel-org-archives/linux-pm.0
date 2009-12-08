From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Tue, 8 Dec 2009 14:16:12 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912081339040.3560__45173.290585126$1260310714$gmane$org@localhost.localdomain>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Tue, 8 Dec 2009, Alan Stern wrote:
> > 
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

Well, in a way.  The branch may have been predicted, and the CPU can 
_internally_ have done the 'y=5' thing into a write buffer before it even 
did the read.

Some time later it will have to _verify_ the prediction and then perhaps 
kill the write before it makes it to a data structure that is visible to 
others, but internally from the CPU standpoint, yes, the write could have 
happened before the read.

Now, whether that write is "before" or "after" the read is debatable. But 
one way of looking at it is certainly that the write took place earlier, 
and the read might have just caused it to be undone.

And there are real effects of this - looking at the bus, you might have a 
bus transaction to get the cacheline that contains 'y' for exclusive 
access happen _before_ the bus transaction that reads in the value of 'x' 
(but you'd never see the writeout of that '5' before).

> And this write is visible to other CPUs, so that if x was initially 0
> and a second CPU sets x to 1, the second CPU may see y == 5 before it
> executes the write to x (whatever that may mean)?

Well, yes and no. CPU1 above won't release the '5' until it has confirmed 
the '1' (even if it does so by reading it late). but assuming the other 
CPU also does speculation, then yes, the situation you describe could 
happen. If the other CPU does

		z = y;
		x = 1;

then it's certainly possible that 'z' contains 5 at the end (even if both 
x and y started out zero). Because now the read of 'y' on that other CPU 
might be delayed, and the write of 'x' goes ahead, CPU1 sees the 1, and 
commits its write of 5, sp when CPU2 gets the cacheline, z will now 
contain 5.

Is it likely? No. CPU microarchitectures aim to do reads early, and writes 
late. Reads are on the critical path, writes can be buffered. But you can 
basically get into "impossible" situations where a write that was _later_ 
in the instruction stream than a read (on CPU2, the 'store 1 to x' would 
be after the load of 'y' from memory) could show up in the other order on 
another CPU.


			Linus
