From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: Fix sysfs interface
Date: Mon, 14 May 2007 11:18:05 +0200
Message-ID: <20070514091805.GH11735@elf.ucw.cz>
References: <200705111158.44913.rjw@sisk.pl> <200705111213.30715.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705111213.30715.rjw@sisk.pl>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Peter Moulder <Peter.Moulder@infotech.monash.edu.au>
List-Id: linux-pm@vger.kernel.org

On Fri 2007-05-11 12:13:30, Rafael J. Wysocki wrote:
> Sorry, there's a mistake in the previous version.  Corrected patch follows.
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The sysfs files /sys/power/disk and /sys/power/state do not work as documented,
> since they allow the user to write only a few initial characters of the
> input string to trigger the option (eg. 'echo pl > /sys/power/disk' activates
> the platform mode of hibernation).  Fix it.
> 
> Special thanks to Peter Moulder <Peter.Moulder@infotech.monash.edu.au> for
> pointing out the problem.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
