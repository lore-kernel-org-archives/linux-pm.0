From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: question about driver's runtime_suspend
Date: Fri, 3 Sep 2010 21:37:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009032135210.7972-100000@netrider.rowland.org>
References: <201009031520.19452.pugs@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009031520.19452.pugs@cisco.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tom Lyon <pugs@cisco.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 3 Sep 2010, Tom Lyon wrote:

> Hi. I am looking at supporting the new PM stuff in my VFIO "driver" - which 
> allows user level drivers for PCI* devices.
> 
> When runtime_suspend is invoked, is it allowed to sleep while determining 
> whether the device can be suspended?  If not, does returning -EAGAIN mean that 
> it will be called again after some interval? 

The runtime_suspend callback is allowed to sleep.  But it should try to 
avoid sleeping for very long.

Returning -EAGAIN does not guarantee that it will be called again.  
That is up to your driver.

> I would like to notify the user level that a suspend is desired, and then wait 
> for it to tell the vfio driver whether or not the suspend is OK.

You should put an upper limit on the amount of time the driver will 
wait to hear back from the user.

Alan Stern
