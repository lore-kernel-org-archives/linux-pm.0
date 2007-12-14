From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: acquire device locks prior to suspending
Date: Fri, 14 Dec 2007 11:49:35 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0712141129200.4768-100000@iolanthe.rowland.org>
References: <20071213233131.733c2438.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071213233131.733c2438.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 13 Dec 2007, Andrew Morton wrote:

> hm, that was all fairly helpful.  <looks at the document> <erk, long>
> 
> This:

> gives me this:
> 
> http://userweb.kernel.org/~akpm/pc131699.jpg
> 
> which identifies your culprit: msr.
> 
> I'd suggest that the above debug patch be turned into some
> boot-option-enabled thing and that it be rolled out with this locking
> change for a while at least.

Rafael, that looks like exactly the same sort of problem as we saw 
before.  Global searching for CPU_DEAD_FROZEN shows several other 
places that perhaps also could be simplified; the actions they take may 
or may not be needed for hibernation.

The following three seem definitely dangerous:

	arch/x86/kernel/cpu/mcheck/mce_64.c
	arch/x86/kernel/cpuid.c
	arch/x86/kernel/msr.c

And of course the third is the one that Andrew spotted.  Would you like 
to address them?  I can package up Andrew's debugging changes into a 
real patch.

Alan Stern
