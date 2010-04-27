From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Invalid opcode on resume from STR on Asus P4P800-VM
Date: Tue, 27 Apr 2010 14:23:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004271422170.1850-100000__45999.4914745495$1272394674$gmane$org@iolanthe.rowland.org>
References: <201004271205.17369.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004271205.17369.linux@rainbow-software.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Kernel development list <linux-kernel@vger.kernel.org>, Robert Hancock <hancockrwd@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 27 Apr 2010, Ondrej Zary wrote:

> > It looks like idle=nomwait should be the workaround with the least
> > impact at the moment..
> 
> It does not work for me.

Not surpisingly, since mwait_usable() ignores the idle_nomwait flag.  
Maybe that's a bug and should be fixed -- I don't know.

Alan Stern
