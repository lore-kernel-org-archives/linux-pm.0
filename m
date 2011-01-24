From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to
	iomaps management
Date: Mon, 24 Jan 2011 09:13:30 +0800
Message-ID: <AANLkTi=YwD7kBZ6XsnUpCfqCmTuwwhkcAYvjXJL3Fj8O__42432.619960937$1295831665$gmane$org@mail.gmail.com>
References: <201101201226.41021.rjw@sisk.pl> <201101222012.14028.rjw@sisk.pl>
	<AANLkTikstr=vY=1S7A4Pudg3u=k4eJ7HRz6tWwAq4N-v@mail.gmail.com>
	<201101232128.03007.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101232128.03007.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 24, 2011 at 4:28 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Sunday, January 23, 2011, Jeff Chua wrote:
>> On Sun, Jan 23, 2011 at 3:12 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Saturday, January 22, 2011, Jeff Chua wrote:
>> >> 2011/1/22 Rafael J. Wysocki <rjw@sisk.pl>:
>> >> > On Saturday, January 22, 2011, Jeff Chua wrote:
>> Strange. If I didn't offline, it hanged during suspend even without
>> thinkpad_acpi. I could see that the suspend code does the offline
>> automatically, but executing the offline before calling suspend makes
>> it no hanging.
>
> That means there's a problem in the CPU hotplug code that manifests itslef
> during suspend. =A0Is this 100% reproducible? =A0Did it happen with 2.6.3=
7?

Quite reproducible. Once "something" trigger the hang,  no matter how
I reset the system, it'll still hang at suspend. And at other times,
it just worked. I tried many things, but it seems if I go back to use
an earlier version (2.6.37 works perfectly for suspend-to-disk/mem),
then switched back to the newer broken version, it'll work for a few
cycles before hanging at suspend-to-disk.

I guess it could be CPU hotplug, and may be that thinkpad-acpi is
triggering the broken cpu hotplug to fail.

Jeff
