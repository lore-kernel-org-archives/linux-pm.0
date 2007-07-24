From: david@lang.hm
Subject: Re: Power Management framework proposal
Date: Tue, 24 Jul 2007 16:02:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707241556140.6590__33113.475298933$1185318351$gmane$org@asgard.lang.hm>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
	<1185125189.2714.13.camel@laptopd505.fenrus.org>
	<1185229405.5439.148.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707241313580.6590@asgard.lang.hm>
	<1185313138.5439.285.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1185313138.5439.285.camel@localhost.localdomain>
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

On Wed, 25 Jul 2007, Benjamin Herrenschmidt wrote:

> On Tue, 2007-07-24 at 13:14 -0700, david@lang.hm wrote:
>>> I think we need a set of constraints that trickle down the power
>> tree
>>> and limit what a given driver can do locally.
>>
>> what sort of contraints are you thinking of?
>
> A parent power state defines what states children can be in. For
> example. A way to express those dependencies would be nice. Or
> alternatiely, the power state of all the children defines the power
> state a parent can go in automatically.

Ok, I see tow things here.

1. do you really want to try and propogate things like this from one to 
the other, or would it be good enough to flag the issue and let the 
software selecting the modes implement this contraint?

2. how can you standardize the requirements?

at the very least you have

for this mode all children must be off

for this mode all children must be in a mode that includes a 'suspended' 
flag (this could be made implicit by saying that you must suspend children 
before parents) and then just flagging the 'suspended, but not off' modes)

what requirements are needed? (I'm sure that there are others, but 
hopefully it's possible to avoid requirements like 'the clock speed for 
device A must be >X to allow device B to operate in mode Y')

David Lang
