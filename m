From: Pavel Machek <pavel@ucw.cz>
Subject: Re: cpufreq user<->kernel interface removal [was Re:
	community PM requirements/issues and PowerOP]
Date: Sun, 17 Sep 2006 14:37:59 +0200
Message-ID: <20060917123759.GD2741@elf.ucw.cz>
References: <20060914162623.GA6867@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060914162623.GA6867@linux.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Mark Gross <mgross@linux.intel.com>
Cc: lkml@elf.ucw.cz.kroah.org, Preece Scott-PREECE <scott.preece@motorola.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

hi!

> Power-OP: Matt, Eugeny, Igor, myself to a much lesser extent
> Oppoint: David
> =

> Interested parties to getting operating point concepts into the main
> line kernel are CELF and MLI members.

Thanks.

> > Or, can each of the different projects send a _short_, 1 paragraph, 4
> > sentance maximum summary of the different things.  Think of it as your
> > "elevator pitch".  The different multi-page summaries ware making my
> > eyes glaze over...
> =

> CE and embedded Linux users have not been able to use cpufreq, mostly
> because those platforms don't have ACPI like FW for controlling all
> > the

?? zaurus uses cpufreq just fine, and you could do that on omap. You'd
not have powersavings coming out of powering down devices, but
otherwise it should be doable.

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
