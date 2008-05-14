From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 14 May 2008 15:38:28 -0700
Message-ID: <m1k5hwzf2z.fsf__48728.5304152921$1210804986$gmane$org@frodo.ebiederm.org>
References: <Pine.LNX.4.44L0.0803221645190.27399-100000@netrider.rowland.org>
	<200803222229.45673.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803222229.45673.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 22 Mar 2008 22:29:44 +0100")
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
Cc: Len Brown <len.brown@intel.com>, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Saturday, 22 of March 2008, Alan Stern wrote:

> The spec doesn't say much about that, so we'll need to carry out some
> experiments.

> Still, as far as I can figure out what the spec authors _might_ mean, I think
> that it would be inappropriate to restore the ACPI NVS area if S5 was entered
> on "power off".  The idea seems to be that the restoration of the ACPI NVS area
> should complement whatever has been preserved by the platform over the
> hibernation/resume cycle.

> IMO, if S5 was entered on "powe off", there are two possible ways to go.
> Either ACPI is initialized by the boot kernel, in which case the image kernel
> should not touch things like _WAK and similar, just throw away whatever
> ACPI-related state it got from the image and try to rebuild the ACPI-related
> data from scratch.  Or the boot kernel doesn't touch ACPI and the image kernel
> initializes it in the same way as during a fresh boot (that might be difficult,
> though).

Just an added data partial point.  In the kexec case I have had not heard
anyone screaming to me that ACPI doesn't work after we switch kernels.

So I expect shutting down ACPI and restarting it should work reliably
and that is easy to test as that is already implemented with kexec.

Eric
