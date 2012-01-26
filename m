From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Question regarding completion signal in S3 flow
Date: Thu, 26 Jan 2012 10:02:26 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1201260956370.1386-100000@iolanthe.rowland.org>
References: <810586B7581CC8469141DADEBC371912057D42@BGSMSX102.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <810586B7581CC8469141DADEBC371912057D42@BGSMSX102.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Mansoor, Illyas" <illyas.mansoor@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 26 Jan 2012, Mansoor, Illyas wrote:

> Hi All,
> 
> I have question related to suspend flow and completion signal:
> 
> Is it possible that a completion signal could be missed in S3 flow after
> processes are frozen? 

What do you mean by "completion signal"?

> The scenario is:
> 
> Suspend_thread->...->dpm_suspend_start->suspend->Wait_for_completion_timeout->do
> es not receive signal and times out

dpm_suspend_start doesn't run until processes are frozen, and frozen 
processes cannot be waiting for a completion.  Therefore this can't 
happen.

> Interrupt->complete->
> 
> This happens very rare, there are other reason why wait_for_completion_times out
> like interrupt not received but I just want
> To make sure if completion signal is not lost during S3.

Of course it's possible that interrupts will not be delivered while the
computer is suspending or suspended.  Those interrupts should be
delivered later, when the computer wakes up again.

Alan Stern
