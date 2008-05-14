From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Thu, 15 May 2008 01:47:23 +0200
Message-ID: <200805150147.24968.rjw__2992.24659470401$1210809032$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803221645190.27399-100000@netrider.rowland.org>
	<200803222229.45673.rjw@sisk.pl>
	<m1k5hwzf2z.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1k5hwzf2z.fsf@frodo.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Len Brown <len.brown@intel.com>, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, 15 of May 2008, Eric W. Biederman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Saturday, 22 of March 2008, Alan Stern wrote:
> 
> > The spec doesn't say much about that, so we'll need to carry out some
> > experiments.
> 
> > Still, as far as I can figure out what the spec authors _might_ mean, I think
> > that it would be inappropriate to restore the ACPI NVS area if S5 was entered
> > on "power off".  The idea seems to be that the restoration of the ACPI NVS area
> > should complement whatever has been preserved by the platform over the
> > hibernation/resume cycle.
> 
> > IMO, if S5 was entered on "powe off", there are two possible ways to go.
> > Either ACPI is initialized by the boot kernel, in which case the image kernel
> > should not touch things like _WAK and similar, just throw away whatever
> > ACPI-related state it got from the image and try to rebuild the ACPI-related
> > data from scratch.  Or the boot kernel doesn't touch ACPI and the image kernel
> > initializes it in the same way as during a fresh boot (that might be difficult,
> > though).
> 
> Just an added data partial point.  In the kexec case I have had not heard
> anyone screaming to me that ACPI doesn't work after we switch kernels.

You don't remove power from devices while doing that.

> So I expect shutting down ACPI and restarting it should work reliably
> and that is easy to test as that is already implemented with kexec.

You can't program devices to generate wakeup events without ACPI, among
other things.

Anyway, I don't think you should focus on replacing the current hibernation
code entirely so much.

Thanks,
Rafael
