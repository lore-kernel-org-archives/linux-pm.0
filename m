From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Tue, 4 Mar 2008 10:40:28 +0100
Message-ID: <20080304094028.GC15255__17273.69904188$1204623716$gmane$org@one.firstfloor.org>
References: <924EFEDD5F540B4284297C4DC59F3DEEA2E8B2@orsmsx423.amr.corp.intel.com>
	<Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080303231033.GB15255@one.firstfloor.org>
	<20080304040048.GA31562@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080304040048.GA31562@codemonkey.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Jones <davej@codemonkey.org.uk>, Andi Kleen <andi@firstfloor.org>, Alan Stern <stern@rowland.harvard.edu>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 03, 2008 at 11:00:48PM -0500, Dave Jones wrote:
> On Tue, Mar 04, 2008 at 12:10:33AM +0100, Andi Kleen wrote:
>  > On Mon, Mar 03, 2008 at 06:05:35PM -0500, Alan Stern wrote:
>  > > On Mon, 3 Mar 2008, Pallipadi, Venkatesh wrote:
>  > > 
>  > > > But, with this patch:
>  > > > - we are penalizing good hardware and making them less power efficient
>  > > > to match the bad ones.
>  > > > - There may also be server systems which first may not have these sort
>  > > > of power fluctuations and even when buggy and have this noise, system
>  > > > may be in some corner of some lab with fans making more noise than the
>  > > > capacitors.
>  > > 
>  > > Can you make it configurable through sysfs?  
>  > 
>  > It already is, through a writable module_parm() 
>  > 
>  > > Default to disabled, but 
>  > > allow the user to turn it on if the machine makes too much noise.
>  > 
>  > 99+% of the users wouldn't be able to figure that out.
> 
> 99+% of users don't have singing capacitors. (Or don't care enough to complain)
> For those that do can't figure out what to do from google,
> we have a documentation problem.

The big question is if there is a measurable difference in power consumption
from a reasonable default value.  I doubt it actually. The normal rule
of thumb is that if you average sleeps are long enough (and they still
stay this way even with the patch enabled) you're doing ok. If there is 
no or not significant penalty there is no reason to not enable it by default.

-Andi
