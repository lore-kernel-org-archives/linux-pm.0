From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Update on USB PM state (2.6.15 queue)
Date: Thu, 6 Oct 2005 08:38:00 +0200
Message-ID: <20051006063800.GC22948@elf.ucw.cz>
References: <200509280957.06073.david-b@pacbell.net>
	<20051004130330.GA9282@openzaurus.ucw.cz>
	<20051005145724.08139EB3BE@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============96887530304209191=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051005145724.08139EB3BE@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============96887530304209191==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > >         * Those other systems don't have any better luck
> > >           when the S1/S3 resume signal is a USB wakeup than
> > >           any other kind of wakeup.
> > > 
> > > Compared to the last time I tested this, it's good to at least
> > > see the USB remote wakeup signals waking the system up; those
> > > seem to be ACPI improvements.  But it still looks like the
> > > cases I most want to see working (S1, S3) are failing on PCs.
> >
> > Look at Doc*/power/video.txt, there's long list of working systems in it.
> 
> Well; that's a list; but sadly, not what I'd call a long one.  :(
> 
> And it doesn't address the case of the system I have which handles
> S1 just fine  ... except that wakeup through USB wedges (after a

S1 is certainly different problem. I fixed the doc to be more clear on
that.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============96887530304209191==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============96887530304209191==--
