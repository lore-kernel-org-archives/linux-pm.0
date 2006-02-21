From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: power management for pcmcia based USB hc driver
Date: Tue, 21 Feb 2006 10:19:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0602211008500.5266-100000@iolanthe.rowland.org>
References: <05B7784238A51247A0A9FB4B348CECAE016F05CE@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============37376057601587376=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <05B7784238A51247A0A9FB4B348CECAE016F05CE@PNE-HJN-MBX01.wipro.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: kaustav.majumdar@wipro.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============37376057601587376==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 21 Feb 2006 kaustav.majumdar@wipro.com wrote:

> Hi all,
> 
> We are facing an issue regarding power management of a PCMCIA based USB
> Host Controller driver. 
> 
> When we are issuing the command "echo -n "3" >
> /sys/class/pcmcia-socket/pcmcia-socket1/device/power/state" from the
> command line (the PC Card was in socket 1), we received the "PM_SUSPEND"
> event in the event handler of the PCMCIA client driver. On getting that,
> inside the client driver, we are releasing the configuration by calling
> pcmcia_release_configuration.
> 
> When we debugged the code, we noted that though we are getting suspend
> event in the pcmcia client driver, the suspend entry points in the hc
> driver are not being called.
> 
> So from that I think a mechanism is needed to communicate this event to
> the hc driver. One possible solution is to set a variable in the PCMCIA
> client driver on suspend and polling that variable from the hc driver.
> 
> Pl. suggest a better solution. Looking forward to your suggestions.

Suspend messages sent via sysfs are not propagated down to child devices
and drivers.  Your userspace program has to make sure to suspend all the
children before trying to suspend a device.  That means suspending all the 
descendants (interfaces and devices) of the host controller, then the host 
controller itself, then the PCMCIA client driver.

The same is true of resume messages sent via sysfs.  They don't get 
propagated either, so again your userspace program must resume all the 
children in the device tree.

Alan Stern


--===============37376057601587376==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============37376057601587376==--
