From: Greg KH <greg@kroah.com>
Subject: Re: How to enable/power off a port
Date: Mon, 17 Apr 2006 07:26:14 -0700
Message-ID: <20060417142614.GA32263@kroah.com>
References: <380D9721A8E2114485644D71E87C6AB201B55E21@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============24358218319176062=="
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

--===============24358218319176062==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 17, 2006 at 05:12:11PM +0530, rasmit.ranjan@wipro.com wrote:
> Hi all,
> 	I can suspend a port from the user space manualy by doing
> 	
> 	echo -n 3 > /sys/bus/usb....../power/state
> 
> Similarlly can I enable/power off a port from the user space manually ?

Search the archives of the linux-usb-devel mailing list for a small
program that does this through usbfs.  That's the only way to disable
power for a USB port (and then only for some hubs, not all support it.)

good luck,

greg k-h

--===============24358218319176062==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============24358218319176062==--
