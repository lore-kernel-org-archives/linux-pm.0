From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform
	to	specify exact irq flags
Date: Mon, 30 Nov 2009 11:37:57 +0200
Message-ID: <20091130093757.GB27979__17621.6214233593$1259683219$gmane$org@gw.healthdatacare.com>
References: <Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org>
	<87hbsd2b17.fsf@tac.ki.iif.hu>
	<20091130082737.GA27979@gw.healthdatacare.com>
	<20091130091420.GE10295@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091130091420.GE10295@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Ferenc Wagner <wferi@niif.hu>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 30, 2009 at 01:14:20AM -0800, Dmitry Torokhov wrote:
> On Mon, Nov 30, 2009 at 10:27:37AM +0200, Mika Westerberg wrote:
> > 
> > BTW: maybe this sharing the IRQ line between multiple buttons could be
> > implemented with threaded irq handler? Then it can go to sleep if, for
> > some reason, gpio_get_value() sleeps. Unfortunately I don't have such
> > hardware so I can't test it.
> > 
> 
> We still need debounce support there so you still need a timer and a
> workqueue. In the current form theraded IRQ will not buy us anything.

Yes, but with threaded irq handler it should be possible to find
out which gpio line caused the irq (via gpio_get_value()) so we can
schedule the correct workqueue handler, right?

MW
