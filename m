From: James Hogan <james@albanarts.com>
Subject: Re: 2.6.38-rc1 resume hang (da8aeb92 "ACPI/Battery:
 Update information on info notification and resume")
Date: Fri, 21 Jan 2011 21:20:28 +0000
Message-ID: <20110121212028.GA2916__37817.5396043391$1295644968$gmane$org@gandalf>
References: <20110121140031.GA3280@gandalf>
 <201101212130.26693.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201101212130.26693.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Fri, Jan 21, 2011 at 09:30:26PM +0100, Rafael J. Wysocki wrote:
> On Friday, January 21, 2011, James Hogan wrote:
> > Hi,
> > 
> > After updating from 2.6.37 to 2.6.28-rc1, resume from suspend is broken
> > on my Dell M1210 Laptop.
> > 
> > I tried pm_trace and both block and battery matched the hash, so I
> > bisected the problem to commit da8aeb92 (see below).
> > 
> > I've reverted this commit on 2.6.38 and it doesn't die on resume anymore.
> > 
> > My bisection log and .config are pasted below.
> > 
> > Let me know if I can provide any more info or help test any patches etc.
> 
> This should have been fixed already in the current Linus' tree by this commit:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=b23fffd778c312b8fb258d342051fcbdf6712128
> 
> Can you verify, please?

Yes, that fixes it. I'll remember to check for an existing fix at the
end of the bisection as well as the beginning next time.

Thanks

James
