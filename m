From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v4 1/2] Input: enable i8042-level wakeup
	control
Date: Fri, 5 Aug 2011 16:24:07 +0100
Message-ID: <CAMLZHHTnTTbD7mn_QsjwyFZ=XU6paddrtXEVuLYossk9qBGFfw__23667.820581659$1312558005$gmane$org@mail.gmail.com>
References: <20110802154916.624619D401C@zog.reactivated.net>
	<20110803065920.GC23399@core.coreip.homeip.net>
	<CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg@mail.gmail.com>
	<20110803184332.GA17880@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110803184332.GA17880@core.coreip.homeip.net>
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
Cc: linux-pm@lists.linux-foundation.org, dilinger@queued.net, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Dmitry,

On Wed, Aug 3, 2011 at 7:43 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Instead of wiring it all through input core could we contain this in
> atkbd and hgpk by registering pm_notifiers and ignoring certain requests
> from input/serio cores during system state transition on OLPC only?

I've started looking at this, but my first problem is that when the
input layer asks atkbd to turn off LEDs, atkbd schedules a workqueue
item to undertake this work. However, as there is no synchronization,
this work only seems to get executed during or after system resume.
This makes it hard to catch with such a scheme. Any ideas?

Daniel
