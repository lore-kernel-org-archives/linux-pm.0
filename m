From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform
	to	specify exact irq flags
Date: Mon, 30 Nov 2009 01:14:20 -0800
Message-ID: <20091130091420.GE10295__16577.3408757106$1259572630$gmane$org@core.coreip.homeip.net>
References: <Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org>
	<87hbsd2b17.fsf@tac.ki.iif.hu>
	<20091130082737.GA27979@gw.healthdatacare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091130082737.GA27979@gw.healthdatacare.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: linux-pm@lists.linux-foundation.org, Ferenc Wagner <wferi@niif.hu>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 30, 2009 at 10:27:37AM +0200, Mika Westerberg wrote:
> 
> BTW: maybe this sharing the IRQ line between multiple buttons could be
> implemented with threaded irq handler? Then it can go to sleep if, for
> some reason, gpio_get_value() sleeps. Unfortunately I don't have such
> hardware so I can't test it.
> 

We still need debounce support there so you still need a timer and a
workqueue. In the current form theraded IRQ will not buy us anything.

-- 
Dmitry
