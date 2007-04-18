From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Wed, 18 Apr 2007 13:27:39 +0200
Message-ID: <20070418112739.GA2011@elf.ucw.cz>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176830290.6225.9.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1176830290.6225.9.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.osdl.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> For powermac, we need to do some things between suspending devices and
> device_power_off, for example setting the decrementer. This patch
> allows architectures to define arch_s2ram_{en,dis}able_irqs in their
> asm/suspend.h to have control over this step.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

Looks ok to me.



								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
