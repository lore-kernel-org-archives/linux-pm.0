From: <rasmit.ranjan@wipro.com>
Subject: Re: suspend to disk not working due to swap space failure
Date: Wed, 9 Aug 2006 08:35:57 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB20250B4CA@PNE-HJN-MBX01.wipro.com>
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
To: johannes@sipsolutions.net
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

 =


> -----Original Message-----
> From: Johannes Berg [mailto:johannes@sipsolutions.net] =

> Sent: Tuesday, August 08, 2006 7:23 PM
> To: Rasmit Ranjan (WT01 - Semiconductors & Consumer Electronics)
> Cc: linux-pm@lists.osdl.org
> Subject: Re: [linux-pm] suspend to disk not working due to =

> swap space failure
> =

> rasmit.ranjan@wipro.com wrote:
> > So i tried creating a new
> > swap space by the command " mkswap". But still my swap =

> partition does =

> > not come up. I reboot my system but that did not work as well. What =

> > might be the problem?
> Is it listed in /etc/fstab so swapon -a can find it?

No it is not listed in /etc/fstab file. But `fdisk -l` shows the swap
partition.
> =

> johannes
> =
