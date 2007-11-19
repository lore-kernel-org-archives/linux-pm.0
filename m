From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Sun, 18 Nov 2007 22:04:52 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711182156330.22727-100000__17852.1755770364$1195441567$gmane$org@netrider.rowland.org>
References: <4740BC36.2070200@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4740BC36.2070200@gmail.com>
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
Cc: r.marek@assembler.cz, Kernel development list <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 18 Nov 2007, Jiri Slaby wrote:

> > gives coretemp_cpu_callback -> coretemp_device_remove ->
> > platform_device_unregister, so coretemp seems to be what I have and you don't.

Yes.

For the coretemp developers: coretemp_cpu_callback() needs to be more 
careful about what it does.  During a system sleep transition (suspend, 
hibernate, resume) it isn't possible to register or unregister a 
device.  Attempts to register will fail and attempts to unregister will 
block until the system sleep is over -- and for this callback that 
means hanging.

It's not clear what the best way is to fix this.  Perhaps the CPU 
notification should be sent along with a special flag indicating that 
the CPU transition is part of a system sleep (although this seems 
racy).  Perhaps the driver should notice when a system sleep begins, 
and defer all CPU-change handling until after the sleep is over.

Alan Stern
