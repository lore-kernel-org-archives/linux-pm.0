From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c
	devices
Date: Thu, 7 Apr 2011 07:22:44 +0200
Message-ID: <201104070722.44771.rjw__35979.6433164321$1302153890$gmane$org@sisk.pl>
References: <20110406095240.410b4e7e@endymion.delvare>
	<20110406223123.GA5297@opensource.wolfsonmicro.com>
	<BANLkTikApnXBtP7c=QLEvM9ye=_YZiSSqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTikApnXBtP7c=QLEvM9ye=_YZiSSqw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sonny Rao <sonnyrao@chromium.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, April 07, 2011, Sonny Rao wrote:
> On Wed, Apr 6, 2011 at 3:31 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Wed, Apr 06, 2011 at 10:49:17AM -0400, Alan Stern wrote:
> >
> >> Neither is the case.  For these subsystems, the PM dependencies _are_
> >> known.
> >
> > ...
> >
> >> Now, I have no idea what the situation is with regard to I2C...
> >
> > You definitely don't know *anything* about the relationships for I2C,
> > especially in embedded systems.
> >
> 
> Would it be okay to enable this on a per-device basis where it is
> known to be safe?

Yes.

> I started out doing it like this,  but I didn't like the way the patch looked
> because it ended up having to call this function twice -- once on the i2c
> master device and once on it's client devices (and actually a third time
> because it had another struct dev for the industrial IO device).  So,
> that seemed pretty ugly.
> 
> Also, it didn't seem to match the usage of device_enable_async_suspend()
> in other parts of the kernel where it was used on whole subsystems.

It is used by subsystems where dependencies between devices are known to
generally follow the structure of the device hierarchy within the kernel
(i.e. they are well-defined buses with well-defined parents and children).

Thanks,
Rafael
