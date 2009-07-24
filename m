From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Generic events for wake up from S1-S4
Date: Fri, 24 Jul 2009 10:39:03 -0300
Message-ID: <20090724133903.GA18827__41561.5595681176$1248442914$gmane$org@khazad-dum.debian.net>
References: <43e72e890907150851m69cd2de6lfb71596fbfac30e6@mail.gmail.com>
	<20090723195114.GR28158@elf.ucw.cz>
	<20090723201050.GD19369@khazad-dum.debian.net>
	<200907232328.03566.rjw@sisk.pl>
	<1248396826.3556.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1248396826.3556.26.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "Luis R. Rodriguez" <mcgrof@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jouni Malinen <j@w1.fi>, linux-wireless <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "John W. Linville" <linville@tuxdriver.com>, Stephen Chen <Stephen.Chen@atheros.com>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 24 Jul 2009, ykzhao wrote:
> > > Well, we *already* deliver "lid opened" when the lid is opened, regardless
> > > of it waking up the computer or not.  But we are missing a way to deliver
> > > other classes of wakeup events.
> > > 
> > > I know of at least these (incomplete list):
> > > 
> > > 1. network-initiated wakeup
> > >    a. wired
> > >    b. wireless
> > >    c. long-range wireless
> > > 
> > > 2. platform health/condition alarms
> > >    a. battery alarm (two levels, warning and emergency)
> > >    b. thermal alarm (two levels, warning and emergency)
> > >    (we need these as generic alarms, not just reason-for-wakeup)
> > > 
> > > 3. device (or device tree) hotplug/hotunplug
> > >    a. hotunplug request or notification
> > >       (we deliver the request/notification, but we don't know we should
> > >       go back to sleep, so all we are missing is the reason-for-wakeup
> > >       event)
> > > 
> > > 4. management
> > >    a. wake-up/power on clock
> > >    b. remote management command (IMPI, etc)
> > >    c. intrusion alarm
> > >    d. theft alarm
> > > 
> > > None of those have a standard interface to notify userspace of the reason of
> > > the wake up AFAIK.  Many of these want a generic event interface to be
> > > delivered not just as reason-for-wakeup, but also as runtime events.
> > > 
> > > And I guess we should also tell userspace what state we are waking up from
> > > (S5 clean state, S5/S4 hibernation, S3), sometimes it matters.
> > 
> > Agreed, and same for the above.
> > 
> > So, what in your opinion would be the best way to expose this information?

Frankly?  It needs to be an easy-to-extend ABI, and the only one that cames
to mind right now are uevents.

> Maybe we should firstly define what event should be delivered to user
> space when it is resumed from S1--S4.

Why not a change uevent (although we could always come up with a new uevent
type for this, and that might be a good idea)?

> And another issue who is in charge of sending the event? By the specific
> device or ACPI notification?

ACPI notifications are hard to extend, I think.  Please correct me if I am
wrong.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
