From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: [RFC] PowerOP Take 3, ARM OMAP1 platform support 3/5
Date: Thu, 27 Jul 2006 01:02:29 +0400
Message-ID: <44C7D865.8020109@gmail.com>
References: <c55240ed0607201301y7ac3be76o6f173d1b6ab50c1d@mail.gmail.com>
	<200607230924.52289.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607230924.52289.david-b@pacbell.net>
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
> On Thursday 20 July 2006 1:01 pm, Eugeny S. Mints wrote:
>   =

>> +struct powerop_point {
>> +       unsigned int v;         /* voltage in mV */
>> +       unsigned int dpll;      /* in KHz */
>> +       unsigned int cpu;       /* CPU frequency in KHz */
>> +       unsigned int tc;        /* in KHz */
>> +       unsigned int per;       /* in KHz */
>> +       unsigned int dsp;       /* in KHz */
>> +       unsigned int dspmmu;    /* in KHz */
>> +       unsigned int lcd;       /* in KHz */
>> +};
>>     =

>
> A few comments:
>
>  - This should be part of patch #4; it's not truly separate.
>   =

PowerOP defines interface between an upper layer and PM core
and struct powerop_point is part of this interface - it defines what
the terms an upper layer and PM Core use to communicate to
each other are. And from this perspective I feel struct
powerop_point  logically belongs to PowerOP layer although
it is defined in arch dependent code.
>  - I take it "v" is CPU voltage rather than some random component?
>   =

yes
>    Either way, there seems to be an omission here since boards
>    could have multiple voltages to care about ...
>   =

see reply under the next bullet discussing board vs SoC but basically yes,
if we have multiple voltages to care about all voltages have to be
represented in the structure. Reference code structure definition may
be incomplete.
>  - In general, shouldn't an operating point be board-specific, so
>    that the parts of the system outside the SOC can be included
>   =

good question. Basically current assumption is that definition is for an SoC
and the values are board specific. While definition will most likely be the
same for every board based on a certain SoC I can imaging for example
that we can have an external clock source for an external hw on a board.
Since that  powerop_point structure definition could be board specific
but that's where I'd prefer to get some input from the community to
decide whether we have to move to board specific operating point
structure definition.
>  - I'd still rather see operating points be identified by a name
>    string of some kind so that the userspace API resembles that
>    of /sys/power/state:  just write the state name to that file.
>
>   =

it's actully designed this way except that an operating point should be
created first to be dereferenced by name. PowerOP sysfs layer
provides two interfaces for operating points to be created. First one is
powerop_register_point() and this interface enables exactly runtime
API you outlined assuming that a kernel entity creates a set of
operating points with help of power_register_point() for example
at boot up.  Second real sysfs interface assumes that a set of operating
 points is created from user space. But since operating points initial
creation may be handled by an init script (again say at system boot up)
the PowerOP runtime API may be again seen as what you described.

Thanks,
Eugeny
> Still looking at the patches, otherwise.
>
> - Dave
>   =

>
>
>   =
