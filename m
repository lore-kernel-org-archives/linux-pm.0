From: Daniel Drake <dsd@laptop.org>
Subject: Re: Trying to understand new wakeup events architecture
Date: Thu, 13 Jan 2011 15:06:28 +0000
Message-ID: <1294931188.2244.5.camel@polyethylene>
References: <AANLkTik0y2O4GTvoFkm-94iSWdWUG8juZ0cBNWXDas8Q@mail.gmail.com>
	<AANLkTinw9MXSXV3FNp-b1S0bpBVBoLJi7CUhC0=2Pgg0@mail.gmail.com>
	<AANLkTi=PL_tzxEnfKGjP4Qjv_jNyR-c95W8-caXfG2vo@mail.gmail.com>
	<201101122102.44482.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101122102.44482.rjw@sisk.pl>
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

On Wed, 2011-01-12 at 21:02 +0100, Rafael J. Wysocki wrote:
> > How do you feel about us using power_kobj to create
> > /sys/power/wakeup_source from inside our OLPC code?
> > This would include a textual representation of the last wakeup source.
> > 
> > Alternatively we could put it as a sysfs attribute of our own platform device.
> 
> I'm basically fine with /sys/power/source as long as its contents are generally
> suitable.  What exactly do you want to show up in that file?

Do you mean /sys/power/source or /sys/power/wakeup_source? I prefer the
latter as the first one sounds like "power source" (AC, battery,
solar, ...)

As for contents, it will read back a string. One of:

rtc alarm
power button
lid
key press
battery
battery state changed
battery error
ebook
wlan packet
ac power
battery critical
gp timer
hda
usb
unknown

Thanks,
Daniel
