From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v4 1/2] Input: enable i8042-level wakeup
	control
Date: Wed, 3 Aug 2011 20:51:07 +0100
Message-ID: <CAMLZHHQNMTgx6NyWsE5zkc95L-i78DYd=KqxJcx1pDaVcLxZQQ__17287.1330207728$1312401204$gmane$org@mail.gmail.com>
References: <20110802154916.624619D401C@zog.reactivated.net>
	<20110803065920.GC23399@core.coreip.homeip.net>
	<CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg@mail.gmail.com>
	<20110803184332.GA17880@core.coreip.homeip.net>
	<CAMLZHHQAjarobktUFiZF7aEVvLuaaAFSBuzrMj4pT_67BFssjA@mail.gmail.com>
	<20110803193814.GA17944@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110803193814.GA17944@core.coreip.homeip.net>
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

On Wed, Aug 3, 2011 at 8:38 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> I believe we can and do mark devices such as USB as wakeup capable on
> other arches, you do not have control here. That is why I am uneasy with
> doing this in input core.

That's possible, but do note that the latest iteration of the patch
only looks at the wakeup capability of the struct input_device. It is
unlikely that another part of the kernel marks it as wakeup-capable
without taking these considerations into account.

It is more likely that, in the USB case, the wakeup field of the
struct usb_device is marked wakeup capable. With Alan's ACPI case
earlier in the discussion, this was true: we found that only the ACPI
device gets marked as wakeup-capable/wakeup-enabled, and not the input
device or even the i8042/serio devices, even though it is implementing
(some form of) keyboard wakeup.

Anyway, I'll look at implementing it according to how you suggested,
which wouldn't involve such wide-reaching changes.

> Is there any keys that are not autorepeating. For example regular
> (non-OLPC) laptops usually do not repeat suspend and other special keys.
> In fact, they quite often forget to send release events for them ;)

I just tested, and all of our keys autorepeat in that fashion. Even
the odd keys like "rotate" and "change language". I guess that makes
us irregular ;)

Daniel
