From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup()
 policy inputs
Date: Mon, 28 Apr 2008 09:43:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804280941440.3566-100000__9422.31343728981$1209390365$gmane$org@iolanthe.rowland.org>
References: <1209372607.3538.107.camel@rzhang-crestline.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1209372607.3538.107.camel@rzhang-crestline.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 28 Apr 2008, Zhang Rui wrote:

> This may cause some "regressions", something like system resumes
> immediately after enter S3. This should rather be a driver/device
> problem which rises a wake up event when it's suspend.
> The right thing to do is to disable the wake up flag for this device.
> The patch was dropped for this reason last time it's merged and we
> should take good care of it this time. :)

Indeed, it's easy to imagine a situation where somebody suspends their 
laptop and then unplugs a USB mouse, thereby causing a wakeup event.

I suspect many PCI devices should be disabled for remote wakeup during 
system sleeps.

Alan Stern
