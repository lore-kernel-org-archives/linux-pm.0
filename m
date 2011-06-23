From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 3.0-rc4 intermittent failure to resume
Date: Thu, 23 Jun 2011 14:02:59 +0200
Message-ID: <201106231402.59491.rjw@sisk.pl>
References: <4E0286F3.6030003@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4E0286F3.6030003@wasp.net.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, June 23, 2011, Brad Campbell wrote:
> G'day all,
> 
> I've recently moved from tuxonice to mainline uswsusp. I'm getting intermittent failure to resume 
> problems. No message in dmesg that I can find, it just boots clean. Is there something I can do to 
> get some debug info on this? It's really, really annoying.
> 
> About 75% of the time it works perfectly, and I can find no rhyme or reason to why it suddenly just 
> decides to ignore the saved state.
> 
> 32 bit userspace with a statically linked 64 bit s2disk, s2both & resume. 64 bit kernel.

Do you use the i915 driver?

Rafael
