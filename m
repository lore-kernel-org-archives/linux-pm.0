From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: About run time power management in linux
Date: Thu, 1 Jul 2010 11:17:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1007011116260.1303-100000@iolanthe.rowland.org>
References: <BLU102-W966E040CADCF02BC6A067EBCD0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W966E040CADCF02BC6A067EBCD0@phx.gbl>
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

On Thu, 1 Jul 2010, Raj Kumar wrote:

> Hi,
> 
>  
> 
> yeah, mostly run time power management will be helpful for embedded devices where the power management is
> 
> crucial because then individual peripherals can be suspended and it saves a power. Because with run time power
> 
> management clock and power domains are easier to manage. 
> 
>  
> 
> But the thing is if driver goes for runtime_suspend and runtime_resume,
> 
>  
> 
> then is the runtime_idle is also mandatory to implement? because i have seen if run time suspend is failed due to
> 
> EAGAIN and EBUSY, it will notify  via  __pm_runtime_idle i guess this notification is valid for bus drivers.

runtime_idle is not mandatory.

> The another question is suppose there are multiple power domains, then with run time power management require
> 
> one bus driver corresponding to each power domain? right?

No, you can use the same driver for multiple power domains.

Alan Stern
