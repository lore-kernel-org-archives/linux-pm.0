From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] Enable async suspend/resume on industrial IO
	devices
Date: Thu, 07 Apr 2011 12:29:14 +0100
Message-ID: <4D9DA00A.3030700__15929.9033497975$1302175778$gmane$org@cam.ac.uk>
References: <1302057915-13549-1-git-send-email-sonnyrao@chromium.org>
	<4D9C477E.4050400@cam.ac.uk>
	<BANLkTikWBU-uW6xKwNt+zrS0JbDPOzdd0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTikWBU-uW6xKwNt+zrS0JbDPOzdd0w@mail.gmail.com>
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
Cc: devel@driverdev.osuosl.org, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Phillip Kurtenbach <pkurtenbach@gmail.com>, snanda@chromium.org, Andrew Morton <akpm@linux-foundation.org>, bleung@chromium.org, linux-pm@lists.linux-foundation.org, Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
List-Id: linux-pm@vger.kernel.org

On 04/06/11 23:47, Sonny Rao wrote:
> On Wed, Apr 6, 2011 at 3:59 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>> On 04/06/11 03:45, Sonny Rao wrote:
>>> Industrial I/O devices can sometimes take a long time to resume,
>>> allowing them to be asynchronus saves 50ms on one light sensor
>>>
>> Hi Sonny,
>>
>> cc'd linux-iio
>>
>> I'm not particularly familiar with this.  Are there any disadvantages?
>> I just wonder if it would be better to push this into individual drivers
>> rather than the core?
> 
> Yeah we could do it that way too, I sent out a similar patch for i2c
> and people were asking if it was entirely safe.  It sounds like it may
> depend on dependencies between devices.
> 
> Do you know if any of the devices in iio have inter-device dependencies?
> I was under the impression they were mostly stand-alone sensors that
> ordinarily wouldn't, but I haven't tried to audit all of them or anything.
Mostly I think is the key word here.  Right now I don't think we have anything
that would have a problem, but putting something like that in the core is
liable to bite sometime in the future.  For now at least I think I'd prefer
to see it in an individual driver.
