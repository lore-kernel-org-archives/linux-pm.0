From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: PowerOp Design and working patch
Date: Sat, 29 Jul 2006 23:07:12 +0400
Message-ID: <44CBB1E0.3030908@gmail.com>
References: <242d827d33807b6b46608a26ed29c273@mvista.com>	<20060728233837.GG2140@kroah.com>	<c6333353f00bb7fd435ef518dc8cee21@mvista.com>	<20060729004546.GA3917@kroah.com>
	<1c70fd37e4eb876295e0194e2b8725d6@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1c70fd37e4eb876295e0194e2b8725d6@mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: david singleton <dsingleton@mvista.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

david singleton wrote:
> Greg,
> 	perhaps I need to back up a bit.  I wasn't submitting these patches
> for inclusion into Linux.  I was presenting them to the people =

> discussing
> how power management might evolve in Linux.
>
> 	This patch is just a toy prototype to use as a strawman to discuss
> how power management infrastructures in Linux might evolve to be more:
> 	=

> 	a) unified
>   =

 From high level POV I can read this patch set as an approach to
design a glue for suspend/resume management and frequency
changes management in the system but  I can hardly get from the
code and supplied documentation how the patch set addresses the
following  issues in question towards Linux power management
unification.

The ideal goal of ongoing efforts is to design a unified power
management framework which allows to build power management
for systems of different types (desktops, embedded, etc) on top
of the framework, customizing power management of a target
system with help of plugins implementation on framework layers.

I'd like to refer to the ongoing discussion on this list based on the
patches I sent out a week ago and ask for comments on how
your patch set addresses:

1) embedded system needs in question including but not
   limited to:
   - runtime operating points creation from userspace
   - standardization of API to control clock and voltage domains
   - integration with dynamic clock(and voltage) management
      (clock/voltage framework)

2) interface (kernel as well as userspace(sysfs)) for the rest of power
    parameters except cpu voltage and frequency

3) per platform nature of an operating point rather than per
    a pm control layer (cpufreq for ex.):
    - you have cpu freq and voltage defined in common code
       while it's still possible that on a certain platform one would
       not be interested in control of these parameters
   - it's cpufreq driver which allocates memory for operating
     points in your patches. I should not duplicating the code if I'm
     implementing another pm control layer instance (policy manager)
     which is actually a plugin for pm framework and can share operating
     points
   - most probably all operating points [at least] of the same type (
     sleeping or frequency) would have the same transition
     call back and since this it seems transition callback might be
     platform specific thing
   - assuming several instances on pm control layer (several
      policy managers) what would be the code which is
      responsible for accessing hardware to handle a certain
      policy manager decision? With the current approach you
     would need to duplicate code of pre/transition/finish
     routines per a pm control layer instance  =


4) you introduced second sysfs interface for cpufreq and
    have not removed original one. Do you expect cpufreq
    sysfs interface to be changed from original one?

Thanks,
Eugeny
> and
> 	b) simplified for both kernel and user space.
>
> 	The Documentation/powerop.txt included in the powerop-core.patch
> tries to describe what the patch is attempting to do and how it works.
>
> David
>
>
> On Jul 28, 2006, at 5:45 PM, Greg KH wrote:
>
>   =

>> On Fri, Jul 28, 2006 at 05:38:11PM -0700, david singleton wrote:
>>     =

>>> On Jul 28, 2006, at 4:38 PM, Greg KH wrote:
>>>
>>>       =

>>>> On Fri, Jul 28, 2006 at 03:31:41PM -0700, david singleton wrote:
>>>>         =

>>>>> Here is a patch that implements a version of the PowerOp concept.
>>>>>           =

>>>> Any chance of breaking this up into logical patches that do one thing
>>>> at
>>>> a time so it can be reviewed better?
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>>
>>>>         =

>>> Here's powerop-core.patch,  powerop-cpufreq.patch and
>>> powerop-x86-centrino.patch.
>>>       =

>> Um, no, that's not how kernel patches are submitted.  How about one per
>> email, with a description of what they do, inline so we can quote them
>> in a message (and actually read them in the original message...)
>>
>> See patches posted here by others as examples of what is expected, and
>> see Documentation/SubmittingPatches for more details.
>>
>> thanks,
>>
>> greg k-h
>>     =

>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>
>   =
