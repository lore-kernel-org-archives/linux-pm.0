From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Questions about run time power management
Date: Sun, 25 Jul 2010 11:48:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1007251147330.31037-100000@netrider.rowland.org>
References: <BLU102-W19F776184395386635AA56EBA40@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W19F776184395386635AA56EBA40@phx.gbl>
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

On Sat, 24 Jul 2010, Raj Kumar wrote:

> Hi Alan,
> 
>  
> 
> Please see my following points:
> 
>  
> 
>  Suppose when device is idle, it says to run time power management framework i am idle
> 
> and run time power management asks the device's bus (if bus is being used), and 
> 
> probably the case is if the device does not want to get suspended because of the starting
> 
> of the activities immediately , it will return the error to platform bus and platform bus returns this error
> 
> to run time power management framework and run time power management will make
> 
> the device status active. In the code of 
> 
>  
> 
> int  __pm_runtime_suspend(arguments...)
> 
> {
> 
> 
>  
> 
>   if (retval) {
>                 dev->power.runtime_status = RPM_ACTIVE;
>                 pm_runtime_cancel_pending(dev);
> 
>                 if (retval == -EAGAIN || retval == -EBUSY) {
>                         notify = true;
>                         dev->power.runtime_error = 0;
>                 }
>         } else {
> 
> 
>  
> 
> }
> 
>  
> 
> So if the retval is -EAGAIN and -EBUSY,  so it means it will again try to make it idle but if the device is
> 
> already doing activities , since it is started doing activities then in that case is this error code
> 
> ECANCELED is appropriate?

No.  -EBUSY is more appropriate, since the device is busy.

Alan Stern
