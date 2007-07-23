From: david@lang.hm
Subject: Re: Power Management framework proposal
Date: Sun, 22 Jul 2007 21:04:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707222054060.6350__25874.3570921526$1185163572$gmane$org@asgard.lang.hm>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
	<1185091022.19678.28.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707220057210.6350@asgard.lang.hm>
	<1185105911.29238.43.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707221156210.6350@asgard.lang.hm>
	<1185145766.2714.27.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707221914550.6350@asgard.lang.hm>
	<1185162647.2714.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1185162647.2714.35.camel@laptopd505.fenrus.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: "ext linux-pm-bounces@lists.linux-foundation.org" <linux-pm-bounces@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 22 Jul 2007, Arjan van de Ven wrote:

>> I disagree with you here. for each frequency setting you can say how much
>> power the cpu/system is expected to use (especially as a percentage of the
>> full power mode). creating this value requires you to take two things into
>> account, the voltage you are running things at (by far the biggest
>> effect), and the minor difference that the frequency makes at that voltage
>> (possibly small enough to ignore entirely).
>>
>> the API I proposed has no problem with there being multiple modes that
>> have the same %power but with different %capability numbers.
>
> how do you deal with the "power at idle" vs "power at full load".. you
> need both at each level to pick the best one, as well as relative
> performance etc.

what I was thinking was to use power at full load for the power rateing of 
each mode.

>> the fact that you want to run at the max frequancy for a given voltage is
>
> no I want to run at the max frequency PERIOD. On just about any PC, it's
> more power efficient to go full speed when executing code, and then idle
> for as long as you can. (there are some second order effects that make
> this a bit more complex, but as first order approach it's a sound
> approach). Voltage follows, and that's fine.

this seems to be contradicted by the fact that AMD is listing the ability 
for each core to run at a different clock speed on the new 4-core chips as 
an advantage. if you always want to run at the max frequency PERIOD then 
why bother engineering the ability to do otherwise? (as opposed to just 
shutting down unused cores)

another example is the 80 core demo chip that Intel has been makeing press 
about. it can run at 1Tflop on 25w of power and 2Tflop at 150w of power. 
running at max freq for a 1Tflop workload would have you eating ~75w of 
power (the numbers may be off, I'm going from memory, but the cost in 
power of doubling the speed was _far_ more then double the power 
requirements)

>> this strategy should work well on the normal unpredictable workload that
>> most people deal with, but there are some cases where the workload becomes
>> pretty predictable (media players for example) where there really is less
>> variation, and a need for a constant availability of the cpu, so it may
>> actually save a smidge of power to run below the highest freq that the
>> voltage allows rather then running faster and being idle more cycles.
>
> that actually is the example showcase of race-to-idle where you
> absolutely want to run at the highest frequency..

only if the transitions don't cost anything significant, and the 
computation capacity per watt of power is the same at all frequencies. the 
chip performance numbers I've been seeing (which I admit are mostly 
embedded datasheets) indicate that neither of these hold true.

David Lang
