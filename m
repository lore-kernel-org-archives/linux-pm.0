From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: [PATCH 0/5] Preallocate swap + minor fix.
Date: Wed, 26 May 2010 17:09:45 +1000
Message-ID: <4BFCC939.1000901__32615.8431744718$1274857889$gmane$org@crca.org.au>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi all.

In current in-kernel hibernation code, swap is allocated as the image is 
being written.

The first four patches in this series rework things so that all swap 
that will be used is allocated prior to any data being written to disk.
The fourth patch might look like too much for one patch, but it's 
necessary to not break bisecting.

The fifth patch fixes a minor error in displaying the speed at which I/O 
occurred.

This is the beginning of what I hope will be a long series of sets of 
patches, first working towards adding support for properly asynchronous 
I/O (not batching, as is currently done), then compression, multiple 
swap devices and more. In short, this is the beginning of work on 
merging TuxOnIce functionality a bit at a time.

The work is coming now because I recently finished my previous job, so 
I'm seeking to get some of those jobs I've been wanting to do for a long 
time out of the way. If anyone wants to employ me to do this work, I 
wouldn't say no! :)

Please excuse me if there are wrapping issues with the patches - I'm 
using Thunderbird, and haven't sent a patch series for quite a while, so 
don't remember the fancy git mailer way (will have to look it up).

Rafael, these and future patches will be available at:

git://git.kernel.org/pub/scm/linux/kernel/git/nigelc/tuxonice-head.git#for-rafael

Regards,

Nigel
