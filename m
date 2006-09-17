From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: Re: community PM requirements/issues and
	PowerOP[Was:	Re: So, what's the status on the recent patches here?]
Date: Sun, 17 Sep 2006 14:25:18 -0400
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DD01BB248A@de01exm64.ds.mot.com>
References: <1158502497.22773.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
In-Reply-To: <1158502497.22773.16.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Amit Kucheria <amit.kucheria@nokia.com>, ext Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

 > From:  Amit Kucheria
> =

> On Sun, 2006-09-17 at 15:40 +0200, ext Pavel Machek wrote:
> > On Sun 2006-09-17 16:28:23, Amit Kucheria wrote:
> > > On Sun, 2006-09-17 at 15:18 +0200, ext Pavel Machek wrote:
...
> > > I was referring to the default method of power save on =

> Zaurus on the =

> > > Sharp ROMs. It was S-T-D (Flash), IIRC. I do not recall drivers =

> > > doing runtime power management on Zaurus; that is a major =

> difference =

> > > from Nokia 770.
> > =

> > I'm pretty sure Zauruses do s-t-ram. Flash is read only =

> during normal =

> > operation.
> > =

> > I'm very sure Sharp zaurus sl-5500 does s-t-ram. After all, it has =

> > 16MB of flash and 64MB of ram. Suspend-to-flash is not an option.
> > =

> > 								Pavel
> =

> If that is the case, I stand corrected. Did the drivers =

> support dynamic idling?
> =

> Although something about the time it took to resume still =

> bothers me....
> I will try to find time to flash it and check.

Google provided a reference to what appears to be a student
paper on power management in the Zaurus, at:
<http://personals.ac.upc.edu/mpericas/zaurus_project-final.pdf#search=3D%2
2%22power%20management%22%20zaurus%20linux%22>.

>From the paper, it sounds like it has cpufreq =

scaling and a sleep mode that is basically suspend-to-RAM.
This was apparently done via backporting stuff to 2.4.

Scott
