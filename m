From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Fri, 6 Aug 2010 15:12:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008061500060.30564__12100.7350892343$1281132918$gmane$org@asgard.lang.hm>
References: <20100805001716.GO24163@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041722060.6545@asgard.lang.hm>
	<20100805004802.GP24163@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008042208350.25170@asgard.lang.hm>
	<20100805151211.GA10080@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008050832010.25170@asgard.lang.hm>
	<AANLkTi=Yyyc-hOPbkJtsnKCVzncnFq8DPnonmyckekwm@mail.gmail.com>
	<alpine.DEB.2.00.1008051312220.23543@asgard.lang.hm>
	<20100805231936.GS2447@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008060111240.30564@asgard.lang.hm>
	<20100806172409.GI2432@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100806172409.GI2432@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, kevin granade <kevin.granade@gmail.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 6 Aug 2010, Paul E. McKenney wrote:

> On Fri, Aug 06, 2010 at 01:29:57AM -0700, david@lang.hm wrote:
>> On Thu, 5 Aug 2010, Paul E. McKenney wrote:
>>
>>> On Thu, Aug 05, 2010 at 01:26:18PM -0700, david@lang.hm wrote:
>>>> On Thu, 5 Aug 2010, kevin granade wrote:
>>>>
>>>>> On Thu, Aug 5, 2010 at 10:46 AM,  <david@lang.hm> wrote:
>>>>>> On Thu, 5 Aug 2010, Paul E. McKenney wrote:
>>>>>>
>>>>>>> On Wed, Aug 04, 2010 at 10:18:40PM -0700, david@lang.hm wrote:
>>>>>>>>
>>>>>>>> On Wed, 4 Aug 2010, Paul E. McKenney wrote:
>>>>>>>>>
>>>>>>>>> On Wed, Aug 04, 2010 at 05:25:53PM -0700, david@lang.hm wrote:
>>>>>>>>>>
>>>>>>>>>> On Wed, 4 Aug 2010, Paul E. McKenney wrote:
>>>>>>>
>>>>>>> [ . . . ]
>>>>>>>
>>
>> it would be nice to get network traffic/connection stats.
>>
>> so two questions.
>>
>> first, what else would you need to get accumulated for the cgroup
>>
>> second, is there a fairly easy way to have these stats available?
>>
>> for the 'last time it ran' stat, this seems like you could have a
>> per-cpu variable per cgroup that's fairly cheap to update, but you
>> would need to take a global lock to read accuratly (the lock may be
>> expensive enough that it's worth trying to read the variables from
>> the other cpu without a lock, just to see if it's remotely possible
>> to sleep/suspend)
>>
>> with timers, is it possible to have multiple timer wheels (one per
>> cgroup)?
>
> I apologize in advance for what I am about to write, but...
>
> If you continue in this vein, you are likely to make suspend blockers
> look very simple and natural.  ;-)

if that's the case then they should be implemented :-)

on the other hand, this may be something that's desirable for 
idle-low-power as well.

David Lang
