From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH v2 3/3] PM / DEVFREQ: add sysfs interface
 (including user tickling)
Date: Wed, 11 May 2011 15:55:40 -0700
Message-ID: <20110511225540.GA3492__5095.01990532062$1305155201$gmane$org@suse.de>
References: <1305100723-29161-1-git-send-email-myungjoo.ham@samsung.com>
	<1305100723-29161-3-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1305100723-29161-3-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, May 11, 2011 at 04:58:43PM +0900, MyungJoo Ham wrote:
> 1. System-wide sysfs interface
> - tickle_all	R: number of tickle_all execution
> 		W: tickle all devfreq devices
> - min_interval	R: devfreq monitoring base interval in ms
> - monitoring	R: shows whether devfreq monitoring is active or
>   not.
> 
> 2. Device specific sysfs interface
> - tickle	R: number of tickle execution for the device
> 		W: tickle the device

Any sysfs file change/addition/removal needs to have a
Documentation/ABI/ entry as well.  Please add that to this patch instead
of burying it in the changelog entry, where no one will be able to find
it in the future.

thanks,

greg k-h
