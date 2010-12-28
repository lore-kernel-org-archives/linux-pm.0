From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Tue, 28 Dec 2010 21:11:43 +0200
Message-ID: <AANLkTimHHN+GesyhR6Jjnm771XLhn=inn=vrSk=mT6Mh__3212.0699914687$1293563612$gmane$org@mail.gmail.com>
References: <AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X@mail.gmail.com>
	<201012261245.29680.rjw@sisk.pl>
	<AANLkTimzNXyirnV9wGXf6R454bwEDf=poBZzevAWXEUd@mail.gmail.com>
	<201012261935.13238.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012261935.13238.rjw@sisk.pl>
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
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 26, 2010 at 8:35 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Sunday, December 26, 2010, Ohad Ben-Cohen wrote:
>> On Sun, Dec 26, 2010 at 1:45 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > Why does the driver need the device to be reset even though it hasn't
>> > been suspeneded yet?
>>
>> Because it is asked to stop the hardware by mac80211.
>
> So I guess the mac80211 layer should ask it to start it again.

It does...

And at this point the driver will try to boot a new firmware, but it
will only succeed if the device was indeed powered off. If it wasn't
(system suspend was cancelled before the host controller  suspended),
the driver will fail to resume the device (because it can't reset it).

We can change man80211 to let us know the system is suspending, and
then we will power down the device directly. Or we can use something
like your "runtime only" proposal, and then pm_runtime_put_sync() will
just work for us regardless of the system state.

But that will not solve the /sys/devices/.../power/control problem.
For that we will either have always to bypass runtime PM, or introduce
something like "always auto"...

Thanks,
Ohad.
