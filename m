From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/6] Suspend: Fix compilation warning for
	CONFIG_SUSPEND unset
Date: Tue, 27 Nov 2007 01:12:33 +0100
Message-ID: <20071127001233.GA9759__6172.37097253582$1196123998$gmane$org@elf.ucw.cz>
References: <200711270025.08128.rjw@sisk.pl> <200711270027.24230.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200711270027.24230.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue 2007-11-27 00:27:23, Rafael J. Wysocki wrote:
> Suspend: Make debug facility depend on CONFIG_SUSPEND
> 
> Make the new suspend debug facility code depend on CONFIG_SUSPEND,
> as appropriate, to remove the compiler warning printed when CONFIG_PM is set
> and CONFIG_SUSPEND is not set.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
