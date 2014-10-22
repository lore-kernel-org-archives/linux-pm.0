From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [GIT PULL] thermal soc changes
Date: Wed, 22 Oct 2014 14:07:03 +0100
Message-ID: <9hhiojc1ceg.fsf@arm.com>
References: <1408711592-8917-1-git-send-email-edubezval@gmail.com>
	<1409125313.8085.22.camel@rzhang1-toshiba>
	<20140827132717.GA15875@developer>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140827132717.GA15875@developer> (Eduardo Valentin's message of
	"Wed, 27 Aug 2014 09:27:19 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rui

Eduardo Valentin <edubezval@gmail.com> writes:

> Hello Rui,
>
> On Wed, Aug 27, 2014 at 03:41:53PM +0800, Zhang Rui wrote:
>> On Fri, 2014-08-22 at 08:46 -0400, Eduardo Valentin wrote:
>> > Hello Rui,
>> > 
>> > Please pull these changes. Here we have three new features: IMX driver has
>> > now support to i.mx6sx, the of-thermal now if aware of disabled thermal zones
>> > in DT, and we shall have tracing support on thermal framework.
>> > 
>> > The following changes since commit 47d104ba5879790c7c91c3390b0b08399e168efe:
>> > 
>> >   Merge branches 'exynos-fix', 'for-rc', 'int3403-fix', 'misc', 'rcar-thermal' and 'sti-thermal' of .git into next (2014-07-22 10:13:00 +0800)
>> > 
>> > are available in the git repository at:
>> > 
>> > 
>> >   https://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git 
>> > 
>> 
>> I suppose you mean
>> http://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git next branch. And I've pulled those changes in your next branch.
>
> Yes Rui. I made a mistake. 
>
> Thanks for pulling.
>
>
>> 
>> thanks,
>
> Cheers,
>

[...]

>> > Punit Agrawal (3):
>> >       thermal: trace: Trace temperature changes
>> >       thermal: trace: Trace when a cooling device's state is updated
>> >       thermal: trace: Trace when temperature is above a trip point

I can't find the thermal trace patches in 3.18-rc1. When should I expect
to see them in Linus' tree?

Cheers,
Punit

[...]
