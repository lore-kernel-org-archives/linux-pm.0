From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [update] Re: [RFC][PATCH] PM / PCI: Update PCI power
 management documentation
Date: Tue, 18 May 2010 15:05:13 -0700
Message-ID: <20100518150513.050bb794__33061.9673048661$1274220501$gmane$org@virtuousgeek.org>
References: <201005162149.31770.rjw@sisk.pl> <4BF0B1C5.4060601@oracle.com>
	<201005180023.24885.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005180023.24885.rjw@sisk.pl>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Linux PCI <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 18 May 2010 00:23:24 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Monday 17 May 2010, Randy Dunlap wrote:
> > On 05/16/10 12:49, Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > I've just finished rewriting the PCI PM documentation.  I hope I didn't forget
> > > of anything important, so please let me know if I did.
> > > 
> > > Generally, please let me know what you think.
> > 
> > Hi,
> > 
> > It reads pretty well IMO.
> > 
> > I have corrected several typos etc.
> > I have also noted a need for explaining *why* something is being done,
> > not just what is being done.
> 
> Thanks a lot for the very useful comments.  I did my best to address them all
> and the modified (and hopefully improved patch) is appended.
> 
> > There may be a few other places where some justification is needed
> > (i.e., would be helpful).
> 
> Well, in fact it is quite difficult to me to identify places where such a
> justification would be useful, because I know how all of this works. :-)
> Fortunately, the justification is usually given in the other two documents this
> one refers to.
> 

Applied, thanks guys.

-- 
Jesse Barnes, Intel Open Source Technology Center
