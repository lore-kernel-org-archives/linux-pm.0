From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Wed, 27 May 2009 10:06:03 +1000
Message-ID: <1243382763.13930.112.camel__11613.6343720884$1243382899$gmane$org@nigel-laptop>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905260002.55500.rjw@sisk.pl>
	<1243297196.16743.137.camel@nigel-laptop>
	<200905270037.43991.rjw@sisk.pl>
Reply-To: nigel@tuxonice.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905270037.43991.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi.

On Wed, 2009-05-27 at 00:37 +0200, Rafael J. Wysocki wrote:
> Well, first, our multithreaded I/O is probably not the same thing as you think
> of, because we have an option to use multiple user space threads that process
> image data (compress, encrypt and feed them to the kernel).

Well, I'm using multiple kernel threads, so it's probably not that
different, but okay.

> Now, we found that it only improves performance substantially if both
> compression and encryption are used.
> 
> As far as the numbers are concerned, I don't have the raw hdparm numbers
> handy, but image writing speed with compression alone usually is in the
> 60 MB/s - 100 MB/s range, sometimes more than 100 MB/s, but that really depends
> on the system.  If encryption is added, it drops substantially and multiple
> threads allow us to restore the previous performance (not 100%, but close
> enough to be worth the additional complexity IMO).

Okay. That's still a significant improvement over 20 or 30 MB/s. It
depends, of course, also on the compression ratio that's achieved.

> Still, one should always take the total length of hibernate-resume cycle into
> accout and the image writing/reading time need not be the greatest part of it.

Yes, the total time is what matters. I'm focussing on the I/O speed
because - especially with larger images - it tends to be the biggest
portion.

Regards,

Nigel
