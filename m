From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problems with PM_FREEZE
Date: Tue, 27 Sep 2005 14:26:33 +0200
Message-ID: <20050927122633.GA9339@openzaurus.ucw.cz>
References: <Pine.LNX.4.44L0.0509232155380.23428-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============92703287771514953=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509232155380.23428-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============92703287771514953==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> A problem with the PM_FREEZE state has surfaced recently.
> 
> It has to do with the device state recorded in the memory image.  When the 
> image is made, devices are in the FREEZE state, and that's what gets 
> recorded.  But then the image is written to disk and devices are put into 
> SUSPEND.
> 
> Later on, when the system wakes up and the image is restored, drivers are 
> asked to resume the devices.  The problem is that now the drivers think 
> the devices are in FREEZE when in fact they are really in SUSPEND.  The 
> difference is significant and it can cause errors in the resume procedure.

No; devices are in FREEZE if their driver was in kernel, and in some kind
of power up state when not. Drivers should just handle both.

> Here's another, slightly more far-fetched problem.  I don't know if this 
> can come up in actual practice.
> 
> When a disk device is put in FREEZE, there may be pending write requests
> in its I/O queue.  After the image has been 
Can they? If so, we need to solve that somehow.

...it might happen with network devices, too. We would send packet twice.
We should limit queueing in drivers across FREEZE...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============92703287771514953==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============92703287771514953==--
