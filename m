From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: About run time power management in linux
Date: Thu, 1 Jul 2010 10:03:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1007011000340.1596-100000@iolanthe.rowland.org>
References: <BLU102-W760DF7F1EFCA2517505ABEBCD0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W760DF7F1EFCA2517505ABEBCD0@phx.gbl>
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

> Hi Alan,
> 
>  
> 
> I have seen in run time power management helper functions. I have some questions during deep sleep modes
> 
> and runtime sleep modes.
> 
>  
> 
> 1) I have seen the code and found that when System wants to go to suspend (deep sleep mode), it has to check for
> 
> pm_runtime_barrier which inturn sees if there is a pending runtime resume then it will not allow system to supend.
> 
> So it means system suspend can not be done forcefully if the some peripheral jobs are running, correct?

Yes.  The system suspend will have to wait until the runtime PM 
activity is finished.

> 2) it means when System deep sleep is going on, run time suspend will never come to peripheral as it checks for usage counter and
> 
> if it is zero then it will ask try again.

Basically yes, although you have the reason backward.  If the usage 
count is _non-zero_ then runtime suspend won't occur.

> 3) if run time suspend is going on,  Then if system wants to go into deep sleep mode, it will wait for run time suspend to finish and then 
> 
> gracefully do the shutdown. correct?

Yes.

> 4) Is it mandatory for peripheral driver but not the bus driver to implement runtime_idle operation?

None of these are mandatory; it all depends on the bus subsystem.  
Some subsystems don't implement runtime PM at all.

Alan Stern
