From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: acquire device locks prior to suspending
Date: Sat, 15 Dec 2007 01:17:21 +0100
Message-ID: <200712150117.21895.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0712141129200.4768-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0712141129200.4768-100000@iolanthe.rowland.org>
Content-Disposition: inline
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, 14 of December 2007, Alan Stern wrote:
> On Thu, 13 Dec 2007, Andrew Morton wrote:
> 
> > hm, that was all fairly helpful.  <looks at the document> <erk, long>
> > 
> > This:
> 
> > gives me this:
> > 
> > http://userweb.kernel.org/~akpm/pc131699.jpg
> > 
> > which identifies your culprit: msr.
> > 
> > I'd suggest that the above debug patch be turned into some
> > boot-option-enabled thing and that it be rolled out with this locking
> > change for a while at least.
> 
> Rafael, that looks like exactly the same sort of problem as we saw 
> before.  Global searching for CPU_DEAD_FROZEN shows several other 
> places that perhaps also could be simplified; the actions they take may 
> or may not be needed for hibernation.
> 
> The following three seem definitely dangerous:
> 
> 	arch/x86/kernel/cpu/mcheck/mce_64.c
> 	arch/x86/kernel/cpuid.c
> 	arch/x86/kernel/msr.c
> 
> And of course the third is the one that Andrew spotted.  Would you like 
> to address them?

Yes, I think I can take care of them, but not earlier than on Sunday.

> I can package up Andrew's debugging changes into a real patch.

Yes, that certainly is worth doing. :-)

Thanks,
Rafael
