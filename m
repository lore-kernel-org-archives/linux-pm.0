From: Len Brown <lenb@kernel.org>
Subject: Re: [RFD] How to tell ACPI drivers what the target sleep
	state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Wed, 20 Jun 2007 21:51:14 -0400
Message-ID: <200706202151.15056.lenb__12556.3253103339$1182390727$gmane$org@kernel.org>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com>
	<1182320280.30540.4.camel@sli10-conroe.sh.intel.com>
	<200706201332.25486.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706201332.25486.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, dbrownell@users.sourceforge.net, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 20 June 2007 07:32, Rafael J. Wysocki wrote:
> On Wednesday, 20 June 2007 08:18, Shaohua Li wrote:
> > On Tue, 2007-06-19 at 13:52 +0200, Rafael J. Wysocki wrote:
> > > On Tuesday, 19 June 2007 04:33, Shaohua Li wrote:
> > > > Based on David's patch
> > > > http://marc.info/?l=linux-acpi&m=117873972806360&w=2
> > > > I slightly changed it.
> > > > 
> > > > Add a helper routine, which gets the sleep state of a ACPI device.
> > > 
> > > Is it going to work with the recent code ordering changes?  I mean,
> > > acpi_pm_prepare() is now called after device_suspend() (and analogously for
> > > the hibernation), so the target ACPI state is not known when the drivers'
> > > .suspend() routines are being called.
> > Not. Could pm_message_t have a member indicating the suspend state?
> 
> Well, I thought about that, but I did't know what people on linux-pm would
> think about that.
> 
> Alternatively, we could introduce a pm_target() global PM operation that will
> set the target sleep state for the entire system.
> 
> I think we should discuss that on linux-pm before any decision is made.

okay, this thread include linux-pm....

I support the proposal that pm_message_t include the target state
in addition to the phase of entering that state.
The reasoning is simple, device drivers that receive a pm_message_t
will do different things depending on the target state.
The example at hand is ACPI devices that need to know how deep a D-state
to go into based on the S-state, and this in-turn depends on if they
are enabled as wakeup devices or not.

thanks,
-Len
