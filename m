From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ACPI code in platform mode hibernation code paths
	(was: Re: [PATCH] swsusp: do not use pm_ops)
Date: Fri, 4 May 2007 14:29:07 +0200
Message-ID: <200705041429.08604.rjw__12168.3128680617$1178281527$gmane$org@sisk.pl>
References: <20070425072350.GA6866@ucw.cz>
	<1178276072.7408.7.camel@johannes.berg>
	<20070504120802.GF13426@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070504120802.GF13426@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Friday, 4 May 2007 14:08, Pavel Machek wrote:
> Hi!
> 
> > > Crazy idea... could we kill hibernate_ops-like struct, and just create
> > > a device for ACPI, using its suspend()/resume()/whatever callbacks to
> > > do the ACPI magic?
> > 
> > Doesn't that have the ordering problem again? You must ensure that this
> > sysdev is suspended as the last one, and that's currently impossible if
> > ACPI is modular.
> 
> I do not think acpi has these kinds of ordering requirements... (And I
> do not see what it has to do with module or not).

Theoretically, ACPI has some ordering requirements.  For example, according to
the spec, the _PTS system-control method should be executed *after* devices are
placed in the appropriate Dx states, which (theoretically) requires us to
execute it after device_suspend() (we don't do this in practice, but I think we
should).

There are some more ordering assumptions like this in the spec and I think
we should at least try to follow them or, if that breaks things, document why
we don't.

That's why I think we should try to do what's needed using hibernation_ops 
(perhaps we'll need to add a couple of callbacks to hibernation_ops) and
then try to replace hibernation_ops with another mechanism allowing us to do
the same.  We first need to determine which operations have to be carried out
at what points so that things don't break.

Greetings,
Rafael
