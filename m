From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
 Re: So, what's the status on the recent patches here?]
Date: Tue, 12 Sep 2006 00:53:46 +0400
Message-ID: <4505CCDA.8020501@gmail.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com>
	<20060911195546.GB11901@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060911195546.GB11901@elf.ucw.cz>
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
> Hi!
> =

>> I know its confusing having oppoint (from Dave Singleton) and powerop =

>> being discussed at the same time.  However, I believe we (PowerOP)
>> have =

> =

> Yes, it is.
> =

>> - PowerOP is only one layer (towards the bottom) in a power management =

>> solution.
>> - PowerOP does *not* replace cpufreq
> =

> PowerOP provides userland interface for changing processor
> frequency. That's bad -- duplicate interface.
Basically the biggest problem with cpufreq interface is that cpufreq has "c=
hose
predefined closest to a given frequency" functionality implemented in the
kernel while there is _no_ any reason to have this functionality implemente=
d in
the kernel if we have sysfs interface exported by PowerOP in place - you ju=
st
_have_ to keep all possible functionality out of the kernel. CPufreq interf=
ace
is just subset of sysfs interface provided by PowerOP and _must_ be impleme=
nted
in userspace on top of sysfs interface - this is the proper way to scape
duplication. Such issue with cpufreq<->kernel userspace interface is conseq=
uence
of the fact that cpufreq implements incorrect design of PM stack layers and
interfaces. PowerOP solves this issues as well.
> =

>> - The PowerOP interface was discussed in detail on this list and we =

>> haven't heard any negative comments.
> =

> Eh? Was I on different list?vb dfgdfv
> =

>> - We are not advocating the integration with sleep states.  We want to =

>> get the PowerOP interface accepted and then we can build on it.
> =

> Good.
> =

>> We have a few more comments from Greg to take care of and  we can add a =

>> Documentation/ file. Then I think its time to get the PowerOP patches =

>> in the queue for acceptance.    Any comments about this?
> =

> Well, you'll only get good interface review when you have
> Documentation/ , and it needs to go to lkml before it goes to any
> queues.
PM stack is too complex and heavy part to go in such pieces thru lkml. i ex=
pect =

all linux  pm experts to be on this list

Eugeny
> 								Pavel
> =
