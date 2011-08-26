From: Maksim Rayskiy <maksim.rayskiy@gmail.com>
Subject: Re: Function to tell S1 standby from STR
Date: Fri, 26 Aug 2011 16:00:14 -0700
Message-ID: <CAFVyGY4Dc0+5h1GF5bEp3PYx6WQtsiUwWD_nuDJtyBc640-gYQ@mail.gmail.com>
References: <CAFVyGY7NE4P4hZWSkzOhYbD-vX6b6oZT9y15LeZsQeh8S-u8iA@mail.gmail.com>
	<201108270045.41314.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108270045.41314.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Fri, Aug 26, 2011 at 3:45 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> On Saturday, August 27, 2011, Maksim Rayskiy wrote:
>> Hi,
>>
>> How can a driver in a suspend/resume call tell if the request is for
>> STR or S1? On SoCs I am working with drivers need to take some extra
>> steps to preserve context when STR is requested.
>>
>> I had to add platform-dependent api to do that, but I figured I am not
>> the only one having to deal with this. There are some comments in
>> arch/arm/mach-at91/pm.c regarding having to treat S1 and S3
>> differently because of wakeup source dependency on clock.
>>
>> And unfortunately these differences has to be taken care of in the
>> drivers, not platform code, because in some cases only device driver
>> knows what represents the hardware context that needs to be saved.
>
> Why not to save the same stuff for "S1" and "S3"?

One of the reasons is speed - you want recovery from S1 be as fast as
possible, restoring S3 context would slow things down.
The other reason is that device comes up in entirely different states,
so it has to be treated differently. It is not only a
matter of saving stuff, you may have to go through different
re-initialization sequence.

If you look at PCI EHCI resume code, you will see that it treats
complete power down and suspend not in the same way. Unfortunately,
for some devices it is hard to tell for sure where it is coming from -
S1 or S3.

Maksim.
