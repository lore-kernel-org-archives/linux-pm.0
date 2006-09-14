From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Thu, 14 Sep 2006 16:12:50 +0400
Message-ID: <acd2a5930609140512x5472223bpebc08d791b64c2e3@mail.gmail.com>
References: <20060913045405.BA7DD1A0084@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<ADE4D9DBCFC3A345AAA95C195F62B6DD01B6A3D9@de01exm64.ds.mot.com>
	<20060914091211.GA14874@elf.ucw.cz>
	<a1a8b0b5c71a78fafd450c10ec52a60d@comcast.net>
	<45092968.7070508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <45092968.7070508@gmail.com>
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
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: linux-pm@lists.osdl.org, Matthew Locke <matthew.a.locke@comcast.net>, Preece Scott-PREECE <scott.preece@motorola.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Eugeny,

On 9/14/06, Eugeny S. Mints <eugeny.mints@gmail.com> wrote:

> Separate or one universal user space<->kernel interface is another story.
> Universal is preferred of course and in two words to achieve universal in=
terface
> current cpufreq interface needs to be improved - but remains unchanged fo=
r user
> space !!!! - in the way to handle "chose closet predefined frequency to an
> arbitrary freq value echo'ed into /sys/cpufreq/cpuN/freq" functionality i=
n user
> space instead of in the kernel. Assuming that frequency attribute is expo=
rted
> for all available operating points it is possible to implement the "cpufr=
eq
> frequency selection logic" in user space and having such functionality in=
 the
> kernel just violates the main rule of having everything possible outside =
of the
> kernel.

Let's not be in a hurry, if possible.
I wonder why not to present PowerOP with a _separate_ *kernel* API at
the moment.

> More details here:
> http://lists.osdl.org/pipermail/linux-pm/2006-September/003660.html
> and here
> http://lists.osdl.org/pipermail/linux-pm/2006-September/003671.html

Again, let's first make PowerOP accepted in mainline and then start
talking about integration with cpufreq.
Looking again at the links you've provided, I'd guess BTW that you
meant configfs not sysfs in some cases.

Vitaly
