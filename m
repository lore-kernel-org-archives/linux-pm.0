From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Mon, 19 Nov 2007 22:53:40 +0100
Message-ID: <200711192253.41532.rjw__7993.79353779859$1195508351$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0711182156330.22727-100000@netrider.rowland.org>
	<4741EB91.9080000@assembler.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4741EB91.9080000@assembler.cz>
Content-Disposition: inline
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

On Monday, 19 of November 2007, Rudolf Marek wrote:
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

Well, in principle you can use the observation that the _FROZEN versions
are used during suspend/hibernation.  Thus, if you only unregister the device
for CPU_DEAD, but you won't do that for CPU_DEAD_FROZEN, it will work as long
as the freezer is there.

> > It's not clear what the best way is to fix this.  Perhaps the CPU 
> > notification should be sent along with a special flag indicating that 
> > the CPU transition is part of a system sleep (although this seems 
> > racy).

In fact, it's already done that way and I don't think it's racy (see above).

Greetings,
Rafael
