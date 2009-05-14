From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: dev->status.power and future of DPM_
Date: Thu, 14 May 2009 13:29:54 +0900
Message-ID: <aec7e5c30905132129v2abb7c72r20fa8b748d42deb6@mail.gmail.com>
References: <aec7e5c30905130329t5610c8d1x925d554b833dedcc@mail.gmail.com>
	<Pine.LNX.4.44L0.0905131007450.3004-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0905131007450.3004-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-pm@vger.kernel.org

Hi Alan,

[Re-adding Kevin]

On Wed, May 13, 2009 at 11:12 PM, Alan Stern <stern@rowland.harvard.edu> wr=
ote:
> On Wed, 13 May 2009, Magnus Damm wrote:
>
>> Hi everyone,
>>
>> What is the future plan for dev->status.power? Right now it seems to
>> reflect the upcoming internal software state of each device when
>> performing suspend and resume. The attached picture may clarify things
>> if it makes it to the list.
>>
>> I'm a bit interested in modifying dev->status.power to reflect the
>> current device power state. Basically getting rid of DPM_PREPARING,
>> DPM_RESUMING, DPM_SUSPENDING and DPM_OFF_NOIRQ (they seem to be fairly
>> unused anyway),
>
> "Fairly unused" is very different from "completely unused". =A0Please
> don't get rid of them.

I understand that USB is using dev->power.status for power management.
USB power management very is good to have, so I have no intention in
breaking that. =3D)

>> and instead using the following states:
>>
>> DPM_ON - default operational state
>> DPM_FROZEN - set after PMSG_FREEZE
>> DPM_OFF - set after PMSG_HIBERNATE
>> DPM_SUSPENDED - set after PMSG_SUSPEND
>
> Is there any reason for making this change?
>
>> On top of this I'd like to allow device drivers to mark devices as
>> idle. And if a device is marked idle then I'd like to allow power
>> management code to perform freeze() on a single device. After that
>> marking the device frozen using DPM_FROZEN. poweroff() may also be
>> called to perform some partial system suspend. It gets more
>> complicated of course, but I guess we need a way to know the state of
>> each device regardless.
>>
>> Any comments?
>
> It sounds like you're trying to resuscitate the proposals for
> centralized device power management from several years ago. =A0The idea
> was abandoned because there was no way to make it work. =A0And there's no
> reason to think the situation is any different now.

So let's look at it from a different angle then. Today there are many
SoCs on the market from multiple vendors, and they all need to be
power managed somehow. Upstream linux is not very good at it, some
vendors have many out-of-tree patches for these things. For SuperH we
have no power management code out-of-tree so _now_ we have a good
chance of implementing something upstream that multiple architectures
can make use of.

Paul Walmsley, Kevin Hilman and I discussed this during last Embedded
Linux Conference last month. From architecture perspective both Arm
and SuperH need to be able enter deep sleep states. For this to happen
we need the ability to save and restore device context during run
time.

Do you have any recommendation for us?

Thank you!

/ magnus
