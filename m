From: Pavel Machek <pavel@ucw.cz>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 10:20:25 +0200
Message-ID: <20060911082025.GD1898@elf.ucw.cz>
References: <450516E8.9010403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <450516E8.9010403@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>, scott.preece@motorola.com
List-Id: linux-pm@vger.kernel.org

Hi!

On Mon 2006-09-11 11:57:28, Eugeny S. Mints wrote:
> [snip]
> >> Are you arguing that the cpufreq interface be morphed to support power
> >> op applications?
> >
> > No. I'm arguing that
> >
> > * cpufreq interface should be used for changing cpu frequency
> the patch set i sent out has cpufreq used for changing cpu frequency,
> hasn't it?

I was talking about kernel<->user interface.

You did echo low > something to change CPU frequency, IIRC.

> can we eventually start talking more close to the code rather than
> speculating without it?

Lets get kernel<->user interface right, first. You'll need to create
Documentation/ entries for your interfaces, eventually, so lets do
that, first, and then talk about code. Oh and it would be nice to cc
lkml on that document, too. New kernel<->user interface is not
decision taken lightly.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
