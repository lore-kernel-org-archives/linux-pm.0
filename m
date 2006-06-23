From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 09:26:26 -0700
Message-ID: <200606230926.26604.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606221614280.6483@g5.osdl.org>
	<1151019097.4046.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151019097.4046.69.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pm@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday 22 June 2006 4:31 pm, Benjamin Herrenschmidt wrote:
> =


> In fact, most of the problem is resume, not suspend. Most of the time,
> the machine goes to sleep... it just doesn't wakeup. From my experience
> over the years, the main culprit for that have been
> =

>  - USB (anything that bus masters while the memory controller is asleep
> ...
> =

>  - USB (again, sorry David) races and deadlocks etc... though most of
> these have been fixed by now.

No sweat.  ISTR my very first kernel _patch_ was fixing a USB resume
bug (OHCI needed to handle the controller-lost-power case).

Plus, through most of the early 2.6 series I considered USB PM unusable
(without the "rmmod workaround") ... basically because things that worked
in 2.4 were broken by PM core and swsusp changes, and it took time to
sort through all of that along with the higher priority breakage.


Plus, somewhere I produced a list of about eight _orthogonal_ factors
affecting PM on any given x86 platform.  Giving 2^(about eight) different
configurations to test for every PM-related change.  That's painful, and
even I won't make time to test many of those configurations.


>  - cpufreq (this is a design bug with cpufreq with the "core/midlayer"
> trying to get in charge instead of the driers and registering a sysdev
> which is very wrong).

That could stand some elaboration in a separate thread; there are folk
working to enhance cpufreq so that it handles other frequency/voltage
scaling approaches.  I happened to notice that cpufreq isn't even using
the driver model very well, too ...

- Dave
