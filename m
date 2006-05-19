From: David Brownell <david-b@pacbell.net>
Subject: Re: suspend and hibernate nomenclature
Date: Thu, 18 May 2006 19:25:29 -0700
Message-ID: <200605181925.30967.david-b@pacbell.net>
References: <1147024930.16057.3.camel@localhost.localdomain>
	<200605181256.35174.david-b@pacbell.net>
	<20060518205013.GB2571@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============46301101333083405=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060518205013.GB2571@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: richard@hughsie.com, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============46301101333083405==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 18 May 2006 1:50 pm, Pavel Machek wrote:

> Well, will it ever go to sleep? In such case? There are many things
> that wake up periodically.

Applications that constantly wake/poll are death to power management anyway,
that's not news ... most of the "work" done by polling is wasted.  When they
get switched to no-timeout/blocking APIs, then they can sleep painlessly
until a relevant wakeup event triggers.

Things that really *must* wake up periodically should be using some API that
interacts with RTC alarms, and those RTC alarms should be acting as system
wakeup events.


There's also non-automated sleep too ... what "apmsleep" used to do when
you told it to suspend until 7am (or for two hours, etc).  The same thing
can be done with /sys/power/state and a wakeup-enabled RTC.


> > As for downloading, that's why ethernet adapters have wake-on-lan (WOL)
> > mechanisms.  Likewise for other wakeup-capable devices, like a keyboard
> > or mouse.  Or even 3D engines, DSPs, SPUs, ...
> 
> ?? WOL is for different functionality, I'm afraid. Or do you know
> ethernet hub that automagically wakes machines when data come?

No, that's exactly what WOL is designed for.  A typical scenarios has
the adapter waking up when the incoming packet is unicast to the MAC
address of that host.  The hub/switch would act normally.

- Dave

--===============46301101333083405==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============46301101333083405==--
