From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Tue, 4 Mar 2008 00:10:33 +0100
Message-ID: <20080303231033.GB15255__2675.96894777871$1204585875$gmane$org@one.firstfloor.org>
References: <924EFEDD5F540B4284297C4DC59F3DEEA2E8B2@orsmsx423.amr.corp.intel.com>
	<Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Pierre Ossman <drzeus-list@drzeus.cx>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 03, 2008 at 06:05:35PM -0500, Alan Stern wrote:
> On Mon, 3 Mar 2008, Pallipadi, Venkatesh wrote:
> 
> > But, with this patch:
> > - we are penalizing good hardware and making them less power efficient
> > to match the bad ones.
> > - There may also be server systems which first may not have these sort
> > of power fluctuations and even when buggy and have this noise, system
> > may be in some corner of some lab with fans making more noise than the
> > capacitors.
> 
> Can you make it configurable through sysfs?  

It already is, through a writable module_parm() 

> Default to disabled, but 
> allow the user to turn it on if the machine makes too much noise.

99+% of the users wouldn't be able to figure that out.

-Andi
