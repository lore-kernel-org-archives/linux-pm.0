From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] PM: fast power off - core
Date: Sun, 28 Jan 2007 20:12:41 +0100
Message-ID: <20070128191241.GA13596@elf.ucw.cz>
References: <45BBA9D5.8020004@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45BBA9D5.8020004@mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: akuster <akuster@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel-owner@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Fastpoweroff  allows a user to power down the system without using rc kill
> scripts. This is used in the advent of a battery operated device about to=
 lose
> power.  The user interface is vis sysfs /sys/power/fastpoweroff. A simple=
 cat of
> the fastpoweroff will list any registered profiles.  To invoke
> the profile sequence, echo {profile name} > /sys/power/fastpoweroff.

No, we do not want "poweroff profiles" in kernel. Sorry.

rc kill scripts should be fast enough, if not, fix them. If it is
impossible (time is spent in kernel waiting for network card to shut
off), fix that.

What you want is pretty much "echo b > ..../sysrq; halt --now".

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
