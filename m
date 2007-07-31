From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH 2/2] Introduce CONFIG_SUSPEND (updated)
Date: Tue, 31 Jul 2007 12:01:07 +0200
Message-ID: <200707311201.09384.rjw__14183.7606359788$1185875825$gmane$org@sisk.pl>
References: <200707251238.50218.lenb@kernel.org>
	<200707311115.29057.rjw@sisk.pl>
	<200707311116.39857.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707311116.39857.oliver@neukum.org>
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
To: Oliver Neukum <oliver@neukum.org>
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 31 July 2007 11:16, Oliver Neukum wrote:
> Am Dienstag 31 Juli 2007 schrieb Rafael J. Wysocki:
> 
> > Well, the people on linux-pm seem to agree that the .suspend() and .resume()
> > callbacks are not suitable for runtime power management, so having them
> > built without SUSPEND or HIBERNATION wouldn't be very useful. ;-)
> 
> These are what USB runtime power management uses.

To be precise, I think the rule should be that if some code is needed for
anything else than suspend/hibernation, it should be under plain CONFIG_PM.
Still, if something is only needed for suspend/hibernation, it should go under
CONFIG_PM_SLEEP or CONFIG_SUSPEND/HIBERNATION, depending on what it's needed
for.

Now, AFAICS, for the majority of drivers .suspend() and .resume() are only
needed for suspend/hibernation and really should be used for suspending
only (some other callbacks are needed for hibernation).

> How many code paths for power management do you want to introduce?

At least one more, for hibernation.

That also depends on what approach to the runtime power management is widely
accepted.  For now, USB is in the vanguard. :-)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
