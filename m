From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 28 Aug 2006 19:39:57 +0200
Message-ID: <20060828173957.GF30105@elf.ucw.cz>
References: <20060817214031.GE6450@ucw.cz>
	<acd2a5930608172242v7ba6e7eeq8ab90ea11175ef4c@mail.gmail.com>
	<20060823122849.GA23456@atrey.karlin.mff.cuni.cz>
	<acd2a5930608240558k4cc77dadxbd6175c05141fe23@mail.gmail.com>
	<20060825195543.GA9568@elf.ucw.cz>
	<acd2a5930608251626t36fb1e79w27acd1eaa6fe5947@mail.gmail.com>
	<20060826101820.GI10257@elf.ucw.cz>
	<acd2a5930608260630l52c914c0h207866a32a3def4a@mail.gmail.com>
	<20060826134653.GQ10257@elf.ucw.cz>
	<20060828164038.GA17944@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060828164038.GA17944@linux.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Mark Gross <mgross@linux.intel.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Mon 2006-08-28 09:40:38, Mark Gross wrote:
> On Sat, Aug 26, 2006 at 03:46:53PM +0200, Pavel Machek wrote:
> > On Sat 2006-08-26 17:30:40, Vitaly Wool wrote:
> > > On 8/26/06, Pavel Machek <pavel@suse.cz> wrote:
> > Because 8388608 policies is clearly not reasonable, powerop can not
> > help here, and something better should be developed... like power
> > domains someone proposed here.
> > =

> > (Or to say it in another words, powerop forces one big power domain,
> > which is bad model for notebook-style machine).
> =

> I doubt notebook-style machines will ever us power op in any
> significant way.  HPC and embedded will be the first users.

I agree here... power op look useless for notebooks. But I doubt power
op authors would agree...

> Power domains will likely build on top power op.
> =

> Power domains adds complexities themselves. Dealing with
> dependencies and constraints between domains will be a challenge.

Once we have power domains in/solved... do we still need power op? I
thought power op could be useful for solving constrains _inside_ one
domain, but...
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
