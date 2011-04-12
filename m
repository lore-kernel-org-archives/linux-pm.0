From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RESEND PATCH] PM: add a config that give warnning
 if driver take too long on suspend/resume.
Date: Tue, 12 Apr 2011 12:09:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104121200530.2000-100000@iolanthe.rowland.org>
References: <BANLkTik8bWF8c+BmrzzqOZiWWwujskgs7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTik8bWF8c+BmrzzqOZiWWwujskgs7w@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Jiejing.Zhang " <kzjeef@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-pm@vger.kernel.org

On Tue, 12 Apr 2011, Jiejing.Zhang  wrote:

> Thanks for you reply.
> Yes, you are right, this parameter can print out log of information,
> also can echo 1 > /sys/module/kernel/parameters/initcall_debug to enable this.
> but the output is really not good to read, and hard to filter out
> what's is time consume device:

...

> Do you think I add a time threshold and a better readable name in
> initcall_debug is a good idea ?
> I've tried add some threshold into this code, but I don't know where
> to put the threshold parameter.
> The initcall_debug is a module parameter of kernel/main.c, I don't
> think add some threshold here is a good idea.
> 
> Also, I think the mission of my patch, and initcall_debug is
> different, my patch is aim to filter out some really time consuming
> device, but initcall_debug seems to figure out where kernel died when
> doing init/suspend/resume operation. It's hard to merge two together.
> 
> my patch put this option under PM_DEBUG, and the threshold file under
> /sys/power/device_suspend_time_threshold
> 
> the output is like this:
> 
> bash-3.2# echo 500 > /sys/power/device_suspend_time_threshold
> bash-3.2# request_suspend_state: mem (0->3) at 73269332502 (1970-01-02
> 03:12:18.107533376 UTC)
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.02 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
> PM: device usb:2-1.1 suspend too slow, it takes          15.758 msecs
> PM: device usb:2-1.4.1 suspend too slow, it takes        21.619 msecs
> PM: device usb:2-1.4 suspend too slow, it takes          18.569 msecs
> PM: device platform:soc-audio.2 suspend too slow, it takes       1216.710 msecs
> da9052_tsi_suspend: called
> PM: device platform:da9052-tsi suspend too slow, it takes        2.538 msecs
> PM: device usb:2-1 suspend too slow, it takes    22.371 msecs
> PM: suspend of devices complete after 1252.998 msecs
> suspend wp cpu=400000000
> PM: late suspend of devices complete after 0.775 msecs
> 
> --- [ log end ] ----
> 
> If you want to figure out which device suspend too slow, this patch
> will do better.

It's okay with me.  Presenting the information in an easy-to-read form 
is fine.  I just wanted to point out that the information is already 
available.

BTW, there are several spelling errors in the Kconfig help text in your 
patch.  You should fix them before submitting the patch again.

Alan Stern
