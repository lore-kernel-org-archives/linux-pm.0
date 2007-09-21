From: "huang ying" <huang.ying.caritas@gmail.com>
Subject: Re: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Fri, 21 Sep 2007 23:02:01 +0800
Message-ID: <851fc09e0709210802o3be2789s8e93410fa07f7066__32920.663644518$1190386986$gmane$org@mail.gmail.com>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211409.25008.rjw@sisk.pl>
	<851fc09e0709210614q33cf3c81u1441fda17a66a6fd@mail.gmail.com>
	<200709211631.19130.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709211631.19130.rjw@sisk.pl>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On 9/21/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, 21 September 2007 15:14, huang ying wrote:
> > On 9/21/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > On Friday, 21 September 2007 05:33, Eric W. Biederman wrote:
> > > > Nigel Cunningham <nigel@nigel.suspend2.net> writes:
> [--snip--]
> > > >
> > > > No one has yet attacked the hard problem of coming up with separate
> > > > hibernate methods for drivers.
> > >
> > > Well, I've been playing a bit with that for some time, but it's not easy by any
> > > means.
> > >
> > > In short, I'm seeing some problems related to the handling of ACPI that seem to
> > > shatter the entire idea of having separate hibernate methods, at least as far
> > > as ACPI systems are concerned.
> >
> > So sadly to hear this. Can you details it a little? Or a link?
>
> Well, the problem is that apparently some systems (eg. my HP nx6325) expect us
> to execute the _PTS ACPI global control method before creating the image _and_
> to execute acpi_enter_sleep_state(ACPI_STATE_S4) in order to finally put the
> system into the sleep state.  In particular, on nx6325, if we don't do that,
> then after the restore the status of the AC power will not be reported
> correctly (and if you replace the battery while in the sleep state, the
> battery status will not be updated correctly after the restore).  Similar
> issues have been reported for other machines.
>
> Now, the ACPI specification requires us to put devices into low power states
> before executing _PTS and that's exactly what we're doing before a suspend to
> RAM.  Thus, it seems that in general we need to do the same for hibernation on
> ACPI systems.

Then, is it possible to separate device quiesce from device suspend.
Perhaps not for swsusp, but for kexec based hibernation?

Best Regards,
Huang Ying
