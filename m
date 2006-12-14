From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: nokia 770 [was Re: community PM requirements/issues
 and PowerOP]
Date: Thu, 14 Dec 2006 18:22:25 +0300
Message-ID: <45816C31.5040805@gmail.com>
References: <20060914101704.GA17820@elf.ucw.cz> <457FEE17.8080806@gmail.com>
	<20061213210359.GC11843@elf.ucw.cz>
	<200612131332.58606.david-b@pacbell.net>
	<BBB6202A-4F06-4D2D-BD8E-DD34267D85E9@comcast.net>
	<20061213215351.GE2418@redhat.com>
	<5062AF8D-E97F-41D2-8602-59578F2B4655@comcast.net>
	<20061213225802.GN2418@redhat.com> <458123F5.6090104@gmail.com>
	<20061214121214.GR2418@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061214121214.GR2418@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>
Cc: scott.preece@motorola.com, Matthew Locke <matthew.a.locke@comcast.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>, Amit Kucheria <amit.kucheria@nokia.com>
List-Id: linux-pm@vger.kernel.org

Dave Jones wrote:

>On Thu, Dec 14, 2006 at 01:14:13PM +0300, Dmitry Krivoschekov wrote:
>
> > > > Ok, let's reword my sentence.  The cpufreq interface does not suppo=
rt  =

> > > > voltage as a  parameter
> > >
> > >Please explain why this is useful at all.
> > >Under what circumstance is "Set the CPU voltage to 1.2V" a useful thing
> > >for a user, sysadmin, or application to do ?
> > >  =

> > >
> > Voltage scaling is a well known technique to reduce power consumption, =
try
> > google search "Dynamic voltage scaling" if you are intrested in it.
>
>You've missed the point.  I'm well aware of dynamic voltage scaling,
>and some of the cpufreq drivers I've written do this.
>  =

>
I'm sorry, I didn't want to offend you, just to be sure we are talking =

about
the same things.

> > I agree, in most cases we don't need to scale CPU voltage and frequency
> > independently since CPU frequency usually coupled with appropriate volt=
age
> > to set.
>
>A CPU frequency _always_ has a specific voltage associated with it.
>
>  =

>
I have to correct you: "CPU frequency of x86 CPU's always has a specific
voltage", it is because of CPU designers have defined this voltage as
the best (or optimal maybe) voltage for this given frequency, it doesn't
mean CPU won't work on some different voltage, you just can say the CPU
with probability of say 99.9% will work stable on this voltage, but if you
want to rise performance you could do it via rising of voltage for example.

But, nobody says "let's give desktop user's the ability to control whatever
they may control, of course, it is dangerous to let an average desktop
user to do such things. But, think about designer who build embedded
mobile system that powered by Linux. Any mobile system always needs for
fine grained power management but you won't be able to tune an optimal
power consumption if you operate by only one parameter (cpufreq).


> > But some CPU's permit to choose frequency value for
> > a given voltage or vice versa
>
>But what sense does it make for a user,sysadmin or application
>to change voltage?  If any of these want to save power, they do so
>by a) doing less work, and then b) lowering the clock speed as this
>is inherently tied to voltage.
>
>  =

>
You always think about this triage user,sysadmin and application of PC's,
think about embedded devices please, there we don't have stupid users
that want to on/off everthing. Why don't let a qualified engineer to tune
a number of parameters to get an optimal performance/power tradeoff?

>And if you lower voltage, you *MUST* reduce the frequency anyway.
>Running CPUs at higher speeds at lower voltages than those frequencies
>are rated for is a fastpath to a crash.
>  =

>
I don't think it's always true, simply CMOS circuity won't work on voltage
levels below some limit.

>This is one fundamental reason I'm opposed to exporting voltages to usersp=
ace.
>Because people _will_ get this wrong, and we will see all manner of
>strange bugs and crashes reported from people running CPUs at higher
>speeds than the voltage is rated for.
>
>By putting this into the hands of userspace, we're setting ourselves up
>to fail.  How does userspace/users know what voltage is safe for what freq=
uency?
>Without being intimate with the CPU datasheets, they're almost guaranteed
>to fail.  =

>
Here I encourage to think about other users (system designers I mean)
who definetely have to read datasheets and other related docs.

>The _driver_ needs to know the pairings of voltage/frequency
>and export the only thing that makes sense.
>
> > Also, CPU is not the only power consumer in the system, you may need to =

> > scale voltage for other devices to get a best perfomance/power trade of=
f.
> > And here is an obvious limitation of cpufreq since it takes care only
> > about CPU.
>
>You see it as a limitation, I see it behaving 'as designed'.
>If those devices have nothing to do with the CPU, why are they even
>relevant to this discussion?
>  =

>
Because the discussion is related to PowerOP, and PowerOP in turn is
a set of different power parameters (or maybe not only power,
it's not a limitation).

>The argument seems to be "cpufreq only cares about CPU frequency, therefore
>we need something different".  But, why?  =

>
Because a number of platforms permit to tune more parameters than CPU freq,
that in turn lets people to design more powersave systems, but cpufreq =

interface
restricts this ability.

But, I didn't ever say we need to remove cpufreq, I say we need to think not
only about PC's but also about embedded (mobile) systems that requre =

some different
solution.

Regards,
Dmitry

>I see no reason why we need
>to change cpufreq at all, just add additional interfaces to cover those
>other devices, as they're unrelated anyway.   And if there *are* any
>devices that are related, they can be tied into the existing cpufreq
>drivers just as for eg, the sa1100 drivers scale DRAM timings with CPU spe=
ed.
>
>		Dave
>
>  =

>
