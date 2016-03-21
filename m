From: Sai Gurrappadi <sgurrappadi@nvidia.com>
Subject: Re: [PATCH v4 2/8] Documentation: arm: define DT cpu capacity bindings
Date: Mon, 21 Mar 2016 12:20:57 -0700
Message-ID: <56F04999.6090902@nvidia.com>
References: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
 <1458311054-13524-3-git-send-email-juri.lelli@arm.com>
 <56EC3F9E.4050209@nvidia.com> <20160321105330.GB12319@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160321105330.GB12319@e106622-lin>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, Linus Walleij <linus.walleij@linaro.org>, will.deacon@arm.com, morten.rasmussen@arm.com, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, broonie@kernel.org, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux@arm.linux.org.uk, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, pboonstoppel@nvidia.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, sudeep.holla@arm.com, Olof Johansson <olof@lixom.net>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: linux-pm@vger.kernel.org



On 03/21/2016 03:53 AM, Juri Lelli wrote:
> Hi Sai,
> 
> On 18/03/16 10:49, Sai Gurrappadi wrote:
>> Hi Juri,
>>
>> On 03/18/2016 07:24 AM, Juri Lelli wrote:
>>
>> <snip>
>>
>>> +
>>> +==========================================
>>> +2 - CPU capacity definition
>>> +==========================================
>>> +
>>> +CPU capacity is a number that provides the scheduler information about CPUs
>>> +heterogeneity. Such heterogeneity can come from micro-architectural differences
>>> +(e.g., ARM big.LITTLE systems) or maximum frequency at which CPUs can run
>>> +(e.g., SMP systems with multiple frequency domains). Heterogeneity in this
>>> +context is about differing performance characteristics; this binding tries to
>>> +capture a first-order approximation of the relative performance of CPUs.
>>
>> Any reason why this capacity number is not dynamically generated based on the
>> max frequency for each CPU? The DT property would then instead specify just
>> the micro-architectural differences between the CPU types.
>>
> 
> I'm not sure I clearly understand your question, so I'll try to
> reiterate it.
> 
> Are you asking why we don't dynamically profile the system, at boot for
> example, to get this number? Or do you ask why this number couldn't be
> only describing micro-arch differences (so, if I get it right, we should
> then multiply it by max freq to get the capacity of a CPU)?
> 
> We already played with the first option (please refer to v2 and v3), but
> we ended up agreeing that dynamic profiling adds overhead to the boot
> process (while a DT approach can provide information to speed up boot)
> and it is in general not repeatable/reliable (as numbers can vary from
> boot to boot for different reasons).
> 
> The second option I think can be feasible, but I'm not sure what we gain
> in practice. We will still need to specify a per-platform number, right?

I meant the second bit. We only need some per-platform fudge factor for
micro-architectural differences. Tying in the Fmax like this statically means
that we need to manually synchronize DVFS tables and this number which seems
unnecessary given that the kernel already has this info on boot.

> 
> Best,
> 
> - Juri
> 
