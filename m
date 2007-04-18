From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [patch 2.6.21-rc5-git 0/3] x86_pc and ACPI
	support	/sys/devices/.../wakeup
Date: Wed, 18 Apr 2007 17:51:06 +0800
Message-ID: <1176889866.5376.34.camel__38219.3850739442$1176889973$gmane$org@localhost.localdomain>
References: <200704051248.40745.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704051248.40745.david-b@pacbell.net>
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
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi, David,

On Thu, 2007-04-05 at 12:48 -0700, David Brownell wrote:
> Following are three patches for basic driver model wakeup flag support on
> PCs.  I think the first two are nearly mergable.  The third previously br=
oke
> powerpc, so it's likely not yet mergeable ... the issue was arch-specific
> differences in PCI initialization, someone else will need to solve them.
> =

> The patches are:
> =

>  - Define a platform_enable_wakeup() PM hook and use it with PCI.  (This
>    might help OLPC with its non-RTC events...)
> =

>  - Make ACPI init and use driver model wakeup flags for the (motherboard)
>    devices in its table ... and implement that new platform hook.  Now
>    /proc/acpi/wakeup is almost purely informative.
> =

Yes.
But /proc/acpi/wakeup is exporting the wrong information then.
I.e. when a physical device is set to may_wakeup, the corresponding GPE
will be enabled before entering a system sleep state.
But we always get status of the ACPI device is disabled
via /proc/acpi/wakeup, even if they could be enabled in
acpi_platform_enable_wakeup when suspending.

Thanks,
Rui
