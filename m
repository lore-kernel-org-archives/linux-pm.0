From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Mon, 17 May 2010 16:32:48 -0700
Message-ID: <AANLkTikENyp0UOKP2NzwjKye1EiZitdE0o4k1Z4ygCsT__36434.1925982901$1274139234$gmane$org@mail.gmail.com>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005172240.35742.rjw@sisk.pl>
	<AANLkTim2b8cKnzPgN7m5zImb0hVDfqVjRidKNVoYi1yO@mail.gmail.com>
	<201005172344.46222.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005172344.46222.rjw@sisk.pl>
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
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 17, 2010 at 2:44 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday 17 May 2010, Brian Swetland wrote:
>> On Mon, May 17, 2010 at 1:40 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Monday 17 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >>
>> >> It should get out of that loop as soon as someone blocks suspend. If
>> >> someone is constantly aborting suspend without using a suspend blocker
>> >> it will be very inefficient, but it should still work.
>> >
>> > Well, the scenario I have in mind is the following. =A0Someone wants t=
o check
>> > the feature and simply writes "opportunistic" to /sys/power/policy and=
 "mem" to
>> > /sys/power/state without any drivers or apps that use suspend blockers.
>> >
>> > How in that case is the system supposed to break out of the suspend-re=
sume loop
>> > resulting from this? =A0I don't see right now, because the main blocke=
r is
>> > inactive, there are no other blockers that can be activated and it is =
next to
>> > impossible to write to /sys/power/state again.
>>
>> I guess we could set a flag when a suspend blocker is registered and
>> refuse to enter opportunistic mode if no blockers have ever been
>> registered.
>>
>> It does seem like extra effort to go through to handle a "don't do
>> that" type scenario (entering into opportunistic suspend without
>> anything that will prevent it).
>
> I agree, but I think it's necessary. =A0We shouldn't add interfaces that =
hurt
> users if not used with care.
>

I'm not sure this can be "fixed". The user asked that the system to
suspend whenever possible, which is what it is doing. I don't think
disabling opportunistic suspend if no suspend blockers have been
registered will work. As soon as we register a suspend blocker we are
back in the same situation.

-- =

Arve Hj=F8nnev=E5g
