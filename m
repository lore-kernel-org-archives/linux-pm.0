From: Victor Lowther <victor.lowther@gmail.com>
Subject: Re: Experimental power saving profile support branch in pm-utils
Date: Sat, 26 Jun 2010 08:55:03 -0500
Message-ID: <AANLkTikXv5ipAIHDvol9iR4hTtP9Lfi79zLway_KkZi9@mail.gmail.com>
References: <AANLkTin4YfM8qqEAxzqa9J8KZYa2L12BcgK5BdkosMPh@mail.gmail.com>
	<87sk4a1iuq.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devkit-devel-bounces+gcfdd-devkit-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <87sk4a1iuq.fsf@gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/devkit-devel>,
	<mailto:devkit-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/devkit-devel>
List-Post: <mailto:devkit-devel@lists.freedesktop.org>
List-Help: <mailto:devkit-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/devkit-devel>,
	<mailto:devkit-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: devkit-devel-bounces+gcfdd-devkit-devel=m.gmane.org@lists.freedesktop.org
Errors-To: devkit-devel-bounces+gcfdd-devkit-devel=m.gmane.org@lists.freedesktop.org
To: Ben Gamari <bgamari@gmail.com>
Cc: pm-utils <pm-utils@lists.freedesktop.org>, devkit-devel@lists.freedesktop.org, Linux Power Management List <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 26, 2010 at 12:08 AM, Ben Gamari <bgamari@gmail.com> wrote:
> On Fri, 25 Jun 2010 23:44:22 -0500, Victor Lowther <victor.lowther@gmail.=
com> wrote:
>> The latest release of pm-utils (1.4.0) added some default hooks for
>> helping conserve power. =A0Based on the recent thread on linux-pm
>> proposing a /sys/power/policy_preference knob, I decided to implement
>> support for setting powersave profiles in pm-utils. =A0From the git
>> logs:
>>
> I'm really confused. This seems like the polar opposite of the direction
> we have been saying we should be taking. The argument has been strongly
> made (Matthew Garrett comes to mind, but there are no doubt others) in
> the past that the concept of a power profile is fundamentally
> broken. Instead we should _always_ be trying to save power. Thankfully
> there are only very few cases where saving power and delivering good
> performance are at stake.

That does not remove the need to manage those cases, and different
users will have different ideas about what an acceptable tradeoff
between power and performance is.

> In general, the faster we can get our work
> done, the longer we can remain in low-power states. =A0Moreover, hardware
> is only getting better at saving power while minimally affecting
> operation.

For hardware like CPUs and memory controllers, this is the case.  It
is less so for PCIe ASPM, SATA/SAS ALPM, and wireless power
management, and not really the case at all for spinning down your hard
drive.

Moreover, an important part of saving power involves tuning the
virtual memory subsystem and the filesystems to minimize disk
I/O,trading how long dirty data remains in memory for power savings.
Different users will have different ideas about what is acceptable,
and it is not something that is really autotunable.

> Thus, I pose the question: do we really want this sort of explicit
> control in the user-space? Even if we do, I far from convinced that the
> policy_preference model is a sound way to expose this preference to the
> user. The 5 levels as layed out in the proposal seem awfully arbitrary
> and really don't express the full gamut of preferences that a user might
> hold.

That is why I want to make it easy to create and manage arbitrary
policies in userspace as opposed to having it in kernelspace where it
is harder to modify according to what the end user desires.

> - Ben
>
