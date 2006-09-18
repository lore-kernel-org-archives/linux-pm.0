From: Matthew Locke <matt@nomadgs.com>
Subject: Re: OpPoint summary
Date: Mon, 18 Sep 2006 09:13:22 -0700
Message-ID: <3624e4a9b11b308693d6fb56551ab5a5@nomadgs.com>
References: <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>
	<20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
	<20060911225617.GB13474@elf.ucw.cz>
	<20060912001701.GC14234@linux.intel.com>
	<20060912033700.GD27397@kroah.com>
	<b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
	<20060914055529.GA18031@kroah.com>
	<b324b5ad0609141007i2a26cf60r45ebf1175c7bcc7d@mail.gmail.com>
	<20060917174835.GA2225@elf.ucw.cz>
	<1158590004.8239.14.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1158590004.8239.14.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Richard A. Griffiths" <richard.griffiths@windriver.com>
Cc: linux-pm@lists.osdl.org, kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


On Sep 18, 2006, at 7:33 AM, Richard A. Griffiths wrote:

> On Sun, 2006-09-17 at 19:48 +0200, Pavel Machek wrote:
>> Hi!
>>
>>>> Care to resend your patches in the proper format, through email so =

>>>> that
>>>> we can see them, and possibly get some testing in -mm if they look =

>>>> sane?
>>>
>>> Greg,
>>>   here's the patch that implements operating points for different
>>>   frequencies
>>> for the speedstep-centrino line of processors.  Operating points are =

>>> created
>>> in much the same manner that cpufreq tables are.  This works for both
>>> simple implementations like the centrino and more complex SoC systems
>>> like the arm-pxa72x which has several clocks to control, and =

>>> different clock
>>> divisors and multipliers.
>>
>>> +static struct oppoint lowest =3D {
>>> +       .name =3D "lowest",
>>> +       .type =3D PM_FREQ_CHANGE,
>>> +       .frequency =3D 0,
>>> +       .voltage =3D 0,
>>> +       .latency =3D 15,
>>> +       .prepare_transition  =3D cpufreq_prepare_transition,
>>> +       .transition =3D centrino_transition,
>>> +       .finish_transition =3D cpufreq_finish_transition,
>>> +};
>>
>> We had nice, descriptive interface... with numbers. Now you want to
>> introduce english state names... looks like a step back to me.
>
> Maybe a compromise could be reached where a defined set of numbers maps
> to  string names ala Unix init states. Many people (at least me) still
> invoke init 6 to reboot a system.  A defined table would satisfy both
> the number and string camps.

PowerOP allows the platform to define the name. In our cpufreq =

integration patches, we reuse the same name that cpufreq centrino used.

>
> Richard
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>
