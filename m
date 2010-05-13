From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 16:28:23 -0700
Message-ID: <s2wa55d774e1005131628v107b339fo7f1da3816a22c5c0__12847.1754760996$1273793382$gmane$org@mail.gmail.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<201005132311.26293.rjw@sisk.pl>
	<1273785399.19100.98.camel@c-dwalke-linux.qualcomm.com>
	<201005132327.16163.rjw@sisk.pl>
	<1273786409.19100.104.camel@c-dwalke-linux.qualcomm.com>
	<20100513214653.GA21120@suse.de>
	<13B9B4C6EF24D648824FF11BE896716203BB0EEAE9@dlee02.ent.ti.com>
	<20100513224600.GB23014@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100513224600.GB23014@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: Oleg Nesterov <oleg@redhat.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 13, 2010 at 3:46 PM, Greg KH <gregkh@suse.de> wrote:
> On Thu, May 13, 2010 at 05:33:58PM -0500, Woodruff, Richard wrote:
>>
>> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> > owner@vger.kernel.org] On Behalf Of Greg KH
>> > Sent: Thursday, May 13, 2010 4:47 PM
>>
>> > Also note that such a driver, without wakelocks, would never get tested,
>> > and so, things start quickly diverging.
>>
>> Do wakelock enabled drivers require a wakelock aware user space to
>> function properly?
>
> Not that I can tell, but others might know more.

Drivers with correct wakelock usage will play nice with opportunistic suspend.

If you're not using opportunistic suspend, you probably don't need
wakelocks at all, and the driver (unless it's broken) should work just
fine for you.

>> If the driver is added you want to make sure the benefit is there and
>> testable for all userspaces.
>
> Agreed.

Definitely.  The fact that say the dsp audio driver or serial driver
on MSM use wakelocks to play nice with opportunistic suspend should
have no impact on, say, Debian-on-G1 which is not using that feature.
Debian would still be able to play audio or write to the serial port.

With wakelock support in the kernel, I'm able to maintain drivers that
(provided they meet the normal style, correctness, etc requirements)
that both can be submitted to mainline (yay!) and can ship on
production hardware as-is (yay!).  Porting other linux based
environments to hardware like G1, N1, etc becomes that much easier
too, which hopefully makes various folks happy.

This helps get us ever closer to being able to build a
production-ready kernel for various android devices "out of the box"
from the mainline tree and gets me ever closer to not being in the
business of maintaining a bunch of SoC-specific
android-something-2.6.# trees, which seriously is not a business I
particularly want to be in.

Brian
