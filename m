From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Resume hangs [was: mmotm 2010-12-02-16-34 uploaded]
Date: Wed, 23 Feb 2011 10:59:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102231058240.2233-100000__19261.9725167335$1298477797$gmane$org@iolanthe.rowland.org>
References: <4D64F678.10309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D64F678.10309@gmail.com>
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
Cc: "Rafael J. Wysocki" <rjw@suse.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 23 Feb 2011, Jiri Slaby wrote:

> On 02/22/2011 04:36 PM, Alan Stern wrote:
> > By the way, are you booting with no_console_suspend?  And do you do 
> > "echo 8 >/proc/sys/kernel/printk" (or equivalently, Alt-SysRq-8) before 
> > suspending?
> 
> Nope.

If you do, it's possible you might get some useful information on the 
screen the next time one of these hangs occurs.

Alan Stern
