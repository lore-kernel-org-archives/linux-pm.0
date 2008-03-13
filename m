From: Thomas Renninger <trenn@suse.de>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.25-rc5
Date: Thu, 13 Mar 2008 14:25:37 +0100
Message-ID: <1205414737.29877.366.camel__43845.045581884$1205414873$gmane$org@queen.suse.de>
References: <200803130214.36861.lenb@kernel.org>
	<20080312234516.bb079cc5.akpm@linux-foundation.org>
	<1205391105.2240.68.camel@acpi-hp-zz.sh.intel.com>
	<20080313125541.GA7365@v2.random>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080313125541.GA7365@v2.random>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrea Arcangeli <andrea@qumranet.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2008-03-13 at 13:55 +0100, Andrea Arcangeli wrote:
> On Thu, Mar 13, 2008 at 02:51:45PM +0800, Zhang, Rui wrote:
> > Well, the patch looks good, this may be caused by a BIOS problem.
> > anyway, I wish to get the response from Andrea so that I can do some
> > investigation ASAP.
> 
> Here attached again. syslog isn't available because by the time it
> crash netconsole isn't up yet, but I try to compile it as module and
> see if it crashes by loading it manually later after netconsole
> started. (you didn't ask for syslog until today)
> 
> Hardware is ASUS M2A-VM ACPI BIOS Revision 1604.
This is pretty sure fixed in 2.6.25-rc5.
 
It's probably this:
https://bugzilla.novell.com/show_bug.cgi?id=350017
It's fixed by:
c8d16e27a3601d1cbcdfe657eb4ff5e762019e8d
-> fixing the memory corruption
b6a163875935ce8e8e85901a7f2b68f7a314d914
-> check the pointer which is now not corrupted anymore, but NULL.

Hmm, the commits are only in Len's tree and have not hit
Linus' tree yet.

   Thomas

> email message attachment
> > -------- Forwarded Message --------
> > From: Andrea Arcangeli <andrea@qumranet.com>
> > To: Zhang, Rui <rui.zhang@intel.com>
> > Cc: Thomas, Sujith <sujith.thomas@intel.com>, Brown, Len
> > <len.brown@intel.com>
> > Subject: Re: thermal.c crash at boot
> > Date: Thu, 21 Feb 2008 15:55:56 +0100
> > 
> > On Mon, Feb 18, 2008 at 09:15:13AM +0800, Zhang, Rui wrote:
> > > Please attach the acpidump output.
> > 
> > attached.
> > 
