From: Sonny Rao <sonnyrao@chromium.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c
	devices
Date: Thu, 7 Apr 2011 01:19:59 -0700
Message-ID: <BANLkTikDc6QhtK6F5VTX4iCkT0CAiXvztg__43160.6373902925$1302164481$gmane$org@mail.gmail.com>
References: <20110406095240.410b4e7e@endymion.delvare>
	<Pine.LNX.4.44L0.1104061043220.1907-100000@iolanthe.rowland.org>
	<20110406223123.GA5297@opensource.wolfsonmicro.com>
	<20110407095513.4c0b708e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110407095513.4c0b708e@endymion.delvare>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 7, 2011 at 12:55 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Mark,
>
> On Thu, 7 Apr 2011 07:31:24 +0900, Mark Brown wrote:
>> On Wed, Apr 06, 2011 at 10:49:17AM -0400, Alan Stern wrote:
>>
>> > Neither is the case. =A0For these subsystems, the PM dependencies _are_
>> > known.
>>
>> ...
>>
>> > Now, I have no idea what the situation is with regard to I2C...
>>
>> You definitely don't know *anything* about the relationships for I2C,
>> especially in embedded systems.
>
> Can you please elaborate? The i2c subsystem uses a standard
> parent-children relationship. It seems fairly similar to USB for
> example. The only special case I can think of is with bus multiplexing,
> but it would be easy enough to switch off async suspend/resume in this
> case.
>
> Sonny, I would expect you to obtain the time saving by only switching
> the i2c client device to async suspend/resume. wasn't it the case? i2c
> bus device suspend/resume shouldn't matter, as the operation should be
> handled by the hardware (e.g. PCI) layer.

I tried that first, and it looked like the client resume wouldn't start on =
the
async thread until the kernel resumed the i2c master which was
happening very late for some reason.  Maybe this was just a fluke of
the device ordering, but enabling it for both master and client allowed
the device resume to consistently happen much earlier.

Sonny
