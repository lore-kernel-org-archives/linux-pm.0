From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [RFC] TuxOnIce
Date: Thu,  7 May 2009 00:38:56 +1000
Message-ID: <1241620755-22133-1-git-send-email-nigel__48742.3420338475$1241621150$gmane$org@tuxonice.net>
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
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

I'd like to submit TuxOnIce for review, with a view to seeking to get it
merged, perhaps in 2.6.31 or .32 (depending upon what needs work before
it can be merged) and the willingness of those who matter.

To briefly summarise the advantages to merging TuxOnIce:

- Support for multiple swap devices
- Support for non-swap (an ordinary file can be used)
- Uses cryptoapi (LZO support, more than 2x speed of uncompressed data!)
- Asynchronous I/O, readahead, multithreaded. Get the maximum throughput
  possible with your hardware.
- Userspace user interface that lets you abort hibernating and abort
  resuming, get nice progress display etc.
- 8 years of testing and improvement.
- Full image of memory (LRU pages that don't need to be atomically
  copied are saved prior to the atomic copy, then used as the
  destination of the atomic copy).
- Support for resuming a different image after writing an image - makes
  powering down a UPS after writing an image doable.
- Simple to set up (works without any userspace binaries, uses existing
  resume= and noresume commandline parameters).

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
