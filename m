From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] Introduce CONFIG_SUSPEND
Date: Mon, 30 Jul 2007 00:22:53 +0200
Message-ID: <200707300022.54633.rjw__23135.8771947727$1185747391$gmane$org@sisk.pl>
References: <200707251238.50218.lenb@kernel.org>
	<200707292336.55588.rjw@sisk.pl> <1185744640.2295.4.camel@work>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1185744640.2295.4.camel@work>
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
To: Richard Hughes <hughsient@gmail.com>
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 29 July 2007 23:30, Richard Hughes wrote:
> On Sun, 2007-07-29 at 23:36 +0200, Rafael J. Wysocki wrote:
> > On Sunday, 29 July 2007 23:18, Adrian Bunk wrote:
> > > On Sun, Jul 29, 2007 at 11:17:20PM +0200, Rafael J. Wysocki wrote:
> > > > On Sunday, 29 July 2007 22:40, Adrian Bunk wrote:
> > > > > On Sun, Jul 29, 2007 at 02:38:05PM +0200, Rafael J. Wysocki wrote:
> > > > > >...
> > > > > > +config SUSPEND
> > > > > > +	bool "Suspend"
> > > > >              "Suspend to RAM"
> > > > 
> > > > Not only.  This also includes "standby".
> > > 
> > > Whatever it includes - please tell it to the user in the prompt.
> > > 
> > > Technical issues are important, but it's often forgotten how many 
> > > problems people run into because the description of a kconfig option 
> > > could have been better.
> > 
> > Sure.  Please see the updated patch I've just sent. :-)
> 
> So are you guys using:
> 
> "standby" = idle state, ~0.5 seconds
> "suspend" = sleep to ram, ~10 seconds
> "hibernate" = sleep to disk, ~30 seconds

Something like this, but "suspend" is not reserved as a name of specific state.

The second state is usually referred to as "suspend to RAM" or "STR" and is
denoted by "mem" in /sys/power/state, if implemented.  Moreover, "standby" and
"mem" are both entered using the same code path, so they may generally be
referred to as "suspend" states.

The times aren't strictly defined for "mem" and "standby", too.  The general
rule is that the times for "mem" are greater then for "standby" and the power
drawn in "mem" is smaller than the power drawn in "standby", but the exact
values will always depend on the platform.  Apart from this, if the platform
supports only one "suspend" state, it decides if that's "mem" or "standby".

On ACPI systems "standby" and "mem" correspond to the S1 and S3 sleep states,
respectively.

Greetings,
Rafael
 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
