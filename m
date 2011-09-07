From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] vt/suspend: cleanup #if defined uglyness and
	fix compile error
Date: Wed, 7 Sep 2011 18:49:43 +0200
Message-ID: <201109071849.43603.arnd__43561.9162432433$1315414448$gmane$org@arndb.de>
References: <201109061404.10301.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201109061404.10301.hartleys@visionengravers.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: len.brown@intel.com, art@ified.ca, gregkh@suse.de, Linux Kernel <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, jslaby@suse.cz, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 06 September 2011, H Hartley Sweeten wrote:
> rder to cleanup
> the #if defined ugliness for the vt suspend support functions. Note that
> CONFIG_VT_CONSOLE is already dependant on CONFIG_VT.
> 
> The function pm_set_vt_switch is actually dependant on CONFIG_VT and not
> CONFIG_PM_SLEEP. This fixes a compile error when CONFIG_PM_SLEEP is
> not set:
> 
> drivers/tty/vt/vt_ioctl.c:1794: error: redefinition of 'pm_set_vt_switch'
> include/linux/suspend.h:17: error: previous definition of 'pm_set_vt_switch' was here
> 
> Also, remove the incorrect path from the comment in console.c.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Arnd Bergmann <arnd@arnd.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Arthur Taylor <art@ified.ca>
> Cc: Jiri Slaby <jslaby@suse.cz>

Acked-by: Arnd Bergmann <arnd@arndb.de>
