From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: About run time power management in linux
Date: Wed, 30 Jun 2010 12:25:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006301225040.1707-100000@iolanthe.rowland.org>
References: <BLU102-W15580CBC32130E58FED981EBCC0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W15580CBC32130E58FED981EBCC0@phx.gbl>
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

On Wed, 30 Jun 2010, Raj Kumar wrote:

> Hi Alan,
> 
>  
> 
> First thanks for reply.  ok as also seems to be in runtime.c, if device wants to suspend and resume
> 
>  
> 
> then device will call helper functions for pm core like pm_runtime_suspend and pm_runtime_resume,
> 
>  
> 
> which internally calls the runtime_resume of the bus and which in turn calls the runtime_resume of the driver.
> 
>  
> 
> correct ?

Yes.

Alan Stern
