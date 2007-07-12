From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH 0/2] Kexec jump: The first step to kexec
	base hibernation
Date: Thu, 12 Jul 2007 12:09:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707121205030.11819-100000__15557.9371414662$1184256590$gmane$org@iolanthe.rowland.org>
References: <469631FA.2070405@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <469631FA.2070405@rtr.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Lord <lkml@rtr.ca>
Cc: david@lang.hm, Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Jul 2007, Mark Lord wrote:

> Rafael J. Wysocki wrote:
> > On Thursday, 12 July 2007 08:43, david@lang.hm wrote:
> >> On Wed, 11 Jul 2007, Jeremy Fitzhardinge wrote:
> >>
> >>> Andrew Morton wrote:
> ..
> >> 8. hibernate kernel does syspend-to-ram to put the devices into a known 
> >> safe state.
> > Again, the devices should be quiesced rather then suspended in this step.
> 
> That's just not possible.  The Hibernate kernel will not have all
> of the same device drivers as the mainline kernel.  Or at least that's
> what people have previously stated here.

It doesn't matter.  The Hibernate kernel needs to quiesce only the 
devices it has been using, since it is the only kernel to run since the 
system was started.

Alan Stern
