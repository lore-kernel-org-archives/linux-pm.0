From: Sonny Rao <sonnyrao@chromium.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c
	devices
Date: Wed, 6 Apr 2011 23:45:34 -0700
Message-ID: <BANLkTi=t03WEB70D0YH29JEQei=wJU5Gig__11538.179315585$1302158816$gmane$org@mail.gmail.com>
References: <20110406095240.410b4e7e@endymion.delvare>
	<20110406223123.GA5297@opensource.wolfsonmicro.com>
	<BANLkTikApnXBtP7c=QLEvM9ye=_YZiSSqw@mail.gmail.com>
	<201104070722.44771.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104070722.44771.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 6, 2011 at 10:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, April 07, 2011, Sonny Rao wrote:
>> On Wed, Apr 6, 2011 at 3:31 PM, Mark Brown
>> <broonie@opensource.wolfsonmicro.com> wrote:
>> > On Wed, Apr 06, 2011 at 10:49:17AM -0400, Alan Stern wrote:
>> >
>> >> Neither is the case. =A0For these subsystems, the PM dependencies _ar=
e_
>> >> known.
>> >
>> > ...
>> >
>> >> Now, I have no idea what the situation is with regard to I2C...
>> >
>> > You definitely don't know *anything* about the relationships for I2C,
>> > especially in embedded systems.
>> >
>>
>> Would it be okay to enable this on a per-device basis where it is
>> known to be safe?
>
> Yes.

Ok, I'll probably submit a patch for the specific case of the slow
light sensor to the IIO
guys later on, and if I find cases where we get wins on other I2C
heavy platforms
(like ARM netbooks) I'll send those out as device-specific changes as well.

<snip>

> It is used by subsystems where dependencies between devices are known to
> generally follow the structure of the device hierarchy within the kernel
> (i.e. they are well-defined buses with well-defined parents and children).

Ok, thanks for the explanation!

Sonny
