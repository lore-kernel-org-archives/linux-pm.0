From: Bojan Smojver <bojan@rexursive.com>
Subject: Re: [PATCH] PM / Hibernate: Restore old swap signature
 to avoid user space breakage
Date: Mon, 06 Dec 2010 10:36:55 +1100
Message-ID: <1291592215.2866.3.camel@shrek.rexursive.com>
References: <201012052324.30231.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012052324.30231.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Karel Zak <kzak@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <linux@treblig.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2010-12-05 at 23:24 +0100, Rafael J. Wysocki wrote:
> Commit 3624eb0 (PM / Hibernate: Modify signature used to mark swap)
> modified hibernate signature used to mark swap partitions containing
> hibernation images, but that turns out to have caused problems in
> libblkid on recent Ubuntu.  Restore the old signature to avoid those
> problems. 

Don't quite understand this change (sorry, probably just being obtuse).

The signature was changed to make sure older kernels don't handle
compressed images by accident, right? If so, this would seem like a bad
idea, because this is what can actually happen now.

Shouldn't user space learn how to handle both signatures instead?

-- 
Bojan
