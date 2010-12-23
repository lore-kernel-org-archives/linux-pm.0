From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Thu, 23 Dec 2010 09:51:22 +0200
Message-ID: <AANLkTi=9kjmb3evOON3WMoGjqadDHqqBKVH4viT02Qf9__13760.3909978226$1293090779$gmane$org@mail.gmail.com>
References: <AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com>
	<AANLkTin23vbbA7+UDzh=v060HbkLMrJjB38cs+AWScPJ@mail.gmail.com>
	<201012182347.08635.rjw@sisk.pl> <201012191122.09581.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012191122.09581.rjw@sisk.pl>
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

On Sun, Dec 19, 2010 at 12:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> That said, I think we may do something different that perhaps will make your
> life somewhat easier.
...
> So, I think we can add a "runtime only" flag working as described above.

That will definitely solve the suspend/resume issue we're having.

But due to /sys/devices/.../power/control, we will still have to
bypass runtime PM for this particular device.

We need a way to unconditionally power down the device, and as long as
runtime PM can be disabled by the user, we can't use it.

Thanks,
Ohad.
