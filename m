From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Tue, 3 Aug 2010 15:08:54 -0700
Message-ID: <AANLkTinJ2jy18bAS-=abtDLaQWVmQdK1Oq105FcNDNyJ__20733.1160935157$1280873393$gmane$org@mail.gmail.com>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<AANLkTi=hoGF7egpyB9sLKJoXv5aiGrxfa9_5iH-96SA=@mail.gmail.com>
	<1280851338.2774.30.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1280851338.2774.30.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

2010/8/3 James Bottomley <James.Bottomley@suse.de>:
> On Mon, 2010-08-02 at 21:18 -0700, Arve Hj=F8nnev=E5g wrote:
>> > o =A0 =A0 =A0 A power-aware application must be able to efficiently co=
mmunicate
>> > =A0 =A0 =A0 =A0its needs to the system, so that such communication can=
 be
>> > =A0 =A0 =A0 =A0performed on hot code paths. =A0Communication via open(=
) and
>> > =A0 =A0 =A0 =A0close() is considered too slow, but communication via i=
octl()
>> > =A0 =A0 =A0 =A0is acceptable.
>> >
>>
>> The problem with using open and close to prevent an allow suspend is
>> not that it is too slow but that it interferes with collecting stats.
>
> Please elaborate on this. =A0I expect the pm-qos stats interface will
> collect stats across user open/close because that's how it currently
> works. =A0What's the problem?
>

The pm-qos interface creates the request object in open and destroys
it in release just like the suspend blocker interface. We need stats
for each client which is lost if you free the object every time you
unblock suspend.

Or are you talking about user space opening and closing the stats
interface (which does not cause any problems)?

>> The wakelock code has a sysfs interface that allow you to use a
>> open/write/close sequence to block or unblock suspend. There is no
>> limit to the amount of kernel memory that a process can consume with
>> this interface, so the suspend blocker patchset uses a /dev interface
>> with ioctls to block or unblock suspend and it destroys the kernel
>> object when the file descriptor is closed.
>
> This is an implementation detail only.

There is no way fix it without changing the user space visible
behavior of the API. The kernel does not know when it is safe to free
the objects.

>=A0The pm-qos objects are long
> lived, so their stats would be too. =A0I would guess that explicit stat
> clearing might be a useful option.
>

Which pm-qos objects are you referring to? The struct pm_qos_object
that backs each pm-qos class is long lived (I don't know why this is
named pm_qos_object), but we need stats in struct pm_qos_request_list.

-- =

Arve Hj=F8nnev=E5g
