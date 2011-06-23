From: Brad Campbell <brad@wasp.net.au>
Subject: Linux 3.0-rc4 intermittent failure to resume
Date: Thu, 23 Jun 2011 08:21:07 +0800
Message-ID: <4E0286F3.6030003@wasp.net.au>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

G'day all,

I've recently moved from tuxonice to mainline uswsusp. I'm getting intermittent failure to resume 
problems. No message in dmesg that I can find, it just boots clean. Is there something I can do to 
get some debug info on this? It's really, really annoying.

About 75% of the time it works perfectly, and I can find no rhyme or reason to why it suddenly just 
decides to ignore the saved state.

32 bit userspace with a statically linked 64 bit s2disk, s2both & resume. 64 bit kernel.

Brad
-- 
Dolphins are so intelligent that within a few weeks they can
train Americans to stand at the edge of the pool and throw them
fish.
