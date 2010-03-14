From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM_QOS updates for 2.6.34-rc1
Date: Sun, 14 Mar 2010 21:08:07 +0100
Message-ID: <201003142108.07164.rjw__33940.2383346625$1268597187$gmane$org@sisk.pl>
References: <20100314003425.GA17812@mgross-acer>
	<20100314062637.GA12064@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100314062637.GA12064@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>, Mark Gross <mgross@linux.intel.com>
Cc: dwalker@codeaurora.org, tiwai@suse.de, bruce.w.allan@intel.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 14 March 2010, Pavel Machek wrote:
> On Sat 2010-03-13 16:34:25, 640E9920 wrote:
> > The following patch series implements to following:
> > 1) pm_qos now uses a handle based implementation.  No more string
> > compares while walking lists.
> > 2) renames the exports to using more accurate names.
> > 3) updates kernel clients of pm_qos per this change
> > 4) added ascii interface to pmqos recognizing strings formatted in 10
> > charactor format "0x12345678"
> > 5) added new pm_qos class, "system_bus_throughput"
> > 
> > I would like to see this series make it into 2.6.34 if its not too late. 
> 
> I believe it is... -rc1 is past us.

It definitely is.

> Also... the way the patches are structured... that will break bisect, no?

Not only that.  Some changelogs would be heartily welcome.  In short, what
change the particular patch is going to make and why it's useful.

Rafael
