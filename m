From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: Oops while going into hibernate
Date: Thu, 13 Jan 2011 12:49:53 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1101131248510.1899__47811.3502882936$1294919442$gmane$org@localhost6.localdomain6>
References: <alpine.LFD.2.02.1101121443230.1900@localhost6.localdomain6>
	<20110112162655.GA13496@thunk.org>
	<alpine.LFD.2.02.1101121755400.2011@localhost6.localdomain6>
	<20110112172646.GB13496@thunk.org>
	<alpine.LFD.2.02.1101121934060.2011@localhost6.localdomain6>
	<A01161D0-D08F-4522-A546-90057B2E1F2A@mit.edu>
	<1294917140.2781.5.camel@shrek.rexursive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1294917140.2781.5.camel@shrek.rexursive.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bojan Smojver <bojan@rexursive.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, "linux-ext4@vger.kernel.org development" <linux-ext4@vger.kernel.org>, Theodore Tso <tytso@mit.edu>, LKML Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, 13 Jan 2011, Bojan Smojver wrote:
> On Wed, 2011-01-12 at 19:44 -0500, Theodore Tso wrote:
> > It looks like somehow the pages were left marked as dirty, so the
> > writeback daemons attempted writing back a page to an inode which was
> > never opened read/write (and in fact as a text page
> > for /usr/bin/killall, was mapped read/only).
> 
> Just out of curiosity, when this happens, is LZO compression being used
> with hibernation (default in 2.6.37) or has it been disabled?
LZO is being used - should I try with hibernate=nocompress?

Regards,
Sebastian
