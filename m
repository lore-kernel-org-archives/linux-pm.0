From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: New comer in the linux-pm list
Date: Fri, 21 Nov 2008 13:42:33 +0000
Message-ID: <20081121134232.GD31866@sirena.org.uk>
References: <OF87B4B960.116849D3-ONC1257507.00457478-C1257507.0045AAE5@sagem.com>
	<1227196499.585.39.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1227196499.585.39.camel@vega.slimlogic.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Liam Girdwood <lrg@kernel.org>
Cc: Olivier LE ROY <olivier.leroy@sagem.com>, linux-pm@lists.linux-foundation.org, Kanider GUENDOUZI <kanider.guendouzi@sagem.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 20, 2008 at 03:54:59PM +0000, Liam Girdwood wrote:
> On Thu, 2008-11-20 at 13:40 +0100, David GIGUET wrote:

> > For example on a cellphone, when you switch to "silent mode" what need
> > do you have to power the audio amplifier, and maybe the audio module
> > inside the SOC may be stopped, saving more power.

> ALSA Soc (ASoC) does this sort of thing already. It can power down
> unused audio components when not in use. Have a look at DAPM in
> sound/soc and Documentation/sound/alsa/soc for details.

There's also some (relatively limited) support for this in the generic
AC97 and HDA drivers.
