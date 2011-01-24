From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to
	iomaps management
Date: Mon, 24 Jan 2011 22:36:08 +0100
Message-ID: <201101242236.09171.rjw__23555.5933476009$1295905150$gmane$org@sisk.pl>
References: <201101201226.41021.rjw@sisk.pl> <201101232128.03007.rjw@sisk.pl>
	<AANLkTi=YwD7kBZ6XsnUpCfqCmTuwwhkcAYvjXJL3Fj8O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=YwD7kBZ6XsnUpCfqCmTuwwhkcAYvjXJL3Fj8O@mail.gmail.com>
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

On Monday, January 24, 2011, Jeff Chua wrote:
> On Mon, Jan 24, 2011 at 4:28 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Sunday, January 23, 2011, Jeff Chua wrote:
> >> On Sun, Jan 23, 2011 at 3:12 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Saturday, January 22, 2011, Jeff Chua wrote:
> >> >> 2011/1/22 Rafael J. Wysocki <rjw@sisk.pl>:
> >> >> > On Saturday, January 22, 2011, Jeff Chua wrote:
> >> Strange. If I didn't offline, it hanged during suspend even without
> >> thinkpad_acpi. I could see that the suspend code does the offline
> >> automatically, but executing the offline before calling suspend makes
> >> it no hanging.
> >
> > That means there's a problem in the CPU hotplug code that manifests itslef
> > during suspend.  Is this 100% reproducible?  Did it happen with 2.6.37?
> 
> Quite reproducible. Once "something" trigger the hang,  no matter how
> I reset the system, it'll still hang at suspend. And at other times,
> it just worked. I tried many things, but it seems if I go back to use
> an earlier version (2.6.37 works perfectly for suspend-to-disk/mem),
> then switched back to the newer broken version, it'll work for a few
> cycles before hanging at suspend-to-disk.
> 
> I guess it could be CPU hotplug, and may be that thinkpad-acpi is
> triggering the broken cpu hotplug to fail.

So please try with this commit on top:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ec30f343d61391ab23705e50a525da1d55395780

Thanks,
Rafael
