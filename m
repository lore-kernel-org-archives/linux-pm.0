From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Question about hibernation
Date: Fri, 8 Oct 2010 21:31:48 +0200
Message-ID: <201010082131.48152.rjw@sisk.pl>
References: <mailman.23.1286318684.6175.linux-pm@lists.linux-foundation.org>
	<BLU102-W129B9481B0793898EF998EB500@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W129B9481B0793898EF998EB500@phx.gbl>
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

On Friday, October 08, 2010, you wrote:
> 
> Hi Rafael,

Hi,

> I am working on device driver whose some part is user space and some part is kernel space. So the user space part
> of the driver provides interface to user space applications. 
> 1) Now, Suppose some user space is application is going on which is accessing the user space driver and user space driver
> scheduled some jobs to kernel space, Now suppose system hibernation start, since it freezes all the user space processes
> so suppose jobs are not completed yet which are scheduled to kernel space by user space.
>  
> when the kernel space device driver completes the jobs and gives the notification to user space driver, since user space
> process is already frozen, so there will be problem if we suspend the driver using suspend and resume.
>  
> right?

Yes, there's going to be a problem if the driver is not prepared to handle such situations.

Depending of the particular case, one possible approach is to use a PM notifier
as described in Documentation/power/notifiers.txt.

> 2) The other point I was seeing, when the power management core freezes all the processes before suspending and resuming
> devices, it will take some time for freezing and after that if some device driver refuses to suspend, then it will again resume
> the whole processes, so latency time be more. right?

Yes, it works as described.

> 3) Next question is regarding the kernel space threads, when these are frozen during suspend/hibernation?

They are frozen immediately after user space has been frozen, but only a
handful of kernel threads are frozen.

Thanks,
Rafael
