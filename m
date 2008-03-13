From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] PM: Handle device registrations
	during	suspend/resume
Date: Thu, 13 Mar 2008 09:37:13 +0100
Message-ID: <20080313083713.GA20299@elf.ucw.cz>
References: <200803120055.25885.rjw@sisk.pl> <200803120057.23101.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803120057.23101.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2008-03-12 00:57:22, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Modify the PM core to protect its data structures, specifically the
> dpm_active list, from being corrupted if a child of the currently
> suspending device is registered concurrently with its ->suspend()
> callback.  In that case, since the new device (the child) is added
> to dpm_active after its parent, the PM core will attempt to
> suspend it after the parent, which is wrong.
> 
> Introduce a new member of struct dev_pm_info, called 'sleeping',
> and use it to check if the parent of the device being added to
> dpm_active has been suspended, in which case the device registration
> fails.  Also, use 'sleeping' for checking if the ordering of devices
> on dpm_active is correct.
> 
> Introduce variable 'all_sleeping' that will be set to 'true' once all
> devices have been suspended and make new device registrations fail
> until 'all_sleeping' is reset to 'false', in order to avoid having
> unsuspended devices around while the system is going into a sleep state.
> 
> Remove pm_sleep_rwsem which is not necessary any more.
> 
> Special thanks to Alan Stern for discussions and suggestions that
> lead to the creation of this patch.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
