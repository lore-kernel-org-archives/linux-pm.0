From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] PM / Hibernate: no kernel_power_off when
 pm_power_off NULL
Date: Tue, 22 Apr 2014 09:09:55 +0200
Message-ID: <20140422070955.GA14108@amd.pavel.ucw.cz>
References: <1398126646-29518-1-git-send-email-sebastian.capella@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398126646-29518-1-git-send-email-sebastian.capella@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Mon 2014-04-21 17:30:46, Sebastian Capella wrote:
> Reboot logic in kernel/reboot will avoid calling kernel_power_off
> when pm_power_off is null, and instead uses kernel_halt.  Change
> hibernate's power_down to follow the behavior in the reboot call.
> 
> Calling the notifier twice (once for SYS_POWER_OFF and again for
> SYS_HALT) causes a panic during hibernation on Kirkwood
> Openblocks A6 board.
> 
> Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
> Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Len Brown <len.brown@intel.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
