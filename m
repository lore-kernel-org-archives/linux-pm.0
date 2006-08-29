From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Tue, 29 Aug 2006 13:49:07 -0400
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A94E18@de01exm64.ds.mot.com>
References: <20060829163455.GA4821@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
In-Reply-To: <20060829163455.GA4821@ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>, David Singleton <daviado@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


> From: linux-pm-bounces@lists.osdl.org =

> [mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Pavel Machek
> Sent: Tuesday, August 29, 2006 11:35 AM
> To: David Singleton
> Cc: linux-pm@lists.osdl.org
> Subject: Re: [linux-pm] So, what's the status on the recent =

> patches here?
> =

> Hi!
> > >>         point, by name. There is a new
> > >/sys/power/operating_points directory
> > >>         that shows all the operating points the
> > >system supports. An
> > >>         exampled from my centrino laptop shows:
> > >>
> > >>         /sys/power/operating_points/high
> > >>         /sys/power/operating_points/highest
> > >>         /sys/power/operating_points/low
> > >>         /sys/power/operating_points/lowest
> > >>         /sys/power/operating_points/medium
> > >>         /sys/power/operating_points/mem
> > >>         /sys/power/operating_points/standby
> > >
> > >What makes you think that mixing operating and sleep =

> states is good =

> > >idea?
> > =

> > They are all power states managed by the kernel and in the =

> operating =

> > point concept they are all operating points the system supports.
> =

> That does not make mixing them right.
---

Could you say why you think they shouldn't be mixed? Absent argument to
the contrary, =

making it a single continuum seems appealing. Why have separate
policies?

---
> =

> > The system can be set to any of the supported states by =

> setting their =

> > name in the /sys/power/state file.  I find simplicity is usually a =

> > good thing.
> =

> I believe the quote is 'make it as simple as possible but not =

> simpler'.
---

So, why don't you think this simplification is possible?

---
> =

> > >And '600MHz' makes lot more sense than 'lowest' on centrino.
> > =

> > Perhaps, but the common name space makes it easy for the =

> power manager =

> > daemon to perform the same functions without having to know =

> that the =

> > lowest speed on my laptop is 600Mhz.
> =

> And enumerate english strings in power daemon? Limiting the =

> numver of states?
---

Are you saying that on your laptop, all possible CPU and bus frequencies

can be used independently? So, it would be unnecessarily limiting to
have =

the system designer provide a list of combinations that work? Remember
that
the scope of this is a limited set of parameters, not all the devices in
the system.

---
> =

> > >
> > >>         /sys/power/operating_points/high/frequency
> > >>         /sys/power/operating_points/high/voltage
> > >>         /sys/power/operating_points/high/latency
> > >
> > >What is voltage for 'mem'?
> > =

> > I don't know what the voltage or latency is for mem.  =

> > Perhaps Intel could better
> > say what the voltage is in the suspend state and what the =

> latency was =

> > for transistion to that state.  I didn't have the data =

> available when =

> > I wrote the code.
> =

> And you will not have data available even if intel helps you. =

> What is _frequency_ for mem? These fields are meaningless for =

> sleep states; that should tell you that mixing sleep and =

> operating states is bad idea.
---

Why isn't 0 a meaningful value for frequency? And I can imagine
that some hardware might have different voltage options for sleep
States.  Additionally, these sys entries could represent the frequency,
voltage, etc., that the system would go to upon resuming from sleep...

scott  =
