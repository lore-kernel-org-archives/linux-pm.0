From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: nokia 770 [was Re: community PM requirements/issues
 and PowerOP]
Date: Thu, 14 Dec 2006 13:14:13 +0300
Message-ID: <458123F5.6090104@gmail.com>
References: <20060914101704.GA17820@elf.ucw.cz>
	<457FEE17.8080806@gmail.com>	<20061213210359.GC11843@elf.ucw.cz>	<200612131332.58606.david-b@pacbell.net>	<BBB6202A-4F06-4D2D-BD8E-DD34267D85E9@comcast.net>	<20061213215351.GE2418@redhat.com>	<5062AF8D-E97F-41D2-8602-59578F2B4655@comcast.net>
	<20061213225802.GN2418@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061213225802.GN2418@redhat.com>
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

>On Wed, Dec 13, 2006 at 02:50:12PM -0800, Matthew Locke wrote:
> > =

> > >>> I'd find that it's used on N770, as a good way to kick in low  =

> > >>> voltage
> > >>> operation modes.
> > >>
> > >> Except that cpufreq doesn't really support voltage changes
> > >
> > > The majority of cpufreq drivers in the tree right now support
> > > voltage scaling just fine.
> > =

> > Ok, let's reword my sentence.  The cpufreq interface does not support  =

> > voltage as a  parameter
>
>Please explain why this is useful at all.
>Under what circumstance is "Set the CPU voltage to 1.2V" a useful thing
>for a user, sysadmin, or application to do ?
>  =

>
Voltage scaling is a well known technique to reduce power consumption, try
google search "Dynamic voltage scaling" if you are intrested in it.

I agree, in most cases we don't need to scale CPU voltage and frequency
independently since CPU frequency usually coupled with appropriate voltage
to set. But some CPU's permit to choose frequency value for
a given voltage or vice versa, and it makes sense to get a mechanism
to control both voltage and frequency in this case. Some platforms,
Intel Mainstone for example, have external s/w-controlled voltage =

requlators,
that allow to change CPU core voltage in pretty wide range.

Also, CPU is not the only power consumer in the system, you may need to =

scale
voltage for other devices to get a best perfomance/power trade off.
And here is an obvious limitation of cpufreq since it takes care only
about CPU.

Regards,
Dmitry

>The voltage something runs at is utterly irrelevant to all the above.
>Given it's inherently tied to the speed a chip runs at, which makes
>a lot more sense for all the above scenarios to change, we export that ins=
tead.
>
>AFAICS, exposing voltages to userspace would be completely pointless.
>
>		Dave
>
>  =

>
