From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Wed, 9 Dec 2009 10:57:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912091051450.4120-100000__24726.9074818634$1260374385$gmane$org@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0912090728200.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912090728200.3560@localhost.localdomain>
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

On Wed, 9 Dec 2009, Linus Torvalds wrote:

> That's partly why I realy did suggest that we do the async stuff purely in 
> the USB layer, rather than try to put it deeper in the device layer. And 
> if we do support it "natively" in the device layer like Rafael's latest 
> patch, I still think we should be very very nervous about making devices 
> async unless there is a measured - and very noticeable - advantage.

Agreed.  Arjan's measurements indicated that USB was one of the biggest
offenders; everything else other than the PS/2 mouse was much faster.  
Given these results there isn't much incentive to do anything else
asynchronously.

(However other devices not present on Arjan's machine may be a
different story.  Spinning up multiple external disks is a good example 
-- although here it may be necessary for the driver to take charge, 
because spinning up a disk requires a lot of power and doing too many 
of them at the same time could be bad.)

Alan Stern
