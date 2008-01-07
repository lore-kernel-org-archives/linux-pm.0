From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] PM: Acquire device locks on suspend
Date: Mon, 7 Jan 2008 01:49:47 +0100
Message-ID: <200801070149.47958.rjw__43057.8925334432$1199667019$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0801061734150.20032-100000@netrider.rowland.org>
	<49505.::ffff:91.5.86.36.1199663162.squirrel@secure.sipsolutions.net>
	<200801070059.16741.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801070059.16741.rjw@sisk.pl>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 7 of January 2008, Rafael J. Wysocki wrote:
> On Monday, 7 of January 2008, Johannes Berg wrote:
> > Rafael J. Wysocki wrote:
> > 
> > >> I don't see anything wrong with it.  All that will happen is that the
> > >> removal will start before the suspend and finish after the resume.
> > >
> > > In that case, we'll attempt to call the device's .suspend() and .resume()
> > > routines, but we shouldn't do that, IMHO.
> > 
> > I don't see anything wrong with that since the driver must be prepared to
> > handle that even in the regular case, it's the only thing you can
> > guarantee: no more method calls after removal finishes. Am I totally
> > misunderstanding things?
> 
> Well, we are towards the end of device removal at this point, having called
> bus_remove_device(dev) for example, but still we've got it on dpm_active ...
> 
> This may not be technically wrong (ie. we should be able to recover from
> that), but it seems conceptually wrong and with pm_sleep_rwsem in place it
> can be avoided.

No, it can't, without major complications.

Well, I think I'll just send a patch that should work most of the time ...

Rafael
