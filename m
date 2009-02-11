From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Wed, 11 Feb 2009 15:55:16 -0800
Message-ID: <d6200be20902111555r3f5f3ccdoc5ea336c058775a0@mail.gmail.com>
References: <20090211044736.GB9980@bulgaria.corp.google.com>
	<Pine.LNX.4.44L0.0902110955490.3056-100000@iolanthe.rowland.org>
	<20090211213751.GB605@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090211213751.GB605@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Brian Swetland <swetland@google.com>, ncunningham@crca.org.au, u.luckas@road.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 11, 2009 at 1:37 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2009-02-11 09:58:23, Alan Stern wrote:
>> On Tue, 10 Feb 2009, Brian Swetland wrote:
>>
>> > [Pavel Machek <pavel@ucw.cz>]
>> > > >
>> > > > wake_lock never blocks.
>> > >
>> > > Wakelock is really bad name: it is not a lock and it does not protect
>> > > wake. I'd say we need better name here.
>> >
>> > I agree with you here -- I've had this discussion with Arve previously,
>> > but have been unable to offer a compelling alternative name.  Anybody
>> > have a good idea?
>>
>> delay_sleep or delaysleep?  block_sleep or blocksleep?  Any of the
>> above with "sleep" replaced by "suspend"?
>
> Actually "sleep_veto" sounded best.

What is the api for a sleep_veto? Lock and unlock makes sense for a
wakelock, but not for a veto.

The original driver used suspendlock for the kernel api, but we used
wakelock for the userspace apis. I changed the name to wakelock so
that it would match the user space api (which we cannot change), and
also because people here usually referred to them as wakelocks despite
the name of the kernel apis.

-- =

Arve Hj=F8nnev=E5g
