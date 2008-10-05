From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: uevent before resume completion
Date: Mon, 06 Oct 2008 09:06:31 +1100
Message-ID: <1223244391.28392.4.camel@nigel-laptop>
References: <20080922141959.GA7976@jeknote.loshitsa1.net>
	<20081005094947.GA2351@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081005094947.GA2351@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, Yauhen Kharuzhy <jekhor@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi.

On Sun, 2008-10-05 at 11:49 +0200, Pavel Machek wrote:
> On Mon 2008-09-22 17:19:59, Yauhen Kharuzhy wrote:
> > Hi.
> > 
> > We have an ARM board which does wakeup on USB cable connection to
> > it. In our power supply driver "USB connect" interrupt handler calls
> > power_supply_changed() which cause generation of uevent (in
> > power_supply_changed_work() ). But usermodehelper_disabled
> > still equals to 1 because resume process is not finished yet and
> > userspace helper is not executed.
> > 
> > How to fix this behaviour without breaking other kernel parts? We
> > definitely need to invoke userspace helper on USB cable insertion. Yes,
> > we can generate event after some time with timer but I think that a more
> > elegant solution can be found.
> 
> If you do it such that your 'delayed uevent' code can be reused by
> other subsystems, it should not be too bad...

One option would be to use the pm_notifier call chain, but it sounds to
me like a better solution would be for someone to modify the
kernel/kmod.c to handle delaying tasks until post hibernate/suspend if
they're UMH_NO_WAIT (Yauhen, is your call blocking?)

Regards,

Nigel
