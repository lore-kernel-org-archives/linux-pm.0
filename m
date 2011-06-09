From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 3/3] PM / DEVFREQ: add sysfs interface
 (including user tickling)
Date: Thu, 9 Jun 2011 19:11:58 +0200
Message-ID: <20110609171157.GA3877@ucw.cz>
References: <1310717510-19002-1-git-send-email-myungjoo.ham@samsung.com>
	<1310717510-19002-4-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1310717510-19002-4-git-send-email-myungjoo.ham@samsung.com>
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
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Hi!

> +What:		/sys/devices/.../power/devfreq_polling_interval
> +Date:		July 2011
> +Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
> +Description:
> +		The /sys/devices/.../power/devfreq_polling_interval shows the
> +		requested polling interval of the corresponding device.

AFAICT, polling only makes sense for one governor; and I guess more
governor parameters will be needed in future. Should polling interval
be governor-specific?
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
