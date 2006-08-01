From: Tim Bird <tim.bird@am.sony.com>
Subject: Re: PowerOp Design and working patch
Date: Tue, 01 Aug 2006 11:02:44 -0700
Message-ID: <44CF9744.2060201@am.sony.com>
References: <acd2a5930607300402n13890dbg150315f617c86ffd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <acd2a5930607300402n13890dbg150315f617c86ffd@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org, david singleton <dsingleton@mvista.com>
List-Id: linux-pm@vger.kernel.org

Vitaly Wool wrote:
> On 7/30/06, david singleton <dsingleton@mvista.com> wrote:
   > By just presenting the supported operating points to the user it
>  > removes the
>  > need for new APIs.  The user just reads the supported operating points
>  > and decides the best use of the supported operating points.
> =

> I see this approach as fundamentally wrong at least because it will
> produce very long and hard to manage lists of operating points.
> Suppose you have 20 hardware vendor approved core CPU frequency
> values, 3 possible voltage values and 10 approved DSP CPU frequency
> values (which are derived from the other PLL). Not too impossible is
> that almost all combinations are available which makes is almost 600
> operating points. I find it absolutely unreal that anyone enters all
> that stuff without mistakes; managing those lists/searching thru them
> will take significant time which will slow down the state transitions;
> and, finally, it's gonna increase the kernel footprint  quite a bit.
> =

> It looks to me that the concept that the kernel can implement
> rules/restrictions for operating points but shouldn't define them with
> possible exception for the most essential ones far better suits both
> embedded and non-embedded use cases.

I don't think anyone expects that the list of operating points
for a machine would be comprehensive (ie every possible combination
of parameters that are known to work).  This hearkens back to the
bad old days of X11 configuration, where users were expected to
set their own dot clocks and mode lines.  While you can still do
this, giving yourself a resolution of, say, 1139 by 582, almost
everyone now just selects from a pre-defined set
of X resolutions.  I think the same is expected to be true of
power operating points.  There would be a set number of
operating points, which would derive from the vendor data
sheets, that would be smallish and not necessarily all-inclusive.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
