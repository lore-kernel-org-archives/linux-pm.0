From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 12:20:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707201216460.3811-100000@iolanthe.rowland.org>
References: <44037b3d409370919bddd8710e6064fc@bga.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <44037b3d409370919bddd8710e6064fc@bga.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Milton Miller <miltonm@bga.com>
Cc: David Lang <david@lang.hm>, LKML <linux-kernel@vger.kernel.org>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, 20 Jul 2007, Milton Miller wrote:

> > We can't do this unless we have frozen tasks (this way, or another) 
> > before
> > carrying out the entire operation.
> 
> What can't we do?   We've already worked with the drivers to quesce the 
> hardware and put any information to resume the device in ram.  Now we 
> ask them to put their device in low power mode so we can go to sleep.  
> Even if we schedule, the only thing userspace could touch is memory.   

Userspace can submit I/O requests.  Someone will have to audit every 
driver to make sure that such I/O requests don't cause a quiesced 
device to become active.  If the device is active, it will make the 
memory snapshot inconsistent with the on-device data.

Alan Stern
