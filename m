From: Pavel Machek <pavel@ucw.cz>
Subject: suspending machine from kernel (was Re: [RFC] why do
	we	need run disk sync before entering S3)
Date: Fri, 15 May 2009 11:08:44 +0200
Message-ID: <20090515090843.GC32740__34817.1845580966$1242378697$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org>
	<200905131616.27334.rjw@sisk.pl> <20090514094249.GG6417@elf.ucw.cz>
	<20090515010055.GB21718@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090515010055.GB21718@khazad-dum.debian.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2009-05-14 22:00:56, Henrique de Moraes Holschuh wrote:
> On Thu, 14 May 2009, Pavel Machek wrote:
> > But remember there are even in-kernel s2ram triggers, for example on
> > zaurus when battery goes critical.
> 
> Are there?  I am quite interested on this!

Yes.

It is a bit of mess, but see

common/sharpsl_pm.c:

   /* Suspend if critical battery level */
        if ((sharpsl_pm.battstat.ac_status != APM_AC_ONLINE)
                        && (sharpsl_pm.battstat.mainbat_status ==
APM_BATTERY_STATUS_CRITICAL)
                        && !(sharpsl_pm.flags & SHARPSL_APM_QUEUED)) {
                sharpsl_pm.flags |= SHARPSL_APM_QUEUED;
                dev_err(sharpsl_pm.dev, "Fatal Off\n");
                apm_queue_event(APM_CRITICAL_SUSPEND);
        }

it eventually triggers regular s2ram paths.

Older versions did suspend on power button press. (You can't really
turn zaurus _off_, AFAICT.)

> Are they safe on x86?

Well, probably safe but definitely would need some cleanup.

> thinkpad-acpi receives some critical alarms from the firmware, for which the
> recommended action by the vendor is to go into S3 immediately.  There is
> also one which requires S4 as the recommended damage control measure.

While s2ram should always work on hardware that supports it (zaurus),
S4 is more tricky. It needs swap to be configured, and userspace
cooperation in uswsusp case.

I guess sending signal to init would be right solution in that
case. (ACPI already does that on overheat.)

								Pavel
(Sorry about breaking Ccs)
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
