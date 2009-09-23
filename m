From: "Rodolfo (kix)" <kix@kix.es>
Subject: Re: [Suspend-devel] Help
Date: Wed, 23 Sep 2009 10:34:12 +0200
Message-ID: <3096bd910909230134v6ad1c5acr53b172d9472488e8__42521.8618046076$1253804446$gmane$org@mail.gmail.com>
References: <E1McOLX-0003Lq-BN@665xhf1.ch3.sourceforge.com>
	<200908152239.15915.rjw@sisk.pl> <20090822073516.GD2108@elf.ucw.cz>
	<200909230133.28689.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909230133.28689.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, kix <kixdotes@users.sourceforge.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

I am thinking about the maintaining ...

1. The users sends the hardware info to be added to the database (now
by mail). Then:

1. Probably we need a little script (or web script? or post directly
form the s2ram -i?):
  1.a The script checks if the machine is previously added to the
database (in a text file). Probably this script can read from the
mailing list format

xxxx:% sudo /root/s2ram -i
This machine can be identified by:
    sys_vendor   =3D "TOSHIBA"
    sys_product  =3D "Satellite U305"
    sys_version  =3D "PSU34U-00L003"
    bios_version =3D "V1.70   "
See http://en.opensuse.org/S2ram for details.

  1.b If is not added, the script add the machine to a text file.

2. The text file can be processed using a little script to convert it
to the "whitelist.[c,h]" files and converted to web page (s2whitelist
and s2web :-))
3. The script can do a git update if needed.

In my opinion, the file should have this format:

<author info for the comment's
line>=B7<sys_vendor>=B7<sys_product>=B7<sys_version>=B7<bios_version>=B7<fl=
ags>

I am using the "=B7" separator because probably is not used in any field.

What do you think? Thanks.

Best Regards,

kix.

On Wed, Sep 23, 2009 at 1:33 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi kix,
>
> On Saturday 22 August 2009, Pavel Machek wrote:
>> Hi!
>>
>> > > Message body follows:
>> > >
>> > > I would like to help in the project.
>> > >
>> > > - updating the database.
>> > >
>> > > Have you seen the patch I sent?
>> >
>> > Yes, sorry for the lack of response, but I didn't really have the time=
 to
>> > review the patch.
>> >
>> > That said, I don't think we'd like to move the whitelist to a separate=
 file.
>> > Rather than that, we've been considering removing it altogether.
>> >
>> > Still, if you want to maintain the whitelist in its current form, I th=
ink
>> > you could do that.
>>
>> Yes, maintainer for the whitelist would be very welcome.
>>
>> Now... whitelist inside the binary is very welcome for init=3D/bin/bash,
>> etc; OTOH if the .c file is compiled from .txt description... that's
>> probably acceptable. Also it might make sense to load external
>> whitelist _in addition_ to the internal one, so people can quickly
>> experiment with whitelist entries...
>
> If you're still willing to be a whitelist maintainer, please set up a git
> repository from which I can pull the whitelist updates.
>
> If you'd like to move the whitelist to a separate file, please do so. =A0=
You are
> free to use whatever format you think is suitable, although it would be n=
ice
> if the whitelist file could be easily updated by users.
>
> Best,
> Rafael
>
> -------------------------------------------------------------------------=
-----
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#3=
3;
> http://p.sf.net/sfu/devconf
> _______________________________________________
> Suspend-devel mailing list
> Suspend-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/suspend-devel
>



-- =

Rodolfo Garc=EDa "kix"
EA4ERH - IN80ER
