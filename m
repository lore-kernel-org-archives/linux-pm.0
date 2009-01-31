From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Sat, 31 Jan 2009 14:41:21 -0800
Message-ID: <d6200be20901311441r8742b8em7201ce3713b8a54a@mail.gmail.com>
References: <20090131074743.GA13633@bulgaria.corp.google.com>
	<Pine.LNX.4.44L0.0901311033590.6305-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0901311033590.6305-100000@netrider.rowland.org>
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
Cc: Brian Swetland <swetland@google.com>, Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 31, 2009 at 7:41 AM, Alan Stern <stern@rowland.harvard.edu> wro=
te:
> On Fri, 30 Jan 2009, Brian Swetland wrote:
>> Imagine the computer in question is a cellphone which is going to need
>> to wake up when a call comes in to do traditional cellphone things, like
>> ring, bring up the incall UI (so the user can answer/cancel), etc.
>
> Yes.  So what?  Nothing I said prevents the computer from waking up
> when a call comes in.  What I said was that when the user tells the
> computer to suspend (e.g., by writing "mem" to /sys/power/state), the
> computer should suspend even if some wakelocks are still locked.

But this could prevent the phone from ringing. What if the user-space
code that is responsible for playing the ringtone has been notified
that a call is coming in and starts reading the audio file with the
ringtone. At the same, the user, unaware that someone is calling,
presses the power button. If we ignore the wakelock in this situation,
the phone will not ring.

-- =

Arve Hj=F8nnev=E5g
