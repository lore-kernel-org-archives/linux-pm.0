From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sun, 26 Dec 2010 19:37:21 +0100
Message-ID: <201012261937.21256.rjw__24322.5661143244$1293388715$gmane$org@sisk.pl>
References: <AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X@mail.gmail.com>
	<201012261245.29680.rjw@sisk.pl>
	<AANLkTinvBD6NhHY7PMw9NSJNBW77-Gah8Vcow6t1aiCT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinvBD6NhHY7PMw9NSJNBW77-Gah8Vcow6t1aiCT@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Sunday, December 26, 2010, Ohad Ben-Cohen wrote:
> On Sun, Dec 26, 2010 at 1:45 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > (It still is not a race, though.)
> 
> Thread 1
> =======
> 
> suspend_handler_of_a_random_device()
> {
>     return failure;
> }
> 
> Thread 2
> =======
> 
> suspend_handler_of_our_mmc_host_controller()
> {
>     invoke our sdio suspend handler and power down the card (directly);
>     return success;
> }
> 
> If thread 2 wins => everything is cool
> If thread 1 wins => our driver will not be able to resume
> 
> The race begins after mac80211 invokes our driver's power off handler,
> which is using pm_runtime_put_sync().

So, it only happens during asynchronous suspend?  In other words, if suspend
is synchronous, everything should be fine, right?

Rafael
