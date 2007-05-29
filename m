From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [3/4] 2.6.22-rc3: known regressions
Date: Tue, 29 May 2007 14:52:58 +0200
Message-ID: <465C222A.8060003__1537.39622696794$1180443249$gmane$org@googlemail.com>
References: <465C188F.9000900@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <465C188F.9000900@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Marcus Better <marcus@better.se>, linux1394-devel@lists.sourceforge.net, Stefan Richter <stefanr@s5r6.in-berlin.de>, =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@bitplanet.net>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pekka Enberg <penberg@cs.helsinki.fi>, Tero Roponen <teanropo@jyu.fi>, linux-usb-devel@lists.sourceforge.net, "art@usfltd.com" <art@usfltd.com>, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi all,

Here is a list of some known regressions in 2.6.22-rc3.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



Suspend

Subject    : 2.6.22-rc1 suspend to RAM problem
References : http://permalink.gmane.org/gmane.linux.power-management.gene=
ral/5819
Submitter  : Marcus Better <marcus@better.se>
Handled-By : Stefan Richter <stefanr@s5r6.in-berlin.de>
             Kristian H=C3=B8gsberg <krh@bitplanet.net>
Status     : caused by fw-ohci module



Timers

Subject    : hrtimer overflow bug on 64-bit systems
References : http://lkml.org/lkml/2007/5/24/391
Submitter  : David Miller <davem@davemloft.net>
Status     : problem is being debugged



TTY

Subject    : tty-related oops in latest kernel(s)
References : http://lkml.org/lkml/2007/5/27/104
Submitter  : Tero Roponen <teanropo@jyu.fi>
Status     : problem is being debugged



USB

Subject    : usb hotplug/udev cannot correctly register usb/scanners
References : http://lkml.org/lkml/2007/5/15/205
Submitter  : art@usfltd.com <art@usfltd.com>
Status     : Unknown



Regards,
Michal

--
"Najbardziej brakowa=C5=82o mi twojego milczenia."
-- Andrzej Sapkowski "Co=C5=9B wi=C4=99cej"
