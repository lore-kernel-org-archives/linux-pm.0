From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Fri, 21 Aug 2009 10:33:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908211032330.2912-100000__2391.57989058203$1250865482$gmane$org@iolanthe.rowland.org>
References: <20090821064630.GB16694@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090821064630.GB16694@sli10-desk.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 21 Aug 2009, Shaohua Li wrote:

> > > I'm still not clear on this.  Does the non-standard wakeup register
> > > have to be set and cleared by the suspend and resume routines in
> > > uhci-hcd, or will it be handled by other code?
> > 
> > I'm not sure if anyone can answer this 100% accurately without doing any
> > testing.
> As far as I know, when the pci trys to enable pme, we will call corresponding
> ACPI methods. In that methods, the non-starndard wakeup registers will be
> set/clear. The issue is we must relay on correct BIOS.

If the BIOS doesn't know about the non-standard register then it won't 
set the wakeup bits.  Therefore the fact that it won't clear them 
doesn't matter.

Alan Stern
