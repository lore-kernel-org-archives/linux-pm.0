From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 03/23] Hibernation: Swap iteration functions.
Date: Mon, 4 Oct 2010 19:54:58 +0200
Message-ID: <20101004175457.GC1518__8319.17353575609$1286217276$gmane$org@ucw.cz>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
	<1285566238-10966-4-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1285566238-10966-4-git-send-email-nigel@tuxonice.net>
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

On Mon 2010-09-27 15:43:38, Nigel Cunningham wrote:
> Add the data structure 'storage_position' and routines that allow
> a caller to iterate over swap in sector order. Note that calling
> reset_storage_pos only resets the position. next_swapdev_block
> must also be called to get the address of the first (and subsequent
> sectors).
> 
> Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>

Merge this with 8/23? AFAICT, this creates unused functions here only
to move them in later patch.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
