From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 0/8] device async action mechanism
Date: Thu, 16 Jul 2009 10:07:31 +0200
Message-ID: <20090716080731.GB8046__2288.13244398243$1247731725$gmane$org@one.firstfloor.org>
References: <1247643512.26272.74.camel@rzhang-dt>
	<87ocrm6xeq.fsf@basil.nowhere.org>
	<1247710483.26272.170.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1247710483.26272.170.camel@rzhang-dt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Van De Ven,
	Arjan" <arjan.van.de.ven@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, arjan@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 16, 2009 at 10:14:43AM +0800, Zhang Rui wrote:
> On Wed, 2009-07-15 at 18:41 +0800, Andi Kleen wrote:
> > Zhang Rui <rui.zhang@intel.com> writes:
> > >
> > > Currently, in order to make sure that it won't bring any side effects,
> > > I only convert the ACPI battery and i8042 to use this framework, whic=
h reduces
> > > 0.5s+ S3 time(suspend time plus resume time)=EF=BB=BF, from 7.0s to l=
ess than 6.5s.
> > =

> > 10.5s+ was intended I guess?
> > =

> what do you mean?

I am confused by you writing

"reduces <small number> from <much larger number> to <still larger number>"

So I assumed you dropped a decimal on <small number>


> =

> the kernel device suspend time is reduced from 3.2s to 2.8s after
> applying this patch set in my test box.
> And I get more optimistic numbers on another laptop, an Eeepc 901,
> from about 2s to 1.6s. And the shutdown time is also reduced 0.4s.


I think I am still confused by your numbers.

How do the 0.5s and the 7.0s relate?

-Andi

-- =

ak@linux.intel.com -- Speaking for myself only.
