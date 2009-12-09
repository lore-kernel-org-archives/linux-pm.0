From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Wed, 9 Dec 2009 14:06:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912091356200.4120-100000__44245.6878642135$1260385832$gmane$org@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0912081339040.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912081339040.3560@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Dec 2009, Linus Torvalds wrote:

> > Wait a second.  Are you saying that with code like this:
> > 
> > 	if (x == 1)
> > 		y = 5;
> > 
> > the CPU may write to y before it has finished reading the value of x?  

> > And this write is visible to other CPUs, so that if x was initially 0
> > and a second CPU sets x to 1, the second CPU may see y == 5 before it
> > executes the write to x (whatever that may mean)?
> 
> Well, yes and no. CPU1 above won't release the '5' until it has confirmed 
> the '1' (even if it does so by reading it late). but assuming the other 
> CPU also does speculation, then yes, the situation you describe could 
> happen. If the other CPU does
> 
> 		z = y;
> 		x = 1;
> 
> then it's certainly possible that 'z' contains 5 at the end (even if both 
> x and y started out zero). Because now the read of 'y' on that other CPU 
> might be delayed, and the write of 'x' goes ahead, CPU1 sees the 1, and 
> commits its write of 5, sp when CPU2 gets the cacheline, z will now 
> contain 5.

That could be attributed to reordering on CPU2, so let's take CPU2's
peculiarities out of the picture (initially everything is set to 0):

	CPU1			CPU2
	----			----
	if (x == 1)		z = y;
		y = 5;		mb();
				x = 1;

This gets at the heart of the question: Can a write move up past a
control dependency?  Similar questions apply to the two types of data 
dependency:

	CPU1			CPU2
	----			----
	y = x + 4;		z = y;
				mb();
				x = 1;

(Initially p points to x, not y):

	CPU1			CPU2
	----			----
	*p = 5;			z = y;
				mb();
				p = &y;

Can z end up equal to 5 in any of these examples?

Alan Stern
