From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] PM: really deprecate deprecated user
	ioctls
Date: Wed, 27 Jan 2010 20:48:11 +0100
Message-ID: <20100127194811.GB4626__31806.1324804605$1264621760$gmane$org@elf.ucw.cz>
References: <1264610778-13242-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1264610778-13242-1-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed 2010-01-27 17:46:17, Jiri Slaby wrote:
> They were deprecated and removed from exported headers more than 2
> years ago. Inform users about their removal in the future now.
> 
> (Switch cases needed to be reorderded for an easy fall through.)
> 
> And add an entry to feature-removal-schedule.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Pavel Machek <pavel@ucw.cz>

ACK.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
