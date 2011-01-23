From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to
	iomaps management
Date: Sun, 23 Jan 2011 21:28:02 +0100
Message-ID: <201101232128.03007.rjw__14210.982892155$1295814591$gmane$org@sisk.pl>
References: <201101201226.41021.rjw@sisk.pl> <201101222012.14028.rjw@sisk.pl>
	<AANLkTikstr=vY=1S7A4Pudg3u=k4eJ7HRz6tWwAq4N-v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikstr=vY=1S7A4Pudg3u=k4eJ7HRz6tWwAq4N-v@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, January 23, 2011, Jeff Chua wrote:
> On Sun, Jan 23, 2011 at 3:12 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday, January 22, 2011, Jeff Chua wrote:
> >> 2011/1/22 Rafael J. Wysocki <rjw@sisk.pl>:
> >> > On Saturday, January 22, 2011, Jeff Chua wrote:
> >>
> >> > means that my patch [11/11] _and_ the replacement are totally wrong, because you have
> >> > _multiple_ NVS regions.  That really helped, thanks a lot.
> >>
> >> Would it be different if I offline all CPUs before suspending to ram?
> >> It seems to help with suspending to disk.
> >
> > No, that doesn't matter.  NVS regions are just sitting there regardless of
> > what happens at run time.
> 
> Strange. If I didn't offline, it hanged during suspend even without
> thinkpad_acpi. I could see that the suspend code does the offline
> automatically, but executing the offline before calling suspend makes
> it no hanging.

That means there's a problem in the CPU hotplug code that manifests itslef
during suspend.  Is this 100% reproducible?  Did it happen with 2.6.37?

Rafael
