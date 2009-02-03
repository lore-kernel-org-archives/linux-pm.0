From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Mon, 2 Feb 2009 16:08:19 -0800
Message-ID: <d6200be20902021608i7c99123l5bd236c212193d40@mail.gmail.com>
References: <Pine.LNX.4.44L0.0902021005050.2550-100000@iolanthe.rowland.org>
	<1233611258.21871.101.camel@nigel-laptop>
	<d6200be20902021521q6a855f78m88413869eb7e2da6@mail.gmail.com>
	<1233618666.21871.231.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1233618666.21871.231.camel@nigel-laptop>
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
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, Uli Luckas <u.luckas@road.de>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 2, 2009 at 3:51 PM, Nigel Cunningham
<ncunningham@crca.org.au> wrote:
>> It is easier for us to add a hook to the individual drivers than to
>> maintain a list of devices in user-space. Also, last time I checked,
>> the only way to disable individual devices was through a deprecated
>> interface. Is there a new way to do this?
>
> Not as far as I know, but I understood that we weren't focusing on what
> currently exists, but on what ought to exist to properly support what
> you're after, in a generic enough way to be useful to others as well.

Early-suspend was easier to add to the kernel, and easier for us to
use from user-space.

> Well, I'm imagining a state that is more than just idle - where, as you
> say, processes don't run until some sort of wakeup event occurs.

You are describing suspend.

>> Suspend gives us two advantages over idle. All threads are frozen
>> which means that an app that is using too much cpu time no longer
>> drains the battery. And, the monotonic clock stops.
>
> Do you want to leave any devices on while in this state? If not, okay -
> suspend to ram sounds right. If yes, I think you want to take
> leave /sys/power/disk alone and go along the lines of run-time power
> management instead.

I don't think leaving a device on should prevent us from using
suspend. Wakeup from suspend is already supported. If wakeup is
enabled for a device, it needs to be in a power state that can support
wakeup (whether this is its lowest power state or not).

-- =

Arve Hj=F8nnev=E5g
