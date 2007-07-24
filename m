From: david@lang.hm
Subject: Re: Power Management framework proposal
Date: Tue, 24 Jul 2007 13:14:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707241313580.6590__3409.05478592521$1185308401$gmane$org@asgard.lang.hm>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
	<1185125189.2714.13.camel@laptopd505.fenrus.org>
	<1185229405.5439.148.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1185229405.5439.148.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 24 Jul 2007, Benjamin Herrenschmidt wrote:

> On Sun, 2007-07-22 at 10:26 -0700, Arjan van de Ven wrote:
>> On Sat, 2007-07-21 at 23:49 -0700, david@lang.hm wrote:
>>
>>> this approach would allow the transition of ALL drivers to the new mode of
>>> operation in one fell swoop, and then adding additional power management
>>> features is just adding to the existing list rather then implementing new
>>> functions.
>>
>>
>> I have a concern with this approach though. It seems to assume that
>> there is one global thing somewhere that sets the system state; in my
>> experience that is the wrong approach; in fact there is a very definite
>> evidence that there are many decisions on power that are to be made
>> local at a high frequency. An example of this is the processor speed;
>> the ondemand governer does exactly this for the cpus that can switch
>> speeds fast; it's just impossible to beat such a local, fast decision
>> with anything on a global scale.
>>
>> On the other hand, some things (the high level goals and constraints)
>> are obviously global.
>
> I think we need a set of constraints that trickle down the power tree
> and limit what a given driver can do locally.

what sort of contraints are you thinking of?

David Lang
