From: <rasmit.ranjan@wipro.com>
Subject: Re: suspend to disk not working due to swap space failure
Date: Wed, 9 Aug 2006 08:35:05 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB20250B4C7@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rjw@sisk.pl
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

 =


> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@sisk.pl] =

> Sent: Tuesday, August 08, 2006 7:15 PM
> To: Rasmit Ranjan (WT01 - Semiconductors & Consumer Electronics)
> Cc: linux-pm@lists.osdl.org
> Subject: Re: [linux-pm] suspend to disk not working due to =

> swap space failure
> =

> On Tuesday 08 August 2006 15:13, rasmit.ranjan@wipro.com wrote:
> > Hi all,
> >     In my laptop, suspend to disk was working properly.But after so =

> > many days I tried it today.But it failed. First time i =

> tried it showed =

> > " Not enough space, Error -12 suspending".But i tried once =

> more. Then =

> > it failed  showing "error: can not find swap device, try swapon -a =

> > ".This seems my swap partition is not active. So I tried =

> "swapon -a" =

> > but it did not work. Also the output of "swapon -s " shows =

> nothing. I =

> > tried "cat /proc/swaps" but this shows nothing as well. So i tried =

> > creating a new swap space by the command " mkswap". But =

> still my swap =

> > partition does not come up. I reboot my system but that did =

> not work =

> > as well. What might be the problem?
> =

> The header of your swap partition got lost.  Please try =

> "mkswap <your_swap_partition_name>" and then swapon -a.  If =

> it works, the suspend should work either.

I tried doing this as wel. But it didn't work. Actually my /etc/fstab
file doesn't show any entry for swap partition.
> =

> Greetings,
> Rafael
> =
