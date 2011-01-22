From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to
	iomaps management
Date: Sat, 22 Jan 2011 10:13:09 +0100
Message-ID: <201101221013.10239.rjw__21839.8671983325$1295687702$gmane$org@sisk.pl>
References: <201101201226.41021.rjw@sisk.pl> <201101212206.37469.rjw@sisk.pl>
	<AANLkTimEoAhO9TRx4Aq7NnTTt6G-u+cHJRyAMjSAJgTm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimEoAhO9TRx4Aq7NnTTt6G-u+cHJRyAMjSAJgTm@mail.gmail.com>
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
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, January 22, 2011, Jeff Chua wrote:
> 2011/1/22 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Friday, January 21, 2011, Jeff Chua wrote:
> >> 2011/1/21 Rafael J. Wysocki <rjw@sisk.pl>:
> >> > Thanks, but unfortunately this wasn't conclusive.  Please apply the patch below
> >> > instead of the previous one (on top of [1/11] - [11/11]) and collect dmesg
> > So, below is a replacement for [11/11].  Please test it on top of
> > [1/11] - [10/11] (the current Linus' tree already contains [1/11] and [2/11])
> > and let me know if it works for you (in either case, please attach dmesg
> > output containing a suspend attempt).
> >
> > If it works, I'll remove the diagnostic messages and submit along with the
> > rest of the patchset.
> 
> Rafael,
> 
> dmesg attached. This time, it worked!

Great, thanks a lot!

> I discovered CONFIG_THINKPAD_ACPI caused suspend-to-disk to hang. I
> need the Thinkpad ACPI to control the fan and bluetooth. It looks like
> the thinkpad acpi is trying acquire locks while suspending.  Disabling
> cmos, light, led and hotkeys makes suspend-to-disk works again.

Well, we should tell the thinkpad_acpi maintainer about that, then (CCed).

It also would be good to file a Bugzilla report about that, if poss.

Rafael
