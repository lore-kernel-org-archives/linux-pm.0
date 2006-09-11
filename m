From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
 Re: So, what's the status on the recent patches here?]
Date: Tue, 12 Sep 2006 02:41:51 +0400
Message-ID: <4505E62F.1000203@gmail.com>
References: <20060911210026.GG11901@elf.ucw.cz>
	<ADE4D9DBCFC3A345AAA95C195F62B6DD01B1D623@de01exm64.ds.mot.com>
	<20060911213930.GJ11901@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060911213930.GJ11901@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Preece Scott-PREECE <scott.preece@motorola.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> On Mon 2006-09-11 17:36:33, Preece Scott-PREECE wrote:
>>> From: Pavel Machek [mailto:pavel@ucw.cz] =

>>>
>>>>>> - PowerOP is only one layer (towards the bottom) in a power =

>>>>>> management solution.
>>>>>> - PowerOP does *not* replace cpufreq
>>>>> PowerOP provides userland interface for changing processor =

>>> frequency. =

>>>>> That's bad -- duplicate interface.
>>>> Basically the biggest problem with cpufreq interface is =

>>> that cpufreq =

>>>> has "chose predefined closest to a given frequency" functionality =

>>>> implemented in the kernel while there is _no_ any reason to =

>>> have this =

>>>> functionality implemented in the kernel if we have sysfs interface =

>>>> exported by PowerOP in place - you just
>>> No, there is reason to keep that in kernel -- so that cpufreq =

>>> userspace interface can be kept, and so that resulting =

>>> kernel<->user interface is not ugly.
>> ---
>>
>> Just as a data point, "keeping the cpufreq interface" is
>> irrelevant to a number of us, because we configure it out
>> of the system.  I'm not really arguing that we should get
>> rid of an existing kernel interface, but I don't see any
>> reason why we shouldn't be able to have a separately
>> configurable interface if cpufreq doesn't meet our needs.
> =

> Configurable interfaces are evil,
Are you saying that not having sysfs attribute nodes for entities which don=
't =

exist in a certain configuration is evil?

In x86 configuration you'd like to have just one attribute - frequency? It'=
s =

just subset of common case when all power parameters available on a platfor=
m are =

exported. In x86 configuration you'd like to echo arbitrary frequency value=
 into =

'sys/something' and have underneath logic to chose "closest" predefine =

frequency? No any reason to handle this in the kernel once frequency attrib=
ute =

is exported.
> and I do not think you can push such
> patch. You have developed your own little interface that suits your
> needs -- and that's fine -- but now you are trying to push it into
> mainline... and that is not, because those interfaces were not really
> designed to work together.
once cpufreq userland interface functionality which does not belong to the =

kernel is moved out of the kernel cpufreq interface becomes a subset of Pow=
erOP =

  sysfs interface. In other words this means that improvements of PM stack =

layers/interfaces design will allow to design/develop an universal userspac=
e =

interface. We'd prefer to move gracefully in this direction though.

	Eugeny
> 								Pavel
