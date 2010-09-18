From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] power: introduce library for
	device-specific OPPs
Date: Sat, 18 Sep 2010 00:42:17 -0500
Message-ID: <4C945139.20602__43571.0049853244$1284788709$gmane$org@ti.com>
References: <1284787459-25643-1-git-send-email-nm@ti.com>
	<20100918053849.GA19709@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100918053849.GA19709@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: Len Brown <len.brown@intel.com>, Phil <ext-phil.2.carmody@nokia.com>, Lnus Walleij <linus.walleij@stericsson.com>, lkml <linux-kernel@vger.kernel.org>, Matthew@smtp1.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

Greg KH had written, on 09/18/2010 12:38 AM, the following:
> On Sat, Sep 18, 2010 at 12:24:19AM -0500, Nishanth Menon wrote:
>> This is hence introduced under lib allowing all architectures to
>> selectively enable the feature based on their capabilities.
> 
> <snip>
> 
>>  Documentation/power/00-INDEX |    2 +
>>  Documentation/power/opp.txt  |  326 ++++++++++++++++++++++++++
>>  drivers/base/power/Makefile  |    1 +
>>  drivers/base/power/opp.c     |  527 ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/opp.h          |  126 ++++++++++
>>  kernel/power/Kconfig         |   14 ++
>>  6 files changed, 996 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/power/opp.txt
>>  create mode 100644 drivers/base/power/opp.c
>>  create mode 100644 include/linux/opp.h
> 
> That doesn't look like the files are under lib/
> 
> Did you forget to move them, or do you need to update the changelog
> message?

Aww... and I thought I fixed them all.. the commit message is wrong.
we had an alignment earlier today to move it from lib to 
drivers/base/power [1] :(

Thanks for catching it. Will fix it in rev 3 after collating any further 
comments as well.

[1] http://marc.info/?l=linux-arm-kernel&m=128476405731191&w=2
-- 
Regards,
Nishanth Menon
