From: Daniel Walker <dwalker@codeaurora.org>
Subject: Re: [PATCH] PM_QOS updates for 2.6.34-rc1
Date: Fri, 19 Mar 2010 12:52:06 -0700
Message-ID: <1269028326.8741.9.camel__28692.2701787718$1269030687$gmane$org@c-dwalke-linux.qualcomm.com>
References: <20100314003425.GA17812@mgross-acer>
	<20100314062637.GA12064@elf.ucw.cz>
	<20100319143055.GA6124@linux.intel.com>
	<201003192049.34665.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003192049.34665.rjw@sisk.pl>
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
Cc: 640E9920 <640e9920@gmail.com>, tiwai@suse.de, bruce.w.allan@intel.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-03-19 at 20:49 +0100, Rafael J. Wysocki wrote:
> On Friday 19 March 2010, mark gross wrote:
> > On Sun, Mar 14, 2010 at 07:26:37AM +0100, Pavel Machek wrote:
> > > On Sat 2010-03-13 16:34:25, 640E9920 wrote:
> > > > The following patch series implements to following:
> > > > 1) pm_qos now uses a handle based implementation.  No more string
> > > > compares while walking lists.
> > > > 2) renames the exports to using more accurate names.
> > > > 3) updates kernel clients of pm_qos per this change
> > > > 4) added ascii interface to pmqos recognizing strings formatted in 10
> > > > charactor format "0x12345678"
> > > > 5) added new pm_qos class, "system_bus_throughput"
> > > > 
> > > > I would like to see this series make it into 2.6.34 if its not too late. 
> > > 
> > > I believe it is... -rc1 is past us.
> > 
> > crap.  I'll guess I'll redo them for next then.
> > 
> > 
> >  
> > > Also... the way the patches are structured... that will break bisect,
> > > no?
> > 
> > Um not sure, how would you recomend I structure them?
> 
> Generally speaking, the kernel should build and should work correctly after
> applying each consecutive patch in the series.

I think you would need to have the handle based method along side the
old method until all the kernel clients are converted.. Then remove the
old method ..

Daniel
