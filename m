From: Daniel Petrini <d.pensator@gmail.com>
Subject: Re: [linux-pm] PowerOP 1/3: PowerOP core
Date: Wed, 10 Aug 2005 09:58:49 -0400
Message-ID: <9268368b05081006585ca7a415@mail.gmail.com>
References: <20050809025157.GB25064@slurryseal.ddns.mvista.com>
	<42F8D4C5.2090800@am.sony.com> <42F94B68.6060107@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk>
In-Reply-To: <42F94B68.6060107@mvista.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk
To: Todd Poynor <tpoynor@mvista.com>
Cc: cpufreq@lists.linux.org.uk, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Geoff Levand <geoffrey.levand@am.sony.com>
List-Id: linux-pm@vger.kernel.org

> If these general ideas of arbitrary platform power parameters and
> operating points are deemed worthy of continued consideration, I'll
> propose what I view is the next step: interfaces to create and activate
> operating points from userspace.
>=20
> At that point it should be possible to write power policy management
> applications for systems that can benefit from this generalized notion
> of operating points: create the operating points that match the system
> usage models (in the case of many embedded systems, the system is some
> mode with different power/performance characteristics such as audio
> playback vs. mobile phone call in progress) and power needs (e.g., low
> battery strength vs. high strength) and activate operating points based
> on events received (new app running, low battery warning, etc.).
>=20
> Any opinions on all that?  Thanks,
>=20
> --
> Todd

Hi,

I'd like to have an idea of how the powerop would evolve to address:

a) exporting all operating points to sysfs - that would be useful for
a policy manager in user space, or the user policy will already be
aware of the ops?

b) Constraints: if I would like to change to a op and such a
transition is not allowed in hardware, what part of the software will
test it? The set/get powerop functions, the higher layers or even some
lower layer (don't know if expected) ?

thanks,

Daniel
--=20
10LE - Linux
INdT - Manaus - Brazil
