From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend to disk not working due to swap space failure
Date: Tue, 8 Aug 2006 15:45:02 +0200
Message-ID: <200608081545.02774.rjw@sisk.pl>
References: <380D9721A8E2114485644D71E87C6AB20250B425@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB20250B425@PNE-HJN-MBX01.wipro.com>
Content-Disposition: inline
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

On Tuesday 08 August 2006 15:13, rasmit.ranjan@wipro.com wrote:
> Hi all,
>     In my laptop, suspend to disk was working properly.But after so many
> days I tried it today.But it failed. First time i tried it showed " Not
> enough space, Error -12 suspending".But i tried once more. Then it
> failed  showing "error: can not find swap device, try swapon -a ".This
> seems my swap partition is not active. So I tried "swapon -a" but it did
> not work. Also the output of "swapon -s " shows nothing. I tried "cat
> /proc/swaps" but this shows nothing as well. So i tried creating a new
> swap space by the command " mkswap". But still my swap partition does
> not come up. I reboot my system but that did not work as well. What
> might be the problem? =


The header of your swap partition got lost.  Please try
"mkswap <your_swap_partition_name>" and then swapon -a.  If it works, the
suspend should work either.

Greetings,
Rafael
