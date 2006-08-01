From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: PowerOp Design and working patch
Date: Tue, 1 Aug 2006 16:23:38 +0400
Message-ID: <acd2a5930608010523g4c89ac6bud37163226da35d1f@mail.gmail.com>
References: <242d827d33807b6b46608a26ed29c273@mvista.com>
	<20060728233837.GG2140@kroah.com>
	<c6333353f00bb7fd435ef518dc8cee21@mvista.com>
	<20060729004546.GA3917@kroah.com>
	<1c70fd37e4eb876295e0194e2b8725d6@mvista.com>
	<44CBB1E0.3030908@gmail.com>
	<62e4476a851bbed395b509023edc5c5c@mvista.com>
	<acd2a5930607300402n13890dbg150315f617c86ffd@mail.gmail.com>
	<b04f25ff9b3eb8a48cad52ee832d5bf2@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <b04f25ff9b3eb8a48cad52ee832d5bf2@mvista.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: david singleton <dsingleton@mvista.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On 8/1/06, david singleton <dsingleton@mvista.com> wrote:
> Actually in practice there aren't that many supported operating
> points, even on the hardware you and I are familiar with.  I've yet
> to construct a case where there are more than 16 to 20
> operating points.

If there's no way for runtime OP creation, you'll have to specify ALL
the _valid_ OPs otherwise you'll be artificially narrowing the
applicability down. I hope that's clear.
And the number of theoretically possible (ie valid) OPs might well be
more than 100 - at least on some PXA boards, on PNX4008, on some
high-end ARMv6 ones etc.

> And the Linux device model allows the system to be set at
> a particular operating point and then suspending the LCD
> or unused USB if so desired.  So the combination flexibility
> is still available.

I wasn't talking about that; I've constructed a (weird yet possible)
example that concerned only frequency/voltage changing, not turning
on/off the devices.

> If there were 600 supported operating points that would be a
> very good reason to use PowerOp.   I'm not sure I'd want
> the user passing all the frequencies, voltages, clock
> divisor and clock multiplier for all those operating points.

Within the given use case for a particular board, given the
possibility of runtime OP creation, there shouldn't be any need to
specify ALL the OPs.

> > It looks to me that the concept that the kernel can implement
> > rules/restrictions for operating points but shouldn't define them with
> > possible exception for the most essential ones far better suits both
> > embedded and non-embedded use cases.
> CPUFREQ shows that it can, and I believe should, define the operating
> points the system supports.  CPUFREQ does NOT let the user pass
> frequency or voltage values into the kernel.  It shows the hardware
> vendor certified and validated frequencies and voltages.

Again, IMO you should specify what OPs are valid to be able to
validate runtime-created OPs, but you shouldn't limit OP creation
kernel-wise.

Vitaly
