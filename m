From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] freezer: use smp barriers
Date: Mon, 25 Apr 2011 10:38:32 +0200
Message-ID: <20110425083832.GA3770__29423.1636486531$1303720780$gmane$org@elf.ucw.cz>
References: <1303716665-27584-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1303716665-27584-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon 2011-04-25 03:31:05, Mike Frysinger wrote:
> The freezer processes are dealing with multiple threads running
> simultaneously, and on a UP system, the memory reads/writes do
> not need barriers to keep things in sync.  These are only needed
> on SMP systems, so use SMP barriers instead.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
