From: David Brownell <david-b@pacbell.net>
Subject: Re: Power Mangement Interfaces
Date: Sat, 31 Mar 2007 09:12:10 -0700
Message-ID: <200703310912.10986.david-b@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
	<1175300283.23438.38.camel@johannes.berg>
	<1175300491.23438.40.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1175300491.23438.40.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.osdl.org, devel@laptop.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 30 March 2007 5:21 pm, Johannes Berg wrote:

> Hm, another thing. The RTC alarm wakeup event, wouldn't that require
> programming the time too? And if so, should that be done through the
> power interface to it?

There's already a cross-platform interface to RTC wakeup alarms; no
new interface is needed (or desirable), much less one that requires
any new or modified /sys/power/... files.

 - Enable the wakeup event in /sys/devices/.../power/wakeup
   (alternate names include /sys/class/rtc/.../device/power/wakeup)

 - Userspace can set the alarm using

    * /dev/rtcX and one ioctl:  RTC_WKALM_SET
    * /dev/rtcX and two ioctls:  RTC_ALM_SET, then RTC_AIE_ON
    * /sys/class/rtc/.../wakealarm

That works on multiple systems already.  I've just posted updates
to make it work for "rtc-cmos" on the RTC list.

- Dave
