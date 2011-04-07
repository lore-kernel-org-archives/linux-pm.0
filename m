From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c
	devices
Date: Thu, 7 Apr 2011 09:55:13 +0200
Message-ID: <20110407095513.4c0b708e__22472.1067156226$1302163003$gmane$org@endymion.delvare>
References: <20110406095240.410b4e7e@endymion.delvare>
	<Pine.LNX.4.44L0.1104061043220.1907-100000@iolanthe.rowland.org>
	<20110406223123.GA5297@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sonny Rao <sonnyrao@chromium.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On Thu, 7 Apr 2011 07:31:24 +0900, Mark Brown wrote:
> On Wed, Apr 06, 2011 at 10:49:17AM -0400, Alan Stern wrote:
> 
> > Neither is the case.  For these subsystems, the PM dependencies _are_ 
> > known.
> 
> ...
> 
> > Now, I have no idea what the situation is with regard to I2C...
> 
> You definitely don't know *anything* about the relationships for I2C,
> especially in embedded systems.

Can you please elaborate? The i2c subsystem uses a standard
parent-children relationship. It seems fairly similar to USB for
example. The only special case I can think of is with bus multiplexing,
but it would be easy enough to switch off async suspend/resume in this
case.

Sonny, I would expect you to obtain the time saving by only switching
the i2c client device to async suspend/resume. wasn't it the case? i2c
bus device suspend/resume shouldn't matter, as the operation should be
handled by the hardware (e.g. PCI) layer.

Rafael, what happens if a parent is set to async suspend/resume but its
children aren't? Does it disable async altogether for the whole branch,
or does it mean that the branch is processed asynchronously as a whole
but its internal processing is serialized? Or something else?

-- 
Jean Delvare
