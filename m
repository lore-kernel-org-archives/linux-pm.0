From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Sun, 1 Feb 2009 01:18:25 +0100
Message-ID: <200902010118.25810.rjw@sisk.pl>
References: <20090131074743.GA13633@bulgaria.corp.google.com>
	<200902010020.04696.rjw@sisk.pl>
	<d6200be20901311532j53af2f44p5b07eb0e76da7b25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20901311532j53af2f44p5b07eb0e76da7b25@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Sunday 01 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Sat, Jan 31, 2009 at 3:20 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday 31 January 2009, Arve Hj=F8nnev=E5g wrote:
> >> But this could prevent the phone from ringing. What if the user-space
> >> code that is responsible for playing the ringtone has been notified
> >> that a call is coming in and starts reading the audio file with the
> >> ringtone. At the same, the user, unaware that someone is calling,
> >> presses the power button. If we ignore the wakelock in this situation,
> >> the phone will not ring.
> >
> > What if the user decides to power off the phone and a call comes in at =
the
> > same time?
> =

> If you are talking about a shutdown, not sleep, then the phone just
> turns off. The phone is not expected to ring when it is turned off so
> there is no point in delaying shutdown.

If the user forcibly puts the device into suspend, it's very much like powe=
ring
off.  The kernel shouldn't prevent that from happening unless in error
conditions.

If incoming calls are supposed to wake up the system, then there are two
possibilities:
- the already started suspend sequence may be aborted and the system may be=
 put
  into the low power state,
- the system may be suspended and then immediately woken up.

Thanks,
Rafael
