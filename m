From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 3/9] PM: suspend_block: Abort task freezing
	if a suspend_blocker is active.
Date: Thu, 7 May 2009 18:22:40 -0700
Message-ID: <d6200be20905071822y377d0f10t3adad66d6c49acc1@mail.gmail.com>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<1241583529-5092-2-git-send-email-arve@android.com>
	<1241583529-5092-3-git-send-email-arve@android.com>
	<1241583529-5092-4-git-send-email-arve@android.com>
	<20090505195753.GE1379@ucw.cz>
	<d6200be20905061851y12b07d59t11b43d74a07aad3b@mail.gmail.com>
	<20090507104143.GB6132@elf.ucw.cz>
	<d6200be20905071649h2d3a57c8h1c1cd72d4bea4d31@mail.gmail.com>
	<1241744802.19600.244.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1241744802.19600.244.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

2009/5/7 Nigel Cunningham <ncunningham@crca.org.au>:
> Hi.
>
> On Thu, 2009-05-07 at 16:49 -0700, Arve Hj=F8nnev=E5g wrote:
>> On Thu, May 7, 2009 at 3:41 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> > If the code runs for 20 seconds, it is a bug to be fixed.
>>
>> The code gives up after 20 seconds, it does not normally run for 20
>> seconds. It is arguably a bug that it gives up after 20 seconds since
>> the time required to freeze all the threads grows with the number of
>> threads that are running. It could still be making progress after 20
>> seconds. Since the time required to freeze all tasks is the number of
>> tasks times the time it takes to interrupt each task there is no way
>> to ensure that the time required is insignificant. If we do not abort
>> task freezing when there is a wakeup event, then the worst case wakeup
>> latency is guarantied to be worse than the worst case latency for any
>> other uninterruptible kernel call.
>
> I agree with Pavel here. If freezing takes 20 seconds, something is
> wrong. (Remember that most tasks will not be running, and will therefore
> respond to the pseudo-signal and freeze immediately).
>
> In fact, I'd go further. In the thousands of times I've run the freezer
> over the years, it has never taken more than 1 second - let alone 20 -

One second is to long.

> when freezing has been successful. A delay of 20 seconds was more
> relevant when the value included the time for syncing data to disk.

This patch does nothing with the 20 second timeout.

-- =

Arve Hj=F8nnev=E5g
