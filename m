From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Mon, 19 Nov 2007 15:27:14 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711191521170.3129-100000__11343.5672865764$1195504112$gmane$org@iolanthe.rowland.org>
References: <4741EB91.9080000@assembler.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4741EB91.9080000@assembler.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rudolf Marek <r.marek@assembler.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 19 Nov 2007, Rudolf Marek wrote:

> Hello all,
> >>> gives coretemp_cpu_callback -> coretemp_device_remove ->
> >>> platform_device_unregister, so coretemp seems to be what I have and you don't.
> > 
> > Yes.
> > 
> > For the coretemp developers: coretemp_cpu_callback() needs to be more 
> > careful about what it does.  During a system sleep transition (suspend, 
> > hibernate, resume) it isn't possible to register or unregister a 
> > device.  Attempts to register will fail and attempts to unregister will 
> > block until the system sleep is over -- and for this callback that 
> > means hanging.
> 
> Well I wrote the driver. Thanks for the clarification. If I recall correctly I 
> looked how this part should be done from others drivers. Now while checking
> what happened to the file, seems Rafael added something related.
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8bb7844286fb8c9fce6f65d8288aeb09d03a5e0d

That does look like it was meant for exactly this sort of situation.

> > It's not clear what the best way is to fix this.  Perhaps the CPU 
> > notification should be sent along with a special flag indicating that 
> > the CPU transition is part of a system sleep (although this seems 
> > racy).  Perhaps the driver should notice when a system sleep begins, 
> > and defer all CPU-change handling until after the sleep is over.
> 
> maybe it does exist?  CPU_DOWN_PREPARE ?
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/cpu-hotplug.txt;hb=HEAD
> 
> Unfortunately I'm not very familiar with this, calling the 
> coretemp_device_remove from CPU_DOWN_PREPARE would help? Looking at microcode 
> driver, seems it just hide sysfs interface from user.

I'm not sure exactly what you want to do here.  But it seems like a 
waste to unregister the coretemp devices at the start of a system sleep 
and then register them back at the end.

Could you simply leave the devices registered throughout the entire
sleep?  Of course, at the end you would have to check that all the CPUs
really did come back up, and unregister the devices for the CPUs that
are still offline.

Alan Stern
