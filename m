From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Tue, 10 Apr 2007 14:00:28 +0200
Message-ID: <20070410120028.GI8239@elf.ucw.cz>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704060217.50560.rjw@sisk.pl>
	<1175849322.3489.64.camel@johannes.berg>
	<200704061141.31677.rjw@sisk.pl>
	<1175852652.3489.67.camel@johannes.berg>
	<20070406191903.GD2583@elf.ucw.cz>
	<1175896767.8459.6.camel@johannes.berg>
	<20070410113623.GF8239@elf.ucw.cz>
	<1176205508.8459.89.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1176205508.8459.89.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Hmm, and can't you simply create sysdev for decrementer and special
> > platform handling? sysdevs should be suspended last...
> =

> In theory, yes.
> =

> In practise, however, it seems to be impossible to get a sysdev into the
> queue that is suspended before any other sysdevs are suspended (i.e.
> right after interrupts are disabled)
> =

> And then there are the platform functions. In theory, they could be done
> with a regular struct device, but in practice they need to be the very
> last thing before interrupts are disabled, and that again is impossible
> to achieve.

Is it feasible to improve sysdev handling to allow this?

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
