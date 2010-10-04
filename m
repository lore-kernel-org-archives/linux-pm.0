From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] PM / Hibernate: Make some boot messages
 look less scary
Date: Mon, 4 Oct 2010 19:58:03 +0200
Message-ID: <20101004175803.GJ1518__49073.580109007$1286217312$gmane$org@ucw.cz>
References: <201009240056.41308.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201009240056.41308.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2010-09-24 00:56:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM / Hibernate: Make some boot messages look less scary
> 
> The hibernate resume code checks if there is an image to resume from
> on every boot and, if the kernel is built with CONFIG_PM_DEBUG set
> and the image is not present, it prints some scary messages
> suggesting there was a boot error of some sort.  Apparently, some
> users are confused by them, so make them look less scary and adjust
> the other hibernate resume debug messages to match them.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Ack.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
