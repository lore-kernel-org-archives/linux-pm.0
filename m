From: "Rodolfo (kix)" <kix@kix.es>
Subject: Re: [Suspend-devel] Help
Date: Wed, 11 Nov 2009 12:22:12 +0100
Message-ID: <3096bd910911110322w744a184cj99bf442d5baca1a2__25035.1311093711$1257938900$gmane$org@mail.gmail.com>
References: <E1McOLX-0003Lq-BN@665xhf1.ch3.sourceforge.com>
	<200909290027.08115.rjw@sisk.pl>
	<3A45B297-68FA-461E-9E31-864627534050@gmail.com>
	<200910041524.42266.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200910041524.42266.rjw@sisk.pl>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, kix <kixdotes@users.sourceforge.net>, pm list <linux-pm@lists.linux-foundation.org>, Stefan Seyfried <stefan.seyfried@googlemail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

I come back from my vacations. I'm so tired and many many mail (and
dirty clothes to wash) ...

Is possible to add a new little configuration file in the suspend
distribution to testing? If the file exists, then, read it and if the
information is correct, apply it to suspend the machine. Else, load
the default machine-whitelist list.

If is correct, then, we can add new machines, tested, to the whitelist data=
base.

kix

On Sun, Oct 4, 2009 at 2:24 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday 29 September 2009, Kix wrote:
>>
>> El 29/09/2009, a las 00:27, "Rafael J. Wysocki" <rjw@sisk.pl> escribi=F3:
>>
>> > On Tuesday 29 September 2009, Rodolfo (kix) wrote:
>> >> Hi!!
>> >
>> > Hi,
>> >
>> >> 1. A new database file, comma separated, has been created (it was
>> >> terrible, I am very tired)
>> >
>> > Well, I can imagine. :-)
>> >
>> >> 2. A little script to search in the database (using the "match"
>> >> function) is implemented
>> >> 3. Other script to convert the database file to whitelist.c has been
>> >> created too.
>> >>
>> >> The scripts has been created using perl. Why? because is fast, good
>> >> and is only for the database maintaning, not for the code
>> >> distribution.
>> >>
>> >> Please, test it, the code is in http://www.kix.es/20090929/
>> >
>> > OK, so the idea is that users wanting to add an entry to the
>> > whitelist will
>> > edit the whitelist file and the use your script to generate a new
>> > whitelist.c before building s2ram. =A0Is this correct?
>>
>> Really I don't know. Probably the users can send the entry to the mail
>> list and (I | We) generate a new whitelist.c
>>
>> Probably we can accept/ decline the new machine using other script and
>> post it to the git automatically
>>
>> I am not sure about if the users need the database file... IMO the
>> database management and the whitelist.c creation should be monitorized
>> and not fully open. A bad entry can be ... terrible?
>
> There are two distinct things to consider here. =A0First, there's the whi=
telist.c
> that's available from the git repository and I agree that it should be
> carefully maintained. =A0Second, there are users with systems that are not
> in the white list and it would be nice to allow them to add their systems
> to their own copies of whitelist.c using a script that will check if the =
system
> is really new etc. =A0Then, these users would be able to send their copie=
s of
> whitelist.c to us so that we can extract the relevant system information =
from
> them and add it to the "master" whitelist.c.
>
>> Using your procedure, if two users modify the script at the some time
>> and sent it, we will lost one entry, therefore we need to use diff
>> between them.
>>
>> On the other hand, probably the database can be "cleaned". Probably
>> some entries can be dupplicated.
>
> Agreed.
>
> Thanks,
> Rafael
>



-- =

Rodolfo Garc=EDa "kix"
EA4ERH - IN80ER
