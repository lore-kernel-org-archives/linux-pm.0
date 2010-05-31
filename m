From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC] lp_events: an lternitive to suspend blocker
	user mode and kernel API
Date: Mon, 31 May 2010 02:55:16 -0700
Message-ID: <AANLkTilPCxcVhcxEyLSixAoOs-ujXzzkSq8cAOE-5Nsz__17728.3332254321$1275299781$gmane$org@mail.gmail.com>
References: <20100530200409.GA21632@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100530200409.GA21632@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: mark.gross@intel.com, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Sun, May 30, 2010 at 1:04 PM, mark gross <640e9920@gmail.com> wrote:
> Low Power Events is a possible alternative to suspend blocker / wake
> lock API used by Android.
>
> It provides comparable power state notification and kernel mode critical
> section definition. =A0It differs from suspend blocker in that:
> 1) it is a platform and device independent implementation. =A0Device
> specific code is register as lp_ops, similar to pm_ops. =A0Drivers use
> the platform independent functions.
>
How is this more platform independent than suspend blockers?

> 2) it forces a user mode transition coming out of a LP state.
> Notification of wake up sources go to the user mode process managing the
> lp states. =A0Notification of blocked LP state entry is through an
> error return, and notification of un-blocking is through a file node as
> well.
>
If you want a user mode transition for every resume, you can easily
get this with the opportunistic suspend patchset by sending an input
event (or other a custom event with that blocks suspend) from a
driver's resume hook.

> I think the change need to the Google Android user mode power handling
> code can be limited to changes to _only_
> "hardware/libhardware_legacy/power/power.c"
>
> This code is still just a prototype of the platform independent code,
> and I'm implementing it on Eclair for the Intel Moorestown platform this
> weekend. =A0I'll have patches to eclair and updated kernel patches that
> enable this sometime Monday, after I bring it up on my target device.
> Hopefully by the end of next week I think I'll have it working well with
> Android.
>
> At this time the following patch is only known to compile. =A0I send it to
> help with the discussion.
>
> FWTW I do work on Android at Intel and I think I can make this work.
> (well, today I do.)
>
> --mgross
>
> Draft kernel patch :
>
...
> +
> +/dev/lpe_wake_event:
> +reads from this returns a list of wake events that happened between entry
> +into the LP state and the return from the read of the low_power_enter de=
vice
> +node. =A0User mode is expected to do something with these events before
> +re-trying to enter low power mode.
> +

I don't think this will work very well. Multiple input events can be
pending at the same time. If you register a single wake-event for an
input device, you don't know if all the events have been read when you
try to clear this wake-event.


-- =

Arve Hj=F8nnev=E5g
