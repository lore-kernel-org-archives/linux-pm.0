From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFD] How to tell ACPI drivers what the target sleep
	state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Wed, 20 Jun 2007 13:32:24 +0200
Message-ID: <200706201332.25486.rjw__14695.5722746954$1182338797$gmane$org@sisk.pl>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com>
	<200706191352.16913.rjw@sisk.pl>
	<1182320280.30540.4.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1182320280.30540.4.camel@sli10-conroe.sh.intel.com>
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
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, dbrownell@users.sourceforge.net, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 20 June 2007 08:18, Shaohua Li wrote:
> On Tue, 2007-06-19 at 13:52 +0200, Rafael J. Wysocki wrote:
> > On Tuesday, 19 June 2007 04:33, Shaohua Li wrote:
> > > Based on David's patch
> > > http://marc.info/?l=linux-acpi&m=117873972806360&w=2
> > > I slightly changed it.
> > > 
> > > Add a helper routine, which gets the sleep state of a ACPI device.
> > 
> > Is it going to work with the recent code ordering changes?  I mean,
> > acpi_pm_prepare() is now called after device_suspend() (and analogously for
> > the hibernation), so the target ACPI state is not known when the drivers'
> > .suspend() routines are being called.
> Not. Could pm_message_t have a member indicating the suspend state?

Well, I thought about that, but I did't know what people on linux-pm would
think about that.

Alternatively, we could introduce a pm_target() global PM operation that will
set the target sleep state for the entire system.

I think we should discuss that on linux-pm before any decision is made.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
