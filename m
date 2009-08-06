From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 2/5] pda-power: switch to new dev_pm_ops
Date: Thu, 6 Aug 2009 13:52:41 +0200
Message-ID: <74d0deb30908060452k1fc0e982jf14be2e895e9a805__44934.548988431$1249566174$gmane$org@mail.gmail.com>
References: <1249496971-9019-1-git-send-email-daniel@caiaq.de>
	<1249496971-9019-2-git-send-email-daniel@caiaq.de>
	<200908052149.55567.elendil@planet.nl>
	<20090805222920.GF19257@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090805222920.GF19257@buzzloop.caiaq.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Mack <daniel@caiaq.de>
Cc: spyro@f2s.com, Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, cbou@mail.ru, mreimer@vpop.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 6, 2009 at 12:29 AM, Daniel Mack<daniel@caiaq.de> wrote:
> On Wed, Aug 05, 2009 at 09:49:52PM +0200, Frans Pop wrote:
>> Daniel Mack wrote:
>> > +static struct dev_pm_ops pda_power_pm_ops =3D {
>> > + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D pda_power_suspend,
>> > + =A0 =A0 =A0 .freeze =A0 =A0 =A0 =A0 =3D pda_power_freeze,
>>
>> Hmmm. Where's pda_power_freeze defined? Forgot to (compile)test the
>> patches?
>
> Yes, sorry. I can't test hibernation, so I didn't pay enough attention.
> I'll resend them anyway with Rafael's new macro used.

After Rafael's comments on gpio_keys, I believe also here
.freeze/.thaw should be empty. enable/disable_irq_wake should be
called from .poweroff/.restore.

regards
Philipp
