From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
 Re: So, what's the status on the recent patches here?]
Date: Tue, 12 Sep 2006 02:05:26 +0400
Message-ID: <4505DDA6.8080603@gmail.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com>
	<20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>
	<20060911210026.GG11901@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060911210026.GG11901@elf.ucw.cz>
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
Cc: pm list <linux-pm@lists.osdl.org>, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
>>>> - PowerOP is only one layer (towards the bottom) in a power management =

>>>> solution.
>>>> - PowerOP does *not* replace cpufreq
>>> PowerOP provides userland interface for changing processor
>>> frequency. That's bad -- duplicate interface.
>> Basically the biggest problem with cpufreq interface is that cpufreq has =

>> "chose
>> predefined closest to a given frequency" functionality implemented in the
>> kernel while there is _no_ any reason to have this functionality =

>> implemented in
>> the kernel if we have sysfs interface exported by PowerOP in place - you =

>> just
> =

> No, there is reason to keep that in kernel -- so that cpufreq
> userspace interface can be kept, and so that resulting kernel<->user
> interface is not ugly.
Cpuferq defines cpufreq_frequency_table structure in arch independent heade=
r =

while it's arch dependent data structure. A lot of code is built around thi=
s =

invalid basic brick and therefore is invalid: cpufreq tables, interface wit=
h cpu =

freq drivers, etc. Notion of transition latency as it defined by cpufreq is =

wrong because it's not a function of cpu type but function of current and n=
ext =

operating point. no runtime control on operating points set. it's always th=
e =

same set of operating points for all system cpus in smp case and no way to =

define different sets or track any dependencies in case say multi core cpus=
. =

insufficient kernel<->user space interface to handle embedded requirements =
and =

no way to extend it within current design. Shall I continue?  Why should th=
en =

anyone want to keep cpufreq userspace interface just due to keep it?
> =

>> of the fact that cpufreq implements incorrect design of PM stack layers =
and
>> interfaces. PowerOP solves this issues as well.
> =

> Actually I believe that cpufreq implements correct design and PowerOP
> got it wrong.
PowerOP/cufreq integration patch set contains very details explanation of t=
he =

cpufreq design issues and POwerOP solutions. Comment there is you feel it's=
 wrong.

Eugeny
> =

>>> Well, you'll only get good interface review when you have
>>> Documentation/ , and it needs to go to lkml before it goes to any
>>> queues.
>> PM stack is too complex and heavy part to go in such pieces thru lkml. i =

>> expect all linux  pm experts to be on this list
> =

> "We are too lazy to make the code clean enough / well enough explained
> to survive lkml review".
> =

> Your interface impacts everyone, so everyone should have chance to
> comment on it.
> 								Pavel
