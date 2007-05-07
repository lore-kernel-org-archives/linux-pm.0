From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...)
Date: Tue, 8 May 2007 00:16:08 +0200
Message-ID: <200705080016.09735.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705051149360.1976-100000@netrider.rowland.org>
	<200705072300.03299.rjw@sisk.pl>
	<200705071445.40547.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705071445.40547.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 7 May 2007 23:45, David Brownell wrote:
> On Monday 07 May 2007, Rafael J. Wysocki wrote:
> > On Monday, 7 May 2007 03:16, David Brownell wrote:
> 
> > > So for now I have drivers/acpi/sleep/main.c exporting
> > > 
> > >         s_state = acpi_get_target_sleep_state();
> > > 
> > > so that ACPI-aware code can know to call "_S3D" instead of
> > > the "_S1D" or "_S4D" methods (and "_S3W" etc).  Of course
> > > the $SUBJECT patch will finish borking that for S4.  :(
> > 
> > Why exactly?
> 
> Because it adds new code paths ... currently pm_ops methods
> record the target state.  Fixable later.

Hmm, I think hibernation_ops do the equivalent of what pm_ops did for
ACPI_STATE_S4 and the target state is still recorded (in
acpi_enter_sleep_state_prep()).  Isn't that correct?
