From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] power: disable hibernation if module loading
 is disabled
Date: Fri, 4 Mar 2011 21:32:02 +0100
Message-ID: <20110304203201.GA22079__35261.4231328063$1299270797$gmane$org@elf.ucw.cz>
References: <1299255084-4390-1-git-send-email-segoon@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1299255084-4390-1-git-send-email-segoon@openwall.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: Len Brown <len.brown@intel.com>, security@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri 2011-03-04 19:11:24, Vasiliy Kulikov wrote:
> If /proc/sys/kernel/modules_disabled is set to 1, then nobody (even full
> root) may not read/write arbitrary kernel memory.  In spite of it,
> hibernation allows anyone with an access to either /dev/snapshot or
> /sys/power/ make the full snapshot of the system.  This snapshot may be
> freely changed and uploaded back.

module loading has nothing to do with hibernation, and hibernation
already checks for CAP_ADMIN or something similary strong. I don't see
why this new check is needed.

In fact, you are probably breaking someone's setup right now.

> +	if (modules_disabled)
> +		return -EPERM;
> +
>  	error = platform_begin(platform_mode);

Hmm. How is this supposed to work with CONFIG_MODULES off?

NAK.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
