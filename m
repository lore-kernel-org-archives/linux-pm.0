From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Runtime power management during system resume
Date: Tue, 24 Aug 2010 13:50:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008241346150.1652-100000@iolanthe.rowland.org>
References: <BLU102-W5B0F0352A72D47CBA27CFEB830@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W5B0F0352A72D47CBA27CFEB830@phx.gbl>
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

On Tue, 24 Aug 2010, Raj Kumar wrote:

> 
>  
> Hi,
>  
> My question is:
>  
> 1) When the system suspends, it invokes pm_runtime_put_sync when complete
> callback is called which will again trigger to put device idle
>  
> means in runtime power management core, the device status is set to RPM_SUSPENDED.
> right?

If the runtime_idle callback routine decides to call
pm_runtime_suspend() then the status will be set to RPM_SUSPENDED.  
Otherwise the status will remain RPM_ACTIVE.

> 2) As you also said that during system resume, it does not increment the power_usage
> counter,
>  
> that is ok, driver will increase the power_usage counter...
>  
> But will driver also set the state to RPM_ACTIVE means pm_runtime_set_active
>  
> right?

The driver is supposed to do that.

> 3) During hibernation, if the driver is registered using platform_driver_register...
>  
> When the system hibernates, will power management core call suspend, resume?

Yes.

Alan Stern
