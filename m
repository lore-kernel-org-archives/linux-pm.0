From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Driver core: don't initialize wakeup flags
Date: Mon, 8 Mar 2010 17:17:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003081711170.1297-100000__18847.8560573005$1268086710$gmane$org@iolanthe.rowland.org>
References: <20100308220035.GA21390@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100308220035.GA21390@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 8 Mar 2010, Greg KH wrote:

> On Mon, Mar 08, 2010 at 04:46:19PM -0500, Alan Stern wrote:
> > This patch (as1351) removes an unnecessary and unwanted assignment
> > from device_initialize().  The wakeup flags are set to 0 along with
> > everything else when the device structure is allocated, so we don't
> > need to do it again.  Furthermore, the subsystem might already have
> > set these flags to their correct values; we don't want to override it.
> 
> Does this solve a bug where a subsystem does do this already?  Or can it
> wait for 2.6.35?

It does not fix any existing bugs.

On the other hand, I have just submitted a separate patch adding 
remote-wakeup support for PNP devices (i8042 keyboard ports in 
particular) that depends on this one.  If you consider not waking up 
from suspend when keys are typed to be a bug, then the two patches 
together (plus a third that enables remote wakeup for the keyboard 
port by default) would count as a bug fix.

Or to put it differently, I'm waffling.  :-)

Alan Stern
