From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 2.6.25-rc6 2/7] acpi_pm_device_sleep_state()
	cleanup
Date: Mon, 24 Mar 2008 17:30:46 +0100
Message-ID: <20080324163045.GB4206__5398.12526335499$1206456466$gmane$org@ucw.cz>
References: <200803201408.33466.david-b@pacbell.net>
	<200803201410.57801.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803201410.57801.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu 2008-03-20 14:10:57, David Brownell wrote:
> Get rid of a superfluous acpi_pm_device_sleep_state() parameter.  The
> only legitimate value of that parameter must be derived from the first
> parameter, which is what all the callers already do.  (However, this
> does not address the fact that ACPI still doesn't set up those flags.)
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

ACK, FWIW.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
