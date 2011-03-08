From: "Rafael J. Wysocki" <rjw@suse.com>
Subject: Re: Resume hangs [was: mmotm 2010-12-02-16-34 uploaded]
Date: Tue, 8 Mar 2011 20:25:38 +0100
Message-ID: <201103082025.38559.rjw__12524.9143726707$1299612452$gmane$org@suse.com>
References: <Pine.LNX.4.44L0.1102221029100.1968-100000@iolanthe.rowland.org>
	<4D75F34B.5010409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D75F34B.5010409@gmail.com>
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
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 08, 2011, Jiri Slaby wrote:
> On 02/22/2011 04:36 PM, Alan Stern wrote:
> > By the way, are you booting with no_console_suspend?  And do you do 
> > "echo 8 >/proc/sys/kernel/printk" (or equivalently, Alt-SysRq-8) before 
> > suspending?
> 
> Unfortunately there are no messages at all.
> 
> Rafael, this is a Factory with intel gfx (modesetting). Do pm-utils
> switch a console in such case? And if yes, to which one?

pm-utils don't, but s2ram does, I'm not sure from the top of my head to
which one, though.

If you use a KMS driver (I get you do), please just "chmod a-x /usr/sbin/s2ram".

Thanks,
Rafael
