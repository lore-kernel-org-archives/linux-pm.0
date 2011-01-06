From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend hangs at platform phase [was: mmotm
	2010-12-23-16-58 uploaded]
Date: Thu, 6 Jan 2011 16:45:28 +0100
Message-ID: <201101061645.28968.rjw__24123.037493746$1294329731$gmane$org@sisk.pl>
References: <201012240132.oBO1W8Ub022207@imap1.linux-foundation.org>
	<201101060028.43342.rjw@sisk.pl> <4D258A55.2040003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D258A55.2040003@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, mm-commits@vger.kernel.org, steiner@sgi.com, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, akpm@linux-foundation.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, January 06, 2011, Jiri Slaby wrote:
> On 01/06/2011 12:28 AM, Rafael J. Wysocki wrote:
> > Two more questions:
> > (1) Does the failing machine power off correctly with the kernel that fails to
> >     suspend?
> 
> Poweroff is OK.
> 
> > (2) Is the failing suspend behavior reproducible if you run
> >     "echo disk > /sys/power/state" instead of "pm-suspend" in the platform test?
> 
> Thanks for the hint no_console_suspend with hibernate shows somwthing
> (opposing to suspend). I've sent a patch for the oops which occured due
> to ioremap change.

Can you send a link to the patch, please?

> The ioremap change still needs to be reverted, obviously.

Does it need to be reverted with your patch applied too?

Rafael
