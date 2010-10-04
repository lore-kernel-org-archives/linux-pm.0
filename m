From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 07/23] Hiberation: Fix speed display.
Date: Mon, 4 Oct 2010 19:51:04 +0200
Message-ID: <20101004175104.GA1518__47882.8150815845$1286217246$gmane$org@ucw.cz>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
	<1285566238-10966-8-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1285566238-10966-8-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@tuxonice.net>
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

On Mon 2010-09-27 15:43:42, Nigel Cunningham wrote:
> Correct the situation where, if an error occurs while writing an image,
> the speed display still uses the number of pages that should have been
> written, rather than the number of pages that were written.
> 
> Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>

Ack.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
