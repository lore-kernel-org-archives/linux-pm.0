From: david singleton <dsingleton@mvista.com>
Subject: Re: PowerOp Design and working patch
Date: Mon, 31 Jul 2006 18:27:51 -0700
Message-ID: <9ccf3d3f54538bb3a8ea72709e776c26@mvista.com>
References: <242d827d33807b6b46608a26ed29c273@mvista.com>
	<20060728233837.GG2140@kroah.com>
	<c6333353f00bb7fd435ef518dc8cee21@mvista.com>
	<20060729004546.GA3917@kroah.com>
	<1c70fd37e4eb876295e0194e2b8725d6@mvista.com>
	<20060729220902.GA8581@kroah.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060729220902.GA8581@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


On Jul 29, 2006, at 3:09 PM, Greg KH wrote:

> On Fri, Jul 28, 2006 at 10:12:26PM -0700, david singleton wrote:
>>
>> Greg,
>> 	perhaps I need to back up a bit.  I wasn't submitting these patches
>> for inclusion into Linux.  I was presenting them to the people
>> discussing
>> how power management might evolve in Linux.
>
> That's fine, but you should at least post them so we can read and
> comment on them from within our email clients then :)
>
> And also by breaking up the patches into small logical changes, it =

> helps
> us to understand what they are doing and would allow us to evaluate =

> them
> much better.
>
> thanks,
>
> greg k-h
>

        Greg,
                 the three patches I just sent,  meant to send this =

first,
         describe a concept called power op that
         shows how the various power management infrastructures in
         Linux could be unified and simplified.  This email describes
         the concept of what power op is trying to do and how it works.

                 The following emails break a prototype patch into
         three logical parts.  The first patch is the powerop-core.patch
         that adds support for an operating point in the standard linux
         power management infrastructure (CONFIG_PM) and adds a new
         function to perform transitioning to operating points other
         than suspend to memory or disk.

                 The second patch adds the cpufreq portion of the patch
         that makes cpufreq table a set of operating points.

                 The third patch adds some operating points for
         the centrino-speedstep (the notebook I'm doing the prototype on)
         and a centrino specific transition function.

                 The goal of these patches is not to show how the
         concept of supported operating points should be implemented,
         rather its intended to show that they can be unified and
         greatly simplified.

                 All the power management infrastructures operate on
         what can be conceptualized as an operating point.  Once they
         get down to the point where they start controlling power, =

frequency
         or voltage, they are transitioning from one operating point
         to another.  They all also follow the same steps to transition
         from one operating point to another.

                 Powerop uses the traditional power management interface
         of /sys/power/state but changes it a bit. When it's read it =

shows
         the current operating point of the system.  Powerop uses a =

second
         sysfs file to present the list of supported operating points, =

their
         name, frequency, voltage and description,  to the user.

                 The user sets the operating point of the system by =

writing
         the name of the operating point into the /sys/power/state file.

                 The goal of powerop is to both unify and simplify the
         different power management infrastructures.  It does this
         by treating all supported states the system can be in as
         different operating points that can be simply transitioned
         to via the name of the operating point.

                 It simplifies power management by following the CPUFREQ
         concept of a vendor specified and validated table of supported
         operating points.  In CPUFREQ the user is not allowed to
         set the frequency or voltage of an operating point that might
         hang the system, either inadverdantly or maliciously.

                 It also simplifies the code  by putting all the =

decisions
         about when to transition to a new operating point in the
         hands of the user.  With this simple example patch the user
         can manually switch between all the supported states of the
         centrino speedstep.


                 The powerop-core.patch has more details in the
         Documentation/power/power.txt file.


David
