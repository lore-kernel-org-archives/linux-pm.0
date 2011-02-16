From: linux-pm.20.masuefke@spamgourmet.com
Subject: Still having problems with Suspend-To-Ram an Intel Atom
	D525
Date: Wed, 16 Feb 2011 19:50:09 +0100
Message-ID: <4D5C1C61.7000200@rwth-aachen.de>
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
List-Id: linux-pm@vger.kernel.org

Hello,

I still have no success suspending my Intel Atom D525 (with the NM10
chipset) to ram.

Suspend to ram does not work at all, suspend to disk works.

Please see the mailing list thread from 20Dec2011 for a detailed problem 
description:
https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/thread.html#29654
and the screenshots on http://www-users.rwth-aachen.de/martin.suefke/s2ram/

I re-tested now with 2.6.38-rc4 and 2.6.22 (git pulls from Linus 
Torvald's kernel tree) in a desperate attempt to find any working
version, so I could maybe try to pin down the problem by git-bisect.
However, also with 2.6.22 and 2.6.38-rc4 suspend to ram does not work.

The configurations for these kernels were made with 'make oldconfig'
from this configuration:
http://www-users.rwth-aachen.de/martin.suefke/s2ram/Kernel_config_2.6.37-rc6

If anybody has any clue, hint, suggestion or questions regarding the
issue, please drop me a note.

Thank You,
Martin Suefke
