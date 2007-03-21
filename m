From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 00:49:51 +0300
Message-ID: <4601A87F.6040608@gmail.com>
References: <1174295302.31250.1.camel@sli10-conroe.sh.intel.com>	<20070320183022.GC2670@elf.ucw.cz>	<1174440888.29722.15.camel@sli10-conroe.sh.intel.com>
	<52d486620703210821h3e26b167kb12a197d7b46e04d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <52d486620703210821h3e26b167kb12a197d7b46e04d@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Amit Kucheria <kucheria.amit@gmail.com>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Amit Kucheria wrote:
> On 3/21/07, Shaohua Li <shaohua.li@intel.com> wrote:
>> On Wed, 2007-03-21 at 02:30 +0800, Pavel Machek wrote:
>
>>> No, that's not how it works; look at hda_audio, it already has
>>> powersave. Just power down audio card 5 seconds after its control file
>>> is closed.
>> It's another case of doing policy in a driver.
>>
>
> IMHO, this kind of policy is best handled inside the driver because it
> is specific to the hardware. This will ensure that the driver will
> just work on every distro without some userspace policy being present
> and setup _correctly_.

It some circumstances this policy may increase power consumption
but not decrease it. Consider the case of repeatable operation,
something like periodic sound beep, with period of 5s.
In this case, a driver implementing the policy will periodically
suspend/resume a number of devices - audio controller, codec, ADC,
but the operation  itself (suspending/resuming) will consume
more power than power consumed by these devices in case they
left running for a 5s. In such a case you may want to change
the predefined  value or  just  disable the policy.

Yes, we may just not close a sound device file, but phone
applications I've seen, do close the file.

And, my example is applicable not for audio drivers only,
keep the file opened may be impossible for some reason.

 =


Thanks,
Dmitry
