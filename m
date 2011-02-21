From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/3] xen: Use PM/Hibernate events for
 save/restore/chkpt
Date: Mon, 21 Feb 2011 11:40:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102211135170.15325-100000__15183.933862909$1298306558$gmane$org@netrider.rowland.org>
References: <1298282702.16356.7578.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1298282702.16356.7578.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ian Campbell <Ian.Campbell@eu.citrix.com>
Cc: Shriram Rajagopalan <rshriram@cs.ubc.ca>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 21 Feb 2011, Ian Campbell wrote:

> On Sun, 2011-02-20 at 07:49 +0000, Pavel Machek wrote:
> > On Sat 2011-02-19 15:12:35, Shriram Rajagopalan wrote:
> > > The current implementation of xen guest save/restore/checkpoint functionality
> > > uses PM_SUSPEND and PM_RESUME events. This is not optimal when taking
> > > checkpoints of a virtual machine (where the suspend hypercall returns
> > > non-zero, requiring the devices and xenbus to just pickup from where they left
> > > off instead of a complete teardown/reconnect to backend). 
> > > 
> > > The following set of patches modify this implementation to use Hibernate style
> > > control flow (freeze/restore for save/restore and freeze/thaw for checkpoint,
> > > which is merely a cancelled save akin to failed swsusp() ).
> > > 
> > > These patches are against Ian Campbell's PVHVM tree at
> > > git://xenbits.xen.org/people/ianc/linux-2.6.git for-stefano/pvhvm
> > > 
> > > at commit 8a8d1bc753c4e2dda5f2890292d60c67d6ebb573
> > > kernel version: 2.6.38-rc4
> > 
> > Series looks ok to me...
> 
> Thanks Pavel, may we take that as an Acked-by?
> 
> For my part the Xen side is:
> Acked-by: Ian Campbell <ian.campbell@citrix.com>

There's one part of this which could be troublesome.  The new code 
generates FREEZE, THAW, and RESTORE events even in kernels where 
CONFIG_HIBERNATION isn't set.  In such kernels, drivers are not 
obliged to handle these events correctly.

Shouldn't the CONFIG_XEN_SAVE_RESTORE option select CONFIG_HIBERNATION?
In which case the #ifdef lines in pm_op() wouldn't need to be changed.

Alan Stern
