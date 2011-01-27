From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Thu, 27 Jan 2011 23:18:27 +0100
Message-ID: <AANLkTinbHx1XtxpWDr+UCUBo6xRCs=zT1AD_y2kXo0cL__11000.0050081455$1296166829$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1101271439020.2090-100000@iolanthe.rowland.org>
	<87tyguje7j.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87tyguje7j.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>, Ido Yariv <ido@wizery.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 27, 2011 at 9:15 PM, Kevin Hilman <khilman@ti.com> wrote:
>
>> If it is, then you can call omap_pm_runtime_suspend() directly instead
>> of calling dev->bus->pm->runtime_suspend().
>
> Personally, I prefer going through dev->bus as we try to avoid SoC
> specific calls in the driver.
>
> This same HW block might be re-used on non-OMAP SoCs (e.g. TI DaVinci)
> that would have different PM at the susbystem level.
>
> So, to summarize, as long as folks are OK with drivers directly calling
> the subsystem runtime PM callbacks, I'll go this route.

I personally think it's okay for the moment. Generally speaking, SD
bus driver might not have runtime PM support so it's better to have
this explicitly called and not compiling for other platforms rather
than have it compiling but working not the way it's expected to.

~Vitaly
