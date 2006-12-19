From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] PM: Change ordering of suspend and
	resume code
Date: Wed, 20 Dec 2006 00:30:02 +0100
Message-ID: <20061219233002.GA2694@elf.ucw.cz>
References: <200612171858.16380.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200612171858.16380.rjw@sisk.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.osdl.org>, Stephen Hemminger <shemminger@osdl.org>, Stefan Seyfried <seife@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi!

> As indicated in a recent thread on Linux-PM, it's necessary to call
> pm_ops->finish() before devce_resume(), but enable_nonboot_cpus() has to =
be
> called before pm_ops->finish()
> (cf. http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.html).
> For consistency, it seems reasonable to call disable_nonboot_cpus() after
> device_suspend().
> =

> This way the suspend code will remain symmetrical with respect to the res=
ume
> code and it may allow us to speed up things in the future by suspending a=
nd
> resuming devices and/or saving the suspend image in many threads.
...
> The following series of patches reorders the suspend and resume code so t=
hat
> nonboot CPUs are disabled after devices have been suspended and enabled b=
efore
> the devices are resumed. =A0It also causes pm_ops->finish() to be called =
after
> enable_nonboot_cpus() wherever necessary.

Series looks okay to me... but it will need _long_ testing in
-mm. (Consider this ACK).

> The first patch changes the ordering of the suspend-to-RAM code and is
> untested, because my boxes continue refusing to resume from RAM for other
> reasons.  If anyone can, please do me a favour and test it.

I did a bit of testing, and it seems to still work, both s2ram and
swsusp. (uswsusp untested).
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
