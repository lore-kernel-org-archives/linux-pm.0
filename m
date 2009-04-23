From: Mattia Dongili <malattia@linux.it>
Subject: Re: [Regression] sony-laptop breaks resume from S2RAM
	(was: Re:	 Resume after suspend-to-ram broken for Vaio SR19VN
	in	30rc2)
Date: Thu, 23 Apr 2009 21:50:25 +0900
Message-ID: <20090423125025.GA6195__8317.55238255045$1240856851$gmane$org@kamineko.org>
References: <31c940650904201152y5f440237rb9c49f1aedfef5a6@mail.gmail.com>
	<200904212050.25531.rjw@sisk.pl>
	<31c940650904220555v1c1a6046ifa40b9c81b390731@mail.gmail.com>
	<200904222202.24271.rjw@sisk.pl>
	<31c940650904221335v21fbffc2y2e9598b564d65659@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <31c940650904221335v21fbffc2y2e9598b564d65659@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: fanderay <fanderay4@googlemail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, "Almer S. Tigelaar" <almer@gnome.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 22, 2009 at 09:35:13PM +0100, fanderay wrote:
> On Wed, Apr 22, 2009 at 9:02 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> Hi Rafael,
> >>
> >> I found the problem: it's the Sony laptop driver. =A0With
> >> CONFIG_SONY_LAPTOP=3Dy, the hard freeze on resume occurs. =A0Without t=
his

what happens if you configure it as a module instead?

> >> driver in the kernel, resume after s2ram -f -p appears to work
> >> correctly.
> >
> > It seems to be an ACPI problem, then. =A0Added some CCs.
> =

> Thanks, I raised bug <http://bugzilla.kernel.org/show_bug.cgi?id=3D13148>.

I'll try to reproduce it.

Almer,
you have an SR too, do you see the same problem as fanderay?

Thanks
-- =

mattia
:wq!
