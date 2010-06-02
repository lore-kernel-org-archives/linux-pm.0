From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [PATCH 0/8]
 Suspend block api (version 8)
Date: Wed, 2 Jun 2010 16:32:44 -0700
Message-ID: <20100602233243.GA27666__11726.2429710992$1275521652$gmane$org@core.coreip.homeip.net>
References: <20100601113309.609349fd@notabene.brown>
	<alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
	<20100601122012.1edeaf48@notabene.brown>
	<alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
	<20100602153235.340a7852@notabene.brown>
	<AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
	<20100602180614.729246ea@notabene.brown>
	<AANLkTimISbs4X2YR_Pal9A80mpkNyCy8laWBcOgR2Cl7@mail.gmail.com>
	<20100602210224.6ae2333f@notabene.brown>
	<20100602210521.54b9cd9b@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100602210521.54b9cd9b@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: Neil Brown <neilb@suse.de>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 02, 2010 at 09:05:21PM +0200, Florian Mickler wrote:
> On Wed, 2 Jun 2010 21:02:24 +1000
> Neil Brown <neilb@suse.de> wrote:
> > 
> > And this decision (to block suspend) really needs to be made in the driver,
> > not in userspace?
> 
> Well, it fits. The requirement is a direct consequence of the intimate
> knowledge the driver has about the driven devices.

That is not really true. A driver does have intimate knowledge of the
device, however it does not necessarily have an idea about the data read
from the device. Consider the gpio_matrix driver: Arve says that it has
to continue scanning matrix once first interrupt arrvies. But it really
depends on what key has been pressed - if user pressed KEY_SUSPEND or
KEY_POWER it cmight be better if we did not wait for key release but
initiated the action right away. The decision on how system reacts to a
key press does not belong to the driver but really to userspace.
 
-- 
Dmitry
