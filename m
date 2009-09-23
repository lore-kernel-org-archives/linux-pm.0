From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] Help
Date: Thu, 24 Sep 2009 00:28:03 +0200
Message-ID: <200909240028.03305.rjw__15431.4419407912$1253744937$gmane$org@sisk.pl>
References: <E1McOLX-0003Lq-BN@665xhf1.ch3.sourceforge.com>
	<200909230133.28689.rjw@sisk.pl>
	<3096bd910909230134v6ad1c5acr53b172d9472488e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <3096bd910909230134v6ad1c5acr53b172d9472488e8@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rodolfo (kix)" <kix@kix.es>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, kix <kixdotes@users.sourceforge.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 23 September 2009, Rodolfo (kix) wrote:
> Hi Rafael,

Hi,

> I am thinking about the maintaining ...
> =

> 1. The users sends the hardware info to be added to the database (now
> by mail). Then:
> =

> 1. Probably we need a little script (or web script? or post directly
> form the s2ram -i?):
>   1.a The script checks if the machine is previously added to the
> database (in a text file). Probably this script can read from the
> mailing list format
> =

> xxxx:% sudo /root/s2ram -i
> This machine can be identified by:
>     sys_vendor   =3D "TOSHIBA"
>     sys_product  =3D "Satellite U305"
>     sys_version  =3D "PSU34U-00L003"
>     bios_version =3D "V1.70   "
> See http://en.opensuse.org/S2ram for details.
> =

>   1.b If is not added, the script add the machine to a text file.

However you arrange that is up to you.  My experience is that the users
generally send whitelist information by email.

> 2. The text file can be processed using a little script to convert it
> to the "whitelist.[c,h]" files and converted to web page (s2whitelist
> and s2web :-))
> 3. The script can do a git update if needed.

Well, I'm surely not going to allow the script to update the master git tree
at kernel.org directly.

> In my opinion, the file should have this format:
> =

> <author info for the comment's
> line>=B7<sys_vendor>=B7<sys_product>=B7<sys_version>=B7<bios_version>=B7<=
flags>
> =

> I am using the "=B7" separator because probably is not used in any field.

What's the code of this character?

Rafael
