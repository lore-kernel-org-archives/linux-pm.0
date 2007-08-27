From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 3/3] PM: Improve handling of ACPI system
	state indicator (rev. 2)
Date: Mon, 27 Aug 2007 10:27:35 +0200
Message-ID: <20070827082735.GG2060@elf.ucw.cz>
References: <200708270149.52585.rjw@sisk.pl> <200708270155.30027.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708270155.30027.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> Introduce a separate ACPI function for setting the system status indicator and
> use it in the right places in the suspend and hibernation related ACPI callbacks
> instead of setting the system status indicator implicitly in
> acpi_enter_sleep_state_prep() and acpi_leave_sleep_state().
> 
> This allows us to avoid turning off the sleep state indicator during hibernation
> on Thinkpads (currently, it is turned off before saving the image, because we
> need to call finish() before unfreezing devices).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
