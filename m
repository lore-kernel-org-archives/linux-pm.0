From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: content of ../power/state file of usb device shows 2
 after suspend
Date: Thu, 21 Sep 2006 10:58:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0609211056210.8293-100000@iolanthe.rowland.org>
References: <380D9721A8E2114485644D71E87C6AB20286D803@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB20286D803@PNE-HJN-MBX01.wipro.com>
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

On Thu, 21 Sep 2006 rasmit.ranjan@wipro.com wrote:

> Hi,    =

>     I face a problem while suspending any USB device through sysfs
> interface.
> I tried this with kernel 2.6.16.28. I tried the following thing
>  =

> echo -n 3 > /sys/bus/usb/devices/3-1.1.0/power/state

3-1.1.0 is not a valid USB device pathname.  Hubs don't have a "port 0".

>  =

> After this when i display the content of the above file by
>  =

> cat /sys/bus/usb/3-1.1.0/power/state
>  =

> I get 2 not 3. But inspite of this the corresponding device interface
> gets suspended properly.

The Power Management core was changed, as you have seen.

> But this inconsistency does not happen with kernel 2.6.15.4. It seems
> like now we need to echo 2 instead of 3 to suspend through sysfs
> interface in 2.6.16. Is it true ? Please suggest

Either echo 2 or echo 3 will work (they do the same thing).  At some point =

in the future the /sys/bus/devices/.../power/state files will be removed =

entirely.

Alan Stern
