From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problem in HCD resume
Date: Tue, 6 Jun 2006 21:07:52 +0000
Message-ID: <20060606210752.GA4265@ucw.cz>
References: <380D9721A8E2114485644D71E87C6AB201F695B0@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <380D9721A8E2114485644D71E87C6AB201F695B0@PNE-HJN-MBX01.wipro.com>
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
Cc: linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Fri 02-06-06 17:38:24, rasmit.ranjan@wipro.com wrote:
> Hi,
> 	I was trying suspend/resume of OHCI based host controller. I
> suspend the device interface, device/port and the roothub interface/bus
> selectively through sysfs.

sysfs suspend/resume interface is broken and only useful for
debugging. You'll need to invent new one.
							Pavel
-- =

Thanks for all the (sleeping) penguins.
