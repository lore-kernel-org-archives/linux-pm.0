From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c
	devices
Date: Wed, 6 Apr 2011 10:23:13 +0200
Message-ID: <20110406102313.401e2e6c__23261.9387600154$1302078335$gmane$org@endymion.delvare>
References: <BANLkTik7i0VQpJb+enUd9c4-XvZQ1S57fQ@mail.gmail.com>
	<20110406052335.GA25578@sirena.org.uk>
	<20110406095240.410b4e7e@endymion.delvare>
	<BANLkTimaRdRNOYM43AhjrU70o=GL0Q-D-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTimaRdRNOYM43AhjrU70o=GL0Q-D-A@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sonny Rao <sonnyrao@chromium.org>
Cc: linux-pm@lists.linux-foundation.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 6 Apr 2011 01:16:07 -0700, Sonny Rao wrote:
> On Wed, Apr 6, 2011 at 12:52 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > Sonny, on how many systems did you test it? In particular, did you test
> > it on several TV cards (which use I2C a lot and sometimes in complex
> > setups)?
> 
> It has only been tested on my x86 system with the light sensor and
> lightly tested on an ARM system with about 6-7 i2c devices.  I was hoping
> the change would help the ARM systems because they make much
> heavier use of i2c than the x86 system.  I haven't tested on anything
> like multiple TV cards because I don't have such a setup -- the ARM
> boxes with several i2c devices is the most complex user of i2c I have
> at the moment.

I meant several TV card models, individually. I don't expect testing
many at once to reveal any problem that individual testing wouldn't
have.

-- 
Jean Delvare
