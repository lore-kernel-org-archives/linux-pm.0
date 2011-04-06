From: Sonny Rao <sonnyrao@chromium.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c
	devices
Date: Wed, 6 Apr 2011 01:16:07 -0700
Message-ID: <BANLkTimaRdRNOYM43AhjrU70o=GL0Q-D-A__11406.4934351065$1302115333$gmane$org@mail.gmail.com>
References: <BANLkTik7i0VQpJb+enUd9c4-XvZQ1S57fQ@mail.gmail.com>
	<20110406052335.GA25578@sirena.org.uk>
	<20110406095240.410b4e7e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110406095240.410b4e7e@endymion.delvare>
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
Cc: linux-pm@lists.linux-foundation.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 6, 2011 at 12:52 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Wed, 6 Apr 2011 06:23:35 +0100, Mark Brown wrote:
>> On Mon, Apr 04, 2011 at 08:47:01PM -0700, Sonny Rao wrote:
>> > This improves our resume time when we have devices on an i2c bus
>> > that are slow to resume. =A0In particular we have a light sensor that
>> > adds about 50ms of resume time on one device. We have to enable it
>> > both on the i2c master and i2c client side and then we get fully async
>> > suspend/resume. =A0I suspect we'll see nice gains on systems with more
>> > i2c devices and will test that out soon.
>> >
>> > Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
>>
>> It'd probably help if the patch explained why this is safe - my
>> immediate question is why if it's safe to just unconditionally enable
>> async suspend for all I2C clients and adaptors it's not safe to do so
>> for all devices of all types?
>
> I have exactly the same concern. From
> Documentation/ABI/testing/sysfs-devices-power:
>
> =A0 =A0 =A0 =A0It generally is unsafe to permit the asynchronous suspend/=
resume
> =A0 =A0 =A0 =A0of a device unless it is certain that all of the PM depend=
encies
> =A0 =A0 =A0 =A0of the device are known to the PM core. =A0However, for so=
me
> =A0 =A0 =A0 =A0devices this attribute is set to "enabled" by bus type cod=
e or
> =A0 =A0 =A0 =A0device drivers and in that cases it should be safe to leav=
e the
> =A0 =A0 =A0 =A0default value.
>
> As I don't see any code being added to guarantee that "all of the PM
> dependencies of the device are known to the PM core", I am skeptical
> about the general correctness of the proposed change.
>
> On the other hand, a quick grep on the kernel tree shows that the scsi,
> usb and pci subsystem enable async suspend unconditionally for all
> devices. This seems quite contradictory with the quoted statement
> above. Rafael, can you please clarify? Is the attribute description too
> alarmist, or are the subsystems too optimistic? ;)

Yeah, this is sort of why I made the change at this level.
I originally wrote a patch which just enabled it for the particular
sensor, but it didn't match with the other uses of that function
in the kernel which did things to entire subsystems like you
point out.  So, I re-wrote it in the optimistic hope that this was safe
just like USB/PCI/SCSI seem to be.

> Original post for reference:
> http://marc.info/?l=3Dlinux-i2c&m=3D130206741920878&w=3D2
>
> Sonny, on how many systems did you test it? In particular, did you test
> it on several TV cards (which use I2C a lot and sometimes in complex
> setups)?

It has only been tested on my x86 system with the light sensor and
lightly tested on an ARM system with about 6-7 i2c devices.  I was hoping
the change would help the ARM systems because they make much
heavier use of i2c than the x86 system.  I haven't tested on anything
like multiple TV cards because I don't have such a setup -- the ARM
boxes with several i2c devices is the most complex user of i2c I have
at the moment.

Sonny
