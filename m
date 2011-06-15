From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] power: opp: Fix rcu_dereference_check()
	without protection!
Date: Wed, 15 Jun 2011 11:50:33 +0530
Message-ID: <4DF84F31.4030108__14762.0634911165$1308118979$gmane$org@ti.com>
References: <1308056600-17601-1-git-send-email-santosh.shilimkar@ti.com>
	<BANLkTimKHsGCrbZ5FhYOyJC8+pASUD-nDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTimKHsGCrbZ5FhYOyJC8+pASUD-nDg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 6/14/2011 9:08 PM, Menon, Nishanth wrote:
> On Tue, Jun 14, 2011 at 08:03, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> With RCU debug options enabled, below warning is observed.
>>
>> ===================================================
>> [ INFO: suspicious rcu_dereference_check() usage. ]
>> ---------------------------------------------------
>> drivers/base/power/opp.c:151 invoked rcu_dereference_check() without protection!
>>
>> other info that might help us debug this:
>>
>> rcu_scheduler_active = 1, debug_locks = 1
>> no locks held by swapper/1.
>> ...
>>
>> ---------------------------------------------------
>>
>> Fix the same by protecting it with rcu_read lock.
>>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Rafael J. Wysocki<rjw@sisk.pl>
>> Cc: Nishanth Menon<nm@ti.com>
>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>> ---
>>   drivers/base/power/opp.c |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
>> index 56a6899..cbed5e1 100644
>> --- a/drivers/base/power/opp.c
>> +++ b/drivers/base/power/opp.c
>> @@ -148,7 +148,9 @@ unsigned long opp_get_voltage(struct opp *opp)
>>         struct opp *tmp_opp;
>>         unsigned long v = 0;
>>
>> +       rcu_read_lock();
>>         tmp_opp = rcu_dereference(opp);
>> +       rcu_read_unlock();
>>         if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
>>                 pr_err("%s: Invalid parameters\n", __func__);
>>         else
> NAK. please read the Documentation/power/opp.txt
> the usage is as follows:
> rcu_read_lock();
> opp = opp_find_freq_ceil();
> voltage = opp_get_voltage(opp);
> rcu_read_unlock();
>
> the reason for this is that the opp pointer is not safe if we lock
> just the dereferencing.
>
Fair enough. if the whole fn is under the lock then it's not
necessary.

Regards
Santosh
