From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 084/123] USB: fix up suspend and resume for
 PCI host controllers
Date: Fri, 16 Jan 2009 18:15:55 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901161805450.4593-100000__9204.47078901834$1232148038$gmane$org@iolanthe.rowland.org>
References: <1232144882.23611.2.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1232144882.23611.2.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 17 Jan 2009, Benjamin Herrenschmidt wrote:

> > Ben, we need to check with you on this also.  These patches we have
> > been throwing around move the code to disable and enable the PPC_PMAC
> > ASIC clocks for USB.  Can that code execute safely at any time while
> > the host controller isn't running?  Is it okay to execute the code
> > with interrupts disabled?
> 
> Wow, that's digging old stuff I haven't touched for some time :-)
> 
> So I think running the pmac hooks with IRQs off might be ok. They have
> delays but they use mdelay() not msleep().
> 
> As to when it is safe to run that code, it isn't a trivial answer. I'd
> say any time after it's been suspended and before it's resumed sounds
> about right, but my experience with those earlier Apple built-in OHCIs
> is that they are -very- sensitive to random environmental conditions
> when suspending/resuming and if -anything- goes wrong, they start
> happily scribbling all over system memory when suspended :-(
> 
> So I think it's going to boil down to testing. Might be useful to find
> somebody with one of the really old powerbooks, I see if I can find that
> around the lab here, mine is dead.
> 
> Do you have a git tree I can pull to test your stuff ?

Not exactly.  Just try this patch:

	http://marc.info/?l=linux-kernel&m=123184641714487&w=2

with vanilla 2.6.29-rc1 or rc2.

Alan Stern
