From: Kevin Hilman <khilman@ti.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Thu, 27 Jan 2011 15:49:37 -0800
Message-ID: <87lj25kium.fsf__18884.8662343391$1296172237$gmane$org@ti.com>
References: <Pine.LNX.4.44L0.1101271439020.2090-100000@iolanthe.rowland.org>
	<87tyguje7j.fsf@ti.com> <201101280021.14344.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101280021.14344.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Fri, 28 Jan 2011 00:21:14 +0100")
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
Cc: linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, Ido Yariv <ido@wizery.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

[...]

>> 
>> So, to summarize, as long as folks are OK with drivers directly calling
>> the subsystem runtime PM callbacks, I'll go this route.
>
> This is perfectly fine as long as you ensure that they won't be called
> concurrently through the runtime PM framework.

Yes, as long as they're only used in the suspend/resume (or _noirq
versions) this is guaranteed since the DPM core is already preventing
runtime PM transitions during suspend/resume.

Kevin
