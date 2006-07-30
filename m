From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: [RFC] PowerOP Take 3, ARM OMAP1 platform support 3/5
Date: Sun, 30 Jul 2006 23:32:07 +0400
Message-ID: <44CD0937.6060905@gmail.com>
References: <c55240ed0607201301y7ac3be76o6f173d1b6ab50c1d@mail.gmail.com>
	<200607230924.52289.david-b@pacbell.net>
	<44C7D865.8020109@gmail.com>
	<200607261728.40443.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607261728.40443.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Matthew Locke <matt@nomadgs.com>, patrick.mochel@intel.com, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:
> On Wednesday 26 July 2006 2:02 pm, Eugeny S. Mints wrote:
>   =

>> David Brownell wrote:
>>     =

>
>   =

>>>  - This should be part of patch #4; it's not truly separate.
>>>   =

>>>       =

>> PowerOP defines interface between an upper layer and PM core
>> and struct powerop_point is part of this interface - it defines what
>> the terms an upper layer and PM Core use to communicate to
>> each other are. And from this perspective I feel struct
>> powerop_point  logically belongs to PowerOP layer although
>> it is defined in arch dependent code.
>>     =

>
> Whereas I say that arch dependent is arch dependent ... unless
> that "core" is indirecting through "struct powerop_point *", the
> interface doesn't include the struct at all.  Ergo my comment.
>
>   =

Let me try to set it this way.
struct powerop_point is an arch independent piece in the sense that any =

platform
which leverages PorewOP concept should implement struct powerop_point.
struct powerop_point is fundamental component that has to be defined by
a platfrom.

In this way struct powerop_point _is_ part of PowerOP interface .
Let me refer to the picture of proposed framework as well. PowerOP is
interface between PM Core and any upper layer in the framework. Pushing
power parameters definition down to PM Core interface (into some patch with
a name related to pm core rather than to PowerOP) makes understanding
of the framework layers much harder IMO.

If you are  referring to the certain implementation let assume that I put
"struct powerop_point;" instead of inclusion of 'asm/powrop.h' in
include/linux/powerop.h file.

This way you get a compilable arch independent powerop core
piece but let me ask what for? To allow arch independent powerop core
to be standalone compilable? It's just useless: if the arch you are =

building for
does not implement definition of struct powerop_point you just  defer
compilation error to the link phase. Currently you can chose PowerOP
core only if you chose an arch which implements arch dependent piece
of PowerOP.

Plus, in such arch files as pm_core.c and cpu-freq.c you will need =

explicitly
include both arch independent and arch dependent pieces of PowerOP.
While it could be fine with pm core I don't like it for layers above PowerOP
as I explained above.

The bottom line is that yes, PowerOP consists of two part -- arch =

independent
and arch dependent -- but it's still is one layer and one interface =

between PM
Core layer and any layer above PowerOP for _all_ platforms.
>   =

>>>  - I take it "v" is CPU voltage rather than some random component?
>>>   =

>>>       =

>> yes
>>     =

>>>    Either way, there seems to be an omission here since boards
>>>    could have multiple voltages to care about ...
>>>   =

>>>       =

>> see reply under the next bullet discussing board vs SoC but basically ye=
s,
>> if we have multiple voltages to care about all voltages have to be
>> represented in the structure. Reference code structure definition may
>> be incomplete.
>>     =

>
> I don't think "complete" is achievable then.  This is exactly where
> there will need to be component boundaries:  there must be OMAP1 specific
> componentry (with some chip-specific nuances), and also there must be
> board specific componentry.
>
> Your patch #4 for example had #ifdeffery for specific boards.  ISTR
> that was wrong -- it should have been chip specfic nuances, 17xx parts
> vs 16xx ones -- but still there _would_ be a need for boar-specific
> components in a real/usable/complete system.
>
>   =


>>>  - In general, shouldn't an operating point be board-specific, so
>>>    that the parts of the system outside the SOC can be included
>>>   =

>>>       =

>> good question. Basically current assumption is that definition is for an=
 SoC
>> and the values are board specific. While definition will most likely be =
the
>> same for every board based on a certain SoC I can imaging for example
>> that we can have an external clock source for an external hw on a board.
>>     =

>
> I agree that parts of an OP will merit that approach.  But ... the SOC
> is not the only system component that needs managing, and it won't always
> be practical to shuffle the others under the "device-specfic PM" tent.
>
>
>   =

OK, I am almost ready to buy this per SoC and per baord-specific OP =

definition
approach. But let me ask first whether you have at least one example of =

a platform
which fits into this model nowadays?
>> Since that  powerop_point structure definition could be board specific
>> but that's where I'd prefer to get some input from the community to
>> decide whether we have to move to board specific operating point
>> structure definition.
>>     =

>
> My input:  make it easy to partition things into components.  One way
> to do that might be to have an SOC component, multiple device components,
> and a board-specific glue component that connects them in the right way.
>
>   =

please elaborate multiple device components.

Thanks,
Eugeny
> - Dave
>
>
>   =
