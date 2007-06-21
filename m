From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFD] How to tell ACPI drivers what the target sleep
	state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 07:48:47 -0700
Message-ID: <200706210748.48781.david-b__43403.5845603377$1182440268$gmane$org@pacbell.net>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com>
	<200706210004.03544.david-b@pacbell.net>
	<200706211442.41140.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706211442.41140.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 21 June 2007, Rafael J. Wysocki wrote:
> The issue at hand is that some device drivers may need to know what the
> target sleep state of the system will be when their .suspend() routines=
 are
> being executed. =A0Currently, there's no means of passing that informat=
ion to the
> drivers and my question is how to do this.

Actually what they need to know is some *attribute* of that state.

They really don't care what the state is.  The $SUBJECT patch isn't
driver code ... it's for platform hooks that expose attributes to
the drivers.  Specifically, it's ACPI code, talking to drivers that
must run on non-ACPI systems.  Any driver that thinks it needs to
understand anything about ACPI states is sadly broken.

Remember also that the Linux "states" (in /sys/power/state) are an
inadequate representation of what most hardware can do.  Common
hardware can support a lot more low power sleep modes than the two
states Linux currently defines ... a limitation inherited from
first APM, and them more recently ACPI, which doesn't fit embedded
systems well at all.

- Dave
