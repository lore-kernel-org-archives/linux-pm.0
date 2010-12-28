From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Tue, 28 Dec 2010 22:41:29 +0200
Message-ID: <AANLkTikxmS0sw6HeXL5QhdzBzBU3U9+hTvsPcyJay5J6__47316.9242417955$1293568959$gmane$org@mail.gmail.com>
References: <AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X@mail.gmail.com>
	<201012261937.21256.rjw@sisk.pl>
	<AANLkTinewad6YxXvn5gnJQ+HJn41Sg96319GQn9KRKWj@mail.gmail.com>
	<201012282104.06232.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012282104.06232.rjw@sisk.pl>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-mmc@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-wireless@vger.kernel.org, Ido Yariv <ido@wizery.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 28, 2010 at 10:04 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, December 28, 2010, Ohad Ben-Cohen wrote:
>> On Sun, Dec 26, 2010 at 8:37 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > So, it only happens during asynchronous suspend? =A0In other words, if=
 suspend
>> > is synchronous, everything should be fine, right?
>>
>> Not necessarily.
>
> So it's not a race after all, is it?

There are several scenarios to the same problem.. In one of them, we
were racing against an event that caused a suspend handler of an
entirely unrelated device to fail. I'm trying very hard not to
overload this thread with irrelevant details.. but anyway this forked
discussion is a bit moot IMHO

> Second, what you'd really want to do (I guess) is:
>
> pm_runtime_put_noidle(device);
> device->bus->pm->runtime_suspend(device);

Yes, our workaround is somewhere in these lines. We're using it
regardless of the system state (runtime or suspending), and frankly,
we're happy with it, just like I said in:

http://www.spinics.net/linux/lists/linux-mmc/msg05052.html

I still call it a workaround though...
