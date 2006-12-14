From: Pavel Machek <pavel@ucw.cz>
Subject: Re: nokia 770 [was Re: community PM requirements/issues
	and PowerOP]
Date: Thu, 14 Dec 2006 14:56:10 +0000
Message-ID: <20061214145609.GA4451@ucw.cz>
References: <457FEE17.8080806@gmail.com> <20061213210359.GC11843@elf.ucw.cz>
	<200612131332.58606.david-b@pacbell.net>
	<BBB6202A-4F06-4D2D-BD8E-DD34267D85E9@comcast.net>
	<20061213215351.GE2418@redhat.com>
	<5062AF8D-E97F-41D2-8602-59578F2B4655@comcast.net>
	<20061213225802.GN2418@redhat.com> <458123F5.6090104@gmail.com>
	<20061214121214.GR2418@redhat.com>
	<acd2a5930612140501n3f287693i3670d836a82f9369@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <acd2a5930612140501n3f287693i3670d836a82f9369@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-pm@lists.osdl.org, Amit Kucheria <amit.kucheria@nokia.com>, Matthew Locke <matthew.a.locke@comcast.net>, scott.preece@motorola.com
List-Id: linux-pm@vger.kernel.org


> >But what sense does it make for a user,sysadmin or =

> >application
> >to change voltage?  If any of these want to save power, =

> >they do so
> >by a) doing less work, and then b) lowering the clock =

> >speed as this
> >is inherently tied to voltage.
> =

> It makes sense to perform changing an operating point =

> dynamically in
> userland.

In very special cases, yes.

> That said, voltage should be accessible from userland.

Why?

If few states differ in voltage but not frequency, the only
user-visible thing is different latency of enter/exit.

If you only have two voltages per frequency (as it was shown in
examples here)... just add 1Hz to make difference between the two.

...but I guess you should teach cpufreq's ondemand governor to deal
with different latencies for different voltages. Before that is done
and shown to have significant power-saving impact, userspace interface
debate is useless.
							Pavel

-- =

Thanks for all the (sleeping) penguins.
