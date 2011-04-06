From: Sonny Rao <sonnyrao@chromium.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c
	devices
Date: Tue, 5 Apr 2011 23:51:48 -0700
Message-ID: <BANLkTikkmmCuAvoov4wY7zUC4mX9yrDnXQ__160.839039790694$1302115329$gmane$org@mail.gmail.com>
References: <BANLkTik7i0VQpJb+enUd9c4-XvZQ1S57fQ@mail.gmail.com>
	<20110406052335.GA25578@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110406052335.GA25578@sirena.org.uk>
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
Cc: linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org, bleung@chromium.org, snanda@chromium.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 5, 2011 at 10:23 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Apr 04, 2011 at 08:47:01PM -0700, Sonny Rao wrote:
>> This improves our resume time when we have devices on an i2c bus
>> that are slow to resume. =A0In particular we have a light sensor that
>> adds about 50ms of resume time on one device. We have to enable it
>> both on the i2c master and i2c client side and then we get fully async
>> suspend/resume. =A0I suspect we'll see nice gains on systems with more
>> i2c devices and will test that out soon.
>>
>> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
>
> It'd probably help if the patch explained why this is safe - my
> immediate question is why if it's safe to just unconditionally enable
> async suspend for all I2C clients and adaptors it's not safe to do so
> for all devices of all types?
>

Yeah, I admit that I'm not yet familiar enough with suspend/resume
to give a good answer, and I was wondering the same thing. I was
hoping people on the lists would chime in an say if it weren't safe,
or if there is a better way to get some parallelism for slow devices.

It might help if I gave you a bit more background on how I got to this
point.

We've been looking at suspend/resume performance on a dual
core Atom netbook (four hardware threads), and noticed each
that bringing each logical cpu up was adding about 80ms to our
resume time.

There was some expectation that having more cpus available
to do device resume would make up for the initial cost of bringing
each cpu up, but it turned out that wasn't the case.  Going from one
logical cpu to two made total resume time lower, but the third and
fourth cpus only added time.   So there wasn't enough device
parallelism to take advantage of four cpus.

So we started looking for what devices were going slow and the
top hitter was a light sensor that has to get totally reinitialized upon
resume.  Also, 50ms seems pretty small but in the case of the
that turns out to be about 8% of our time in device resume.

I've also noticed some other devices which aren't asynchronous
taking more than a trivial amount of time.  Especially some of the
ACPI devices like fans, batterys, etc, and was going to go look
at making those async as well if it would help.

I'm open to suggestions on how to tackle this, thanks for the
feedback.

Sonny
