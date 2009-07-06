From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Patch 0/2: Add compression support to swsusp.
Date: Mon, 06 Jul 2009 15:29:09 +1000
Message-ID: <4A518BA5.3060900__34387.6478531913$1246859284$gmane$org@crca.org.au>
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
To: Rafael Wysocki <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, TuxOnIce-devel <tuxonice-devel@lists.tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi Rafael.

Sorry that I've been so slow to send anything after our recent
discussion about merging TuxOnIce. Too much on my plate, as usual.

Here are a couple of patches for your consideration. The first one adds
support for combining partial pages together when writing the image
proper, and breaking them apart again when reading the image back. The
second patch builds on the first one, adding support for compressing the
data that is written in an image.

The net effect should be a good boost in the speed of writing the image,
but a slowdown (for now) in the speed of reading the image, because we
can't decompress data that hasn't been read yet, and so currently need
to do the reads synchronously. I'm a bit under the weather at the
moment, and am going to go to bed now. I hope, though, to get another
patch or two prepared reasonably quickly, which will implement an
algorithm for doing readahead.

Regards,

Nigel
