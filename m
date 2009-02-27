From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 27 Feb 2009 14:09:12 -0800
Message-ID: <d6200be20902271409y395822c9ic8f1223f6551631c__40986.6281007$1235772702$gmane$org@mail.gmail.com>
References: <200902192215.18365.rjw@sisk.pl> <200902271522.41915.rjw@sisk.pl>
	<20090227142946.GA13650@srcf.ucam.org>
	<200902272154.03539.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902272154.03539.rjw@sisk.pl>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 27, 2009 at 12:54 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday 27 February 2009, Matthew Garrett wrote:
>> On Fri, Feb 27, 2009 at 03:22:39PM +0100, Rafael J. Wysocki wrote:
>> > On Friday 27 February 2009, Pavel Machek wrote:
>> > > Wakelocks done right are single atomic_t... and if you set it to 0,
>> > > you just unblock "sleeper" thread or something. Zero polling and very
>> > > simple...
>> >
>> > Except that you have to check all of the wakelocks periodically in a l=
oop =3D>
>> > polling. =A0So?
>>
>> Why do you need to check them? If you're taking this approach you just
>> have something like:
>>
>> suspend_unblock() {
>> =A0 =A0 =A0 if (atomc_dec_and_test(&suspend_lock))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend();
>> }
>>
>> and then check that the lock count is still 0 after device_suspend().
>> There's no need to poll.
>
> I was talking about wakelocks as originally proposed.

Can you be more specific? My wakelock implementation triggers suspend
when the active list becomes empty. No polling required.

-- =

Arve Hj=F8nnev=E5g
