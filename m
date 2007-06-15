From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [2/2] 2.6.22-rc4: known regressions v3
Date: Fri, 15 Jun 2007 16:26:09 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706151624340.14121__8758.92765257067$1181950227$gmane$org@woody.linux-foundation.org>
References: <46704923.1010009@googlemail.com> <46704C44.8020602@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46704C44.8020602@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: discuss@x86-64.org, Mikael Pettersson <mikpe@it.uu.se>, Dan Aloni <da-x@monatomic.org>, Greg Kroah-Hartman <gregkh@suse.de>, Netdev <netdev@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net, Jay Vosburgh <fubar@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Alex Riesen <raa.lkml@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Stephen Hemminger <shemminger@linux-foundation.org>, David Miller <davem@davemloft.net>, Ioan Ionita <opslynx@gmail.com>, Chad Tindel <ctindel@users.sourceforge.net>
List-Id: linux-pm@vger.kernel.org



On Wed, 13 Jun 2007, Michal Piotrowski wrote:
> 
> Subject    : hibernate(?) fails totally - regression
> References : http://lkml.org/lkml/2007/6/1/401
> Submitter  : David Greaves <david@dgreaves.com>
> Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
> Caused-By  : Tejun Heo <htejun@gmail.com>
>             commit 9666f4009c22f6520ac3fb8a19c9e32ab973e828
> Status     : problem is being debugged

Ahh. This is fixed (fix by Tejun, confirmed by David), and the fix has 
been merged. It's commit bc90ba093a, in case anybody cares.

		Linus
