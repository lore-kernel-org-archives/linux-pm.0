From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
 Re: So, what's the status on the recent patches here?]
Date: Tue, 12 Sep 2006 00:24:25 +0400
Message-ID: <4505C5F9.4060704@gmail.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<450530BD.8090101@gmail.com> <20060911193637.GA11901@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060911193637.GA11901@elf.ucw.cz>
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
Cc: pm list <linux-pm@lists.osdl.org>, scott.preece@motorola.com
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Hi!
> =

>>>>>> Are you arguing that the cpufreq interface be morphed to support pow=
er
>>>>>> op applications?
>>>>> No. I'm arguing that
>>>>>
>>>>> * cpufreq interface should be used for changing cpu frequency
>>>> the patch set i sent out has cpufreq used for changing cpu frequency,
>>>> hasn't it?
>>> I was talking about kernel<->user interface.
>> me too. PowerOP is inkernel interface but which _allows_ to build various
>> different kernel<->user interfaces on top of it. This PowerOP _advantage=
_ =

>> allows community to experiment with various kernel<->user interfaces
>> on top =

> =

> Kernel interface is not something to be experimented with.
it is since current interface (cpufreq in conjunction with /sys/power/state=
, =

etc) does not address all requirements to the interface. PowerOP approach h=
elps =

to figure out best interface gracefully since there is no common opinion in=
 the =

community yet.
> =

>> and eventually end up with the best solution. The solution can be either =

>> one universal, agreed by community kernel<-> user interface on top or I =
can =

>> imaging the approach when kernel<-> user interfaces on top are configura=
ble =

>> feature and system designer choses kernel<->user interface which fits be=
st =

>> the systems he/she builds.
> =

> ...and configurable kernel interfaces are very bad idea.
it's not an argument. the ideal goal to end up with one universal interface=
. but =

until you personally stuck with cpufreq interface this is the only way to =

proceed towards universal interface design. let people to investigate advan=
tages =

and disadvantages of this and that interfaces on a working system since we =
can't =

convince each other by this flame.
> =

>>> You did echo low > something to change CPU frequency, IIRC.
>> My patch set presents two different interfaces built on top of PowerOP - =

>> cpufreq and sysfs interfaces. So _no_, PowerOP is not all about
> =

> Okay, drop sysfs interface, and we may have something that can be
> reviewed.
previous take of PowerOP did not contain sysfs part but I have not received=
 any =

you comment on this. Sysfs is completely optional feature after all.
 >
> Actually that's good idea. Submit powerop without doing _any_ kernel
> interface changes, so we can see that it makes sense...
It was submitted this way several times.

Eugeny
