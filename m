From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PowerOp Design and working patch
Date: Mon, 7 Aug 2006 22:06:42 +0000
Message-ID: <20060807220642.GC4540@ucw.cz>
References: <242d827d33807b6b46608a26ed29c273@mvista.com>
	<20060728233837.GG2140@kroah.com>
	<c6333353f00bb7fd435ef518dc8cee21@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <c6333353f00bb7fd435ef518dc8cee21@mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: david singleton <dsingleton@mvista.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> >singleton wrote:
> >>Here is a patch that implements a version of the =

> >>PowerOp concept.
> >
> >Any chance of breaking this up into logical patches =

> >that do one thing at
> >a time so it can be reviewed better?

> Here's powerop-core.patch,  powerop-cpufreq.patch and =

> powerop-x86-centrino.patch.

You failed to inline your patches, so I can't comment properly.
Anyway, having talkative description strings 'suspend-to-disk ACPI' is
ugly for kernel, and you got them wrong.

I'm not sure if I read your patch right, but having suspend-to-disk
latency measured in *micro*seconds seems 'interesting' to me. And what
is the frequency of machine suspended to disk?

Yes, making it easier to add states to /sys/power/state would be
nice...

						Pavel
