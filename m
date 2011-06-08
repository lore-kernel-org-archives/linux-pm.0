From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/1] [RFC] include storage keys in hibernation
	image
Date: Wed, 08 Jun 2011 09:45:23 +0200
Message-ID: <20110608074523.211912903__29143.7075393789$1307519588$gmane$org@de.ibm.com>
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
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jiri
List-Id: linux-pm@vger.kernel.org

Greetings,

we have discovered a shortcoming of the s390 support for supend to disk.
The problem is that we currently do not save and restore the storage
keys - the one additional byte associated with each 4K page, a unique
property of s390. The resume from disk will read the hibernation image
from disk and restore the original pages. The I/O or the memory move for
safe pages will set the referenced and the dirty bit in the storage key
for every restored page. Without a reset to the state before the
hibernation cycle the pages will appear to be dirty which causes
problems for e.g. read-only filesystems. 

The solution implemented with this patch saves the storage key in the
upper 8 bits of the page-frame-numbers. The code adds 6 new function
in kernel/power/snapshot.c which are conditionally defined with
CONFIG_S390. The call sites of these functions are scattered in the
snapshot code which makes it hard to find a better abstraction for the
interface. The comments should make clear what the functions do.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
