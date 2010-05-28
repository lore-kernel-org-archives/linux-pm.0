From: nigel@tuxonice.net
Subject: Nigel's current for-rafael queue
Date: Fri, 28 May 2010 21:14:49 +1000
Message-ID: <1275045299-25890-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

I've done some more work today. Here's an updated copy of the patches
in my queue. As you'll see, I'm focussing on the low level i/o. These
patches split out the more generic bio functions to block_io.c, leaving
swap.c with just the swap specific functions (and, at the moment, the
highlevel i/o routines). In doing this, I'm setting up a foundation
for getting rid of the swap_map pages (I'll instead store extents in
the image header), and through that for doing fully asynchronous I/O,
which should give some speed increase. The changes also lay the groundwork
for support for multiple swap devices and non-swap at a later stage.

Regards,

Nigel
