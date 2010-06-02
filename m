From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Nigel's current for-rafael queue
Date: Wed,  2 Jun 2010 22:18:59 +1000
Message-ID: <1275481160-31150-1-git-send-email-nigel__46191.2750536159$1275481246$gmane$org@tuxonice.net>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi all.

Here is my current patch queue.

Taken together, the patches implement the separation of low level
block i/o into a separate file, switch from using swap_map_pages
to extents stores prior to the 'header' page and implement fully
asynchronous (rather than batched I/O). I have only run it under
VMware so far, but would estimate a doubling in speed due to the
async i/o.

Looking at Jiri's patches, there is definitely some overlap, but
more in terms of lines in the code than direction of effort (with
the exception of separating swap out). He has covered areas for
improvement that I was going to do, just not yet.

Jiri, unless you object, I'm going to seek to apply your patches
on top of what I've done. Does that sound okay?

Nigel
