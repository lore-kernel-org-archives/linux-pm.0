From: Sonny Rao <sonnyrao@chromium.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c
	devices
Date: Wed, 6 Apr 2011 16:08:32 -0700
Message-ID: <BANLkTikApnXBtP7c=QLEvM9ye=_YZiSSqw__46861.0282558531$1302131986$gmane$org@mail.gmail.com>
References: <20110406095240.410b4e7e@endymion.delvare>
	<Pine.LNX.4.44L0.1104061043220.1907-100000@iolanthe.rowland.org>
	<20110406223123.GA5297@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110406223123.GA5297@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 6, 2011 at 3:31 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Apr 06, 2011 at 10:49:17AM -0400, Alan Stern wrote:
>
>> Neither is the case. =A0For these subsystems, the PM dependencies _are_
>> known.
>
> ...
>
>> Now, I have no idea what the situation is with regard to I2C...
>
> You definitely don't know *anything* about the relationships for I2C,
> especially in embedded systems.
>

Would it be okay to enable this on a per-device basis where it is
known to be safe?

I started out doing it like this,  but I didn't like the way the patch look=
ed
because it ended up having to call this function twice -- once on the i2c
master device and once on it's client devices (and actually a third time
because it had another struct dev for the industrial IO device).  So,
that seemed pretty ugly.

Also, it didn't seem to match the usage of device_enable_async_suspend()
in other parts of the kernel where it was used on whole subsystems.

Sonny
