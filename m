From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Question about hibernation
Date: Thu, 14 Oct 2010 20:59:26 +0200
Message-ID: <201010142059.26869.rjw@sisk.pl>
References: <mailman.23.1286318684.6175.linux-pm@lists.linux-foundation.org>
	<201010141151.05297.rjw@sisk.pl>
	<BLU102-W13CE4234FF4484062541F8EB560@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W13CE4234FF4484062541F8EB560@phx.gbl>
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

On Thursday, October 14, 2010, Raj Kumar wrote:
> 
> Hi Rafael,

Hi,

> Thanks for your quick reply.  
>  
> 1) I already implemented this with dev_pm_ops. I used suspend and resume callbacks
> whose prototype is like
>  
> struct dev_pm_ops power_mgmt_ops
> {
>    .suspend =  powermanagement_suspend,
>    .resume =  powermanagement_resume
>  
> }
>  
> int powermanagement_suspend(device *dev)
> {
>  
> }
>  
> In normal suspend to ram mode it will work. But will it work in case of hibernation also?

It may be sufficient to point hibernate-specific callback pointers to your
suspend/resume routines:
  
 struct dev_pm_ops power_mgmt_ops
 {
    .suspend =  powermanagement_suspend,
    .resume =  powermanagement_resume,
    .freeze =  powermanagement_suspend,
    .thaw =  powermanagement_resume,
    .poweroff =  powermanagement_suspend,
    .restore =  powermanagement_resume,
 }

depending on the particular needs of your driver.

> if yes, since in suspend and resume call backs, only the device structure is provided, so how can
> then person can identify it is suspend to ram or hibernation?

See above.

> or for hibernation, poweroff  and restore function should be implemented which is similar
> to suspend and resume call backs in case of suspend to ram?

Yes.

Thanks,
Rafael
