From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Mon, 2 Feb 2009 15:21:06 -0800
Message-ID: <d6200be20902021521q6a855f78m88413869eb7e2da6@mail.gmail.com>
References: <Pine.LNX.4.44L0.0902021005050.2550-100000@iolanthe.rowland.org>
	<1233611258.21871.101.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1233611258.21871.101.camel@nigel-laptop>
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

On Mon, Feb 2, 2009 at 1:47 PM, Nigel Cunningham
<ncunningham@crca.org.au> wrote:
> It sounds to me like all of this stuff is just power management of
> individual devices, which should be done through the sysfs interface and
> completely unrelated to /sys/power/state.

It is easier for us to add a hook to the individual drivers than to
maintain a list of devices in user-space. Also, last time I checked,
the only way to disable individual devices was through a deprecated
interface. Is there a new way to do this?

> I'm putting the talk about
> suspending the CPU in this box too because it sounds like the desire is
> to stop the CPU without necessarily suspending other devices such as
> transmitters - sort of a CPU freq state where the frequency is 0.

Is this different from idle?

> That said, if suspend to ram is what they really want for 'auto-mem',
> what you're suggesting sounds good to me.

Suspend gives us two advantages over idle. All threads are frozen
which means that an app that is using too much cpu time no longer
drains the battery. And, the monotonic clock stops.

-- =

Arve Hj=F8nnev=E5g
