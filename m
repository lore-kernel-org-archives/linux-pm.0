From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sun, 26 Dec 2010 16:53:57 +0200
Message-ID: <AANLkTinvBD6NhHY7PMw9NSJNBW77-Gah8Vcow6t1aiCT__15720.8492084921$1293375328$gmane$org@mail.gmail.com>
References: <AANLkTimj0E3Rz_8WQrU4wGg3ONyXzkUT9+U3Xqz7Cq0X@mail.gmail.com>
	<Pine.LNX.4.44L0.1012252041260.10725-100000@netrider.rowland.org>
	<AANLkTinyKfwcZLD5D4rdF6OpQqr79F==GRjAMBjjbupW@mail.gmail.com>
	<201012261245.29680.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012261245.29680.rjw@sisk.pl>
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

On Sun, Dec 26, 2010 at 1:45 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> (It still is not a race, though.)

Thread 1
=======

suspend_handler_of_a_random_device()
{
    return failure;
}

Thread 2
=======

suspend_handler_of_our_mmc_host_controller()
{
    invoke our sdio suspend handler and power down the card (directly);
    return success;
}

If thread 2 wins => everything is cool
If thread 1 wins => our driver will not be able to resume

The race begins after mac80211 invokes our driver's power off handler,
which is using pm_runtime_put_sync().
