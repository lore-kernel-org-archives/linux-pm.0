From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] cpufreq: Reformat printk() statement
Date: Mon, 10 Mar 2014 09:49:18 -0700
Message-ID: <1394470158.24244.18.camel@joe-AO722>
References: <1394127279-29871-1-git-send-email-soren.brinkmann@xilinx.com>
	 <CAKohpo=E2PAD7XNm4y3tXv6-ArPCj+8RG-WsJLOfvJoZ7EkstQ@mail.gmail.com>
	 <1394424432.30791.11.camel@joe-AO722>
	 <f29b7db5-e5a2-48d8-ae42-8ec562c4c4f6@CO9EHSMHS025.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <f29b7db5-e5a2-48d8-ae42-8ec562c4c4f6@CO9EHSMHS025.ehs.local>
Sender: cpufreq-owner@vger.kernel.org
To: =?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2014-03-10 at 09:35 -0700, S=F6ren Brinkmann wrote:
> Hi Joe,

Hello S=F6ren:

> On Sun, 2014-03-09 at 09:07PM -0700, Joe Perches wrote:
> > On Mon, 2014-03-10 at 11:53 +0800, Viresh Kumar wrote:
> > > On 7 March 2014 01:34, Soren Brinkmann <soren.brinkmann@xilinx.co=
m> wrote:
> > > > Reformat a printk statement to:
> > > >  - use pr_warn
> > > >  - bring the whole string into a single line in favor of being =
able to
> > > >    grep for the message (ignoring the 80 char limit)
> > > >
> > > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > []
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >=20
> > A more comprehensive patch would be to:
> >=20
> > Add missing newlines
> > Coalesce format fragments
> > Convert printks to pr_<level>
> > Align arguments
>=20
> I agree. But I didn't want to spend time on "fixing" formatting witho=
ut
> knowing it will be accepted. Also, I was grepping for the message I
> ended up changing because on an issue I actually needed to fix.
>=20
> Do you want me to squash your changes into the patch I submitted? Or =
do
> you wanna pick up mine and submit your patch?

What I sent incorporates your change.

If Viresh or Rafael want me to sign it, I will,

Original-patch-by: S=F6ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Joe Perches <joe@perches.com>

otherwise, feel free to resend it with your signature.

cheers, Joe


