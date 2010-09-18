From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH v2] power: introduce library for
	device-specific OPPs
Date: Fri, 17 Sep 2010 22:38:49 -0700
Message-ID: <20100918053849.GA19709__6024.32139353386$1284788412$gmane$org@suse.de>
References: <1284787459-25643-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1284787459-25643-1-git-send-email-nm@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nishanth Menon <nm@ti.com>
Cc: Len Brown <len.brown@intel.com>, Phil <ext-phil.2.carmody@nokia.com>, Lnus Walleij <linus.walleij@stericsson.com>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Sep 18, 2010 at 12:24:19AM -0500, Nishanth Menon wrote:
> This is hence introduced under lib allowing all architectures to
> selectively enable the feature based on their capabilities.

<snip>

>  Documentation/power/00-INDEX |    2 +
>  Documentation/power/opp.txt  |  326 ++++++++++++++++++++++++++
>  drivers/base/power/Makefile  |    1 +
>  drivers/base/power/opp.c     |  527 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/opp.h          |  126 ++++++++++
>  kernel/power/Kconfig         |   14 ++
>  6 files changed, 996 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/power/opp.txt
>  create mode 100644 drivers/base/power/opp.c
>  create mode 100644 include/linux/opp.h

That doesn't look like the files are under lib/

Did you forget to move them, or do you need to update the changelog
message?

thanks,

greg k-h
