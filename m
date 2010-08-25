From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Runtime power management during system resume
Date: Wed, 25 Aug 2010 10:51:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008251046400.1601-100000@iolanthe.rowland.org>
References: <BLU102-W296D98B5535DEC8A7A973EB840@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W296D98B5535DEC8A7A973EB840@phx.gbl>
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

On Wed, 25 Aug 2010, Raj Kumar wrote:

> But since during system suspend power_usage counter is incremented by 1 But if the device is active
> 
> means its state is RPM_ACTIVE, its power_usage counter is 1 in run time power management core.
> 
>  
> 
> when the system suspend happens, it will also increment the power_usage_counter by 1 during dpm_prepare
> 
>  
> 
> Now   the power_usage_counter is 2.
> 
>  
> 
> So when dpm_complete is invoked, it will decrement the power_usage_counter by 1 during dpm_complete.
> 
>  
> 
> So now when the drivers gets system suspend, its power_usage counter is still 1.
> 
>  
> 
> So what in this scenario, does the device decrements the power_usage counter itself?

Firstly, the _device_ can't change the power_usage counter.  Only the
_driver_ can.  You seem to keep forgetting this point; you need to keep
it straight:

		Driver != Device

Secondly, after the system suspend the power_usage counter has the same
value as it did before.  In your case the usage_counter was 1 before
the system suspend and it is 1 after the system suspend.  Whatever
routine was responsible for setting the counter to 1 originally will
also be responsible for decrementing the counter to 0 some time later.

Alan Stern
