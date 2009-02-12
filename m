From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 06/10] PM: Add early suspend api.
Date: Thu, 12 Feb 2009 11:34:56 +0000
Message-ID: <20090212113456.GD28176@srcf.ucam.org>
References: <1234316955-31304-1-git-send-email-arve@android.com>
	<1234316955-31304-2-git-send-email-arve@android.com>
	<1234316955-31304-3-git-send-email-arve@android.com>
	<1234316955-31304-4-git-send-email-arve@android.com>
	<1234316955-31304-5-git-send-email-arve@android.com>
	<1234316955-31304-6-git-send-email-arve@android.com>
	<1234316955-31304-7-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1234316955-31304-7-git-send-email-arve@android.com>
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
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 10, 2009 at 05:49:11PM -0800, Arve Hj=F8nnev=E5g wrote:

> +EARLY_SUSPEND_LEVEL_BLANK_SCREEN:
> +  On suspend the screen should be turned off but the framebuffer must st=
ill be
> +  accessible. On resume the screen can be turned back on.
> +
> +EARLY_SUSPEND_LEVEL_STOP_DRAWING:
> +  On suspend this level notifies user-space that it should stop accessin=
g the =

> +  framebuffer and it waits for it to complete. On resume it notifies use=
r-space =

> +  that it should resume screen access.
> +  Two methods are provided, console switch or a sysfs interface.
> +
> +EARLY_SUSPEND_LEVEL_DISABLE_FB:
> +  Turn off the framebuffer on suspend and back on on resume.
> +

This set seems like a pretty poor example. There's already a userspace =

interface for controlling the LCD via sysfs, and extending this to power =

down the associated framebuffer hardware would be trivial.

> +EARLY_SUSPEND_LEVEL_STOP_INPUT:
> +  On suspend turn off input devices that are not capable of wakeup or wh=
ere
> +  wakeup is disabled. On resume turn the same devices back on.

Why not just ask your userspace input consumer to release the device and =

then have the driver automatically power itself down when its use count =

hits zero?

-- =

Matthew Garrett | mjg59@srcf.ucam.org
