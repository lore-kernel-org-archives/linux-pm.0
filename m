From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Need Help to debug resume hangs at schedule()
	function
Date: Mon, 2 May 2011 20:39:16 +0200
Message-ID: <201105022039.16936.rjw@sisk.pl>
References: <2FC8B95E2C77614C9F13EDC44D58183C0108944B@BLR-SJP-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <2FC8B95E2C77614C9F13EDC44D58183C0108944B@BLR-SJP-MBX01.wipro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: purusothaman.ramajothi@wipro.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, May 02, 2011, purusothaman.ramajothi@wipro.com wrote:
> Hi,
> 
>  
> 
>                 I am using 2.6.27.18 kernel.My machine is powerpc
> architecture.I executed the deep sleep operation by executing the
> following command:
> 
>  
> 
> "echo mem > /sys/power/state"
> 
>  
> 
> The suspend opeartion was successful.All the devices and user level
> threads are suspended.
> 
>  
> 
> But sometimes during resume my machine hangs.This is not happening
> regularly.But it occurs after 60 or 70 times of deep sleep operation.So
> for debugging this I have added checkpoints in the flow of deep
> check.When this issue was produced the kernel hangs around "thaw_tasks"
> or "schedule" function of "thaw_processes".These functions are defined
> in "kernel/power/process.c".
> 
>  
> 
> Note: The final printk message "Restarting tasks.....done" was not
> displayed when this issue occurred.But all the devices and drivers
> resumed back.
> 
>  
> 
> I was not able to debug this as the reproduciablity rate was too
> low.Kindly help me in solving the issue.

Well, the only advice I can give you at the moment is to try a newer kernel
(the newer the better).

Thanks,
Rafael
