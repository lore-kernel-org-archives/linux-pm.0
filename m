From: Dave Jones <davej@redhat.com>
Subject: Re: nokia 770 [was Re: community PM requirements/issues
	and PowerOP]
Date: Thu, 14 Dec 2006 07:12:14 -0500
Message-ID: <20061214121214.GR2418@redhat.com>
References: <20060914101704.GA17820@elf.ucw.cz> <457FEE17.8080806@gmail.com>
	<20061213210359.GC11843@elf.ucw.cz>
	<200612131332.58606.david-b@pacbell.net>
	<BBB6202A-4F06-4D2D-BD8E-DD34267D85E9@comcast.net>
	<20061213215351.GE2418@redhat.com>
	<5062AF8D-E97F-41D2-8602-59578F2B4655@comcast.net>
	<20061213225802.GN2418@redhat.com> <458123F5.6090104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <458123F5.6090104@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: scott.preece@motorola.com, Matthew Locke <matthew.a.locke@comcast.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>, Amit Kucheria <amit.kucheria@nokia.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 14, 2006 at 01:14:13PM +0300, Dmitry Krivoschekov wrote:

 > > > Ok, let's reword my sentence.  The cpufreq interface does not suppor=
t  =

 > > > voltage as a  parameter
 > >
 > >Please explain why this is useful at all.
 > >Under what circumstance is "Set the CPU voltage to 1.2V" a useful thing
 > >for a user, sysadmin, or application to do ?
 > >  =

 > >
 > Voltage scaling is a well known technique to reduce power consumption, t=
ry
 > google search "Dynamic voltage scaling" if you are intrested in it.

You've missed the point.  I'm well aware of dynamic voltage scaling,
and some of the cpufreq drivers I've written do this.

 > I agree, in most cases we don't need to scale CPU voltage and frequency
 > independently since CPU frequency usually coupled with appropriate volta=
ge
 > to set.

A CPU frequency _always_ has a specific voltage associated with it.

 > But some CPU's permit to choose frequency value for
 > a given voltage or vice versa

But what sense does it make for a user,sysadmin or application
to change voltage?  If any of these want to save power, they do so
by a) doing less work, and then b) lowering the clock speed as this
is inherently tied to voltage.

And if you lower voltage, you *MUST* reduce the frequency anyway.
Running CPUs at higher speeds at lower voltages than those frequencies
are rated for is a fastpath to a crash.

This is one fundamental reason I'm opposed to exporting voltages to userspa=
ce.
Because people _will_ get this wrong, and we will see all manner of
strange bugs and crashes reported from people running CPUs at higher
speeds than the voltage is rated for.

By putting this into the hands of userspace, we're setting ourselves up
to fail.  How does userspace/users know what voltage is safe for what frequ=
ency?
Without being intimate with the CPU datasheets, they're almost guaranteed
to fail.  The _driver_ needs to know the pairings of voltage/frequency
and export the only thing that makes sense.

 > Also, CPU is not the only power consumer in the system, you may need to =

 > scale voltage for other devices to get a best perfomance/power trade off.
 > And here is an obvious limitation of cpufreq since it takes care only
 > about CPU.

You see it as a limitation, I see it behaving 'as designed'.
If those devices have nothing to do with the CPU, why are they even
relevant to this discussion?

The argument seems to be "cpufreq only cares about CPU frequency, therefore
we need something different".  But, why?  I see no reason why we need
to change cpufreq at all, just add additional interfaces to cover those
other devices, as they're unrelated anyway.   And if there *are* any
devices that are related, they can be tied into the existing cpufreq
drivers just as for eg, the sa1100 drivers scale DRAM timings with CPU spee=
d.

		Dave

-- =

http://www.codemonkey.org.uk
