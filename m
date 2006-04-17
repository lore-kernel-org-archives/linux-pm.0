From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: How to enable/power off a port
Date: Mon, 17 Apr 2006 10:35:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0604171024270.5391-100000@iolanthe.rowland.org>
References: <380D9721A8E2114485644D71E87C6AB201B55E21@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============33158001160222406=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB201B55E21@PNE-HJN-MBX01.wipro.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rasmit.ranjan@wipro.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============33158001160222406==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 17 Apr 2006 rasmit.ranjan@wipro.com wrote:

> Hi all,
> 	I can suspend a port from the user space manualy by doing
> 	
> 	echo -n 3 > /sys/bus/usb....../power/state
> 
> Similarlly can I enable/power off a port from the user space manually ?

It depends on where the port is.  For ports built into the computer, the 
answer is generally No.  The USB controller hardware in computers does not 
have per-port power control.

On some systems you might be able to turn off power to _all_ the ports
attached to a particular USB host controller by turning off power to the
controller itself (put it in a D3cold state).  But this would affect more
than one port, and most systems won't allow you to do it anyway.

If the port is part of an external hub instead of build into the computer, 
you may be able to do it.  Many hubs do not support per-port power 
control, but some of them do.  You can get more information and a 
userspace program here:

http://www.gniibe.org/ac-power-by-usb/ac-power-control.html

Alan Stern


--===============33158001160222406==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============33158001160222406==--
