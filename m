From: Pavel Machek <pavel@ucw.cz>
Subject: Re: better oopsing when frozen
Date: Fri, 29 Jul 2011 21:54:30 +0200
Message-ID: <20110729195430.GB1720__41467.5561398782$1311969542$gmane$org@ucw.cz>
References: <201107251043.19932.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201107251043.19932.oneukum@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon 2011-07-25 10:43:19, Oliver Neukum wrote:
> Hi Rafael,
> 
> I had a problem with the kernel stopping the machine forever because I got an
> oops while tasks were frozen. It seems to me that we should thaw when this
> happens. How about this approach?

Danger, Will Robinson. You must not write to the filesystems after
hibernation started. By thawing, you may do just that.

It should be safe to thaw as long as final suspend signature is not
on disk and will not be written there.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
