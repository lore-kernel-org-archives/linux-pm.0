From: Rudolf Marek <r.marek@assembler.cz>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Mon, 19 Nov 2007 21:01:21 +0100
Message-ID: <4741EB91.9080000__19107.4796872728$1195581740$gmane$org@assembler.cz>
References: <Pine.LNX.4.44L0.0711182156330.22727-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0711182156330.22727-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Slaby <jirislaby@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hello all,
>>> gives coretemp_cpu_callback -> coretemp_device_remove ->
>>> platform_device_unregister, so coretemp seems to be what I have and you don't.
> 
> Yes.
> 
> For the coretemp developers: coretemp_cpu_callback() needs to be more 
> careful about what it does.  During a system sleep transition (suspend, 
> hibernate, resume) it isn't possible to register or unregister a 
> device.  Attempts to register will fail and attempts to unregister will 
> block until the system sleep is over -- and for this callback that 
> means hanging.

Well I wrote the driver. Thanks for the clarification. If I recall correctly I 
looked how this part should be done from others drivers. Now while checking
what happened to the file, seems Rafael added something related.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8bb7844286fb8c9fce6f65d8288aeb09d03a5e0d

> It's not clear what the best way is to fix this.  Perhaps the CPU 
> notification should be sent along with a special flag indicating that 
> the CPU transition is part of a system sleep (although this seems 
> racy).  Perhaps the driver should notice when a system sleep begins, 
> and defer all CPU-change handling until after the sleep is over.

maybe it does exist?  CPU_DOWN_PREPARE ?

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/cpu-hotplug.txt;hb=HEAD

Unfortunately I'm not very familiar with this, calling the 
coretemp_device_remove from CPU_DOWN_PREPARE would help? Looking at microcode 
driver, seems it just hide sysfs interface from user.

Thanks,
Rudolf
