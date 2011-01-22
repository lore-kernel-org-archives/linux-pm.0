From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to
	iomaps management
Date: Sat, 22 Jan 2011 10:25:49 +0100
Message-ID: <201101221025.49327.rjw__47585.3094518699$1295688425$gmane$org@sisk.pl>
References: <201101201226.41021.rjw@sisk.pl>
	<AANLkTimEoAhO9TRx4Aq7NnTTt6G-u+cHJRyAMjSAJgTm@mail.gmail.com>
	<AANLkTin3d4LdnqDYtrTK=KdmjADA2MsaWYoLG19FxOzG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTin3d4LdnqDYtrTK=KdmjADA2MsaWYoLG19FxOzG@mail.gmail.com>
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

On Saturday, January 22, 2011, Jeff Chua wrote:
> On Sat, Jan 22, 2011 at 1:54 PM, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
> > 2011/1/22 Rafael J. Wysocki <rjw@sisk.pl>:
> >> On Friday, January 21, 2011, Jeff Chua wrote:
> >>> 2011/1/21 Rafael J. Wysocki <rjw@sisk.pl>:
> >>> > Thanks, but unfortunately this wasn't conclusive.  Please apply the patch below
> >>> > instead of the previous one (on top of [1/11] - [11/11]) and collect dmesg
> >> So, below is a replacement for [11/11].  Please test it on top of
> >> [1/11] - [10/11] (the current Linus' tree already contains [1/11] and [2/11])
> >> and let me know if it works for you (in either case, please attach dmesg
> >> output containing a suspend attempt).
> >>
> >> If it works, I'll remove the diagnostic messages and submit along with the
> >> rest of the patchset.
> >
> > Rafael,
> >
> > dmesg attached. This time, it worked!
> >
> > I discovered CONFIG_THINKPAD_ACPI caused suspend-to-disk to hang. I
> > need the Thinkpad ACPI to control the fan and bluetooth. It looks like
> > the thinkpad acpi is trying acquire locks while suspending.  Disabling
> > cmos, light, led and hotkeys makes suspend-to-disk works again.
> 
> Here's the dmesg.

Thanks!

Well, and this:

Brought up 4 CPUs
2011-01-22T11:32:56.424328+08:00 boston kernel: Total of 4 processors activated (17023.83 BogoMIPS).
2011-01-22T11:32:56.424329+08:00 boston kernel: PM: Registering ACPI NVS region at bb371000 (528384 bytes)
2011-01-22T11:32:56.424332+08:00 boston kernel: PM: Registering ACPI NVS region at bb668000 (524288 bytes)
2011-01-22T11:32:56.424334+08:00 boston kernel: PM: Registering ACPI NVS region at bb76b000 (49152 bytes)
2011-01-22T11:32:56.424335+08:00 boston kernel: PM: Registering ACPI NVS region at bb77a000 (28672 bytes)
2011-01-22T11:32:56.424337+08:00 boston kernel: PM: Registering ACPI NVS region at bb782000 (36864 bytes)
2011-01-22T11:32:56.424338+08:00 boston kernel: PM: Registering ACPI NVS region at bb78c000 (77824 bytes)
2011-01-22T11:32:56.424339+08:00 boston kernel: NET: Registered protocol family 16

means that my patch [11/11] _and_ the replacement are totally wrong, because you have
_multiple_ NVS regions.  That really helped, thanks a lot.

Rafael
