From: Zygo Blaxell <vger-linux-omap-esightcorp@mailtoo.hungrycats.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 14:35:56 -0400
Message-ID: <20100527183556.GB25663__21290.2350970127$1274986146$gmane$org@gibbs.hungrycats.org>
References: <20100526133721.602633b2@schatten.dmk.lab>
	<AANLkTikzgaOFdQKess4E-D86OLPOzxP3dWiDkU_UR0ri@mail.gmail.com>
	<20100526142430.327ccbc4@schatten.dmk.lab>
	<20100526141612.3e2e0443@lxorguk.ukuu.org.uk>
	<AANLkTin97MMu-XO_Lk-snefBWz2ymhS0Qi1y1RxLwdVA@mail.gmail.com>
	<20100527003943.07c17f85@lxorguk.ukuu.org.uk>
	<20100527140655.GA28048@srcf.ucam.org>
	<alpine.LFD.2.00.1005271642440.3032@localhost.localdomain>
	<20100527155201.GA31937@srcf.ucam.org>
	<20100527171615.15a1fd3d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100527171615.15a1fd3d@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Thu, May 27, 2010 at 05:16:15PM +0100, Alan Cox wrote:
> So you need
> 
> 	Userspace -> QoS guarantee expression, implied resource
> 			expression via device use. *NO* knowledge of
> 			device or platform in the application

I have a pile of use cases where I want to turn off "implied resource
expression via device use."  There are two orthogonal variables to
consider:

1.  I'm drawing cows on the screen (or asking another process to do so
on my behalf).

2.  I care whether anyone can actually see the cows, and I'm willing
(or not) to burn power to make them visible.

Quite often, I'm drawing cows but I don't care about cow visibility,
so I would tell PM to turn the display off when the PM framework is
looking for ways to conserve power; however, if the animated cow is part
of an alarm clock application, then I want the display on, powering it
up if was previously turned off.

A real-world example of this is a backup process on a file server.
I'd like to tell the kernel that the backup process's CPU usage and
disk I/O is *not* implied resource expression, and if there's no other
processes using the CPU or disks, the kernel can just power down the
drives or idle the CPU on a whim.  The backup process can hang until
some other process comes along to wake the drives and CPU up again,
and then the backups will run during the idle time while the drive
is waiting for new requests from other processes.  Obviously if the
backup process is trying to write dirty pages to a powered-down drive
there will be problems (memory starvation and lost data come to mind),
so I'd make sure I don't do that.

I'd also like to change my mind about these sorts of things on the fly,
without requiring hooks in the backup process itself.  I'm thinking
of a syscall with PID, FD, mode bits (read/write?  iowait/runnable?),
and policy (whether usage implies expression).

I can express mostly the same things if "policy" was "maximum latency,"
but not all.  Consider how you'd have to specify latencies to get hard
disks that spin down when idle, spin up immediately if read requests are
issued, but wait several minutes to spin up if write requests are issued.
I can't specify that with a single latency value since it would result
in either unacceptably large latencies in some cases, or the disks
would never spin down.  I'd need a matrix with drive power states as
rows and read/write operations as columns, either per process or per
file descriptor.  Also something in user-space needs to know about the
approximate value for hard disk spin-up times in order to set their PM
QoS constraints high enough to be useful but also low enough to be useful.

Well, maybe the last problem can be resolved by specifying QoS constraints
in bands.  You'd have a QOS_OTHER band that applies to processes that
haven't specified a constraint, and a QOS_EXPLICIT band that applies to
those that have, and you'd be able to change all the QOS_OTHER processes
at once.
