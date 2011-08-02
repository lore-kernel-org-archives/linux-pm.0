From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 02/11] PM: extend PM QoS with per-device
	wake-up constraints
Date: Tue, 02 Aug 2011 10:49:39 -0700
Message-ID: <87bow7ln4c.fsf__33830.4306300872$1312307554$gmane$org@ti.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	<1309446685-17502-3-git-send-email-j-pihet@ti.com>
	<201107022310.50175.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107022310.50175.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 2 Jul 2011 23:10:49 +0200")
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
Cc: markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> Hi,
>
> On Thursday, June 30, 2011, jean.pihet@newoldbits.com wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>> 
>> - add a new PM QoS class PM_QOS_DEV_WAKEUP_LATENCY for device wake-up
>> constraints. Due to the per-device nature of the new class the constraints
>> list is stored inside the device dev_pm_info struct instead of the internal
>> per-class constraints lists.
>
> I think PM_QOS_DEV_LATENCY might be a better name.
>
>> The new class is only available from kernel drivers and so is not exported
>> to user space.
>
> It should be available to user space, however, because in many cases drivers
> simply have no idea what values to use (after all, the use decides if he
> wants to trade worse video playback quality for better battery life, for
> example).
>

FWIW, I think it's wrong to expose the raw per-device constraints
directly to userspace.

I think it's the responsibility of the subsystems (video, audio, input,
etc.) to expose QoS knobs to userspace as they see fit and now allow
userspace to tinker directly with QoS constraints.

Kevin
