From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
 Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 13:47:41 +0400
Message-ID: <450530BD.8090101@gmail.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060911082025.GD1898@elf.ucw.cz>
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

> On Mon 2006-09-11 11:57:28, Eugeny S. Mints wrote:
>> [snip]
>>>> Are you arguing that the cpufreq interface be morphed to support power
>>>> op applications?
>>> No. I'm arguing that
>>>
>>> * cpufreq interface should be used for changing cpu frequency
>> the patch set i sent out has cpufreq used for changing cpu frequency,
>> hasn't it?
> =

> I was talking about kernel<->user interface.
me too. PowerOP is inkernel interface but which _allows_ to build various
different kernel<->user interfaces on top of it. This PowerOP _advantage_ a=
llows =

community to experiment with various kernel<->user interfaces on top and =

eventually end up with the best solution. The solution can be either one =

universal, agreed by community kernel<-> user interface on top or I can ima=
ging =

the approach when kernel<-> user interfaces on top are configurable feature=
 and =

system designer choses kernel<->user interface which fits best the systems =

he/she builds.
> =

> You did echo low > something to change CPU frequency, IIRC.
My patch set presents two different interfaces built on top of PowerOP - cp=
ufreq =

and sysfs interfaces. So _no_, PowerOP is not all about 'echo low > somethi=
ng'. =

Such kernel<-> user interface is  an _option_. PowerOP supports full _legac=
y_ =

cpufreq interface as another option - please check out PowerOP/cpufreq =

integration patch set. The goal is either to end up with one kernel<->user =

interface which addresses both pc world and embedded world requirements to =

user<->kernel interface _or_ - as an alternative I'd prefer - have these =

kernel<->user interfaces configurable: if you build laptop  system - chose =

cpufreq interface on top of PowerOP; if you build embedded - chose sysfs =

interface. But with the approach when everything is built on top PowerOP[PM =

Core, Clock framework] you just eliminate all unnecessary duplication if PM =

functionality in PM  stack.

Just in case you are confused by the fact I didn;t send out PowerOP/cpufreq =

integration patch along with the last PowerOP Core take: PowereOP Core patc=
h I =

sent out in the last take is a standalone functional piece. PowerOP/cpufreq =

integration patch is just a further extension and applies to the most recen=
t =

POwerOP Core without any changes so there was no reason to resend =

PowerOP/cpufreq integration.
> =

>> can we eventually start talking more close to the code rather than
>> speculating without it?
> =

> Lets get kernel<->user interface right, first. You'll need to create
> Documentation/ entries for your interfaces, eventually, so lets do
> that, first, and then talk about code.
Documentation/ piece is fine, I will add it. But I feel I put quite detaile=
d =

comments along with the patches at least to explain interfaces.
> Oh and it would be nice to cc
> lkml on that document, too. New kernel<->user interface is not
> decision taken lightly.
PowerOP Core and PowerOP/cpufreq integration patch sets present two clear a=
nd =

configurable kernel<->user interfaces. I personally feel that interfaces =

configuration feature allows graceful interface discussion and possibility =
to =

get a decision smoothly instead of a flame on a list. If you argue against =

configuration feature please put comments on exactly configuration feature. =

Otherwise please explicitly list the requirements for kernel<->user interfa=
ce =

you have which are not addressed by these two interfaces assuming you can c=
hose =

either interface having PowerOP underneath.

Thanks,
	Eugeny
> 									Pavel
