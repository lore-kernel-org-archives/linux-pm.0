From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Sat, 31 Jan 2009 15:32:07 -0800
Message-ID: <d6200be20901311532j53af2f44p5b07eb0e76da7b25@mail.gmail.com>
References: <20090131074743.GA13633@bulgaria.corp.google.com>
	<Pine.LNX.4.44L0.0901311033590.6305-100000@netrider.rowland.org>
	<d6200be20901311441r8742b8em7201ce3713b8a54a@mail.gmail.com>
	<200902010020.04696.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902010020.04696.rjw@sisk.pl>
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
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 31, 2009 at 3:20 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Saturday 31 January 2009, Arve Hj=F8nnev=E5g wrote:
>> But this could prevent the phone from ringing. What if the user-space
>> code that is responsible for playing the ringtone has been notified
>> that a call is coming in and starts reading the audio file with the
>> ringtone. At the same, the user, unaware that someone is calling,
>> presses the power button. If we ignore the wakelock in this situation,
>> the phone will not ring.
>
> What if the user decides to power off the phone and a call comes in at the
> same time?

If you are talking about a shutdown, not sleep, then the phone just
turns off. The phone is not expected to ring when it is turned off so
there is no point in delaying shutdown.

-- =

Arve Hj=F8nnev=E5g
