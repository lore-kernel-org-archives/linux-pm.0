From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 7/7] PM: Asynchronous suspend and resume
	of i8042
Date: Wed, 26 Aug 2009 17:43:53 +0200
Message-ID: <20090826154352.GB1338__38521.2143570699$1251323165$gmane$org@ucw.cz>
References: <200908122218.13975.rjw@sisk.pl> <200908170215.21173.rjw@sisk.pl>
	<200908170221.34885.rjw@sisk.pl>
	<1250579010.5351.69.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1250579010.5351.69.camel@rzhang-dt>
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
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue 2009-08-18 15:03:30, Zhang Rui wrote:
> On Mon, 2009-08-17 at 08:21 +0800, Rafael J. Wysocki wrote:
> > Set async_suspend for i8042.
> > 
> it's the psmouse reset that takes the 0.4 seconds during suspend.
> ???so we should call device_enable_async_suspend for the psmouse serio
> device in psmouse-base.c

Do we really need to reset it during suspend?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
