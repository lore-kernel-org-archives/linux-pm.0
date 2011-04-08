From: Sonny Rao <sonnyrao@chromium.org>
Subject: Re: [PATCH] Enable async suspend/resume on industrial IO
	devices
Date: Thu, 7 Apr 2011 20:26:27 -0700
Message-ID: <BANLkTikRPz_NYY=mJ8Mqe9k2cyu-ouC4iw__23258.3593846813$1302233352$gmane$org@mail.gmail.com>
References: <1302057915-13549-1-git-send-email-sonnyrao@chromium.org>
	<4D9C477E.4050400@cam.ac.uk>
	<BANLkTikWBU-uW6xKwNt+zrS0JbDPOzdd0w@mail.gmail.com>
	<4D9DA00A.3030700@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D9DA00A.3030700@cam.ac.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: devel@driverdev.osuosl.org, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Phillip Kurtenbach <pkurtenbach@gmail.com>, snanda@chromium.org, Andrew Morton <akpm@linux-foundation.org>, bleung@chromium.org, linux-pm@lists.linux-foundation.org, Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 7, 2011 at 4:29 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 04/06/11 23:47, Sonny Rao wrote:
>> On Wed, Apr 6, 2011 at 3:59 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>>> On 04/06/11 03:45, Sonny Rao wrote:
>>>> Industrial I/O devices can sometimes take a long time to resume,
>>>> allowing them to be asynchronus saves 50ms on one light sensor
>>>>
>>> Hi Sonny,
>>>
>>> cc'd linux-iio
>>>
>>> I'm not particularly familiar with this. =A0Are there any disadvantages?
>>> I just wonder if it would be better to push this into individual drivers
>>> rather than the core?
>>
>> Yeah we could do it that way too, I sent out a similar patch for i2c
>> and people were asking if it was entirely safe. =A0It sounds like it may
>> depend on dependencies between devices.
>>
>> Do you know if any of the devices in iio have inter-device dependencies?
>> I was under the impression they were mostly stand-alone sensors that
>> ordinarily wouldn't, but I haven't tried to audit all of them or anythin=
g.
> Mostly I think is the key word here. =A0Right now I don't think we have a=
nything
> that would have a problem, but putting something like that in the core is
> liable to bite sometime in the future. =A0For now at least I think I'd pr=
efer
> to see it in an individual driver.
>
Ok sure, FYI, I had a similar discussion with the i2c folks and I
think the consensus was to do it per-driver as well.
The driver I was interested in was the tsl258x which isn't in staging
yet.  When it goes in, I shall submit my patch on top of that.


Thanks,
Sonny
