From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: About run time power management in linux
Date: Wed, 30 Jun 2010 10:23:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006301019140.1707-100000@iolanthe.rowland.org>
References: <BLU102-W77098297EEED290634D10EBCC0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W77098297EEED290634D10EBCC0@phx.gbl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Raj Kumar <rajkumar278@hotmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Please fix your email client to wrap lines after about 72 columns and 
not to insert excess blank lines.

On Wed, 30 Jun 2010, Raj Kumar wrote:

> Hi,
> 
> I am working in power management. I have few questions about run time power management which was merged in linux 2.6.32 kernel onwards. 
> 
>  
> 
> Since the run time power management defines that when idle, suspend and resume will be scheduled, now the thing is from device driver perspective, 
> 
>  
> 
> it is bus driver that will suspend and resume its devices. but what from driver perspective driver needs to implement means as run time power management 
> 
>  
> 
> has also helper functions which will tell PM core that when to call various callbacks for suspend and resume for drivers (device, bus). 
> 
>  
> 
> But it might be case when the whole bus is not idle and still some drivers can be put into low power mode. 
> 
>  
> 
> Then does bus driver will be responsible for invoking the driver's suspend and resume (run time) or PM core will do that ? 

The PM core will invoke the bus driver's runtime_idle, runtime_suspend,
and runtime_resume callback functions.  These functions are then
responsible for invoking the device driver's suspend and resume 
routines.

Alan Stern
