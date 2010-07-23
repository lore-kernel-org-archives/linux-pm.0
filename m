From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Questions about run time power management
Date: Fri, 23 Jul 2010 10:26:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1007231022120.1823-100000@iolanthe.rowland.org>
References: <BLU102-W10EC41B7844B167719657CEBA20@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W10EC41B7844B167719657CEBA20@phx.gbl>
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

On Fri, 23 Jul 2010, Raj Kumar wrote:

> Hi,
> 
> 
> I am implementing the run time power management in my drivers. So i have the following
> questions:
> 
> 
> 1) I am using the work queue approach for run time power management, Now the thing is
> when the device is idle and it notifies the run time power management via helper function
> pm_request_idle, and at the same time if resume is done then in that case does the runtime power management
> cancels the idle and does not invoke any callback like runtime_suspend of driver? 

How can a resume occur while the device is idle?  Idle means that the 
device isn't suspended -- it's at full power but not doing anything.  
Hence a resume cannot occur at the same time.

> 2) like as mentioned in run time power management document, when the usage_count of device
> reaches zero, is there any run time power management thread in background that will immediately suspends
> the device or it is again via helper functions. It seems from the code that usage_count is zero and suspended
> via helper functions. Is it correct?

All suspends occur via the helper functions, whether a background 
thread is involved or not.

> 3) The third question is more specific about platform bus usage? can the char device driver use platform bus?
> can char device register as platform device?

Yes.  Devices can be registered on any bus.

Alan Stern
